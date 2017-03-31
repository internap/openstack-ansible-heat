# openstack-ansible-heat
An ansible AND heat template repository to manage different workload on internap public cloud

You have to pass parameters using -e <PARAM1>=<VALUE1> -e <PARAMS2>=<VALUE2> for Ansible
and directly on the command line for Heat

Mandatory parameters:
role=               the role you want to push
os_cloud=           your clouds.yaml cloud profile/account name

optional parameters:
node_count=         the total number of node you want to create/maintain
public_node_count=  the number of node you want to be public facing
action=             a non-default action to trigger, can be :
                   - delete: the script will then delete all existing instances
                   - delete_all: the script will delete instance, local config files and keys in OS
                   - delete_all_includinguserkey: the script will wipe keys
                       and instances both in OS and locally
key_filename=       explicit SSH key file name to use
