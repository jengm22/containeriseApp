# /app/Dockerfile

# Use an official Node.js runtime as a parent image (a slim version is smaller and more secure)
FROM node:18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for dependency installation
# This leverages Docker's layer caching.
COPY package*.json ./
RUN npm install --production

# Copy the rest of the application source code
COPY . .

# Make your app's port accessible to the outside world
EXPOSE 3000

# Define the command to run your app
CMD [ "node", "index.js" ]