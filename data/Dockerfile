#
# Fill the variant store of https://github.com/Intel-HSS/store
#
# General Requirements described by https://github.com/Intel-HSS/store/wiki/Setup-and-Initialization
#

FROM store_base

# We will need python stuffs
RUN yum -y install \
    python-pip \
    python-setuptools \
    python-devel \
    postgresql-devel

WORKDIR $VARIANTSTORE_DIR/store
RUN pip install -r requirements.txt
# RUN python setup.py develop
# pretty sure setup.py is only necessary for metadb and/or server

ENV PATH /opt/variant_store/store/search_library/dependencies/GenomicsDB/bin:$PATH

RUN create_tiledb_workspace $VARIANTSTORE_DIR/GenomicsDB_Workspace

WORKDIR $VARIANTSTORE_DIR/store/utils

# Before build/run of image, edit config files in dockerfile directory to fit desired parameters. 
# Info on parameter choices at https://github.com/Intel-HLS/GenomicsDB/wiki/Importing-VCF-data-into-GenomicsDB#execution-parameters-for-the-import-program
# And at https://github.com/Intel-HSS/store/wiki/VCF-to-TileDB-Import-Design#config-file
ADD store_config_files/load_to_tile.cfg $VARIANTSTORE_DIR/store/utils/example_configs/load_to_tile.cfg
ADD store_config_files/tile_loader.json $VARIANTSTORE_DIR/store/utils/example_configs/tile_loader.json

RUN python maf2tile.py