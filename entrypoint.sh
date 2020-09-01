#!/bin/bash
set -e

echo "Genarate JENKINS SSH KEY"
source /usr/local/bin/generate_key.sh
echo "start JENKINS"
# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
    exec tini -- /usr/local/bin/jenkins.sh "$@"
fi
echo "machine gerrit.coc-automative.com login gerritadmin password 123" > /var/jenkins_home/.netrc
exec "$@"
