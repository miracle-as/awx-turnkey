python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install ansible
pip install virtualenv
ansible-galaxy collection install --force ansible.posix
ansible-galaxy role install -fr roles/requirements.yml
ansible-playbook awxrpm.yml

