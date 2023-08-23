FROM node:16-buster-slim

RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

COPY . .
RUN npm install -g npm@9.8.1
RUN npm install

EXPOSE 5000

CMD ["npm", "start"]
