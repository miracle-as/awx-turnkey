python3 -m venv /usr/local/venv

source /usr/local/venv/bin/activate
pip install --upgrade pip
pip install ansible
pip install virtualenv
pip install yolk3k
ansible-galaxy collection install --force ansible.posix
ansible-galaxy role install -fr roles/requirements.yml
ansible-playbook awxrpm.yml

