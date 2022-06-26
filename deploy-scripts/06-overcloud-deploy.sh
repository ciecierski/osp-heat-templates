#!/bin/bash

exec > >(tee -a 06-overcloud-deploy.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc

time openstack overcloud deploy \
  --overcloud-ssh-user stack \
  --stack ${STACK_NAME} \
  --templates /usr/share/openstack-tripleo-heat-templates \
  --networks-file /home/stack/default-network-isolation.yaml \
  -e /home/stack/overcloud-network-deployed-${STACK_NAME}.yaml \
  -e /home/stack/overcloud-vip-deployed-${STACK_NAME}.yaml \
  -e /home/stack/overcloud-baremetal-deployed-${STACK_NAME}.yaml \
  -e /home/stack/overcloud-ceph-deployed.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/cephadm/cephadm.yaml \
  -e /home/stack/overcloud-environment.yaml \
  -e /home/stack/container-image-prepare.yaml \
  $@

date
