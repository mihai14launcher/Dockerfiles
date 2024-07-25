# Base image for Render Version of Docker VPS 
FROM ubuntu:latest

# Update the instance
RUN apt-get update -y && apt-get upgrade -y && apt update -y && apt upgrade -y

# Changing the password to 'root'
RUN echo "root:root" | chpasswd

# Install necessary packages
RUN apt-get install -y \
    shellinabox \
    dropbear \
    curl \
    wget \
    unzip \
    zip \
    nano \
    tar \
    nginx \
    npm \
    tmate

# Install Ngrok for Online Terminal
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install -y ngrok

# Setup Shell in a box
RUN sed -i 's/^# SHELLINABOX_PORT=.*/SHELLINABOX_PORT=7979/' /etc/default/shellinabox && \
    sed -i 's/^# SHELLINABOX_ARGS=.*/SHELLINABOX_ARGS="--no-beep --disable-ssl -s \/:LOGIN"/' /etc/default/shellinabox

# Expose ports
EXPOSE 8461 22 80 7979

# Install PM2 and logrotate
RUN npm install -g pm2 && pm2 install pm2-logrotate

# Create index.html
RUN echo '<!DOCTYPE html>\n<html>\n<head>\n<title>It works :)</title>\n</head>\n<body>\n<h1>It works :)</h1>\n</body>\n</html>' > /var/www/html/index.html

# Copy the Edge.sh for Web Terminal
COPY edge.sh /

#Add Token 
RUN ngrok config add-authtoken your-token

#Starting PM2 edge.sh file
RUN pm2 start edge.sh --name Network

# Start Web Terminal
CMD ["sh", "-c", "nginx && shellinaboxd --no-beep --disable-ssl -s /:LOGIN --port=7979"]
