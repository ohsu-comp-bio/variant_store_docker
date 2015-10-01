FROM phusion/baseimage

ENV LD_LIBRARY_PATH /usr/lib/openmpi/lib/

ENV TILEDB_DIR /opt/tiledb
ENV TILEDB_BIN $TILEDB_DIR/tiledb_cmd/bin/release

# Default directory where data is stored.
ENV TILEDB_DATA_DIR /data/tiledb

# Metadata for data to be imported.
ENV TILEDB_DATA_CONFIG $TILEDB_DATA_DIR/data.json

# CSV data to be imported.
ENV TILEDB_IMPORT_DATA $TILEDB_DATA_DIR/data.csv

# Use sane defaults for TileDB.
ENV TILEDB_CONFIG_ATTRIBUTE_NAMES END,REF,ALT,QUAL,FILTER,BaseQRankSum,ClippingRankSum,MQRankSum,ReadPosRankSum,DP,MQ,MQ0,DP_FORMAT,MIN_DP,GQ,SB,AD,PL,GT
ENV TILEDB_CONFIG_DIM_NAMES samples,position
ENV TILEDB_CONFIG_TYPES int64,char:var,char:var,float,int:var,float,float,float,float,int,float,int,int,int,int,int:4,int:var,int:var,int:var,int64
ENV TILEDB_CONFIG_CELL_ORDER column-major
ENV TILEDB_CONFIG_CAPACITY 1000
ENV TILEDB_CONFIG_CONSOLIDATION_STEP 5

# Note that TILEDB_CONFIG_DIM_DOMAINS is specified in 20_define_array
ENV TILEDB_CONFIG_MAX_COL_DOMAIN 4000000000

ADD . $TILEDB_DIR

WORKDIR $TILEDB_DIR

RUN apt-get -qq update

RUN apt-get install -y autotools-dev \
	g++ \
	build-essential \
	openmpi-bin \
	openmpi-doc \
	libopenmpi-dev

RUN make MPIPATH=/etc/alternatives/ BUILD=release -j 8
