FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    docker.io \
    python3 \
    python3-pip \
    && apt-get clean

RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

USER jenkins