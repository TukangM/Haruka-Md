FROM node:lts-buster

# Update package lists
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl

# Install Node.js
RUN apt-get install -y nodejs

# Install ffmpeg, imagemagick, and webp
RUN apt-get install -y ffmpeg imagemagick webp

# Copy package.json and install dependencies
COPY . .
RUN npm i


# Expose port
EXPOSE 5000

CMD ["node", "haruka.js"]
