# Webarchitects Ansible Role

[![pipeline status](https://git.coop/webarch/ansible/badges/master/pipeline.svg)](https://git.coop/webarch/ansible/-/commits/master)

This role contains an Ansible role for installing Ansible collections, [Ansible Lint](https://github.com/ansible/ansible-lint) and [Molecule](https://github.com/ansible-community/molecule) on Debian Bookworm, Debian Bullseye and Ubuntu Jammy.

Debian Bullseye provides [Ansible 2.10.7](https://packages.debian.org/bullseye/ansible) and Ubuntu Jammy provides [Ansible 2.10.7](https://packages.ubuntu.com/jammy/ansible), when this role is run on these distros Ansible itself will also be updated to match the Ansible version on [Debian Bookworm](https://packages.debian.org/bookworm/ansible-core).

The suggested way to use this role is via the [localhost repo](https://git.coop/webarch/localhost) which contains a [ansible.sh](https://git.coop/webarch/localhost/-/blob/main/ansible.sh) script that will download this role and run it.

This role is designed to be run by a non-root user, it will install Ansible to `~/.local/bin`, if `~/.local/bin` is not found in the `$PATH` environmental variable then the suggested method for updating the `$PATH` is to add the following to your `~/.bash_profile`:

```bash
PATH=${HOME}/.local/bin:${PATH}
export PATH=${PATH}
```

After updating or creating this file you need to either exit the shell and reopen it or run `source ~/.bash_profile`.

## Role variables

See the [defaults/main.yml](defaults/main.yml) file for the default variables, the [vars/main.yml](vars/main.yml) file for the preset variables and [meta/argument_specs.yml](meta/argument_specs.yml) for the variable specification.

### ans

Set the `ans` variable to `false` to prevent any tasks in this role being run.

### ans_collections

A list of Ansible collections and their versions that will be installed, each item in the list requires a `name` for the name of the collection and the `version`, the version can be a version number or `latest`, for example:

```yaml
ans_collections:
  - name: community.general
    version: latest
```

The versions of `community.general` that are available can be found on the [GitHub releases page](https://github.com/ansible-collections/community.general/releases).

### ans_version

The version of Ansible that will be installed if the packaged version is less than this version.

## License

This role is released under [the same terms as Ansible itself](https://github.com/ansible/ansible/blob/devel/COPYING), the [GNU GPLv3](LICENSE).

## Notes

List the installed Ansible galaxy collections:

```bash
ansible-galaxy collection list
```

## Links

* [Ansible Porting Guides](https://docs.ansible.com/ansible/devel/porting_guides/porting_guides.html) porting guides that can help you in updating playbooks, plugins and other parts of your Ansible infrastructure from one version of Ansible to the next

## Repo history

Originally, [in 2019](https://git.coop/webarch/ansible/-/tree/archive2019), this repo contained a few roles that have since been moved to other repos.
