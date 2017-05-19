# Webarchitects Co-operative Ansible Playbooks for Debian Servers

Playbooks to setup things specifically for Webarchitects Co-operative so our
other published playbooks can be more generic, for example we use `vim` and
therefore remove `nano`...

To run one of these playbooks as `root` on the remote server using a SSH
password:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook example.yml -k -u root -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```

To run one of these playbooks as `root` on the remote server using public keys:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook example.yml -u root -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```

To run one of these playbooks as a sudoer using public keys:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook example.yml -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```






