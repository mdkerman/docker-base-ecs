#!/bin/bash

TAG=`cat TAG`

# Needs to run as root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

set -e

BASE=`grep FROM Dockerfile | cut -d ' ' -f 2`

if ! (echo $BASE | grep -q ^barchart); then
	docker pull $BASE
fi

docker build -t $TAG -q .
docker save $TAG | docker-squash -t $TAG | docker load
docker images -f dangling=true -q | xargs docker rmi
