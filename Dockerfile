FROM jenkins/jenkins:2.222.4-lts
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
RUN /usr/local/bin/install-plugins.sh workflow-basic-steps pipeline-stage-step kubernetes git-client git ssh-agent gerrit-trigger ownership email-ext emailext-template configuration-as-code workflow-aggregator http-post poll-mailbox-trigger build-user-vars junit:1.29 sonar:2.12
RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.4.0.2170-linux.zip

USER jenkins
# Generate jenkins ssh key.
COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

