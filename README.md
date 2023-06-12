# awx-turnkey

The Alpha release:


prereqs: 

A rhel8.4 server installed an ansible ready 

You need to install the role with ansible-galaxy
python4 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install ansible
sudo ansible-galaxy collection install ansible.posix
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

ansible-playbook -i inventory awxrpm.yml  
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, 
Mar 19 2021, 05:13:41) [GCC 8.4.1 20200928 (Red Hat 8.4.1-1)]. This feature will be removed from ansible-core in version 2.12. Deprecation 
warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.

PLAY [awxrpm | install awx server] ***************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Enable EPEL Repository on CentOS 8] ************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : depend | Ensure dependencies are installed.] ***************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Install add  packages] *************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Add the group 'awx' with a specific gid and] ***************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Add the user 'awx' with a specific uid and a primary group of 'awx'] ***************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Create log dir] ********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Create  /var/lib/awx/rsyslog] ******************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Recursively change ownership of the directory /etc/tower/conf.d] *******************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : set owner /run/tower] **************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Enable SELinux in enforcing mode] **************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : adding nginx to group awx] *********************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Add pg12 repo] *********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : disable pg] ************************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : install pg 12] *********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Stop service postgres, if not stopped] *********************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : destroy database] ******************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : are we new] ************************************************************************************
[WARNING]: Skipped '/var/lib/pgsql/12/data/' path due to this access issue: '/var/lib/pgsql/12/data/' is not a directory
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : run initdb] ************************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Pause for 5 seconds to settle] *****************************************************************
Pausing for 5 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Start service postgres, if not started] ********************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : run  create postgres user] *********************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create postgress db] ***************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : set password] **********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create postgress access] ***********************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Restart service postgres, if not restarted] ****************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create postgress credentials] ******************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : install redis] *********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : adding existing user cloud-user to group sudo] *************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : enable socket in redist] ***********************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Start service redis, if not started] ***********************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Copy SSL certificate] **************************************************************************
skipping: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Copy provided SSL private key] *****************************************************************
skipping: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Create temporary directory for openssl config] *************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : copy openssl config] ***************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create self signed SSL certificates] ***********************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : set permissions on self-signed SSL certificate] ************************************************
ok: [awxserver] => (item=/etc/tower/tower.cert)
ok: [awxserver] => (item=/etc/tower/tower.key)

TASK [miracle-ansible-role-awxrpm-scl-installer : Install awxrpm nginx.conf] *********************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Stop nginx and set autostart] ******************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Start nginx and set autostart] *****************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Git checkout nodejs] ***************************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure nodejs] ******************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : compile nodejs] ********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Copy node binary] ******************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Copy the build script] *************************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : AWX RPM repo] **********************************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Install the latest  miracle awxrpm] ************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Creates tower] *********************************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Ensure awx is in the nginx group] **************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower socket directory.] *********************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower socket directory for tmpfiles.d] *******************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : generate the secret key] ***********************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the awx settings file] ***************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower system user's home directory.] *********************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower system user's .ssh directory.] *********************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower projects directory.] *******************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower job output directory.] *****************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Tower job public directory.] *****************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Add Towers `conf.d` directory.] ****************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : configure tower log directory] *****************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Update awx_supervisord logrotate config file] **************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Update hourly cron logrotate invocation] *******************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Update dependent service configuration] ********************************************************
ok: [awxserver] => (item=nginx)
ok: [awxserver] => (item=supervisord)
ok: [awxserver] => (item=miracle)
ok: [awxserver] => (item=miracle)

TASK [miracle-ansible-role-awxrpm-scl-installer : Update dependent service configuration] ********************************************************
ok: [awxserver] => (item=nginx)
ok: [awxserver] => (item=supervisord)
ok: [awxserver] => (item=miracle)
ok: [awxserver] => (item=miracle)

TASK [miracle-ansible-role-awxrpm-scl-installer : Reload systemd configuration] ******************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Check if this is a fresh installation] *********************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Configure the Rsyslog socket directory.] *******************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : Create tmpfiles.d entry for rsyslog socket directory] ******************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create export script] **************************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : create awx_preparescript] **********************************************************************
changed: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : configure tower run socket dir] ****************************************************************
ok: [awxserver]

TASK [miracle-ansible-role-awxrpm-scl-installer : configure tower run socket dir] ****************************************************************
changed: [awxserver]



So far so good. 

We have an database
subsytems,
users
webserver, ssl keys etc.

