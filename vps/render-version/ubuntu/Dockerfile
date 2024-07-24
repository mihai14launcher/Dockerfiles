# Use the latest Debian image as a parent image
FROM ubuntu:latest

# Update and upgrade the base image
RUN apt-get update -y && \
    apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y tmate curl wget unzip tar zip nano htop neofetch \
    python3-pip npm nginx

# Install global npm packages
RUN npm install -g pm2
RUN pm2 install pm2-logrotate

# Install systemd and related packages
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile

# Copy the HTML file to the NGINX default directory
COPY index.html /var/www/html/index.html

# Expose port 6969
EXPOSE 6969

# Replace the default NGINX configuration with a custom one
RUN echo 'server {\n\
    listen 6969;\n\
    server_name localhost;\n\
    location / {\n\
        root /var/www/html;\n\
        index index.html index.htm;\n\
    }\n\
}' > /etc/nginx/sites-available/default

# Enable the custom configuration by linking it to the sites-enabled directory
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Run tmate session and start nginx in the foreground
CMD ["tmate"]

# Set the entrypoint to systemd
ENTRYPOINT ["/sbin/init"]
