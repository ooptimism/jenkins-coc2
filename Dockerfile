FROM qingfeng1987/jenkins-coc2:1.2
MAINTAINER lqf <bbsywj@gmail.com>

USER root

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
RUN apt-get update && apt-get install -y libcurl4-openssl-dev

USER jenkins
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
