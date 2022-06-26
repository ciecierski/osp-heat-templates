#!/bin/bash

exec > >(tee -a 05-ceph-deploy.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc
time openstack tripleo container image prepare -e /home/stack/container-image-prepare.yaml

time openstack overcloud ceph deploy \
  -o /home/stack/overcloud-ceph-deployed.yaml \
  --container-image-prepare /home/stack/container-image-prepare.yaml \
  --stack ${STACK_NAME} \
  --network-data /home/stack/default-network-isolation.yaml \
  /home/stack/overcloud-baremetal-deployed-${STACK_NAME}.yaml \
  $@

date
