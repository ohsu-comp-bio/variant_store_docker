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
RUN python setup.py develop

ENV PATH /opt/variant_store/store/search_library/dependencies/GenomicsDB/bin:$PATH

RUN create_tiledb_workspace $VARIANTSTORE_DIR/GenomicsDB_Workspace

WORKDIR $VARIANTSTORE_DIR/store/utils

# Before build/run of image, edit config files in dockerfile directory to fit desired parameters. 
# Info on parameter choices at https://github.com/Intel-HLS/GenomicsDB/wiki/Importing-VCF-data-into-GenomicsDB#execution-parameters-for-the-import-program
# And at https://github.com/Intel-HSS/store/wiki/VCF-to-TileDB-Import-Design#config-file
ADD store_config_files/load_to_tile.cfg $VARIANTSTORE_DIR/store/utils/example_configs/load_to_tile.cfg
ADD store_config_files/tile_loader.json $VARIANTSTORE_DIR/store/utils/example_configs/tile_loader.json
ADD store_config_files/project_config.json $VARIANTSTORE_DIR/store/utils/example_configs/project_config.json
ADD store_config_files/variant_config.json $VARIANTSTORE_DIR/store/utils/example_configs/variant_config.json
ADD mafs_to_import/* /tmp/mafs_to_import/

CMD python maf2tile.py -c example_configs/project_config.json -o outputfi.txt -d $VARIANTSTORE_DIR/store/ -i /tmp/mafs_to_import -l ./example_configs/load_to_tile.cfg