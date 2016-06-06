#
# Build https://github.com/Intel-HSS/store
#
# Installation described https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#
FROM store_base

# psycopg2 needs pg_config in postgresql-devel
RUN yum -y install epel-release
RUN yum -y install \
  python-pip \
  python-setuptools \
  postgresql-devel \
  python-devel \
  uwsgi

# install python dependencies and store modules.  Setting up a virtual environment shouldn't be necessary in a
# virtual container, but the code is written to expect it.
#
WORKDIR $VARIANTSTORE_DIR/store
#RUN pip install virtualenv
#RUN virtualenv venv
#RUN . venv/bin/activate && pip install -r requirements.txt && python setup.py develop
RUN pip install -r requirements.txt && python setup.py develop

# add server configuration files
#ADD variantstore.ini .
#ADD ga4gh.conf web/ga4gh_test.conf

ENV PYTHONPATH $VARIANTSTORE_DIR/store/web

WORKDIR $VARIANTSTORE_DIR/store/metadb
ADD alembic.metadb.ini ./alembic.ini
CMD alembic upgrade head

# libquery.so at $VARIANTSTORE_DIR/store/search_library/lib

# Expose application port
#EXPOSE 5000

#ENTRYPOINT ["uwsgi"]
#CMD ["--ini",  "variantstore.ini"]
