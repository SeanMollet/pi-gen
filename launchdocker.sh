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

CONTAINER_NAME='apt-cacher-ng'
CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)
if [ ! "${CID}" ]; then
	echo Launching apt-cacher-ng
	docker build -t sameersbn/apt-cacher-ng github.com/sameersbn/docker-apt-cacher-ng
	docker run --name apt-cacher-ng --init -d --restart=always \
	  --publish 3142:3142 \
	  --volume apt-cacher-ng-data:/var/cache/apt-cacher-ng \
	  sameersbn/apt-cacher-ng || docker start apt-cacher-ng
fi
	  
  
