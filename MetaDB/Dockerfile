#
# Open MetaDB as part of https://github.com/Intel-HSS/store
#
# Described by https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#

FROM postgres

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y nginx \
    libapache2-mod-wsgi \
    python-pip \
    python-dev

ENV POSTGRES_USER metadb \
    POSTGRES_PASSWORD metadb \
    POSTGRES_DB metadb

#ENV PYTHONPATH $PYTHONPATH:$VARIANTSTORE_DIR/store/:$VARIANTSTORE_DIR/store/web
