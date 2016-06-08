
Commands for running MetaDB in PostgreSQL container, with initialization occuring in separate variant_metadb_init container. 

Create new network for the containers:

  docker network create --driver bridge variant_store

Build and run postgresql and metadb:

Inside variant_metadb/

  docker build -t variant_metadb . 

  docker run -p 5432:5432 --net=variant_store -d --name variant_metadb variant_metadb

** The choice of container name is important here; variant_metadb is the name that the initialization process knows to look for to complete. 

Start MetaDB Initialization:

Inside variant_metadb_init/

  docker build -t variant_metadb_init .

  docker run --net=variant_store variant_metadb_init


Commands for spinning up all containers with docker-compose:

In variant_store_docker/

  docker-compose build

  docker-compose up