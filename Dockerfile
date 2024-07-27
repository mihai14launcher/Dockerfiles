FROM debian:12

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
        systemd \
        systemd-sysv \
        dbus \
        sudo \
        docker.io && \
    echo 'root:root' | chpasswd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create systemd service for Docker
RUN mkdir -p /etc/systemd/system/docker.service.d && \
    printf '[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H fd://\n' > /etc/systemd/system/docker.service.d/override.conf

# Enable Docker service
RUN systemctl enable docker

# Create systemd service for Portainer
RUN printf '[Unit]\nDescription=Portainer Service\nAfter=docker.service\nRequires=docker.service\n' > /etc/systemd/system/portainer.service && \
    printf '[Service]\nExecStart=/usr/bin/sudo docker run -d --name portainer -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce\n' >> /etc/systemd/system/portainer.service && \
    printf '[Install]\nWantedBy=multi-user.target\n' >> /etc/systemd/system/portainer.service

# Enable Portainer service
RUN systemctl enable portainer

# Expose port
EXPOSE 9000

# Use systemd as the entry point
CMD ["/sbin/init"]
