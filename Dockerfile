# Stage 1: Development stage
# FROM node:20.18.0-alpine as development
# WORKDIR /Oslo-frontend

# COPY package.json .
# RUN npm install
# COPY . .

# # Stage 2: Build stage
# FROM development as build

# RUN npm run build

# # Stage 3: Production stage
# FROM node: 20.18.0-alpine 

# WORKDIR /Oslo-frontend

# COPY --from=build /Oslo-frontend/dist ./dist
# COPY package.json .


# RUN npm install -g http-server
# #RUN npm install --only=production

# EXPOSE 3000

# CMD ["npm", "start"]

#/////////////////////////////

# # Stage 1: Build stage
# FROM node:20.18.0-alpine as build

# WORKDIR /app

# COPY package.json ./
# COPY package-lock.json ./
# RUN npm install --legacy-peer-deps

# # Copy everything including vite.config.js
# COPY . .

# # Build React + Vite app
# RUN npm run build

# # Stage 2: Production
# FROM node:20.18.0-alpine

# WORKDIR /app

# RUN npm install -g http-server

# COPY --from=build /app/build ./build

# EXPOSE 3000
# CMD ["http-server", "build"]

#/////////////////////////////


# Stage 1: Build stage
FROM node:20.18.0-alpine as build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install --legacy-peer-deps

# Copy everything
COPY . .

# Build React App (CRA → build folder)
RUN npm run build

# Stage 2: Production
FROM node:20.18.0-alpine

WORKDIR /app

RUN npm install -g http-server

# CRA uses build folder
COPY --from=build /app/build ./build

EXPOSE 3000
CMD ["http-server", "build"]



