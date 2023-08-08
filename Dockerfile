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
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
RUN command -v nvm
RUN nvm install 16
RUN node -v

# Copy package.json and install dependencies
COPY . .
RUN npm install


# Expose port
EXPOSE 5000

CMD ["node", "haruka.js"]