we can run ***********************************************************************************************************************************************************
   scl enable miracle-awxrpm "python3 -m pip list"
Package                  Version  
------------------------ ---------
adal                     1.2.2    
aiohttp                  3.6.2    
aioredis                 1.3.1    
ansible-runner           2.0.0a2  
ansiconv                 1.0.0    
asciichartpy             1.5.25   
asgiref                  3.2.5    
async-timeout            3.0.1    
attrs                    19.3.0   
autobahn                 20.12.3  
Automat                  20.2.0   
awx                      19.4.0   
azure-common             1.1.25   
azure-keyvault           1.1.0    
azure-nspkg              3.0.2    
cachetools               4.0.0    
certifi                  2021.10.8
cffi                     1.14.0   
channels                 2.4.0    
channels-redis           3.1.0    
chardet                  3.0.4    
click                    7.1.2    
constantly               15.1.0   
coreapi                  2.3.3    
coreschema               0.0.4    
cryptography             2.9.2    
Cython                   0.29.22  
daphne                   2.4.1    
dataclasses              0.6      
defusedxml               0.6.0    
dictdiffer               0.8.1    
distro                   1.5.0    
Django                   2.2.16   
django-auth-ldap         2.1.0    
django-cors-headers      3.7.0    
django-crum              0.7.5    
django-debug-toolbar     3.2.2    
django-extensions        2.2.9    
django-guid              2.2.0    
django-jsonfield         1.2.0    
django-oauth-toolkit     1.1.3    
django-pglocks           1.0.4    
django-polymorphic       2.1.2    
django-qsstats-magic     1.1.0    
django-radius            1.3.3    
django-redis             4.5.0    
django-rest-swagger      2.2.0    
django-solo              1.1.3    
django-split-settings    1.0.0    
django-taggit            1.2.0    
djangorestframework      3.12.1   
djangorestframework-yaml 1.0.3    
docutils                 0.16     
future                   0.16.0   
gitdb                    4.0.2    
GitPython                3.1.7    
google-auth              1.11.3   
hiredis                  1.0.1    
hyperlink                20.0.1   
idna                     2.9      
idna-ssl                 1.1.0    
importlib-metadata       0.0.0    
importlib-resources      0.0.0    
incremental              17.5.0   
irc                      18.0.0   
isodate                  0.6.0    
itypes                   1.2.0    
jaraco.classes           3.1.0    
jaraco.collections       3.0.0    
jaraco.functools         3.0.0    
jaraco.logging           3.0.0    
jaraco.stream            3.0.0    
jaraco.text              3.2.0    
Jinja2                   2.11.2   
JSON-log-formatter       0.3.0    
jsonschema               3.2.0    
kubernetes               11.0.0   
lockfile                 0.12.2   
lxml                     4.5.0    
Markdown                 3.2.1    
MarkupSafe               1.1.1    
more-itertools           8.2.0    
msgpack                  1.0.0    
msrest                   0.6.11   
msrestazure              0.6.3    
multidict                4.7.5    
netaddr                  0.7.19   
oauthlib                 3.1.0    
openapi-codec            1.3.2    
openshift                0.11.0   
pexpect                  4.7.0    
pip                      19.3.1   
pkgconfig                1.5.1    
prometheus-client        0.7.1    
psutil                   5.8.0    
psycopg2                 2.8.4    
ptyprocess               0.6.0    
pyasn1                   0.4.8    
pyasn1-modules           0.2.8    
pycparser                2.20     
pygerduty                0.38.2   
PyHamcrest               2.0.2    
PyJWT                    1.7.1    
pyOpenSSL                19.1.0   
pyparsing                2.4.6    
pyrad                    2.3      
pyrsistent               0.15.7   
python-dateutil          2.8.1    
python-dsv-sdk           1.0.1    
python-ldap              3.3.1    
python-string-utils      1.0.0    
python3-openid           3.1.0    
python3-saml             1.9.0    
pytz                     2019.3   
PyYAML                   5.4.1    
receptorctl              0.9.7    
redis                    3.4.1    
requests                 2.23.0   
requests-oauthlib        1.3.0    
rsa                      4.0      
ruamel.yaml              0.16.10  
ruamel.yaml.clib         0.2.0    
schedule                 0.6.0    
service-identity         18.1.0   
setuptools               41.6.0   
simplejson               3.17.5   
six                      1.14.0   
slackclient              1.1.2    
smmap                    3.0.1    
social-auth-app-django   3.1.0    
social-auth-core         3.3.1    
sqlparse                 0.3.1    
tacacs-plus              1.0      
tempora                  2.1.0    
twilio                   6.37.0   
Twisted                  20.3.0   
txaio                    20.12.1  
typing-extensions        3.10.0.2 
uritemplate              4.1.1    
urllib3                  1.25.8   
uWSGI                    2.0.18   
uwsgitop                 0.11     
websocket-client         0.57.0   
xmlsec                   1.3.3    
yarl                     1.4.2    
zipp                     0.0.0    
zope.interface           5.0.0    
[root@awxserver ~]# 


