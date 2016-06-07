

The postgres default port is 5432.

 docker run --rm -p 5432:5432 --name metadb postgres

if running on OS X you need to forward the container ports to make the accessible to outside the
docker machine:

 docker-machine ssh default -L 5432:localhost:5432

"postgres" is the default user in the postgres image.  This command lists the database in the
postgres server:

 psql -l postgresql://localhost:5432 postgres