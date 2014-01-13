# Playa Mesos

[Playa Mesos][8] helps you quickly create [Apache Mesos][1] test environments.
This project relies on [VirtualBox][5], [Vagrant][6], and an Ubuntu box image
which has Mesos pre-installed. The box image is downloadable for your
convenience, but it can also be built from source using [Packer][9].

## Requirements

* [VirtualBox][5] 4.2+
* [Vagrant][6] 1.3+
* [git](http://git-scm.com/downloads) (command line tool)
* [Packer][9] 0.5+ (optional)

## Quick Start

1. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)

1. [Install Vagrant](http://www.vagrantup.com/downloads.html)

1. Clone this repository
```bash
git clone https://github.com/mesosphere/playa-mesos.git
cd playa-mesos
```

1. Make sure tests pass
```bash
bin/test
```

1. Change to the `ubuntu_13.04` profile directory
```bash
cd profiles/ubuntu_13.04
```

1. Start the VM
```bash
vagrant up
```

1. Connect to the Mesos Web UI on [10.141.141.10:5050](http://10.141.141.10:5050)

1. SSH to the VM
```bash
vagrant ssh
ps -eaf | grep mesos
exit
```

1. Halt the VM
```bash
vagrant halt
```

1. Destroy the VM
```bash
vagrant destroy
```

## Building the Mesos box image (optional)

1. Install [Packer][9]

    Installing Packer is not completely automatic. Once you have downloaded and
    extracted Packer, you must update your search path so that the `packer`
    executable can be found.
```bash
# EXAMPLE - PACKER LOCATION MUST BE ADJUSTED
PATH=$PATH:/path/where/i/extracted/packer/archive/
```

1. Change to the `ubuntu_13.04` profile directory
```bash
cd profiles/ubuntu_13.04
```

1. Destroy any existing VM
```bash
vagrant destroy
```

1. Build the Vagrant box image
```bash
./build
```

1. Start the VM using the local box image
```bash
vagrant up
```

The build is controlled with the following files:

* [profiles/ubuntu_13.04/config.json][21]
* [profiles/ubuntu_13.04/packer/packer.json][22]
* [lib/scripts/*][23]

For additional information on customizing the build, or creating a new profile,
see [Configuration][15] and the [Packer Documentation][20].

## Documentation

* [Configuration][15]
* [Common Tasks][16]
* [Troubleshooting][17]
* [Known Issues][18]
* [To Do][19]

## Similar Projects

* [vagrant-mesos](https://github.com/everpeace/vagrant-mesos): Vagrant
  provisiong with multinode and EC2 support

## Authors

* [Jeremy Lingmann](https://github.com/lingmann) ([@lingmann](https://twitter.com/lingmann))

[1]: http://incubator.apache.org/mesos/ "Apache Mesos"
[2]: http://github.com/mesosphere/marathon "Marathon"
[3]: http://jenkins-ci.org/ "Jenkins"
[4]: http://zookeeper.apache.org/ "Apache Zookeeper"
[5]: http://www.virtualbox.org/ "VirtualBox"
[6]: http://www.vagrantup.com/ "Vagrant"
[7]: http://www.ansibleworks.com "Ansible"
[8]: https://github.com/mesosphere/playa-mesos "Playa Mesos"
[9]: http://www.packer.io "Packer"
[13]: http://mesosphere.io/downloads "Mesosphere Downloads"
[14]: http://www.ubuntu.com "Ubuntu"
[15]: doc/config.md "Configuration"
[16]: doc/common_tasks.md "Common Tasks"
[17]: doc/troubleshooting.md "Troubleshooting"
[18]: doc/known_issues.md "Known Issues"
[19]: doc/to_do.md "To Do"
[20]: http://www.packer.io/docs "Packer Documentation"
[21]: profiles/ubuntu_13.04/config.json "config.json"
[22]: profiles/ubuntu_13.04/packer/packer.json "packer.json"
[23]: lib/scripts "scripts"