And all of this matches:

[root@awxserver ~]# yum list installed |grep awxrpm
miracle-awxrpm-Automat.noarch                  20.2.0-1                                            @miracleawxrpm                           
miracle-awxrpm-Cython.x86_64                   0.29.22-1                                           @miracleawxrpm                           
miracle-awxrpm-Django.noarch                   2.2.16-1                                            @miracleawxrpm                           
miracle-awxrpm-GitPython.noarch                3.1.7-1                                             @miracleawxrpm                           
miracle-awxrpm-JSON-log-formatter.noarch       0.3.0-1                                             @miracleawxrpm                           
miracle-awxrpm-Jinja2.noarch                   2.11.2-1                                            @miracleawxrpm                           
miracle-awxrpm-Markdown.noarch                 3.2.1-1                                             @miracleawxrpm                           
miracle-awxrpm-MarkupSafe.x86_64               1.1.1-1                                             @miracleawxrpm                           
miracle-awxrpm-PyHamcrest.noarch               2.0.2-1                                             @miracleawxrpm                           
miracle-awxrpm-PyJWT.noarch                    1.7.1-1                                             @miracleawxrpm                           
miracle-awxrpm-PyYAML.x86_64                   5.4.1-1                                             @miracleawxrpm                           
miracle-awxrpm-Twisted.x86_64                  20.3.0-1                                            @miracleawxrpm                           
miracle-awxrpm-adal.noarch                     1.2.2-1                                             @miracleawxrpm                           
miracle-awxrpm-aiohttp.x86_64                  3.6.2-1                                             @miracleawxrpm                           
miracle-awxrpm-aioredis.noarch                 1.3.1-1                                             @miracleawxrpm                           
miracle-awxrpm-ansible-runner.noarch           2.0.0a2-1                                           @miracleawxrpm                           
miracle-awxrpm-ansiconv.noarch                 1.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-asciichartpy.noarch             1.5.25-1                                            @miracleawxrpm                           
miracle-awxrpm-asgiref.noarch                  3.2.5-1                                             @miracleawxrpm                           
miracle-awxrpm-async-timeout.noarch            3.0.1-1                                             @miracleawxrpm                           
miracle-awxrpm-attrs.noarch                    19.3.0-1                                            @miracleawxrpm                           
miracle-awxrpm-autobahn.noarch                 20.12.3-1                                           @miracleawxrpm                           
miracle-awxrpm-awx.noarch                      19.4.0-1                                            @miracleawxrpm                           
miracle-awxrpm-azure-common.noarch             1.1.25-1                                            @miracleawxrpm                           
miracle-awxrpm-azure-keyvault.noarch           1.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-azure-nspkg.noarch              3.0.2-1                                             @miracleawxrpm                           
miracle-awxrpm-cachetools.noarch               4.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-certifi.noarch                  2021.10.8-1                                         @miracleawxrpm                           
miracle-awxrpm-cffi.x86_64                     1.14.0-1                                            @miracleawxrpm                           
miracle-awxrpm-channels.noarch                 2.4.0-1                                             @miracleawxrpm                           
miracle-awxrpm-channels-redis.noarch           3.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-chardet.noarch                  3.0.4-1                                             @miracleawxrpm                           
miracle-awxrpm-click.noarch                    7.1.2-1                                             @miracleawxrpm                           
miracle-awxrpm-constantly.noarch               15.1.0-1                                            @miracleawxrpm                           
miracle-awxrpm-coreapi.noarch                  2.3.3-1                                             @miracleawxrpm                           
miracle-awxrpm-coreschema.noarch               0.0.4-1                                             @miracleawxrpm                           
miracle-awxrpm-cryptography.x86_64             2.9.2-1                                             @miracleawxrpm                           
miracle-awxrpm-daphne.noarch                   2.4.1-1                                             @miracleawxrpm                           
miracle-awxrpm-defusedxml.noarch               0.6.0-1                                             @miracleawxrpm                           
miracle-awxrpm-dictdiffer.noarch               0.8.1-1                                             @miracleawxrpm                           
miracle-awxrpm-distro.noarch                   1.5.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-auth-ldap.noarch         2.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-cors-headers.noarch      3.7.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-crum.noarch              0.7.5-1                                             @miracleawxrpm                           
miracle-awxrpm-django-debug-toolbar.noarch     3.2.2-1                                             @miracleawxrpm                           
miracle-awxrpm-django-extensions.noarch        2.2.9-1                                             @miracleawxrpm                           
miracle-awxrpm-django-guid.noarch              2.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-jsonfield.noarch         1.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-oauth-toolkit.noarch     1.1.3-1                                             @miracleawxrpm                           
miracle-awxrpm-django-pglocks.noarch           1.0.4-1                                             @miracleawxrpm                           
miracle-awxrpm-django-polymorphic.noarch       2.1.2-1                                             @miracleawxrpm                           
miracle-awxrpm-django-qsstats-magic.noarch     1.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-radius.noarch            1.3.3-1                                             @miracleawxrpm                           
miracle-awxrpm-django-redis.noarch             4.5.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-rest-swagger.noarch      2.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-solo.noarch              1.1.3-1                                             @miracleawxrpm                           
miracle-awxrpm-django-split-settings.noarch    1.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-django-taggit.noarch            1.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-djangorestframework.noarch      3.12.1-1                                            @miracleawxrpm                           
miracle-awxrpm-djangorestframework-yaml.noarch 1.0.3-1                                             @miracleawxrpm                           
miracle-awxrpm-docutils.noarch                 0.16-1                                              @miracleawxrpm                           
miracle-awxrpm-future.noarch                   0.16.0-1                                            @miracleawxrpm                           
miracle-awxrpm-gitdb.noarch                    4.0.2-1                                             @miracleawxrpm                           
miracle-awxrpm-google-auth.noarch              1.11.3-1                                            @miracleawxrpm                           
miracle-awxrpm-hiredis.x86_64                  1.0.1-1                                             @miracleawxrpm                           
miracle-awxrpm-hyperlink.noarch                20.0.1-1                                            @miracleawxrpm                           
miracle-awxrpm-idna.noarch                     2.9-1                                               @miracleawxrpm                           
miracle-awxrpm-idna-ssl.noarch                 1.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-importlib-metadata.noarch       4.8.1-1                                             @miracleawxrpm                           
miracle-awxrpm-importlib-resources.noarch      5.2.2-1                                             @miracleawxrpm                           
miracle-awxrpm-incremental.noarch              17.5.0-1                                            @miracleawxrpm                           
miracle-awxrpm-irc.noarch                      18.0.0-1                                            @miracleawxrpm                           
miracle-awxrpm-isodate.noarch                  0.6.0-1                                             @miracleawxrpm                           
miracle-awxrpm-itypes.noarch                   1.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.classes.noarch           3.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.collections.noarch       3.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.functools.noarch         3.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.logging.noarch           3.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.stream.noarch            3.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jaraco.text.noarch              3.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-jsonschema.noarch               3.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-kubernetes.noarch               11.0.0-1                                            @miracleawxrpm                           
miracle-awxrpm-lockfile.noarch                 0.12.2-1                                            @miracleawxrpm                           
miracle-awxrpm-lxml.x86_64                     4.5.0-1                                             @miracleawxrpm                           
miracle-awxrpm-more-itertools.noarch           8.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-msgpack.x86_64                  1.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-msrest.noarch                   0.6.11-1                                            @miracleawxrpm                           
miracle-awxrpm-msrestazure.noarch              0.6.3-1                                             @miracleawxrpm                           
miracle-awxrpm-multidict.x86_64                4.7.5-1                                             @miracleawxrpm                           
miracle-awxrpm-netaddr.noarch                  0.7.19-1                                            @miracleawxrpm                           
miracle-awxrpm-oauthlib.noarch                 3.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-openapi-codec.noarch            1.3.2-1                                             @miracleawxrpm                           
miracle-awxrpm-openshift.noarch                0.11.0-1                                            @miracleawxrpm                           
miracle-awxrpm-pexpect.noarch                  4.7.0-1                                             @miracleawxrpm                           
miracle-awxrpm-pkgconfig.noarch                1.5.1-1                                             @miracleawxrpm                           
miracle-awxrpm-prometheus-client.noarch        0.7.1-1                                             @miracleawxrpm                           
miracle-awxrpm-psutil.x86_64                   5.8.0-1                                             @miracleawxrpm                           
miracle-awxrpm-psycopg2.x86_64                 2.8.4-1                                             @miracleawxrpm                           
miracle-awxrpm-ptyprocess.noarch               0.6.0-1                                             @miracleawxrpm                           
miracle-awxrpm-pyOpenSSL.noarch                19.1.0-1                                            @miracleawxrpm                           
miracle-awxrpm-pyasn1.noarch                   0.4.8-1                                             @miracleawxrpm                           
miracle-awxrpm-pyasn1-modules.noarch           0.2.8-1                                             @miracleawxrpm                           
miracle-awxrpm-pycparser.noarch                2.20-1                                              @miracleawxrpm                           
miracle-awxrpm-pygerduty.noarch                0.38.2-1                                            @miracleawxrpm                           
miracle-awxrpm-pyparsing.noarch                2.4.6-1                                             @miracleawxrpm                           
miracle-awxrpm-pyrad.noarch                    2.3-1                                               @miracleawxrpm                           
miracle-awxrpm-pyrsistent.x86_64               0.15.7-1                                            @miracleawxrpm                           
miracle-awxrpm-python-dateutil.noarch          2.8.1-1                                             @miracleawxrpm                           
miracle-awxrpm-python-ldap.x86_64              3.3.1-1                                             @miracleawxrpm                           
miracle-awxrpm-python-string-utils.noarch      1.0.0-1                                             @miracleawxrpm                           
miracle-awxrpm-python3-openid.noarch           3.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-python3-saml.noarch             1.9.0-1                                             @miracleawxrpm                           
miracle-awxrpm-pytz.noarch                     2019.3-1                                            @miracleawxrpm                           
miracle-awxrpm-receptorctl.noarch              0.9.7-1                                             @miracleawxrpm                           
miracle-awxrpm-redis.noarch                    3.4.1-1                                             @miracleawxrpm                           
miracle-awxrpm-requests.noarch                 2.23.0-1                                            @miracleawxrpm                           
miracle-awxrpm-requests-oauthlib.noarch        1.3.0-1                                             @miracleawxrpm                           
miracle-awxrpm-rsa.noarch                      4.0-1                                               @miracleawxrpm                           
miracle-awxrpm-ruamel.yaml.noarch              0.16.10-1                                           @miracleawxrpm                           
miracle-awxrpm-ruamel.yaml.clib.x86_64         0.2.0-1                                             @miracleawxrpm                           
miracle-awxrpm-runtime.x86_64                  1.0.0-1.el8                                         @miracleawxrpm                           
miracle-awxrpm-schedule.noarch                 0.6.0-1                                             @miracleawxrpm                           
miracle-awxrpm-service-identity.noarch         18.1.0-1                                            @miracleawxrpm                           
miracle-awxrpm-simplejson.x86_64               3.17.5-1                                            @miracleawxrpm                           
miracle-awxrpm-six.noarch                      1.14.0-1                                            @miracleawxrpm                           
miracle-awxrpm-slackclient.noarch              1.1.2-1                                             @miracleawxrpm                           
miracle-awxrpm-smmap.noarch                    3.0.1-1                                             @miracleawxrpm                           
miracle-awxrpm-social-auth-app-django.noarch   3.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-social-auth-core.noarch         3.3.1-1                                             @miracleawxrpm                           
miracle-awxrpm-sqlparse.noarch                 0.3.1-1                                             @miracleawxrpm                           
miracle-awxrpm-tacacs-plus.noarch              1.0-1                                               @miracleawxrpm                           
miracle-awxrpm-tempora.noarch                  2.1.0-1                                             @miracleawxrpm                           
miracle-awxrpm-twilio.noarch                   6.37.0-1                                            @miracleawxrpm                           
miracle-awxrpm-txaio.noarch                    20.12.1-1                                           @miracleawxrpm                           
miracle-awxrpm-typing-extensions.noarch        3.10.0.2-1                                          @miracleawxrpm                           
miracle-awxrpm-uWSGI.x86_64                    2.0.18-1                                            @miracleawxrpm                           
miracle-awxrpm-uritemplate.noarch              4.1.1-1                                             @miracleawxrpm                           
miracle-awxrpm-urllib3.noarch                  1.25.8-1                                            @miracleawxrpm                           
miracle-awxrpm-uwsgitop.noarch                 0.11-1                                              @miracleawxrpm                           
miracle-awxrpm-websocket-client.noarch         0.57.0-1                                            @miracleawxrpm                           
miracle-awxrpm-xmlsec.x86_64                   1.3.3-1                                             @miracleawxrpm                           
miracle-awxrpm-yarl.x86_64                     1.4.2-1                                             @miracleawxrpm                           
miracle-awxrpm-zipp.noarch                     3.6.0-1                                             @miracleawxrpm                           
miracle-awxrpm-zope.interface.x86_64           5.0.0-1                                             @miracleawxrpm   

