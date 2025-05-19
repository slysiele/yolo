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


