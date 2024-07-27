# Use the official Node.js image as a base
FROM node:16

# Set the working directory
WORKDIR /app

# Clone the Uptime Kuma repository
RUN git clone https://github.com/louislam/uptime-kuma.git .

# Install dependencies
RUN npm install

# Expose the default port for Uptime Kuma
EXPOSE 3001

# Start Uptime Kuma
CMD ["npm", "run", "start-server"]
