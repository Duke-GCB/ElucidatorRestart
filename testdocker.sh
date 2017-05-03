#!/usr/bin/env bash
# Builds docker image and runs it mounting ./external and passing host to communicate with.
set -e

ELUCIDATOR_HOST=ubuntu@10.16.72.64
PWD=$(pwd)
IMAGENAME=quay.io/dukegcb/elucidator-restart

docker build -t $IMAGENAME .

docker run -p 443:443 -p 80:80 -e ELUCIDATOR_HOST=$ELUCIDATOR_HOST -v $PWD/external:/etc/external -v $PWD/external/ssh:/usr/share/httpd/.ssh $IMAGENAME
