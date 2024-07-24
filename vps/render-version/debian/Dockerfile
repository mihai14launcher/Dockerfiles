# Use the latest Debian image as a parent image
FROM debian:latest

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

# Create the HTML file with the desired content
RUN echo '<!DOCTYPE html>\n<html>\n<head>\n<title>Hello from NGINX</title>\n</head>\n<body>\n<h1><strong>**Now you can use uptime robot or another service status uptime to host your app 24/7</strong></h1>\n</body>\n</html>' > /var/www/html/index.html

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

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]

# Set the entrypoint to systemd
ENTRYPOINT ["/sbin/init"]
