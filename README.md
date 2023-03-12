# Webarchitects Ansible Role

[![pipeline status](https://git.coop/webarch/ansible/badges/master/pipeline.svg)](https://git.coop/webarch/ansible/-/commits/master)

This repo contains an Ansible role for [installing Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [Ansible Lint](https://github.com/ansible/ansible-lint), [Molecule](https://github.com/ansible-community/molecule) and other [Python Package Index](https://pypi.org/) (PyPI) packages on Debian Bookworm, Debian Bullseye and Ubuntu Jammy.

The version of [Ansible provided by Debian Bullseye](https://packages.debian.org/bullseye/ansible) and the version provided by [Ubuntu Jammy](https://packages.ubuntu.com/jammy/ansible) is `2.10.7` and when this role is run on these distros Ansible itself will be installed for the user running this role.

This role is currently set to more-or-less match the Ansible version available on [Debian Bookworm](https://packages.debian.org/bookworm/ansible-core) (the version strings are set in the [defaults/main.yml](defaults/main.yml) file).

**Note** The `master` branch of this role is used for development and testing, currently it is a WIP to replace `pip` with `pipx`. 

## Usage

The suggested method for using this role is via the [localhost repo](https://git.coop/webarch/localhost) which contains a [ansible.sh](https://git.coop/webarch/localhost/-/blob/main/ansible.sh) script that will download this role and run it, for example:

```bash
git clone https://git.coop/webarch/localhost.git
cd localhost
./ansible.sh --check # check what versions are available and installed
./ansible.sh         # update pypi packages and ansible collections
```

This role is designed to be run by a non-root user, it will install Ansible to `~/.local/bin`, if `~/.local/bin` is not found in the `$PATH` environmental variable and if the users `$SHELL` environmental variable ends in `bash` and `~/.bash_profile` doesn't exist then one will be created (but it won't be touched if it already exists), see the [files/bash_profile.sh](bash_profile.sh) file for it's content.

To manually update the `$PATH` add the following to your `~/.bash_profile` or whichever file sets your `$PATH` environmental variable when you login:

```bash
PATH="${HOME}/.local/bin:${PATH}"
export PATH="${PATH}"
```

After updating or creating a file containing your `$PATH` environmental variable you will need to either exit the shell and login again / reopen it or run `source ~/.bash_profile`, (replace `~/bash_profile` which which ever path contains the settings).

## Role variables

See the [defaults/main.yml](defaults/main.yml) file for the default variables, the [vars/main.yml](vars/main.yml) file for the preset variables and the [meta/argument_specs.yml](meta/argument_specs.yml) file for the variable specification.

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

### ans_downgrade

The `ans_downgrade` variable defaults to `false`, if it is set to `true` then this role will install older versions of PyPi packages  Ansible Galaxy Collections even when newer system versions are present.

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

If this role is run usidng `sudo` or as `root` these packages will be automatically installed, when it is run as a non-root user this role will fail if these packages are not present.

### ans_pypi_pkgs

A list of Python Package Index ([PyPI](https://pypi.org/)), package names, URLs and versions that will be installed as user packages if they are not already available as system packages.

Each item in the list requires a `name` for the name of the PyPI package, when the `state` is not set to `absent` a `url` for the URL of the project on the PyPI website and a `version` is also required, the version can be a version number or `latest`, the `extras` list and `state` are optional, for example:

```yaml
ans_pypi_pkgs:
  - name: ansible-core
    url: https://pypi.org/pypi/ansible-core
    version: "2.14.1"
  - name: ansible-lint
    url: https://pypi.org/pypi/ansible-lint
    version: latest
  - name: "molecule-plugins"
    extras:
      - docker
      - podman
    state: forcereinstall
    url: https://pypi.org/pypi/molecule-plugins
    version: "23.0.0"
  - name: resolvelib
    state: absent
```

Only `absent`, `present` (the default) and `forcereinstall` are supported for `state`, use `state: present` and `version: latest` for the latest version, `forcereinstall` is necessary if the list of `extras` is changed, see the [Installing "Extras"](https://packaging.python.org/en/latest/tutorials/installing-packages/#id29) documentation.

Note that the `url` is used to download a JSON file that lists all the versions of the package that are available, the URL for the JSON file is the `url` appended with `/json`, the URL without `/json` redirects to the project page, for example `https://pypi.org/pypi/ansible-core` redirects to `https://pypi.org/project/ansible-core/`.

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
python3 -m pip list --user --format=json | jq | jp "[].name" | yq -o=yaml -PM | awk '{ print $2 }'
```

Delete all PyPi user packages on Debian Bookworm:

```bash
python3 -m pip uninstall --break-system-packages \
$(pip list --user --format=json | jq | jp "[].name" | yq -o=yaml -PM | awk '{ print $2 }' | xargs )
```

List the PyPI package extras present, this `jq` query has been [copied from GitHub](https://github.com/pypa/pip/issues/4824#issuecomment-1298200394):

```bash
python3 -m pip inspect | jq '.installed[]|select(.metadata.name=="molecule-plugins").metadata.provides_extra'
```

List the pipx packages present:

```bash
pipx list
pipx list --json | jq
```

List the installed Ansible galaxy collections:

```bash
ansible-galaxy collection list
ansible-galaxy collection list --format=json | jq
```

## Links

* [Ansible Porting Guides](https://docs.ansible.com/ansible/devel/porting_guides/porting_guides.html) that can help you in updating playbooks, plugins and other parts of your Ansible infrastructure from one version of Ansible to the next

## Repository

The primary URL of this repo is [`https://git.coop/webarch/ansible`](https://git.coop/webarch/ansible) however it is also [mirrored to GitHub](https://github.com/webarch-coop/ansible-role-ansible) and [available via Ansible Galaxy](https://galaxy.ansible.com/chriscroome/ansible).

If you use this role please use a tagged release, see [the release notes](https://git.coop/webarch/ansible/-/releases).

Originally, [in 2019](https://git.coop/webarch/ansible/-/tree/archive2019), this repo contained a few roles that have since been moved to other repos.

## Copyright

Copyright 2019-2023 Chris Croome, &lt;[chris@webarchitects.co.uk](mailto:chris@webarchitects.co.uk)&gt;.

This role is released under [the same terms as Ansible itself](https://github.com/ansible/ansible/blob/devel/COPYING), the [GNU GPLv3](LICENSE).
