#!/bin/bash

echo "---got signal handler at : $WC_NOTIFY" > /tmp/heat-signaling
echo "Openstack Ansible roles are being installed" >> /tmp/install_output

cd /tmp/
git clone http://github.com/internap/openstack-ansible+heat
cp -R /tmp/openstack-ansible+heat /etc/ansible/

echo "Openstack Ansible roles installed" >> /tmp/install_output
$WC_NOTIFY --data-binary '{"status": "SUCCESS"}'
