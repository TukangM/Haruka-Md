# syntax=docker/dockerfile:1

FROM node:16-alpine
COPY . .
RUN npm i
EXPOSE 5000
CMD ["node", "index.js"]
