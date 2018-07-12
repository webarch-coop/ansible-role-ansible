# Webarchitects Co-operative Ansible Playbooks for Debian Servers

Playbooks to setup things specifically for Webarchitects Co-operative so our other published playbooks can be more generic, for example we use `vim` and therefore remove `nano`...

## Initial server configuration

Once the virtual server has been created login as root using the Xen console and then run the following, replacing `chriscroome` with your username:

```bash
apt update
apt upgrade -y 
apt install -y python ssh-import-id
ssh-import-id chriscroome 
```

Where `$GITHUB_USERNAME` is your GitHub username, this will import your SSH public keys from GitHub, or use `ssh-import-id-lp` to use your SSH public keys from Launchpad.

Please run an appropriate `sudoers` Playbook to add sudoers accounds before runnng this Playbook.

## Running the Playbook

To run one of these playbooks as a sudoer using public keys:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook webarch.yml -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```

To run one of these playbooks as `root` on the remote server using a SSH
password:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook webarch.yml -k -u root -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```

To run one of these playbooks as `root` on the remote server using public keys:

```bash
export DISTRO="stretch"
export SERVERNAME="example.webarch.net"
ansible-playbook webarch.yml -u root -i ${SERVERNAME}, -e "hostname=${SERVERNAME} distro=${DISTRO}"
```

## Ansible 2.4

Debian Stretch ships with Ansible 2.2 and this is now rather old, so to update your local machine to 2.4 from backports, first add the backports repo and then install Ansible:

```bash
sudo -i
echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install ansible
```




