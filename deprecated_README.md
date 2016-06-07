### Variant Store Docker Images ###

This repository contains a [Docker Compose](https://docs.docker.com/compose/)
configuration for instantiating a Variant Store configuration. There are three
images used in this configuration:

# 1. `tile_db`: This image compiles and installs TileDB from source.
1. 'store_base': This images is defined in the 'GenomicsDB' directory; it compiles and installs TileDB and the extention GenomicsDB from source. 

2. `variant_store`: Installs Variant Store from source and installs the
  GA4GH-based web server as a service. Also contacts the PostgreSQL container and initializes the metadb arrays. 

#3. `data`: A simple [data container](https://medium.com/@ramangupta/why-docker-data-containers-are-good-589b3c6c749e) (data containers replaced by [named volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/)) that's used for managing the TileDB workspace. Note that this creates a `/data` directory at the root of the filesystem that is shared across any containers that call `--volumes-from=variant_store_data`.

3. `metadb`: Extends the official PostgreSQL image for use with the MetaDB portion of variant store.  

#Since these services are built off of [Phusion's Baseimage](http://phusion.github.io/baseimage-docker/),
#each image may install init scripts from `<image_name>/etc/my_init.d/*` to
`/etc/init.d/` in the container. These scripts are ran each time a container is
created.
PostgreSQl mage is based on Debian, others on Centos7. 

Additional services, such as the GA4GH web service, are installed from
`<image_name>/etc/service/<service_name>/run` are installed on the system.
Please read up on the Phusion Baseimage documentation on why this is.

Finally, any additional scripts are installed from `<image_name>/usr/local/bin`.

#### Running ####

First, make sure that you run `git submodule init` and `git submodule update` to pull the latest source code from TileDB and the Variant Store.

1. `docker-compose build`: First build all of the images.

2. `docker-compose start variant_store_data`: Start the data container. This 
  container wil exit immediately.

3. `docker cp docker cp </local/path/to/tiledb> variant_store_data:/data`: We
  need to copy data from the host to the data container. The local `tiledb`
  directory structure should look like:

  ```
  tiledb
  ├── data.tiledb
  ├── metadata.json
  └── workspace
  ```
  where `data.tiledb` should be the CSV file containing variant data and
  `metadata.json` is the JSON configuration containing metadata for the
  variants. `workspace` should be an empty directory.

4. `docker-compose up`: This will start our services.

You can test by running `curl http://localhost:3000` where the Docker daemon is
running which should yield the HTML response:

```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>404 Not Found</title>
<h1>Not Found</h1>
<p>The requested URL was not found on the server.  If you entered the URL manually please check your spelling and try again.</p>
```
