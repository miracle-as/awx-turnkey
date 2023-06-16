#!/usr/bin/env bash
# Install Ansible AWX on RHEL 9
# Author:
#   - Red Hat, Inc.
#   - Ansible, Inc.
#   - Community Contributors
# License: GPLv3
# Reference:
#   -
#   -

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
if [[ ! -f /etc/redhat-release ]]; then
   echo "This script only supports RHEL 9"
   exit 1
fi
if [[  $1 !=  "--fast" ]]; then


  if [[ $ORG == "" ]]; then
    echo "Please set the ORG environment variable"
    exit 1
  fi

  if [[ $activationkey == "" ]]; then
    echo "Please set the activationkey environment variable"
    exit 1
  fi

  subscription-manager register --org $ORG --activationkey $activationkey
  subscription-manager attach 
  subscription-manager repos --enable ansible-2.9-for-rhel-9-x86_64-rpms
  subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms

# Install Python3 and Ansible
  sudo dnf install -y python3
  sudo dnf install -y python3-pip
  sudo dnf install -y python3-devel
  sudo dnf install -y gcc
  sudo dnf install -y git
  sudo dnf install -y openssl-devel
  sudo dnf install -y libselinux-python3
  sudo dnf install -y libffi-devel
  sudo dnf install -y redhat-rpm-config
  sudo dnf install -y libsemanage-python3
  sudo dnf install -y libxml2-devel
  sudo dnf install -y libxslt-devel
  sudo dnf install -y zlib-devel
  sudo dnf install -y nodejs
  sudo dnf install -y npm
  sudo dnf install -y gettext


fi
# Create Python3 Virtual Environment
python3 -m venv /usr/local/venv

# Install Ansible   
source /usr/local/venv/bin/activate
pip install --upgrade pip
pip install ansible
pip install virtualenv
pip install uwsgi

# Install Ansible AWX
ansible-galaxy collection install --force ansible.posix
ansible-galaxy role install -fr roles/requirements.yml
ansible-playbook awxrpm.yml

