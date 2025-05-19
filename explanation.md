## Explanation of Implementation IP4
## 1. Choice of Kubernetes Objects used for Deployment
I used a StatefulSet for MongoDB to ensure it has stable storage and network identity, which are essential for database reliability.

For the backend and frontend, I used Deployments because they are stateless services. Deployments make it easy to scale and update these components without worrying about persistent data or network identity. Deployments are ideal for stateless applications that can be replaced or scaled horizontally.

## 2. Method used to expose pods to internet traffic

I used LoadBalancer services to expose the backend and frontend pods. This automatically provides external IPs, allowing internet users to access the applications directly.

I confirmed external exposure by retrieving the external IP using: kubectl get svc -n gke-devops-week8

## 3. Use of Persistent Storage

For MongoDB, I used StatefulSets along with Persistent Volume Claims (PVCs) to provide stable and durable storage. This ensures that even if a MongoDB pod restarts or is rescheduled, the data remains intact. Each pod in the StatefulSet gets a unique and consistent volume via a PVC.

On the other hand, the backend and frontend services are stateless—they do not retain any data between restarts. Therefore, I used Deployments for them without attaching any persistent storage. They can be scaled or restarted without worrying about data loss.

In summary, persistent storage was essential for MongoDB due to its need for durable data, while it was unnecessary for the backend and frontend.


## 4. Git Workflow

For this project, I used two branches: master and main. I handled the core setup—like Kubernetes manifests and deployment configurations—on the master branch. Once the infrastructure was stable, I created a main branch where I focused on documentation tasks, such as updating the README.md and writing the explanation.md after completing IP2 and IP3.

This separation allowed me to keep infrastructure-related changes isolated from documentation updates, making the workflow cleaner and easier to manage.

## 5. Successful Running of the Applications and Debugging Steps and good practices

To ensure everything worked correctly, I tested the full deployment by checking if the backend was connected to MongoDB and could handle requests. I also confirmed that the backend was exposed to the internet using a LoadBalancer service.

If issues came up, I used:

kubectl logs <pod-name> to check logs for connection or config errors.

kubectl describe pod <pod-name> to inspect pod health and resource issues.

Verified service settings to ensure pods were properly exposed.

When something wasn’t working, I restarted pods, fixed environment variables, or updated Kubernetes configs.
For Docker images, I used version-based tags (e.g., sielei/yolo-frontend:v1.0.1) to keep track of changes.

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


