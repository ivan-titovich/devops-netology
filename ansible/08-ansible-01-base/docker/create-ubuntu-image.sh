#!/bin/bash
# howto: bash create-ubuntu-image.sh name_for_image
IMAGETAG=$1

docker build -f ubuntu/Dockerfile -t $IMAGETAG .