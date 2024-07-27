FROM docker:20.10.7-dind

# Install necessary packages
RUN apk update && \
    apk add --no-cache tmate sudo && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    printf "systemctl start systemd-logind" >> /etc/profile

# Start portainer container
RUN mkdir /portainer && \
    printf '#!/bin/sh\n' > /portainer/start.sh && \
    printf 'dockerd-entrypoint.sh &\n' >> /portainer/start.sh && \
    printf 'sleep 10\n' >> /portainer/start.sh && \
    printf 'docker run -d --name portainer -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce\n' >> /portainer/start.sh && \
    chmod +x /portainer/start.sh

# Expose port
EXPOSE 9000

# Use the custom start script as the entry point
CMD ["/portainer/start.sh"]
