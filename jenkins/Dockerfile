FROM jenkins/jenkins:lts-jdk17

# No utilizar en un ambiente de producción
ENV JENKINS_USER=admin
ENV JENKINS_PASS=admin
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false
COPY plugins.txt .
USER root
RUN jenkins-plugin-cli -f plugins.txt
RUN apt-get update && apt-get install -y docker.io python3 python3-pip python3-django pylint && apt-get clean
COPY start.sh .
RUN mkdir /deploy
RUN chown jenkins:jenkins /deploy
RUN apt-get update -y
RUN apt-get install -y maven 
# USER jenkins
ENTRYPOINT [ "/start.sh" ]

