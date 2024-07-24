# Use the latest Debian image as a parent image
FROM debian:latest

# Update and upgrade the base image
RUN apt-get update -y && \
    apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y tmate curl wget unzip tar zip nano htop neofetch \
    python3-pip npm sudo shellinabox

# Configure Shell In A Box
RUN sed -i 's/^# SHELLINABOX_PORT=.*/SHELLINABOX_PORT=8461/' /etc/default/shellinabox
RUN sed -i 's/^# SHELLINABOX_USER=.*/SHELLINABOX_USER=root/' /etc/default/shellinabox

# Set root password
RUN echo "root:root" | chpasswd

# Expose port 8461
EXPOSE 8461

# Start Shell In A Box
CMD ["shellinaboxd", "--no-beep", "--background"]
