FROM debian:12

# Install necessary packages
RUN apt-get update && \
    apt-get install -y tmate sudo docker.io && \
    echo 'root:root' | chpasswd && \
    apt-get clean

# Start docker daemon in the background and portainer
RUN printf '#!/bin/bash\n' > /start.sh && \
    printf 'dockerd &\n' >> /start.sh && \
    printf 'sleep 5\n' >> /start.sh && \
    printf 'docker run -d --name portainer -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce\n' >> /start.sh && \
    chmod +x /start.sh

# Expose port
EXPOSE 9000

# Use the custom start script as the entry point
CMD ["/start.sh"]
