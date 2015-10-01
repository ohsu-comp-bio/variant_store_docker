FROM tiledb

EXPOSE 5000

ENV STORE_DIR /opt/store

ADD . $STORE_DIR

ADD etc /etc

WORKDIR $STORE_DIR/search_library

RUN apt-get -qq update

RUN apt-get install -y python-setuptools \
	python-dev \
	libmysqlclient-dev

RUN easy_install pip
RUN pip install --upgrade
RUN pip install -r ../GA4GHAPI/reqs.txt

RUN make TILEDB=$TILEDB_DIR SPEED=1 -j 8
