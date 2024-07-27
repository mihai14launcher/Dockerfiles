FROM debian:12

RUN apt-get update && \
    apt-get install -y tmate && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile && \
    apt install sudo -y && \
    sudo apt update -y && \
    sudo apt install docker.io -y && \
    systemctl start docker && \
    systemctl enable docker && \
    sudo docker run -d \
--name portainer \
-p 9000:9000 \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce

EXPOSE 9000

CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
