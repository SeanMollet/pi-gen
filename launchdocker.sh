#!/bin/bash
arch=$(uname -i)

docker build -t seanmollet/pi-gen -f Dockerfile ./

mkdir -p work
mkdir -p deploy

docker stop pi-gen
docker rm pi-gen
docker run -d \
--privileged \
--cap-add=ALL \
-v /lib/modules:/lib/modules \
-v /dev:/dev \
-v $PWD:/pi-gen \
--name pi-gen seanmollet/pi-gen

  
