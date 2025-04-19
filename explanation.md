# 1. Choice of base image to build container

For this assessment, the base image used to build the containers is `node:20-alpine3.21` because it is a lightweight and a minimal version of the official Node.js image therefore assisted to reduce the size of the image:
 
 1. Client:`node:20-alpine3.21`
 2. Backend: `node:20-alpine3.21`
 3. Mongo : `mongo:8.0`

## 2. Dockerfiles created for each container

The two docker files created are for the client (frontend) and backend:

**client Dockerfile**

```
# Build stage
FROM node:20-alpine3.21 as build

WORKDIR /app

# Set legacy OpenSSL mode to avoid Webpack error
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY package*.json ./
RUN npm install && npm cache clean --force && rm -rf /tmp/*

COPY . .
RUN npm run build

# Production stage with Nginx
FROM nginx:stable-alpine as production

# Copy built files to nginx public folder
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

**backend Dockerfile**

```
# Set base image
FROM node:20-alpine3.21

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Copy application source
COPY . .

# Set environment
ENV NODE_ENV=production

# Expose backend port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]

```

## 3. Docker Compose Networking
Docker compose orchastrates the containers (backend,frontend and mongo db) into a single application environment. By default, Docker compose creates a bridge network for the services allowing them to communicate. Below is the networking section on the docker-compose.yaml:

backend:
    # ...
    ports:
      - "5000:5000"
    networks:
      - yolo_app-net

  client:
    # ...
    ports:
      - "3000:80"
    networks:
      - yolo_app-net
  
  mongodb:
    # ...
    ports:
      - "27017:27017"
    networks:
      - yolo_app-net

  networks:
    yolo_app-net:
      driver: bridge

All containers are connected to the yolo_app-net bridge network.

## 4. Docker compose volume defination and usage
The docker compose file defines volume for mongodb to persist data, ensuring that the data remains intact even if the container is stopped or deleted.

on the yaml file:

```
volumes:
  app-mongo-data:
    driver: local

```

## 5. Git Workflow to achieve the given tasks

To carry out the tasks given on the assessment, the below git workflow was used:

1. Fork the repository from the original repository shared.
2. Cloned the repo to my machine: `git clone https://github.com/slysiele/yolo.git`
3. Create a .gitignore file or use present one to add unnecessary files from version control
4. Added the client docker file
   `cd client`
   `git add Dockerfile`
5. Added the backend docker file
   `cd backend`
   `git add Dockerfile`
6. Added the docker-compose file to the repo
   `git add docker-compose.yaml`
7. Commited all changes done
   `git commit -m "commit message"`
8. Pushed changes as I commited them
   `git push`
9. Build all the images
   `docker compose up --build`
10. Pushed the images to docker hub
   `docker push`
11. Deploying the containers
    `docker compose up`

