# vue-app

> Test App

## Build Setup

``` bash
# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm start

# generate static project
$ npm run generate

# build for docker and launch server
$ docker build -t vue-demo .
$ docker run -it -p 3000 vue-demo

# build for docker and launch server as development mode
$ docker build -t vue-demo . --build-arg APP_ENV=develop

# To run docker-compose
$ docker-compose up --build -d
```

For detailed explanation on how things work, checkout [Nuxt.js docs](https://nuxtjs.org).
