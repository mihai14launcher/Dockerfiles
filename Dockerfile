From ubuntu:latest

RUN apt update -y
RUN apt upgrade -y
RUN apt install ufw -y

RUN apt-get update && \
    apt-get install -y tmate && \
    echo 'root:root' | chpasswd && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile

RUN ufw allow 8080
RUN ufw allow 5657

EXPOSE 8080
EXPOSE 5657

RUN apt install systemctl -y

RUN apt install nginx curl nano wget unzip tar zip -y

RUN apt install sudo

RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo os=ubuntu dist=jammy bash

RUN sudo apt install htop tmate php npm python3-pip -y
RUN sudo npm install -g pm2
RUN clear
RUN sudo pm2 install pm2-logrotate

RUN sudo apt-get install pufferpanel

RUN sudo pufferpanel user add admin@admin.admin admin1 admin1 admin1 admin

RUN sudo systemctl enable --now pufferpanel
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok
	
RUN ngrok config add-authtoken put-your-ngrok-token-here

RUN ngrok http 8080	
