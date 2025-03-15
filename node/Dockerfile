# CentOS9
FROM quay.io/centos/centos:stream9

# install ssh server
RUN yum -y install openssh-server && yum clean all

# install sudo
RUN yum -y install sudo && yum clean all

RUN useradd -m -s /bin/bash ansible
RUN mkdir /home/ansible/.ssh/
RUN chown -R ansible:ansible /home/ansible/.ssh/
RUN echo "ansible:p@ssword01" | chpasswd

RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

# expose 22 port
EXPOSE 22

# start up sshd
CMD ["/usr/sbin/sshd", "-D"]
