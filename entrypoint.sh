#!/bin/bash
set -e

echo "Genarate JENKINS SSH KEY"
source /usr/local/bin/generate_key.sh
echo "machine gerrit.coc-automative.com login gerritadmin password 123" > /var/jenkins_home/.netrc
cd /var/jenkins_home/
if [ ! -d /var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/MySonarQube ]; then
    mkdir -p /var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/MySonarQube
    unzip /sonar-scanner-cli-4.4.0.2170-linux.zip && mv sonar-scanner-4.4.0.2170-linux/* /var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/MySonarQube
fi
echo "start JENKINS"
# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
    exec tini -- /usr/local/bin/jenkins.sh "$@"
fi
exec "$@"
