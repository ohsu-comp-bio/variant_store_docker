FROM variantstoredocker_tile_db

EXPOSE 5000

ENV VARIANT_STORE_DIR /opt/variant_store

ADD . /

WORKDIR $VARIANT_STORE_DIR/search_library

RUN apt-get -qq update

RUN apt-get install -y \
  libmysqlclient-dev \
  python-dev \
  python-setuptools

# Create virtual environment and install reqs into that virtualenv.
RUN easy_install pip && pip install virtualenv
RUN virtualenv $VARIANT_STORE_DIR/.venv
RUN $VARIANT_STORE_DIR/.venv/bin/pip install -r ../GA4GHAPI/reqs.txt

RUN make TILEDB=$TILEDB_DIR/ SPEED=1 -j 8
