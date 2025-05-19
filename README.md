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

### ANSIBLE AUTOMATION
Add a vagrant vm in this case geerlingguy ubuntu2004
 - vagrant box add geerlingguy/ubuntu2004
 - vagrant box list
 - vagrant init geerlingguy/ubuntu2004
 - vagrant up
 - vagrant status
 - vagrant ssh-config

 Add configuration on vagrant file to specify the location of ansible playbook
 implement ansible tasks: ansible-galaxy init 
 run vagrant provision

 ## Run the file using  vagrant provision to test its working
 silvestor@silvestor:~/WORKSPACE/yolo$ vagrant provision
==> default: Running provisioner: ansible...
    default: Running ansible-playbook...

PLAY [Yolo ecommerce playbook] *************************************************

TASK [Gathering Facts] *********************************************************
[WARNING]: Platform linux on host default is using the discovered Python
interpreter at /usr/bin/python3.8, but future installation of another Python
interpreter could change the meaning of that path. See
https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [default]

TASK [docker : Update apt cache] ***********************************************
changed: [default]

TASK [docker : Install Python3 and pip3] ***************************************
ok: [default]

TASK [docker : Update pip] *****************************************************
ok: [default]

TASK [docker : Install 'Docker SDK for Python' using pip] **********************
ok: [default]

TASK [docker : Add Docker GPG key] *********************************************
ok: [default]

TASK [docker : Add Docker official repository] *********************************
ok: [default]

TASK [docker : Install Docker packages] ****************************************
ok: [default]

TASK [docker : Start Docker service] *******************************************
ok: [default]

TASK [docker : Add current user to docker group] *******************************
ok: [default]

TASK [docker : Download Docker Compose binary] *********************************
ok: [default]

TASK [docker : Verify Docker Compose installation] *****************************
changed: [default]

TASK [docker : Clone GitHub repository] ****************************************
ok: [default]

TASK [docker : Check if docker-compose.yaml exists] ****************************
ok: [default]

TASK [docker : Copy docker-compose.yaml] ***************************************
skipping: [default]

TASK [docker : Ensure correct permissions for Docker Compose file] *************
ok: [default]

TASK [docker : Run Docker Compose pull] ****************************************
changed: [default]

TASK [docker : Deploy Docker Compose] ******************************************
changed: [default]

PLAY RECAP *********************************************************************
default                    : ok=25   changed=10   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0 

### pulled images on vagrant box
vagrant@ubuntu-focal:~/yolo$ docker images
REPOSITORY               TAG       IMAGE ID       CREATED             SIZE
silvestor/yolo-client    v1.0.0    284c4b56b3b2   About an hour ago   50.3MB
silvestor/yolo-backend   v1.0.0    cf60e25c56bf   About an hour ago   162MB
mongo                    latest    f6a661f83eee   2 days ago          890MB

vagrant@ubuntu-focal:~/yolo$ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED             STATUS             PORTS                                     NAMES
1a6f0d68e25a   silvestor/yolo-backend:v1.0.0   "docker-entrypoint.s…"   About an hour ago   Up About an hour   0.0.0.0:5000->5000/tcp                    yolo-backend
3abd5e5477b1   mongo:latest                    "docker-entrypoint.s…"   About an hour ago   Up About an hour   0.0.0.0:27017->27017/tcp                  app-mongo
f43323787974   silvestor/yolo-client:v1.0.0    "/docker-entrypoint.…"   About an hour ago   Up About an hour   0.0.0.0:3000->80/tcp, [::]:3000->80/tcp   yolo-client

## Step 2 Terraform
Created a new branch Stage_two
Installed terraform, linked terraform and ansible
Run terraform init to add the rest of the files and terraform apply


## Orchestrating to GCP

Create the GKE Cluster
- I set my desired region and zone
	`gcloud config set compute/zone us-central1-a`
- Created the GKE Cluster
  --num-nodes=3 \
  --machine-type=e2-medium \
  --disk-size=50 \
  --enable-autoscaling --min-nodes=1 --max-nodes=3 \
  --zone=us-central1-a
  
show nodes created

