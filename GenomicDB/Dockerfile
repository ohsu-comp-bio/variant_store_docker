#
# Build GenomicsDB from https://github.com/Intel-HLS
#
# https://github.com/Intel-HLS/GenomicsDB/wiki/Compiling-GenomicsDB
#
FROM centos:7

#
# build requires gcc version >= 4.9.0, which we get using devtoolset-3.
RUN yum -y update
RUN yum -y install centos-release-scl-rh
RUN yum -y install epel-release
RUN yum -y install \
  devtoolset-3 \
  git \
  openmpi-devel \
  openssl-devel \
  libcsv-devel
RUN yum -y groupinstall "Development Tools"

# scl enable devtoolset-3 bash
ENV INFOPATH /opt/rh/devtoolset-3/root/usr/share/info
ENV PATH /opt/rh/devtoolset-3/root/usr/bin:/usr/lib64/openmpi/bin:$PATH
ENV X_SCLS devtoolset-3
ENV LD_LIBRARY_PATH /opt/rh/devtoolset-3/root/usr/lib64:/opt/rh/devtoolset-3/root/usr/lib:/usr/lib64/openmpi/lib

ENV MPI_DIR /etc/alternatives
ENV VARIANTSTORE_DIR /opt/variant_store

# store repository must be cloned into the docker context before docker build.
# git clone --recursive --depth 1 https://github.com/Intel-HSS/store.git $VARIANTSTORE_DIR/store
# after recursive clone you'll need to remove the ".git" files and directories so that htslib Makefile doesn't try to
# read the library version number from the git repository.  The problem is that the submodules use absolute pathnames,
# which will be absolute in the host machine, not the image, so reading the version from git files produces error
# messages.
# find . -name ".git*" -exec rm -rf {} \;
WORKDIR $VARIANTSTORE_DIR
ADD store store/

WORKDIR $VARIANTSTORE_DIR/store/search_library/dependencies/GenomicsDB
RUN make TILEDB_DIR=dependencies/TileDB/ RAPIDJSON_INCLUDE_DIR=dependencies/RapidJSON/include/ BUILD=release USE_LIBCSV=1 OPENMP=1 -j 6

WORKDIR $VARIANTSTORE_DIR/store/search_library
RUN make BUILD=release GENOMICSDB_DIR=/opt/variant_store/store/search_library/dependencies/GenomicsDB/ USE_LIBCSV=1 OPENMP=1 -j 6

CMD echo "I'm functional!"
