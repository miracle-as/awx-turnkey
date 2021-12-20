# awx-turnkey

The Alpha release:


prereqs: 

A rhel8.4 server installed an ansible ready 

You need to install the role with ansible-galaxy


ansible-galaxy -fr roles/requirements.yml

the file installes this:
  - src: https://github.com/JakobHolstDK/miracle-ansible-role-awxrpm-scl-installer.git
    scm: git
    version: "master"
    
    
Run the playbook 

awxrpm.yml playbook


---
- name: "awxrpm | install awx server"
  hosts: awxserver
  roles:
    - role: miracle-ansible-role-awxrpm-scl-installer
      version: "19.4.0"
      awx_db_password: "dsfsdfds"
      awxpassword: "awx2know"
      postgreshost: "awxserver"
      nginx_disable_https: True
      nginx_http_port: 80
      nginx_disable_hsts: True
      nodejsversion: v14.x
      secret_key: werwerwer13dfdssdfsdfsdfsd32fds
      CLUSTER_HOST_ID: 'localhost'
      awx_install_pg_init_name: 'miracle'
      awx_install_redis_init_name: 'miracle'




The install output: 
