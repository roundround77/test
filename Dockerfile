FROM ubuntu:18.04

RUN \
        apt-get update && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:deadsnakes/ppa && \
        apt-get install -y python3.9 && \
        apt-get install -y python3-pip && \
        apt-get install -y python3.9-distutils && \
        apt-get install -y git-all && \
        apt-get install -y pylint && \   
        apt-get install -y python-pytest && \
        apt-get install -y unzip  && \
        apt-get install -y wget unzip  && \
        apt-get install -y vim

RUN mkdir -p /root
RUN python3.9 -m pip install boto3 pylint-exit pylint-fail-under pytest-cov
WORKDIR /root
COPY ./ /root
RUN mkdir /downloads/sonarqube -p
RUN cd /downloads/sonarqube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
RUN unzip sonar-scanner-cli-4.2.0.1873-linux.zip
RUN mv sonar-scanner-4.2.0.1873-linux /root/sonarqube-scanner
RUN export PATH=$PATH:/root/sonarqube-scanner/bin
WORKDIR /root
RUN pylint --generate-rcfile > .pylintrc
RUN echo "fail-under=5" >> .pylintrc
RUN echo touch ~/.pylintrc
