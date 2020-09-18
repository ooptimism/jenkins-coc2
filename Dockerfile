FROM qingfeng1987/jenkins-coc2:1.2
MAINTAINER lqf <bbsywj@gmail.com>

USER root

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.4.0.2170-linux.zip \
&& unzip sonar-scanner-cli-4.4.0.2170-linux.zip && mv sonar-scanner-4.4.0.2170-linux /usr/local/sonar-scanner \
&& rm sonar-scanner-cli-4.4.0.2170-linux.zip

USER jenkins
ENV PATH="$PATH:/usr/local/sonar-scanner/bin"
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
