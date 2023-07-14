FROM node:lts-buster

# Update package lists
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install ffmpeg, imagemagick, and webp
RUN apt-get install -y ffmpeg imagemagick webp

# Copy package.json and install dependencies
RUN npm i ws
RUN npm i


# Expose port
EXPOSE 5000

# Run the command to start the application
CMD node haruka.js
