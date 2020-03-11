TenantCloud Laravel Role
=========

The role will enable rapid deployment of project Laravel 

Requirements
------------

Need be installed NGINX, PHP, MySQL Server

Role Variables
--------------

work_domain:
work_dir:
project_git:
mysql_host:
mysql_admin_user:
mysql_admin_password: 
mysql_db_user:
mysql_db_user_pass:
mysql_database:
s3_key:
s3_secret:
s3_host:
s3_bucket:
s3_region:

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

```yaml
- name: Setup
  hosts: localhost
  vars:
    work_domain: laravel.dev
    work_dir: laravel
    project_git: git@bitbucket.org:mycompany/laravel.git
    mysql_host: 127.0.0.1
    mysql_admin_user: root
    mysql_admin_password: rootpassword
    mysql_db_user: userdb
    mysql_db_user_pass: userdbpassword
    mysql_database: laraveldb
    s3_key: accesskey
    s3_secret: secretkey
    s3_host: https://s3.endpoint
    s3_bucket: laravelbucket
    s3_region: us-east-1
  remote_user: ubuntu
  roles:
    - tenantcloud.laravel
```

License
-------

BSD

Author Information
------------------

TenantCloud DevOps Team
