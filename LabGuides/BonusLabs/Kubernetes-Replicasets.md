Replicasets in Kubernetes make sure that when a deployment is made 'x' number of pods for that deployment are always running. For the Planespotter frontend deployment we specified '2' replicas to aways run, take a look at the deployment YAML for Palanespotter frontend here

https://github.com/Boskey/planespotter/blob/master/kubernetes/frontend-deployment_all_k8s.yaml

Notice where it says replica: 2

---begin--snippet----- apiVersion: apps/v1beta1 kind: Deployment metadata: name: planespotter-frontend namespace: planespotter labels: app: planespotter-frontend tier: frontend spec: ** replicas: 2** selector: matchLabels: app: planespotter-frontend template: metadata: labels: app: planespotter-frontend tier: frontend ---end--snippet---

Now Lets take a look at the number of pods running for the frontend service.

kubectl get pods -n planespotter

You should see and output like below ( NOTE: The numbers in the Name will vary for each deployment)

NAME READY STATUS RESTARTS AGE mysql-0 1/1 Running 0 47d planespotter-app-6b8546fdf5-4ml9c 1/1 Running 0 49d planespotter-app-6b8546fdf5-w8zxw 1/1 Running 0 49d planespotter-frontend-c68b6675c-77ldd 1/1 Running 0 49d planespotter-frontend-c68b6675c-qslxf 1/1 Running 0 49d redis-server-94b668486-8stwr 1/1 Running 0 15d

Lets delete one of the Pods running the frontend service

List the Pods for planespotter (from above) and copy the name of one of the pods that starts with 'planespotter-frontent-'
2.Delete one of the pods in fronend ( change the name of the pod to the one you copied from above)

kubectl delete pod <name of your planespotter-frontend-pod> -n planespotter

List the Pods still running for frontend
kubectl get pods -n planespotter

Notice the count of pods for planespotter-frontend, notice that there are still 2 pods ( even after deleting one), however the name of one of the pods is different than before ( the unique number in the name) Kubernetes just created a new pod after original pod was deleted in step 2 above. This is because of the way Kubernetes operates. It sees that the count of pods after the delete command was hit in step 2 is gone to one, however the replicaset count mentioned for the frontend deployment YAML specifies the deployment to have a count of 2. In order to maintain state, Kubernetes will provision another Pod for the same deployment by deploying the associated container image.