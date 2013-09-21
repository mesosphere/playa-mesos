#!/usr/bin/env bash
set -e
set -u

sudo apt-get update > /dev/null
sudo apt-get -y install ansible
