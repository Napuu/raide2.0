FROM node:13-alpine
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build
RUN npm i -g serve
CMD serve dist
