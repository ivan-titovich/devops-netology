FROM pycontribs/fedora

RUN dnf -y install openssh-server httpd supervisor

#RUN yum update &&
#RUN yum install  openssh-server sudo -y

RUN  echo 'root:root' | chpasswd

RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

#RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]