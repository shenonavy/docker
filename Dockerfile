# Bundling the necessary external packages into a standalone build
FROM node:12.16.1 as builder

# create destination directory
RUN mkdir -p /usr/src/vue-demo
WORKDIR /usr/src/vue-demo

ARG APP_ENV=production

# copy the app, note .dockerignore
COPY . /usr/src/vue-demo/

# Print enviroment variables
RUN if [ "$APP_ENV" = "production" ] ; then \
         rm -rf .env && \
         echo "APP_ENV=production" >> .env && \
         echo "BASE_URL=https://your-domain.com" >> .env && \
       ; \
    fi

# Install packages
RUN npm ci

# build necessary, even if no static files are needed,
# since it builds the server as well
RUN npm run build

# The runner stage
FROM node:12.16.1 as runner

# Create a separate folder for the application to live in
WORKDIR /usr/src/vue-demo

# Copy files
COPY --from=builder /usr/src/vue-demo/.nuxt ./.nuxt

COPY --from=builder /usr/src/vue-demo/static ./static

COPY --from=builder /usr/src/vue-demo/store ./store

COPY --from=builder /usr/src/vue-demo/node_modules ./node_modules

COPY --from=builder /usr/src/vue-demo/nuxt.config.js ./nuxt.config.js

COPY --from=builder /usr/src/vue-demo/package.json ./package.json

COPY --from=builder /usr/src/vue-demo/.env ./.env

# expose 3000 on container
EXPOSE 3000

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=3000

# start the app
CMD [ "npm", "start" ]