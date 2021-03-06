ARG JENKINS_VERSION=2.263
FROM jenkins/jenkins:$JENKINS_VERSION
LABEL Maintainer="Yash Jagdale <jagdale0210@gmail.com>"
LABEL Description="This demo shows how to setup Jenkins Config-as-Code with Docker, Pipeline, and Groovy Hook Scripts" Vendor="Yash Jagdale" Version="0.2"

ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

COPY init_scripts/src/main/groovy/ /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home/pipeline-library
VOLUME /var/jenkins_home/pipeline-libs
EXPOSE 5005

COPY jenkins2.sh /usr/local/bin/jenkins2.sh
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yaml
COPY jenkins.yaml /var/jenkins_home/jenkins.yaml
ENTRYPOINT ["tini", "--", "/usr/local/bin/jenkins2.sh"]