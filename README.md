ansible_role_tenantcloud.laravel
=========

Ansible role for install and setup laravel framework

Requirements
------------

Preconfigured Ubuntu server with MySQL 5.7, PHP, Redis, Nginx

Role Variables
--------------

work_domain: mydomain.dev
work_dir: myprojectdirectory
project_git: git@bitbucket.org:mycompany/myproject.git
mysql_host: 127.0.0.1
mysql_user: root
mysql_password:
mysql_database: mydatabase
minio_key: myaccesskey
minio_secret: mysecretkey
minio_host: https://minio.mydomain.dev:9002
minio_bucket: myminiobucket

Dependencies
------------

After playbook finished you must enter your project directory and run some command.

* For Emailer:
```bash
php artisan migrate
npm run watch
```

Example Playbook
----------------

```yaml
- name: Setup
  hosts: localhost
  vars:
    work_domain: emailer.dev
    work_dir: emailer
    project_git: git@bitbucket.org:mycompany/emailer.git
    mysql_host: 127.0.0.1
    mysql_user: root
    mysql_password:
    mysql_database: emailer
    minio_key: accesskey
    minio_secret: secretkey
    minio_host: https://minio.emailer.dev:9002
    minio_bucket: emailer
  remote_user: user
  roles:
    - tenantcloud.laravel
```

License
-------

BSD

Author Information
------------------

TenantCloud DevOps Team
