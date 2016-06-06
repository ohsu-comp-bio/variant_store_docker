
Commands for running MetaDB in PostgreSQL container, with initialization occuring in separate variant_store_server container. 

Create new network for the containers:

docker network create --driver bridge metadb_network

Build and run postgresql and metadb:

Inside MetaDB/

docker build -t store_metadb . 

docker run -p 5432:5432 --net=metadb_network -d --name metadb store_metadb

Start Variant Store Server:

Inside variant_store/

docker build -t store_server . 

docker run --net=metadb_network store_server