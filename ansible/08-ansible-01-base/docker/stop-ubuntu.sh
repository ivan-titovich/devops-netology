#!/bin/bash
# howto: bash start-ubuntu.sh name_for_container
MYNAME=$1

docker stop $MYNAME