This is really good.

the scl environment is places where we want ad the pythonpath is ready
scl first, then system and finally local

[root@awxserver ~]# cat /opt/miracle/miracle-awxrpm/enable 
export PATH=/opt/miracle/miracle-awxrpm/root/usr/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/opt/miracle/miracle-awxrpm/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export MANPATH=/opt/miracle/miracle-awxrpm/root/usr/share/man:$MANPATH
export PKG_CONFIG_PATH=/opt/miracle/miracle-awxrpm/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}
export XDG_DATA_DIRS="/opt/miracle/miracle-awxrpm/root/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export PYTHONPATH=/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages:/opt/miracle/miracle-awxrpm/root/lib64/python3.8/site-packages:/usr/lib/python3.8/site-packages:/usr/local/lib/python3.8/site-packages:/usr/local/lib64/python3.8/site-packages




***********************************************************************************************************************************************************

HELP NEEDED

***********************************************************************************************************************************************************

  [root@awxserver ~]# cat /opt/miracle/miracle-awxrpm/enable 
export PATH=/opt/miracle/miracle-awxrpm/root/usr/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/opt/miracle/miracle-awxrpm/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export MANPATH=/opt/miracle/miracle-awxrpm/root/usr/share/man:$MANPATH
export PKG_CONFIG_PATH=/opt/miracle/miracle-awxrpm/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}
export XDG_DATA_DIRS="/opt/miracle/miracle-awxrpm/root/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export PYTHONPATH=/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages:/opt/miracle/miracle-awxrpm/root/lib64/python3.8/site-packages:/usr/lib/python3.8/site-packages:/usr/local/lib/python3.8/site-packages:/usr/local/lib64/python3.8/site-packages
[root@awxserver ~]# scl enable miracle-awxrpm "awx-manage"
Traceback (most recent call last):
  File "/opt/miracle/miracle-awxrpm/root/usr/bin/awx-manage", line 11, in <module>
    load_entry_point('awx==19.4.0', 'console_scripts', 'awx-manage')()
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/__init__.py", line 171, in manage
    execute_from_command_line(sys.argv)
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/django/core/management/__init__.py", line 381, in execute_from_command_line
    utility.execute()
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/django/core/management/__init__.py", line 357, in execute
    django.setup()
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/django/__init__.py", line 24, in setup
    apps.populate(settings.INSTALLED_APPS)
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/django/apps/registry.py", line 114, in populate
    app_config.import_models()
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/django/apps/config.py", line 211, in import_models
    self.models_module = import_module(models_module_name)
  File "/usr/lib64/python3.8/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1014, in _gcd_import
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 671, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 783, in exec_module
  File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/conf/models.py", line 11, in <module>
    from awx.main.models.base import CreatedModifiedModel, prevent_search
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/main/models/__init__.py", line 12, in <module>
    from awx.main.models.credential import Credential, CredentialType, CredentialInputSource, ManagedCredentialType, build_safe_env  # noqa
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/main/models/credential/__init__.py", line 49, in <module>
    credential_plugins = dict((ep.name, ep.load()) for ep in iter_entry_points('awx.credential_plugins'))
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/main/models/credential/__init__.py", line 49, in <genexpr>
    credential_plugins = dict((ep.name, ep.load()) for ep in iter_entry_points('awx.credential_plugins'))
  File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line 2443, in load
    return self.resolve()
  File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line 2449, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/opt/miracle/miracle-awxrpm/root/lib/python3.8/site-packages/awx/main/credential_plugins/tss.py", line 4, in <module>
    from thycotic.secrets.server import PasswordGrantAuthorizer, SecretServer, ServerSecret
ModuleNotFoundError: No module named 'thycotic.secrets.server'
  
  This is unexpected and I really would appreciate fresh eyes and bold ideas!
  
  
  
  
  

  




