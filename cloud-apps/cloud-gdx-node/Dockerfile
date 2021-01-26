FROM node:10-alpine

# create working directory
WORKDIR /mnt/server

# install dependencies
# COPY package*.json ./
COPY . .

RUN npm install

# if building for production
# RUN npm ci --only=production

CMD [ "node", "server.js" ]




