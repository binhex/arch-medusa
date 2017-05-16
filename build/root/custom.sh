#!/bin/bash

# exit script if return code != 0
set -e

repo_name="pymedusa"
app_name="Medusa"
install_name="medusa"

# find latest release tag from github
release_tag=$(curl --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 60 -s "https://github.com/${repo_name}/${app_name}/releases" | grep -P -o -m 1 "(?<=/${repo_name}/${app_name}/releases/tag/)[^\"]+")

# download install zip file
curl --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 60 -o "/tmp/${app_name}-release.zip" -L "https://github.com/${repo_name}/${app_name}/archive/${release_tag}.zip"

# unzip to /tmp
unzip "/tmp/${app_name}-release.zip" -d /tmp

# create destination directories
mkdir -p "/opt/${install_name}/"

# move to destination folder
mv /tmp/${app_name}*/* "/opt/${install_name}/"

# remove source zip file
rm "/tmp/${app_name}-release.zip"
