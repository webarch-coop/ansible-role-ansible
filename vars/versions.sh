#!/usr/bin/env bash
#
# Run this script to generate an YAML array of Ansible versions
#
#   bash ./versions.sh > versions.yml
#
# Changelog URLs can be found here
# https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-community-changelogs

declare -a base_changelog_urls=(
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/2.10/CHANGELOG-v2.10.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/3/CHANGELOG-v3.rst"
)
declare -a core_changelog_urls=(
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/4/CHANGELOG-v4.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/5/CHANGELOG-v5.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/6/CHANGELOG-v6.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/7/CHANGELOG-v7.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/8/CHANGELOG-v8.rst"
"https://raw.githubusercontent.com/ansible-community/ansible-build-data/main/9/CHANGELOG-v9.rst"
)

echo "---"
echo "ans_versions:"
for url in "${base_changelog_urls[@]}"
  do
    wget -q "${url}" -O CHANGELOG
    readarray -t strings < <(grep "contains Ansible-base version" CHANGELOG | sort -V)
    for line in "${strings[@]}"
      do
        ansible=$(echo "${line}" | awk '{print $2}')
        base=$(echo "${line}" | awk '{print $6}' | sed 's/[.]$//')
        echo "  - ansible: ${ansible}"
        echo "    base: ${base}"
    done
done
for url in "${core_changelog_urls[@]}"
  do
    wget -q "${url}" -O CHANGELOG
    readarray -t strings < <(grep -i "contains Ansible-core version" CHANGELOG | sort -V)
    for line in "${strings[@]}"
      do
        ansible=$(echo "${line}" | awk '{print $2}')
        core=$(echo "${line}" | awk '{print $6}' | sed 's/[.]$//')
        echo "  - ansible: ${ansible}"
        echo "    core: ${core}"
    done
done
rm CHANGELOG
