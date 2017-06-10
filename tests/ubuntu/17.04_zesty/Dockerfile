FROM ubuntu:17.04

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN gem install ansible -v 0.2.2

CMD tail -f /dev/null

# RUN apt-get update -qq && \
#     apt-get install sudo ansible git -y >> /dev/null

# RUN ansible --version

# ENV USER docker_ansible
# RUN /usr/sbin/groupadd $USER && \
#     /usr/sbin/useradd $USER -m -d /home/$USER -g $USER -s /bin/bash && \
#     echo $USER 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER docker_ansible

# WORKDIR /tmp/environment-setup

# CMD ansible-playbook -i tests/inventory tests/test.yml
