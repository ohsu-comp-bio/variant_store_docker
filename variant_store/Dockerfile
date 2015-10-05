FROM variantstoredocker_tile_db

EXPOSE 5000

ENV VARIANT_STORE_DIR /opt/variant_store
ENV VARIANT_STORE_GA4GH_CONFIG $VARIANT_STORE_DIR/GA4GHAPI/ga4gh/ga4gh.conf

# TileDB configuration variables
ENV TILEDB_CONFIG_WORKSPACE /data/tiledb/workspace
ENV TILEDB_CONFIG_ARRAY_NAME variant_store

ADD . /

WORKDIR $VARIANT_STORE_DIR

RUN apt-get -qq update

RUN apt-get install -y \
  libmysqlclient-dev \
  python-dev \
  python-setuptools

RUN easy_install pip && pip install \
  jinja2 \
  virtualenv 

# Create a virtual environment and install reqs into that virtualenv.
RUN virtualenv $VARIANT_STORE_DIR/.venv
RUN $VARIANT_STORE_DIR/.venv/bin/pip install -r GA4GHAPI/reqs.txt

# Render our config file using environmental variables
RUN j2 /etc/variant_store/ga4gh.conf.j2 > $VARIANT_STORE_GA4GH_CONFIG

RUN cd search_library && make TILEDB=$TILEDB_DIR/ SPEED=1 -j 8
