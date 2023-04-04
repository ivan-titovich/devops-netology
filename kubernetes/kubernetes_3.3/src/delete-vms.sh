#!/bin/bash

set -e

function delete_vm {
  local NAME=$1
  $(yc compute instance delete --name="$NAME")
}

delete_vm "master1"
delete_vm "worker1"
delete_vm "worker2"


