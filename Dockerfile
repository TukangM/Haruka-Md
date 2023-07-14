FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get install nodejs npm

COPY package.json .

RUN npm install openai
RUN npm install

COPY . .

EXPOSE 5000

CMD ["node", "haruka.js"]
