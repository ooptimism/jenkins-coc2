FROM jenkins/jenkins:lts
MAINTAINER lqf <bbsywj@gmail.com>

USER root

# install neu root CA
COPY neu2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
RUN apt-get update && apt-get install -y make
# Install plugins
#RUN /usr/local/bin/install-plugins.sh \
#  gerrit-trigger \
#  kubernetes
RUN /usr/local/bin/install-plugins.sh workflow-basic-steps pipeline-stage-step kubernetes git-client git ssh-agent gerrit-trigger ownership email-ext emailext-template configuration-as-code workflow-aggregator http-post
#configuration
RUN mkdir -p /jenkins/casc_configs
ENV CASC_JENKINS_CONFIG=/jenkins/casc_configs
COPY config.yaml /jenkins/casc_configs/config.yaml

USER jenkins
# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

