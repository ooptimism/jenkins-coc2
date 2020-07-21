FROM jenkins/jenkins:lts
MAINTAINER lqf <bbsywj@gmail.com>

USER root

# install neu root CA
COPY neu2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
RUN apt-get update && apt-get install -y make
RUN /usr/local/bin/install-plugins.sh workflow-basic-steps pipeline-stage-step kubernetes git-client git ssh-agent gerrit-trigger ownership email-ext emailext-template configuration-as-code
ENV SomeUserPassword=123
ENV SSH_PRIVATE_KEY=/var/jenkins_home/.ssh/id_rsa
# Install plugins
#RUN /usr/local/bin/install-plugins.sh \
#  gerrit-trigger \
#  kubernetes
USER jenkins

# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

