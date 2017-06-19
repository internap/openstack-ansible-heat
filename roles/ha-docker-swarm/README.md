### An ansible template to install and manage a Docker Swarm (latest)

See [the main documentation](/) for installation instruction and details.

+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) HA installation and config
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) Security hardening

## What does it do ?
Adding to the docker-swarm workload features, this template/recipe add high
availability. By default, unless you specify more using the public_node_count
parameters, 2 publicly exposed instance will be elected as Swarm Manager. They
will be load-balanced using keepalived on a shared OpenStack Neutron port.
This Neutron port IP should then be used in your DNS entries.

### Private / public nodes split
- If don't specify the public_node_count parameters during the deployment, we will
automatically elect the first 2 nodes as the managers of the Swarm and the first
one will be the Leader of the Swarm
- We will use the remainder left after instantiating the number of public node
specified in the public_node_count parameter as private nodes, not accessible to
the internet unless you go through the ssh bastion server.

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

### Creating/adding 4 nodes to the Swarm:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=ha-docker-swarm -e node_count=4
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  
