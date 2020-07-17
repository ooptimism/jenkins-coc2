FROM jenkins/jenkins:lts
MAINTAINER lqf <bbsywj@gmail.com>

USER root

# install neu root CA
COPY neu2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
RUN apt-get update && apt-get install -y make
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh < /usr/share/jenkins/ref/plugins.txt
ENV SomeUserPassword=123
ENV SSH_PRIVATE_KEY=/var/jenkins_home/.ssh/id_rsa
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/credentials.yaml
COPY credentials.yaml $CASC_JENKINS_CONFIG
# Install plugins
#RUN /usr/local/bin/install-plugins.sh \
#  gerrit-trigger \
#  kubernetes
USER jenkins

# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

