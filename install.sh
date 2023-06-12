python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install ansible
sudo ansible-galaxy collection install ansible.posix
ansible-galaxy role install -fr roles/requirements.yml

