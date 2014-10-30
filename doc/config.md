# Playa Mesos Configuration

### config.json
The following options must be set in `config.json`:

<dl>
  <dt>platform</dt>
  <dd>Virtualization platform (possible choices are: ```virtualbox```, ```vmware_fusion```, ```vmware_workstation```)</dd>

  <dt>box_name</dt>
  <dd>Vagrant box-name</dd>

  <dt>base_url</dt>
  <dd>Base URL where the Vagrant box images are stored.</dd>
  <dd>Download path is dynamically extracted with this schema: ```base_url```/```platform```/```box_name```.box</dd>

  <dt>ip_address</dt>
  <dd>IP address used by the VM on a private network using a /24 netmask</dd>

  <dt>vm_ram</dt>
  <dd>MB of RAM allocated to the VM</dd>

  <dt>vm_cpus</dt>
  <dd>Number of CPU cores allocated to the VM</dd>
</dl>