sylvestorsielei@cloudshell:~ (gke-devops-week8)$ kubectl get nodes -o wide
NAME                                          STATUS   ROLES    AGE     VERSION               INTERNAL-IP   EXTERNAL-IP      OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-yolo-cluster-default-pool-3c47c8fd-hd24   Ready    <none>   2m14s   v1.32.3-gke.1785003   10.128.0.5    104.198.143.63   Container-Optimized OS from Google   6.6.72+          containerd://1.7.24
gke-yolo-cluster-default-pool-3c47c8fd-hmv1   Ready    <none>   2m12s   v1.32.3-gke.1785003   10.128.0.4    34.173.131.188   Container-Optimized OS from Google   6.6.72+          containerd://1.7.24
gke-yolo-cluster-default-pool-3c47c8fd-xv7p   Ready    <none>   2m11s   v1.32.3-gke.1785003   10.128.0.3    34.27.55.19      Container-Optimized OS from Google   6.6.72+          containerd://1.7.24


- Enabled K8s Engine API
`gcloud services enable container.googleapis.com`
- Authenticated to my google account after downloading gcloud sdk
`gcloud auth login`
- Set up my project here
`gcloud config set project gke-devops-week8`
- configured docker
`gcloud auth configure-docker`
- Pulled my images from dockerhub
`docker pull sielei/yolo-backend:v1.0.0`
`docker pull sielei/yolo-client:v1.0.0`
- Retagged them to:
docker tag sielei/yolo-backend:v1.0.0 gcr.io/gke-devops-week8/yolo-backend:v1.0.0
docker tag sielei/yolo-client:v1.0.0 gcr.io/gke-devops-week8/yolo-client:v1.0.0
docker tag mongo gcr.io/gke-devops-week8/mongodb-image:v1.0.0
Pushed the new image name
docker push gcr.io/gke-devops-week8/yolo-client:v1.0.0
docker push gcr.io/gke-devops-week8/yolo-backend:v1.0.0
docker push gcr.io/gke-devops-week8/mongodb-image:v1.0.0
- Created a new namespace
`kubectl create namespace gke-devops-week8`

## Applied Kubernetes Manifests

silvestor@silvestor:~/WORKSPACE/yolo$ kubectl apply -f manifests/yolo-frontend.yaml
deployment.apps/yolo-frontend created
service/yolo-frontend created
silvestor@silvestor:~/WORKSPACE/yolo$ kubectl apply -f manifests/yolo-backend.yaml
deployment.apps/yolo-backend created
service/yolo-backend created
silvestor@silvestor:~/WORKSPACE/yolo$ kubectl apply -f manifests/mongodb-statefulset.yaml
statefulset.apps/mongodb created
service/mongodb created
silvestor@silvestor:~/WORKSPACE/yolo$ kubectl apply -f manifests/network-policy.yaml
networkpolicy.networking.k8s.io/allow-same-namespace created
silvestor@silvestor:~/WORKSPACE/yolo$ 

## Monitor Deployment
silvestor@silvestor:~/WORKSPACE/yolo$ kubectl get deployment -n gke-devops-week8
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
yolo-backend    1/1     1            1           3h48m
yolo-frontend   1/1     1            1           3h49m

silvestor@silvestor:~/WORKSPACE/yolo$ kubectl get svc -n gke-devops-week8
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)          AGE
mongodb         ClusterIP      34.118.234.75   <none>           27017/TCP        3h49m
yolo-backend    LoadBalancer   34.118.235.56   35.222.183.205   5000:32658/TCP   3h50m
yolo-frontend   LoadBalancer   34.118.238.67   34.72.193.246    80:30321/TCP     3h50m

silvestor@silvestor:~/WORKSPACE/yolo$ kubectl get pods -n gke-devops-week8
NAME                             READY   STATUS    RESTARTS   AGE
mongodb-0                        1/1     Running   0          3h51m
yolo-backend-557fc9588c-rkhnv    1/1     Running   0          3h32m
yolo-frontend-745999769b-n9rps   1/1     Running   0          89m

## Access the Application
Once deployments are up and running, access application using the external IP or domain name associated with your GKE LoadBalancer.
Application Accessible via: http://34.72.193.246/

