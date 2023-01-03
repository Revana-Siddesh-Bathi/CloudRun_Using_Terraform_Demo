FROM node:alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g yaml2json
RUN npm install -s express
COPY . .
EXPOSE 8080
ENTRYPOINT ["node", "index.js"]