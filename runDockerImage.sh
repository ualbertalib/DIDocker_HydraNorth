#!/bin/bash

if [[ -z "$LOCAL_SRC_PATH" || -z "$EZID_PASSWORD" || -z "$IMG_TAG" ]]; then
    echo ""
    echo "Need to set following environment variables: "
    echo ""
    echo "LOCAL_SRC_PATH to point to your HydraNorth source tree root"
    echo "EZID_PASSWORD to contain EZID testing password"
    echo "IMG_TAG specify which image you are usin, should be either 'centos' or 'deb'"
    echo ""
    exit 1
fi

dockerversion=$(docker --version  | cut -f3 -d' ' | sed 's/[^0-9.]//g'| cut -f1,2 -d'.')
if [[ "$dockerversion"  < "1.13" ]]; then
    echo "You are running docker version $dockerversion, this image does not run properly on"
    echo "version less then 1.13, please make sure you have docker version 1.13 or higher"
    echo ""
    exit 1
fi

export IMAGE=ualibraries/hydra_north:$IMG_TAG
docker run -d -v $LOCAL_SRC_PATH:/app -p 3000:3000 -p 8983:8983 -e EZID_PASSWORD=$EZID_PASSWORD $IMAGE
docker logs -f $(docker ps | grep $IMAGE | cut -d " " -f1)
