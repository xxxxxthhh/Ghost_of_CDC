# Use the official Node.js 14 image as a parent image
FROM node:14-buster

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install Ghost CLI
RUN npm install -g ghost-cli@latest

# Install project dependencies
RUN npm install --production

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Make sure the storage folders are writable
RUN mkdir -p content/adapters/storage
RUN chmod 0777 content/adapters/storage

# Tell Docker what port to expose
EXPOSE 2368

# Use the "ghost start" command to run the app
CMD ["ghost", "run"]
