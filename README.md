Ansible Cookiecutter with Molecule Tests
========================================

Install prerequisities
----------------------

```bash
# Using venv
python3 -m venv ~/ansible-molecule
source ~/ansible molecule/bin/activate

# Install python modules
pip3 install --upgrade --user pip
pip3 install --upgrade --user python-vagrant
pip3 install --upgrade --user ansible "molecule[docker]" "molecule[podman]"
pip3 install --upgrade --user molecule-libvirt python-vagrant
```

Creating a new role
-------------------

```bash
molecule init template \
  --url https://github.com/cmihai-ansible/cookiecutter-role.git \
  --role-name myrole
```

Testing your role with molecule
-------------------------------

```bash
cd roles/myrole
molecule test
```

Using KVM
---------

Install the libvirt driver for vagrant:

```bash
sudo yum install https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm
sudo yum install libvirt-devel ruby-devel gcc
export VAGRANT_DEFAULT_PROVIDER=libvirt
export VAGRANT_PREFERRED_PROVIDERS=libvirt

# Build vagrant-libvirt
export CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib'
export GEM_HOME=~/.vagrant.d/gems GEM_PATH=$GEM_HOME:/opt/vagrant/embedded/gems
export PATH=/opt/vagrant/embedded/bin:$PATH
vagrant plugin install vagrant-libvirt
```

Use KVM:

```bash
molecule -s kvm create
molecule -s kvm login
```

Cleanup:

```
vagrant global-status
vagrant destroy ID
```

Using podman
------------

```
molecule -s podman test
```

On CentOS 8, you need to enable CR to obtain podman 1.4.2.

TODO
----

1. Add support for non x86-64 platforms (ex: ARM)
2. Platform support: Fedora 29-31, Ubuntu 18.04+, Amazon Linux
3. Support for packer and building images and containers
4. Support for vagrant

Debug KVM:
----------

- firewalld service must be up
- no pool images must be defined. Use `virsh pool-list --all` as user and root!
- use `sudo virsh pool-undefine images`

To define your pools use:

```
virsh pool-list

virsh pool-define /dev/stdin <<EOF
<pool type='dir'>
  <name>default</name>
  <target>
    <path>/var/lib/libvirt/images</path>
  </target>
</pool>
EOF

virsh pool-start default
virsh pool-autostart default
```
