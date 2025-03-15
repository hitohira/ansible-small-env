# CentOS9
FROM quay.io/centos/centos:stream9

# system update
RUN yum -y update && yum clean all

# install sudo
RUN yum -y install sudo
# install ssh clients
RUN yum -y install openssh-clients

# install ansible
RUN yum -y install epel-release && \
yum -y install ansible && \
yum -y install iputils && \
yum -y install sshpass && \
yum clean all

ADD ansible.cfg /etc/ansible

RUN useradd -m -s /bin/bash ansible

RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

