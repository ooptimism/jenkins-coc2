FROM jenkins/jenkins:lts
MAINTAINER lqf <bbsywj@gmail.com>

USER root

# install neu root CA
COPY neu2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates

COPY generate_key.sh /usr/local/bin/generate_key.sh
RUN generate_key.sh

# Install plugins
#RUN /usr/local/bin/install-plugins.sh \
#  gerrit-trigger \
#  kubernetes
USER jenkins


ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
