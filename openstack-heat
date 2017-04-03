#!/usr/bin/env sh
# parameters :
#   --
#   --os-cloud=     your cloud.yaml cloud name to use
#   --environment=  the environment file to load
#   name            name of the stack you want to create
#
# example : ./openstack-heat.yaml --os-cloud=inap-Demo1 --environment=data/docker-default.yaml testbruno
#

USAGE="Openstack Heat template executor\n
Usage: $(basename "$0") [-h] [-o] [-r] \n
\n
Options:\n
    -h  show this help prompt\n
    -o  name of clouds.yaml profile/account to use\n
    -r  name of the role/template to execute"

for param in "$@"
do
  case $param in
    -o=*|--os-cloud=*)
      OS_CLOUD=`echo $param | sed 's/[-a-zA-Z0-9]*=//'`
      ;;
    -r=*|--role=*)
      ROLE=`echo $param | sed 's/[-a-zA-Z0-9]*=//'`
      ;;
    -h=*|--help=*)
      HELP=YES
      echo ${HELP}
      ;;
    *)
      ;;
esac
done

if [[ -z ${ROLE} ]] || [[ -z ${OS_CLOUD} ]]; then
  echo ${USAGE}
else
  $(openstack stack create -t heat-templates/${ROLE}.yaml --os-cloud=${OS_CLOUD} --environment=data/${ROLE}-default.yaml heat-${ROLE})
fi
