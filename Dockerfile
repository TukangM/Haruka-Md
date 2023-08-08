FROM node:lts-buster

# Update package lists
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl

# Install Node.js
RUN apt-get install -y nodejs

# Install ffmpeg, imagemagick, and webp
RUN apt-get install -y ffmpeg imagemagick webp

# install nodejs version manager
RUN curl -sL https://deb.nodesource.com/setup_16.x 1 | bash -
RUN apt update -y
RUN apt install -y nodejs

RUN node --version

# Copy package.json and install dependencies
COPY . .
RUN npm install


# Expose port
EXPOSE 5000

CMD ["node", "haruka.js"]
