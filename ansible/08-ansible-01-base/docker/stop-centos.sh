#!/bin/bash
# howto: bash start-centos.sh name_for_container
MYNAME=$1

docker stop $MYNAME
