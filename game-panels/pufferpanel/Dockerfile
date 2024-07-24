FROM UBUNTU:LATEST
#Upgrade the instance
RUN apt-get update
RUN apt-get upgrade
RUN apt update -y
RUN apt upgrade -y
#Start and install firewall ports
RUN apt install ufw -y
EXPOSE 8080
EXPOSE 5657

#Install and setup Systemctl
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
 printf "systemctl start systemd-logind" >> /etc/profile

#Install Pufferpanel
RUN apt install curl wget tar unzip zip -y
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo os=ubuntu dist=jammy bash &
RUN sudo apt-get install -y pufferpanel &
RUN sudo pufferpanel user add --name pufferpanel --email docker@install.local --password pufferpanel --admin &
RUN sudo systemctl enable --now pufferpanel &

CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
