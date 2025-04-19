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
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS         PORTS                                             NAMES
fbfbd7e31f39   silvestor/yolo-client:v1.0.0    "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:3000->80/tcp, [::]:3000->80/tcp           yolo-client
79f8a796df49   silvestor/yolo-backend:v1.0.0   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp       yolo-backend
165ee1a61f90   mongo                           "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:27017->27017/tcp, [::]:27017->27017/tcp   app-mongo


Once started, the services i.e backend, frontend, and MongoDB should be accessible on their respective ports exposed:

Backend (Node.js): Port 5000
Frontend (React): Port 3000
MongoDB: Port 27017

# Docker compose images
silvestor@silvestor:~/WORKSPACE/yolo$ docker compose images
CONTAINER           REPOSITORY               TAG                 IMAGE ID            SIZE
app-mongo           mongo                    latest              6595a4d1b15f        888MB
yolo-backend        silvestor/yolo-backend   v1.0.0              2fa19797ab61        191MB
yolo-client         silvestor/yolo-client    v1.0.0              3c8f3c252300        49.3MB

# Docker Images
silvestor@silvestor:~/WORKSPACE/yolo$ docker images | grep yolo
REPOSITORY                      TAG       IMAGE ID       CREATED          SIZE
silvestor/yolo-client           v1.0.0      3c8f3c252300   35 minutes ago   49.3MB
silvestor/yolo-backend          v1.0.0      2fa19797ab61   40 minutes ago   191MB

# Docker compose ps
silvestor@silvestor:~/WORKSPACE/yolo$ docker compose ps
NAME           IMAGE                           COMMAND                  SERVICE        CREATED          STATUS          PORTS
app-mongo      mongo                           "docker-entrypoint.s…"   app-ip-mongo   35 minutes ago   Up 35 minutes   0.0.0.0:27017->27017/tcp, [::]:27017->27017/tcp
yolo-backend   silvestor/yolo-backend:v1.0.0   "docker-entrypoint.s…"   yolo-backend   35 minutes ago   Up 35 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp
yolo-client    silvestor/yolo-client:v1.0.0    "/docker-entrypoint.…"   yolo-client    35 minutes ago   Up 35 minutes   0.0.0.0:3000->80/tcp, [::]:3000->80/tcp

# Docker Networks created
silvestor@silvestor:~/WORKSPACE/yolo$ docker network ls
NETWORK ID     NAME                   DRIVER    SCOPE
05c0b99a3ca4   yolo_app-net           bridge    local
ec7d68181b5a   bridge                 bridge    local

# File structure
. ├── backend │ └── Dockerfile ├── client │ └── Dockerfile └── docker-compose.yaml

# Pushing to Dockerhub
silvestor@silvestor:~/WORKSPACE/yolo$ sudo docker push sielei/yolo-client:v1.0.0
The push refers to repository [docker.io/sielei/yolo-client]
7c1e76b94c0c: Pushed 
a0636672c7fc: Pushed 
6dba76576010: Pushed 
51b6aefac2f5: Pushed 
6f197061abd6: Pushed 
ed2f467e1cfc: Pushed 
49c50d3fe932: Pushed 
aad7be8b43d9: Pushed 
994456c4fd7b: Pushed 
v1.0.0: digest: sha256:9af059719ae1e37413bc0d1c0bc449beeb71411ddded4814522840fb188b4087 size: 2200

# Images of persistent data when adding products and images deployed to github
The images are on the root folder of the project. The below image names show: images deployed to github and screenshot of yolo webapp of the added products.

productsadded.png, imagesdeployed.png, backendwithversion.png and clientwithversion.png

# To access application on browser
Open a browser and navigate to this link: http://localhost:3000/

# To stop the running containers
run the following command: docker compose down


