FROM node:16.13.2-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
CMD ["npm", "run", "dev"]