python3 -m venv /usr/local/venv
sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms

# Install Ansible   
source /usr/local/venv/bin/activate
pip install --upgrade pip
pip install ansible
pip install ansible-lint
pip install virtualenv
# Install Ansible AWX
ansible-galaxy collection install --force ansible.posix
ansible-galaxy role install -fr roles/requirements.yml
ansible-playbook awxrpm.yml

