#
# Initialize MetaDB in PostgreSQL container. 
#
# Installation described https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#
FROM centos:7

# psycopg2 needs pg_config in postgresql-devel
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install \	
  openssl-devel \
  python-devel \
  python-pip \
  postgresql-devel 
RUN yum -y groupinstall "Development Tools"

# install python dependencies and store modules.
# for consistency, keep using VARIANTSTORE_DIR
ENV VARIANTSTORE_DIR /opt/variant_store
ENV PYTHONPATH=$PYTHONPATH:$VARIANTSTORE_DIR/store/
WORKDIR $VARIANTSTORE_DIR/store

ADD metadb ./metadb
# ADD requirements.txt .

# RUN pip install -r requirements.txt 
RUN pip install \
    alembic \
    psycopg2

WORKDIR $VARIANTSTORE_DIR/store/metadb
ADD alembic.metadb.ini ./alembic.ini
CMD alembic upgrade head