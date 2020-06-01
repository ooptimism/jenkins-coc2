#!/bin/bash
set -e

# Constants
JENKINS_HOME="/var/jenkins_home"
JENKINS_SSH_DIR="${JENKINS_HOME}/.ssh"

if [ ! -d "${JENKINS_SSH_DIR}" ]; then mkdir -p "${JENKINS_SSH_DIR}"; fi

if [ ! -f ${JENKINS_SSH_DIR}/"id_rsa" ]; then
    echo "Generating Jenkins Key Pair"
    rm -f ${JENKINS_SSH_DIR}/id_rsa.pub
    ssh-keygen -t rsa -f ${JENKINS_SSH_DIR}/'id_rsa' -b 4096 -N '';
fi
