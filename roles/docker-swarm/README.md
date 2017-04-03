### An ansible AND heat template to install and manage a Docker Swarm (latest)

See [the main documentation](/) for installation instruction and details.

+ ![Progress](http://progressed.io/bar/100)   (Ubuntu) Docker Swarm installation and configuration
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) Security hardnessing
+ ![Progress](http://progressed.io/bar/0)     (Ubuntu) High availability

## What does it do ?
Adding to the basic workload features, this template/recipe add the installation
and configuration of a Docker Swarm. All 'public' nodes will be elected as Leader
in the swarm, all 'private' nodes will be 'slaves'.

### Private / public nodes split
- If don't specify the public_node_count parameters during the deployment, we will
automatically elect the first node as the one, publicly exposed, Leader of the Swarm
- Otherwise, we will use the remainder left after instantiating the number of public node
specified in the public_node_count parameter as private nodes.

## How to use
> **Note:** These are currently configured to be used with an Internap Agile Cloud account.

### Creating/adding 4 nodes to the Swarm:
* using Ansible:
  ```bash
  ./openstack-ansible -e os_cloud=<MY_CLOUDS_YAML_PROFILE> -e role=docker-swarm -e node_count=4
  ```
* using Heat:
  ```bash
  ./openstack-heat --os-cloud=<MY_CLOUDS_YAML_PROFILE> --role=docker-swarm --node_count=4
  ```

# Contributing
Feel free to raise issues and send some pull request, we'll be happy to look at them!
We also would love to have other provider adding their own workload and configuration
to make it a repository of generic, hardened, IaaS recipe.  