### An ansible AND heat template repository to manage different workload on internap public cloud


It currently fully support the following workload

+ ![Progress](http://progressed.io/bar/80)   [docker](/roles/docker) - A basic docker installation
+ ![Progress](http://progressed.io/bar/80)   [docker-swarm](/roles/docker-swarm) - A swarm installation (using latest swarm version)
+ ![Progress](http://progressed.io/bar/40)   [maas](/roles/maas)  - A basic Ubuntu MaaS installation for inventory management
+ ![Progress](http://progressed.io/bar/20)   [rancher](/roles/rancher) - A rancher mode installation
+ ![Progress](http://progressed.io/bar/100)  [docker-stable](/roles/docker-stable)  - The current stable version of docker installation

You can see the support details by clicking the workload name.

## What does it do ?
It really depends of the workload you want to deploy, but bundle, by default, you get :
- full dynamic inventory from OpenStack, allowing you to grow or shrink your deployment as needed
- unless specified otherwise, a specific ssh key to the deployment, ensuring only
people having this key can access the deployed nodes
- a separation between 'public nodes' who are internet exposed and hardened to
avoid any unneeded exposure and the 'private nodes' who are only communicating
through the local customer-specific network
- a bridge (bastion technically), for you to be able to access the private nodes securely
- a proxy configuration, for the private nodes to be able to do update and installations of package

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

#### Using Ansible
1. First, install Ansible:
   * On Ubuntu
   ```bash
   sudo apt-get install ansible
   ```
   * On CentOS
   ```bash
   sudo yum install ansible
   ```
   * On MacOSX (you need to have brew installed)
   ```bash
   brew install ansible
   ```
2. Clone this repo :
  ```bash
   git clone https://github.com/internap/ansible-ansible-heat
  ```
3. Make sure your clouds.yaml file is configured properly:
  ```bash
  cat ~/.config/openstack/clouds.yaml
  ```
  it should look something like :
 ```text
  clouds:
    inap-AMSDemo1:
      profile: internap
      auth:
        auth_url:       https://identity.api.cloud.iweb.com/v3
        project_name:   inap-12345
        domain_name:    default
        username:       api-RANDOM_NUMBER_GIVENTOYOU
        password:       YOUR_PASSWORD
      region_name:      ams01
  ```

4. launch the Ansible playbook using :
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=<THE_WORKLOAD_NAME>
  ```

#### Using Heat
1. First, install pip and python:
   * On Ubuntu
   ```bash
   apt install python-dev python-pip
   ```
   * On CentOS
   ```bash
   yum install python-devel python-pip
   ```
   * On MacOSX (you need to have brew installed)
   ```bash
   brew install python
   ```
2. Install the OpenStack Client:
  ```bash
  pip install python-openstackclient
  ```
2. Clone this repo:
  ```bash
  git clone https://github.com/internap/ansible-ansible-heat
  ```
3. Make sure your clouds.yaml file is configured properly:
  ```bash
  cat ~/.config/openstack/clouds.yaml
  ```
  it should look something like:
  ```text
  clouds:
    inap-AMSDemo1:
      profile:        internap
      auth:
        auth_url:       https://identity.api.cloud.iweb.com/v3
        project_name:   inap-12345
        domain_name:    default
        username:       api-RANDOM_NUMBER_GIVENTOYOU
        password:       YOUR_PASSWORD
      region_name:      ams01
  ```
4. launch the Heat template using:
  ```bash
  ./openstack-heat --os-cloud=<MY_CLOUDS_YAML_PROFILE> --role=<THE_WORKLOAD_NAME>
  ```

### Optional parameters:
* node_count= the total number of node you want to create/maintain
* public_node_count= the number of node you want to be public facing
* action= a non-default action to trigger, that can be :
 - delete: the script will then delete all existing instances
 - delete_all: the script will delete instance, local config files and keys in OS
 - delete_all_includinguserkey: the script will wipe keys and instances both in OS and locally
* key_filename= explicit SSH key file name to use

##### Which would mean, for a 4 node docker swarm cluster using a shared ssh key stored in /tmp/blabla:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=<THE_WORKLOAD_NAME> -e node_count=4 -e key_filename=/tmp/blabla
  ```
* using Heat:
  ```bash
  ./openstack-heat --os_cloud=<MY_CLOUDS_YAML_PROFILE> --role=<THE_WORKLOAD_NAME> --node_count=4 --key_filename=/tmp/blabla
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
