#!/usr/bin/env bash
set -e
set -u

# global vars
readonly inventory="/vagrant/ansible/inventory"
readonly playbook="/vagrant/ansible/ubuntu_1204.yml"

function main() {
  echo "Running Playa Mesos VM Bootstrap"
  install_ansible
  provision
}

function install_ansible() {
  echo "Installing Ansible"

  # Check for prerequisites
  hash sudo 2>/dev/null         || { echo >&2 "ERROR: sudo not found"; exit 1; }
  hash apt-get 2>/dev/null      || { echo >&2 "ERROR: apt-get not found"; exit 1; }
  sudo -n apt-get -v >/dev/null || { echo >&2 "ERROR: root privilege requires password"; exit 1; }

  # Install ansible
  sudo apt-get update > /dev/null
  sudo apt-get -y install ansible
}

function provision() {
  echo "Provisioning the VM"

  # Check for required files
  test -r "$inventory" || { echo >&2 "ERROR: ${inventory} not readable"; exit 1; }
  test -r "$playbook"  || { echo >&2 "ERROR: ${playbook} not readable"; exit 1; }

  hash ansible-playbook 2>/dev/null || { echo >&2 "ERROR: ansible-playbook not found"; exit 1; }

  # Provision the VM using ansible and the mounted project directory
  ansible-playbook -i "$inventory" -c local "$playbook"
}

main
