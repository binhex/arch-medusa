#!/bin/bash

# exit script if return code != 0
set -e

repo_name="pymedusa"
app_name="Medusa"
install_name="medusa"

# find latest release tag from github
curly.sh -rc 6 -rw 10 -of /tmp/release_tag -url "https://github.com/${repo_name}/${app_name}/releases"
release_tag=$(cat /tmp/release_tag | grep -P -o -m 1 "(?<=/${repo_name}/${app_name}/releases/tag/)[^\"]+")

# download install zip file
curly.sh -rc 6 -rw 10 -of "/tmp/${app_name}-release.zip" -url "https://github.com/${repo_name}/${app_name}/archive/${release_tag}.zip"

# unzip to /tmp
unzip "/tmp/${app_name}-release.zip" -d /tmp

# create destination directories
mkdir -p "/opt/${install_name}/"

# move to destination folder
mv /tmp/${app_name}*/* "/opt/${install_name}/"

# remove source zip file
rm "/tmp/${app_name}-release.zip"
