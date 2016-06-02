#
# Open MetaDB as part of https://github.com/Intel-HSS/store
#
# Described by https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#

FROM postgres

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y nginx \
    libapache2-mod-wsgi \
    python-pip \
    python-dev

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH

#ENV PYTHONPATH $PYTHONPATH:$VARIANTSTORE_DIR/store/:$VARIANTSTORE_DIR/store/web
