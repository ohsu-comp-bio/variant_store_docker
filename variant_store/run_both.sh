#!/bin/bash

alembic upgrade head

# libquery.so at $VARIANTSTORE_DIR/store/search_library/lib

# Expose application port
# EXPOSE 5000
ls
cd ..
#WORKDIR $VARIANTSTORE_DIR/store

#ENTRYPOINT ["uwsgi"]
#CMD ["--ini",  "variantstore.ini"]

uwsgi --ini variantstore.ini