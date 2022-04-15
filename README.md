# Webarchitects Ansible Role

[![pipeline status](https://git.coop/webarch/ansible/badges/master/pipeline.svg)](https://git.coop/webarch/ansible/-/commits/master)

This role might contain an Ansible role for installing Ansible in the future, currently it checks which versions can be found in `/usr/bin` and `/usr/local/bin`.

This role might also do installs of collections in the future, for now you can update collections in `~/.ansible/collections/ansible_collections` like this:

```bash
ansible-galaxy collection install community.general
ansible-galaxy collection install community.mysql
```

Originally, [in 2019](https://git.coop/webarch/ansible/-/tree/archive2019), this repo contained a few roles that have since been moved to other repos.
