#!/bin/bash
# howto: bash start-ubuntu.sh name_for_container
MYNAME=$1

docker run --name $MYNAME -p 22:22 -d ub1 bin/bash -c 'service ssh start | sleep 6000'
