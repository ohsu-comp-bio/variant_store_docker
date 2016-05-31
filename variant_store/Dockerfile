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
  python-devel
#  mod_wsgi
#   uwsgi \
#   uwsgi-plugin-python

# install python dependencies and store modules.
#
WORKDIR $VARIANTSTORE_DIR/store
RUN pip install -r requirements.txt
RUN python setup.py develop

# add server configuration files
ADD variantstore.ini .
ADD ga4gh.conf web/ga4gh_test.conf

ENV PYTHONPATH $VARIANTSTORE_DIR/store/web

# Expose application port
EXPOSE 5000

ENTRYPOINT ["uwsgi"]
CMD ["--ini",  "variantstore.ini"]

# install.py expects there to be a $USER, but docker container doesn't have one.
#
# install creates "GA4GHAPI.pth in ~/.local/lib/python/site-packages.  is that supposed to load into the PYTHONPATH?
#
#  wsgi.py checks for PYTHONPATH having "web".
#  	Exception: GA4GHAPI path is not set. Run store/web/install.py, and use --system-site-packages when creating a virtualenv
#
#  wsgi.py loads ga4gh_test.conf by default
#
# why does config file need to specify virtualenv location?
#
# No such file or directory: '/variantdb/repos/venv/bin/activate_this.py'