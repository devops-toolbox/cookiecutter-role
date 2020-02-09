Role Name
=========

{{ cookiecutter.role_name }}: {{ cookiecutter.description }}

[![Build Status](https://travis-ci.org/cmihai-ansible/{{ cookiecutter.role_name }}.svg?branch=master)](https://travis-ci.org/cmihai-ansible/{{ cookiecutter.role_name }})

Ansible galaxy:
---------------

[https://galaxy.ansible.com/devops-toolbox.{{ cookiecutter.role_name }}](https://galaxy.ansible.com/devops-toolbox.{{ cookiecutter.role_name }})

```bash
ansible-galaxy install devops-toolbox.{{ cookiecutter.role_name }}
```

Requirements
------------

- For RHEL, a Red Hat subscription or functional local repository.
- Ansible {{ cookiecutter.min_ansible_version }} or higher

Role Variables
--------------

```yaml
{{ cookiecutter.role_name }}_packages_state: present
{{ cookiecutter.role_name }}_remove_packages: true
{{ cookiecutter.role_name }}_enable_service: true
{{ cookiecutter.role_name }}_enable_selinux: true
{{ cookiecutter.role_name }}_copy_templates: true
{{ cookiecutter.role_name }}_firewall_configure: true
{{ cookiecutter.role_name }}_firewall_rules:
  - service: ssh
  - port: 3389
{{ cookiecutter.role_name }}_users:
  - user: devops
    group: docker
{{ cookiecutter.role_name }}_selinux_booleans:
  - name: ftp_home_dir
    state: true
    persistent: true
```

Dependencies
------------

- For Red Hat, subscription-manager.

Example Playbook
----------------

```yaml
---
- name: Install {{ cookiecutter.role_name }} on localhost
  hosts:
    - localhost
  connection: local

  tasks:
    - name: {{ cookiecutter.role_name }} is configured
      import_role:
        name: devops-toolbox.{{ cookiecutter.role_name }}
      vars:
        {{ cookiecutter.role_name }}_packages_state: present
        {{ cookiecutter.role_name }}_remove_packages: true
        {{ cookiecutter.role_name }}_enable_service: true
        {{ cookiecutter.role_name }}_enable_selinux: true
        {{ cookiecutter.role_name }}_copy_templates: true
        {{ cookiecutter.role_name }}_firewall_configure: true
        {{ cookiecutter.role_name }}_firewall_rules:
          - service: ssh
          - port: 3389
        {{ cookiecutter.role_name }}_users:
          - user: devops
            group: docker
        {{ cookiecutter.role_name }}_selinux_booleans:
          - name: ftp_home_dir
            state: true
            persistent: true
      tags: {{ cookiecutter.role_name }}
```

License
-------

MIT

Author Information
------------------

- {{ cookiecutter.author_information }}
