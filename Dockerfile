FROM ubuntu:latest

# Update package lists
RUN apt-get update

# Install Node.js 16 and npm
RUN apt-get install -y nodejs npm yarn sudo

# Run command(s) after installation
RUN pwd
RUN npm i
CMD node haruka.js
