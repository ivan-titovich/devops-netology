#!/bin/bash

set -e

function delete_vm {
  local NAME=$1
  $(yc compute instance delete --name="$NAME")
}

delete_vm "controlplane1"
delete_vm "controlplane2"
delete_vm "controlplane3"
delete_vm "workernode1"
delete_vm "workernode2"