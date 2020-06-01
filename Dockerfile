FROM qingfeng1987/jenkins-coc2:1.2
MAINTAINER xlm <xue.lm@neusoft.com>

COPY generate_key.sh /usr/local/bin/generate_key.sh
COPY entrypoint.sh /entrypoint.sh
RUN entrypoint.sh
USER jenkins


ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
