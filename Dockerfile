FROM node:lts-buster

# Update package lists
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl

# Install Node.js
RUN apt-get install -y nodejs

# Copy package.json and install dependencies
COPY . .
RUN npm i


# Expose port
EXPOSE 5000

CMD ["node", "haruka.js"]# syntax=docker/dockerfile:1

FROM node:16-alpine
COPY . .
RUN npm i
EXPOSE 5000
CMD ["node", "haruka.js"]
