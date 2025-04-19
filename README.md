## YOLO E-Commerce Web Application - Dockerized

# Overview
This project demonstrates the containerization of an e-commerce web application using Docker and Docker Compose.
The application is composed of:
    • Frontend 
    • Backend
    • MongoDB Database
Each component runs in its own Docker container, and all are integrated using Docker Compose.

# Requirements
Before you start, ensure you have the below installed on your pc:
Docker
Docker compose
Node.js

## Steps to set up application locally

git clone https://github.com/slysiele/yolo.git
cd yolo

## How to build and run application using docker compose
docker compose up --build

# Verify that the containers are running

silvestor@silvestor:~/WORKSPACE/yolo$ docker ps
CONTAINER ID   IMAGE                                  COMMAND                  CREATED          STATUS         PORTS                                             NAMES
f68ad7a285d0   brianbwire/brian-yolo-backend:v1.0.0   "node server.js"         4 minutes ago    Up 4 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp       brian-yolo-backend
138ea808f554   brianbwire/brian-yolo-client:v1.0.0    "npm start"              33 minutes ago   Up 4 minutes   0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp       brian-yolo-client
300a1415d34e   mongo                                  "docker-entrypoint.s…"   15 hours ago     Up 4 minutes   0.0.0.0:27017->27017/tcp, [::]:27017->27017/tcp   app-mongo

Once started, the services i.e backend, frontend, and MongoDB should be accessible on their respective ports exposed:

Backend (Node.js): Port 5000
Frontend (React): Port 3000
MongoDB: Port 27017

# Docker compose images
silvestor@silvestor:~/WORKSPACE/yolo$ docker compose images
CONTAINER            REPOSITORY                      TAG                 IMAGE ID            SIZE
app-mongo            mongo                           latest              6595a4d1b15f       888MB
brian-yolo-backend   brianbwire/brian-yolo-backend   v1.0.0              6d9f0fc1d719       103MB
brian-yolo-client    brianbwire/brian-yolo-client    v1.0.0              d789b0799b79       415MB

# Docker Images
silvestor@silvestor:~/WORKSPACE/yolo$ docker images | grep yolo
REPOSITORY                      TAG       IMAGE ID       CREATED          SIZE
brianbwire/brian-yolo-backend   v1.0.0    6d9f0fc1d719   18 minutes ago   103MB
brianbwire/brian-yolo-client    v1.0.0    d789b0799b79   47 minutes ago   415MB

# Docker compose ps
silvestor@silvestor:~/WORKSPACE/yolo$ docker compose ps
NAME                 IMAGE                                  COMMAND                  SERVICE              CREATED          STATUS          PORTS
app-mongo            mongo                                  "docker-entrypoint.s…"   app-ip-mongo         15 hours ago     Up 21 minutes   0.0.0.0:27017->27017/tcp, [::]:27017->27017/tcp
brian-yolo-backend   brianbwire/brian-yolo-backend:v1.0.0   "node server.js"         brian-yolo-backend   21 minutes ago   Up 21 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp
brian-yolo-client    brianbwire/brian-yolo-client:v1.0.0    "npm start"              brian-yolo-client    49 minutes ago   Up 21 minutes   0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp

# Docker Networks created
silvestor@silvestor:~/WORKSPACE/yolo$ docker network ls
NETWORK ID     NAME                   DRIVER    SCOPE
0f4e1a8da9a0   app-net                bridge    local
cd2dccda4a50   bridge                 bridge    local


