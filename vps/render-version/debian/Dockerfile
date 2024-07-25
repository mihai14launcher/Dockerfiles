# Use the latest Debian image as a parent image
FROM debian:latest

# Update and upgrade the base image
RUN apt-get update -y && \
    apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y tmate curl wget unzip tar zip nano htop neofetch \
    python3-pip npm sudo shellinabox

# Set up Shell In A Box to use port 8461 and allow root login
RUN sed -i 's/^# SHELLINABOX_PORT=.*/SHELLINABOX_PORT=8461/' /etc/default/shellinabox
RUN sed -i 's/^# SHELLINABOX_ARGS=.*/SHELLINABOX_ARGS="--no-beep --disable-ssl -s /:LOGIN"/' /etc/default/shellinabox

# Set root password
RUN echo "root:root" | chpasswd

RUN apt install ufw -y
RUN ufw allow 8461
RUN ufw allow 80
RUN ufw allow 8080
RUN ufw allow 2022
RUN ufw allow 5657

# Expose port 8461
EXPOSE 8461
EXPOSE 80
EXPOSE 8080
EXPOSE 2022
EXPOSE 5657

# Start Shell In A Box
CMD ["shellinaboxd", "--no-beep", "--disable-ssl", "--port=8461", "-s", "/:LOGIN"]
