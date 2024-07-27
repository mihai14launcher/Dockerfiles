# Use the official Debian image as a base
FROM debian:12

# Install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy static website files to Apache's web root
COPY . /var/www/html/

# Expose the default port for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
