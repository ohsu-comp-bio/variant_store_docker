
Start server as

  docker run -p 5000:5000 variant_store


  # set port forwarding in docker-machine.
  docker-machine ssh default -L 5000:localhost:5000

  access running image at http://127.0.0.1:5000