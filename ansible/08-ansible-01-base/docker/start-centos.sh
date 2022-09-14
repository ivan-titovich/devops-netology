#!/bin/bash
# howto: bash start-centos.sh name_for_container
MYNAME=$1

docker run --name $MYNAME -p 222:22 -d cent1 bin/bash -c 'service ssh start | sleep 6000'
