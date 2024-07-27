# Use the official WordPress image as a base
FROM wordpress:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y \
        sudo \
        less \
        vim \
        net-tools \
        iputils-ping && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy custom configurations if needed
# COPY custom-config.php /usr/src/wordpress/wp-config.php

# Expose the default port for WordPress
EXPOSE 80

# Set the entry point to the standard WordPress entry point script
ENTRYPOINT ["docker-entrypoint.sh"]

# Set the default command to start Apache in the foreground
CMD ["apache2-foreground"]
