FROM pycontribs/ubuntu:latest

RUN apt update && apt install  openssh-server sudo -y

RUN  echo 'root:root' | chpasswd

RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 22

CMD ["sh", "-c", "tail -f /dev/null"]