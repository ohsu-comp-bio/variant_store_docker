#
# Build GenomicsDB from https://github.com/Intel-HLS
# And Variant Store from https://github.com/Intel-HSS/store
#
# https://github.com/Intel-HLS/GenomicsDB/wiki/Compiling-GenomicsDB
# https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#
FROM centos:7

# build requires gcc version >= 4.9.0, which we get using devtoolset-3.
# psycopg2 needs pg_config in postgresql-devel
# uwsgi needs Python.h in python-devel
# PyVCF==0.6.7 conflicts with virtualenv version installed by pip, so we install virtualenv using yum
RUN yum -y update
RUN yum -y install centos-release-scl-rh
RUN yum -y install epel-release
RUN yum -y install \
  devtoolset-3 \
  git \
  openmpi-devel \
  openssl-devel \
  libcsv-devel \
  python-devel \
  python-pip \
  python-setuptools \ 
  postgresql-devel \
  python-virtualenv

# scl enable devtoolset-3 bash
ENV INFOPATH /opt/rh/devtoolset-3/root/usr/share/info
ENV PATH /opt/rh/devtoolset-3/root/usr/bin:/usr/lib64/openmpi/bin:$PATH
ENV X_SCLS devtoolset-3
ENV LD_LIBRARY_PATH /opt/rh/devtoolset-3/root/usr/lib64:/opt/rh/devtoolset-3/root/usr/lib:/usr/lib64/openmpi/lib
ENV MPI_DIR /etc/alternatives
ENV VARIANTSTORE_DIR /opt/variant_store

# store repository must be cloned into the docker context before docker build.
# git clone --recursive --depth 1 git@github.com:Intel-HSS/store.git $VARIANTSTORE_DIR/store
# after recursive clone you'll need to remove the ".git" files and directories so that htslib Makefile doesn't try to
# read the library version number from the git repository.  The problem is that the submodules use absolute pathnames,
# which will be absolute in the host machine, not the image, so reading the version from git files produces error
# messages.
# find . -name ".git*" -exec rm -rf {} \;
WORKDIR $VARIANTSTORE_DIR
ADD store store/

# Build TileDB
WORKDIR $VARIANTSTORE_DIR/store/search_library/dependencies/GenomicsDB
RUN make TILEDB_DIR=dependencies/TileDB/ RAPIDJSON_INCLUDE_DIR=dependencies/RapidJSON/include/ BUILD=release USE_LIBCSV=1 OPENMP=1 -j 6

# Build GenomicsDB
WORKDIR $VARIANTSTORE_DIR/store/search_library
RUN make BUILD=release GENOMICSDB_DIR=/opt/variant_store/store/search_library/dependencies/GenomicsDB/ USE_LIBCSV=1 OPENMP=1 -j 6

# Install python dependencies and store modules
WORKDIR $VARIANTSTORE_DIR/store
RUN virtualenv venv
RUN . venv/bin/activate
RUN pip install -r requirements.txt && python setup.py develop
ENV PATH $VARIANTSTORE_DIR/store/search_library/dependencies/GenomicsDB/bin:$PATH

# Create volume and import workspace
RUN mkdir /opt/genomic_io/
RUN create_tiledb_workspace /opt/genomic_io/ce/
VOLUME /opt/genomic_io/

# Configure Server
ADD variantstore.ini . 
ADD ga4gh.conf web/ga4gh_test.conf
ENV PYTHONPATH $VARIANTSTORE_DIR/store/web

EXPOSE 5000
ENTRYPOINT ["uwsgi"]
CMD ["--ini", "variantstore.ini"]