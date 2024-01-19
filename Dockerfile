# Use the official Node.js 14 image as a parent image
FROM node:14-buster

# Set the working directory in the container
WORKDIR /usr/src/app

# Create a new user "ghostuser" and switch to it
RUN adduser --disabled-password --gecos '' ghostuser

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install Ghost CLI locally
RUN npm install ghost-cli@latest

# Give ownership of the directory to the non-root user
RUN chown -R ghostuser:ghostuser /usr/src/app

# Switch to your new user
USER ghostuser

# Install project dependencies
RUN npm install --production

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Make sure the storage folders are writable
RUN mkdir -p content/adapters/storage
RUN chmod 0777 content/adapters/storage

# Tell Docker what port to expose
EXPOSE 2368

# Use npx to run Ghost CLI commands
CMD ["npx", "ghost", "run"]
