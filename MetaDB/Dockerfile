#
# Open MetaDB as part of https://github.com/Intel-HSS/store
#
# Described by https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#

FROM store_base

RUN yum -y install \
    nginx \
    mod_wsgi \
    python-pip \
    python-devel \
    postgresql \
    postgresql-devel \
    postgresql-server 

WORKDIR $VARIANTSTORE_DIR/store
RUN pip install -r requirements.txt

#RUN createdb MetaDB

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
USER postgres

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
ENV PYTHONPATH $PYTHONPATH:$VARIANTSTORE_DIR/store/:$VARIANTSTORE_DIR/store/web

VOLUME /var/lib/postgresql/data

RUN initdb /var/run/postgresql