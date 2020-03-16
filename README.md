tenantcloud.laravel
=========

Ansible role for install laravel project.

  - emailer
  - tc-ci
  - tc-dg

Requirements
------------

Need be installed NGINX, PHP, MySQL Server, Redis, Node

Role Variables
--------------

work_user: "user"
work_domain: 
work_dir: "work"
project_git: 
project_git_branch: 
mysql_host: 
mysql_admin_user: 
mysql_admin_password:
mysql_database: 
mysql_db_user: 
mysql_db_user_pass: 
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

    - hosts: localhost
      become: no
      vars:
        work_user: "user"
        work_domain: 
        work_dir: "work"
        project_git: 
        project_git_branch: 
        mysql_host: 
        mysql_admin_user: 
        mysql_admin_password:
        mysql_database: 
        mysql_db_user: 
        mysql_db_user_pass: 
        s3_key:
        s3_secret:
        s3_host:
        s3_bucket:
        s3_region:
      roles:
        - tenantcloud.laravel

License
-------

BSD

Author Information
------------------

TenantCloud DevOps Team
