# Playa Mesos

Playa Mesos helps you quickly build functional [Mesos][Mesos] environments, complete with
[Zookeeper][Zookeeper], [Marathon][Marathon], and a sample application or two.  All components are
checked out from source and built from scratch.  This makes it easy to test the
latest builds or pin to a stable version.  This project relies heavily on
VirtualBox, Vagrant, and Ansible.

## Authors

* [Jeremy Lingmann](https://github.com/lingmann)

## Requirements

* [VirtualBox][VirtualBox] 4.2+
* [Vagrant][Vagrant] 1.3+
* The Internet (at least for the initial build)

## Quick Start

Commands below assume that your current working directory is the root of the
[Playa Mesos][Playa Mesos] checkout and VirtualBox is running on `localhost`.

1. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)

2. [Install Vagrant](http://downloads.vagrantup.com/)

3. Check that ports 5050 and 8080 are available (used by demo Vagrantfile)
```bash
netstat -an|egrep '(5050|8080)'|egrep LISTEN
```

4. Build the demo VM
```bash
( cd vagrant/demo && vagrant up --provision )
```
This will take some time!  Your demo VM is now building and installing Mesos
from source on top of a clean Ubuntu 12.04 image.  This will take approximately
30 minutes on a 2013 generation MacBook Pro.  If prompted for a bridge network
interface, choose an interface with a DHCP server available.  Bridging makes it
easier to access ports allocated by Mesos, however if you would prefer, you can
disable bridging in the Vagrantfile.

5. Connect to the Mesos Web UI: [http://localhost:5050](http://localhost:5050)

6. Connect to the Marathon Web UI: [http://localhost:8080](http://localhost:8080)

7. Start Jenkins on Mesos using the Marathon client
```bash
( cd vagrant/demo && vagrant ssh )
marathon start \
  --id="jenkins" \
  --command="java -Xmx512m -Xms512m -jar /opt/jenkins/jenkins.war --httpPort=\$PORT" \
  --cpus=0.5 \
  --mem=512 \
  --uri="https://s3.amazonaws.com/lingmann/jenkins_config-0.1.0.tgz" \
  --env="JENKINS_HOME=jenkins_config-0.1.0"
exit
```

8. Halt the demo VM
```bash
( cd vagrant/demo && vagrant halt )
```

## Jenkins Mesos Integration

For further information on Jenkins integration with Mesos see [Building a
framework on Mesos](http://www.youtube.com/watch?v=TPXw_lMTJVk).  Jump to
16m30s for specifics on how you can enable the Jenkins Mesos Framework and
create jobs which run on the cluster.

## Common Tasks

### Start the demo VM
```bash
( cd vagrant/demo && vagrant up )
```

### Destroy the demo VM
```bash
( cd vagrant/demo && vagrant destroy )
```

### Re-build the VM without destroying the image
```bash
( cd vagrant/demo && vagrant ssh )
sudo rm /var/tmp/*
sudo rm -rf /usr/local/src/*
exit
( cd vagrant/demo && vagrant provision )
```

### Connect to the VM directly with SSH
```bash
ssh -i ~/.vagrant.d/insecure_private_key -p 2222 vagrant@localhost
```

This is essentially the same as
```bash
( cd vagrant/demo && vagrant ssh )
```

## Troubleshooting

### General failures

Check your environment for the required tools and versions.  All of these must
be availabe and in your PATH.
```bash
vagrant --version
VBoxManage --version
```

### The demo build fails part-way through

Verify Internet connectivity from within the Virtual Machine.
```bash
( cd vagrant/demo && vagrant up && vagrant ssh )
ping www.google.com
exit
```
And try to re-provision.
```bash
( cd vagrant/demo && vagrant provision )
```

### Internet or network connectivity issues

Check the config.vm.provider section of your [Vagrantfile](https://github.com/lingmann/playa-mesos/blob/master/vagrant/demo/Vagrantfile) for [VirtualBox network
configuration options](http://www.virtualbox.org/manual/ch06.html).  You may need to adjust or add options depending
on your network requirements.

### ([Errno 8] Exec format error)

```
[default] Running provisioner: ansible...
ERROR: problem running /Users/jlingmann/code/playa-mesos/vagrant/demo/vagrant_ansible_inventory_default --list ([Errno 8] Exec format error)
Ansible failed to complete successfully. Any error output should be
visible above. Please fix these errors and try again.
```
Remove the execute bit from your inventory file with: `chmod -x vagrant_ansible_inventory_default`

### Something else?

Let me know!

## Known Issues

General
* The demo Virtual Machine uses an [INSECURE SSH KEYPAIR](https://github.com/mitchellh/vagrant/tree/master/keys)
* Mesos `make check` fails non-deterministicly and is disabled
* Java crashes regularly when running/building/unit-testing with Java 6
* The Jenkins plugin was recently removed from the Mesos repo and the build
  process needs to be updated to work with the new location
* Marathon builds are failing on the demo vm... even with this [recent
  fix](https://github.com/mesosphere/marathon/commit/26d2b8ceb6670bbd2bfd5578f47854373c4c7147) did not address all of the issues
  Perhaps an asset permissions issue?
* TCP ports `8080` and `5050` are forwarded to the VM and may conflict with
  existing listeners
* During the initial shell provisioning the warning `stdin: is not a tty` will
  appear. This is harmless and can be ignored. See [Vagrant Issue #1674](https://github.com/mitchellh/vagrant/issues/1673)

Mesos
* Mesos executor is running all jobs as root (yup!! need to figure out how to
  properly configure this)

Jenkins Mesos Plugin
* Jenkins Framework is requiring 2 CPU's, which is why the demo VM is
  configured with 4 CPU cores.

Marathon Client
* -u does not seem to support multiple args
* -u does not support 302 redirects (as used by github release links)

## TODO

* Move to externally driven configuration (~/.playa-mesos)
* Support using custom SSH keys
* Create wrapper script for managing VM's
* Automatically configure Jenkins to use the Mesos Cloud
* Figure out better ways to compile and link the Jenkins plugin so that it is
  not as dependant on the Mesos build environment (for example, the plugin may
  have mesos libraries linking to libunwind.so...)
* Provide a way to create a demo VM using packaged components instead of
  building them from scratch when improved packages are available.
* Add support for CentOS

[Mesos]: http://incubator.apache.org/mesos/ "Apache Mesos"
[Marathon]: http://github.com/mesosphere/marathon "Marathon"
[Jenkins]: http://jenkins-ci.org/ "Jenkins"
[Zookeeper]: http://zookeeper.apache.org/ "Apache Zookeeper"
[VirtualBox]: http://www.virtualbox.org/ "VirtualBox"
[Vagrant]: http://www.vagrantup.com/ "Vagrant"
[Ansible]: http://www.ansibleworks.com "Ansible"
[Playa Mesos]: http://github.com/lingmann/playa-mesos "Playa Mesos"
