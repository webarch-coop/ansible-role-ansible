# Webarchitects Ansible Role

[![pipeline status](https://git.coop/webarch/ansible/badges/master/pipeline.svg)](https://git.coop/webarch/ansible/-/commits/master)

This role contains an Ansible role for installing Ansible Galaxy collections and [Ansible Lint](https://github.com/ansible/ansible-lint) and [Molecule](https://github.com/ansible-community/molecule) via `pip3`, see the [defaults/main.yml](defaults/main.yml) file for the versions that are installed. 

It can also optionally install [a version Ansible](https://pypi.org/project/ansible-core/#history) using `pip3`, however this isn't done by default as this role is being tested and developed using [the Debian Bookworm version of Ansible](https://packages.debian.org/bookworm/ansible-core).

## Links

* [Ansible Porting Guides](https://docs.ansible.com/ansible/devel/porting_guides/porting_guides.html) porting guides that can help you in updating playbooks, plugins and other parts of your Ansible infrastructure from one version of Ansible to the next

## Repo history

Originally, [in 2019](https://git.coop/webarch/ansible/-/tree/archive2019), this repo contained a few roles that have since been moved to other repos.
