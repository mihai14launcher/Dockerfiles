FROM ubuntu:latest

RUN apt-get update && \
apt-get upgrade
RUN apt install curl wget unzip tar zip -y
RUN apt install git

RUN apt install npm -y
RUN git clone https://github.com/louislam/uptime-kuma.git
RUN cd uptime-kuma
RUN npm run setup
RUN npm install pm2 -g && pm2 install pm2-logrotate
RUN pm2 start server/server.js --name uptime-kuma
EXPOSE 3001
CMD ["pm2", "start", "server/server.js", "--name", "uptime-kuma"]
