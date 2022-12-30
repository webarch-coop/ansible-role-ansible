# Webarchitects Ansible Role

[![pipeline status](https://git.coop/webarch/ansible/badges/master/pipeline.svg)](https://git.coop/webarch/ansible/-/commits/master)

This role contains an Ansible role for [installing Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [Ansible Lint](https://github.com/ansible/ansible-lint), [Molecule](https://github.com/ansible-community/molecule) and other [Python Package Index](https://pypi.org/) (PyPI) packages on Debian Bookworm, Debian Bullseye and Ubuntu Jammy.

The version of [Ansible provided by Debian Bullseye](https://packages.debian.org/bullseye/ansible) and the version provided by [Ubuntu Jammy](https://packages.ubuntu.com/jammy/ansible) is `2.10.7`, when this role is run on these distros Ansible itself will be installed for the user running this role.

This role is set to match the Ansible version available on [Debian Bookworm](https://packages.debian.org/bookworm/ansible-core) (the version strings are set in the [defaults/main.yml](defaults/main.yml) file), Ansible is not installed for users on Debian Bookworm since the Debian packaged version is fine.

This role is designed to be run by a non-root user, it will install Ansible to `~/.local/bin`, if `~/.local/bin` is not found in the `$PATH` environmental variable then the suggested method for updating the `$PATH` is to add the following to your `~/.bash_profile`:

```bash
PATH=${HOME}/.local/bin:${PATH}
export PATH=${PATH}
```

After updating or creating this file you need to either exit the shell and reopen it or run `source ~/.bash_profile`.

The suggested way to use this role is via the [localhost repo](https://git.coop/webarch/localhost) which contains a [ansible.sh](https://git.coop/webarch/localhost/-/blob/main/ansible.sh) script that will download this role and run it.

## Role variables

See the [defaults/main.yml](defaults/main.yml) file for the default variables, the [vars/main.yml](vars/main.yml) file for the preset variables and [meta/argument_specs.yml](meta/argument_specs.yml) for the variable specification.

### ans

Set the `ans` variable to `true` run the tasks in this role, it defaults to `false`.

### ans_cols

A list of Ansible collections, URLS and versions.

Each item in the list requires a `name`, for the name of the collection, a `url`, for the GitHub repo URL of the collection and a `version`, the version can be a version number or `latest`, for example:

```yaml
ans_cols:
  - name: community.general
    url: https://github.com/ansible-collections/ansible.posix
    version: latest
```

Note that the `url` of the GitHub project is appended with `/releases/latest` to get the URL of the latest release, for example for `community.general` this is [the latest version](https://github.com/ansible-collections/community.general/releases/latest), see the [GitHub releases page](https://github.com/ansible-collections/community.general/releases) for all the versions available..

### ans_pkgs

A list of Debian / Ubuntu packages that are required, for example;

```yaml
ans_pkgs:
  - ansible
  - python3-argcomplete
  - python3-dnspython
  - python3-jmespath
```

See the [defaults/main.yml](defaults/main.yml) file for the default list of packages.

If this role is run suidng `sudo` or as `root` these packages will be automatically installed, when run as a non-root user the role will fail if these packages are not present.

### ans_pypi_pkgs

A list of [Python Package Index ([PyPI[(https://pypi.org/)), package names and versions that will be installed as user packages if they are not already available as system packages or user packages.

Each item in the list requires a `name` for the name of the PyPI package, a `url` for the URL of the project on the PyPI website and a `version`, the version can be a version number or `latest`, for example:

```yaml
ans_pypi_pkgs:
  - name: ansible-core
    url: https://pypi.org/pypi/ansible-core
    version: "2.14.1"
  - name: ansible-lint
    url: https://pypi.org/pypi/ansible-lint
    version: latest
```

Note that the `url` is used to download a JSON file that lists all the versions of the package that are available, the URL for the JSON file is the `url` appended with `/json`, the URL without `/json` redirects to the project page, eg `https://pypi.org/pypi/ansible-core` redirects to `https://pypi.org/project/ansible-core/`.

## Notes

List the PyPI system packages present:

```bash
python3 -m pip list
python3 -m pip list --format=json | jq
```

List the PyPI user packages present:

```bash
python3 -m pip list --user
python3 -m pip list --user --format=json | jq
```

List the installed Ansible galaxy collections:

```bash
ansible-galaxy collection list
ansible-galaxy collection list --format=json | jq
```

## Links

* [Ansible Porting Guides](https://docs.ansible.com/ansible/devel/porting_guides/porting_guides.html) that can help you in updating playbooks, plugins and other parts of your Ansible infrastructure from one version of Ansible to the next

## Repo history

Originally, [in 2019](https://git.coop/webarch/ansible/-/tree/archive2019), this repo contained a few roles that have since been moved to other repos.

## License

This role is released under [the same terms as Ansible itself](https://github.com/ansible/ansible/blob/devel/COPYING), the [GNU GPLv3](LICENSE).
