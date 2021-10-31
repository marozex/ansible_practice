FROM almalinux:8.4

COPY .secret/id_rsa.pub /tmp/authorized_keys
RUN dnf -y install openssh-server sudo
RUN sed -i 's/^#\(Pubkey.*$\)/\1/g' /etc/ssh/sshd_config
RUN useradd deploy
RUN echo "deploy ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
RUN mkdir -m 700 /home/deploy/.ssh
RUN mv /tmp/authorized_keys /home/deploy/.ssh/authorized_keys
RUN chown -R deploy:deploy /home/deploy/.ssh
RUN chmod 600 /home/deploy/.ssh/*
RUN rm -f /var/run/nologin

CMD ["/usr/sbin/sshd", "-D"]