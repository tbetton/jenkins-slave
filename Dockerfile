FROM jenkinsci/slave:latest 
USER root
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce
RUN groupadd docker
RUN usermod -aG docker jenkins
#RUN apt-get update && apt-get install -y python-pip 
#RUN pip install ansible 
RUN mkdir -p /home/jenkins/.ssh && \
    chown -R 1000:1000 /home/jenkins/.ssh

USER jenkins
