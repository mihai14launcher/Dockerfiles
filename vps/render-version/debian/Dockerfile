# Use the latest Debian image as a parent image
FROM debian:latest

# Update and upgrade the base image
RUN apt-get update -y && \
    apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y tmate curl wget unzip tar zip nano htop neofetch \
    python3-pip npm sudo shellinabox nginx

# Install ngrok
RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz && \
    tar -xvf ngrok.tgz && \
    mv ngrok /usr/local/bin/ngrok && \
    rm ngrok.tgz

# Set up Shell In A Box to allow root login
RUN sed -i 's/^# SHELLINABOX_PORT=.*/SHELLINABOX_PORT=7979/' /etc/default/shellinabox
RUN sed -i 's/^# SHELLINABOX_ARGS=.*/SHELLINABOX_ARGS="--no-beep --disable-ssl -s /:LOGIN"/' /etc/default/shellinabox

# Set root password
RUN echo "root:root" | chpasswd

# Create a basic index.html file
RUN echo '<!DOCTYPE html>\n<html>\n<head>\n<title>It works :)</title>\n</head>\n<body>\n<h1>It works :)</h1>\n</body>\n</html>' > /var/www/html/index.html

# Expose ports
EXPOSE 80
EXPOSE 7979

# Start NGINX, Shell In A Box, and ngrok
CMD ["sh", "-c", "nginx && shellinaboxd --no-beep --disable-ssl -s /:LOGIN --port=7979 & ngrok edge --authtoken $NGROK_TOKEN --url $NGROK_EDGE_URL --region=us"]
