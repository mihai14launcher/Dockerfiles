FROM debian:12

RUN apt-get update && \
    apt-get install -y tmate && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile

RUN apt install sudo -y
RUN sudo apt update -y

RUN sudo apt install docker.io -y
RUN systemctl start docker
RUN systemctl enable docker

EXPOSE 9000

sudo docker run -d \
--name portainer \
-p 9000:9000 \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce

CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
