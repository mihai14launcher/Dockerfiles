# Use the official Nginx image as a base
FROM nginx:latest

# Copy static website files to Nginx's web root
COPY . /usr/share/nginx/html

# Expose the default port for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
