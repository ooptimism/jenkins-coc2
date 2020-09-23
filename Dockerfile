FROM qingfeng1987/jenkins-coc2:1.5
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
#configuration
RUN /usr/local/bin/install-plugins.sh poll-mailbox-trigger build-user-vars sonarqube-generic-coverage
RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN mkdir -p /jenkins/casc_configs
ENV CASC_JENKINS_CONFIG=/jenkins/casc_configs
COPY config.yaml /jenkins/casc_configs/config.yaml
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.4.0.2170-linux.zip

USER jenkins
# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

