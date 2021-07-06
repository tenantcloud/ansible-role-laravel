
![Lint Ansible Roles](https://github.com/tenantcloud/ansible-role-laravel/workflows/Lint%20Ansible%20Roles/badge.svg?branch-master)
[![Build Status](https://github.com/tenantcloud/ansible-role-laravel/workflows/Enlarge%20version/badge.svg)](https://github.com/tenantcloud/ansible-role-laravel/workflows/Enlarge%20version/badge.svg)
[![Stable Version](https://img.shields.io/github/v/tag/tenantcloud/ansible-role-laravel)](https://img.shields.io/github/v/tag/tenantcloud/ansible-role-laravel)

TenantCloud Laravel Role
=========

The role will enable rapid deployment of project Laravel 

Requirements
------------

MacOS Catalina or higher
PHPStorm 2020.3.1
tcctl package commands for development
docker, docker-compose, git-lfs, gnu-sed, yq

Role Variables
--------------

ansible_user:
ansible_pass:
work_dir:
work_domain:
project_git:
project_git_branch:
docker_app_name: "laravel"
docker_mailhog_port:
docker_minio_port:
docker_mysql_port:
docker_app_port:
docker_supervisor_port:
docker_supervisor_port_queue:

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

```yaml
- name: Setup
  hosts: localhost
  vars:
    ansible_user: "user"
    ansible_pass: "qwerty123"
    work_dir: "work"
    work_domain: 'laravel.tc.loc'
    project_git: 'git@github.com:tenantcloud/laravel-example.git'
    project_git_branch: 'main'
  roles:
    - tenantcloud.laravel
```

```yaml
    work_dir: '/var/www/html/laravel.tc.loc' for linux or 'work' for macosx
``` 

License
-------

BSD

Author Information
------------------

TenantCloud DevOps Team
