FROM ubuntu:16.10

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install software-properties-common sudo git >> /dev/null -y && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get install ansible -y >> /dev/null

RUN ansible --version

ENV USER docker_ansible
RUN /usr/sbin/groupadd $USER && \
    /usr/sbin/useradd $USER -m -d /home/$USER -g $USER -s /bin/bash && \
    echo $USER 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker_ansible

WORKDIR /tmp/environment-setup

CMD ansible-playbook -i tests/inventory tests/test.yml
