FROM jenkins/jenkins:lts
MAINTAINER lqf <bbsywj@gmail.com>

USER root

# install neu root CA
COPY neu2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
RUN apt-get update && apt-get install -y make
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
# Install plugins
#RUN /usr/local/bin/install-plugins.sh \
#  gerrit-trigger \
#  kubernetes
USER jenkins

# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ARG JENKINS_GENERATE_RELEASE_NOTE=true
ARG JENKINS_GERRIT_SERVER=10.1.23.110

ENTRYPOINT ["/entrypoint.sh"]

