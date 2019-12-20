FROM node:13-alpine
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build
RUN npm i -g serve
EXPOSE 4001
CMD serve -l tcp://0.0.0.0:4001 dist
