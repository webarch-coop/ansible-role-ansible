#!/usr/bin/env bash

ansible-galaxy install -r requirements.yml --force

if [[ -z "${DISTRO}" ]]; then
  echo 'Please: `export DISTRO="stretch"`'
  exit 1
fi

if [[ -z "${SERVERNAME}" ]]; then
  echo 'Please: `export SERVERNAME="example.org.uk"`'
  exit 1
fi

echo "Running: ansible-playbook webarch.yml -i ${SERVERNAME}, -e \"hostname=${SERVERNAME} distro=${DISTRO}\" -v"

ansible-playbook webarch.yml -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}" -v

