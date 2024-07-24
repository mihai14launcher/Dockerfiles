FROM Debian:latest

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt install tmate curl wget unzip tar zip nano htop neofetch -y

RUN apt install python3-pip npm -y
RUN npm install -g pm2
RUN pm2 install pm2-logrotate

RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session && \
    printf "systemctl start systemd-logind" >> /etc/profile

RUN tmate

CMD ["bash"]
ENTRYPOINT ["/sbin/init"]
