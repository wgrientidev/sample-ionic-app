# Use Node.js LTS image as the base
FROM node:lts AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Ionic app
RUN npm run build

# Use Nginx image for serving the built app
FROM nginx:alpine

# Install Node.js and npm in Nginx image
RUN apk add --no-cache nodejs npm


# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
