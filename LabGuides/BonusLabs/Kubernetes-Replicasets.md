Replicasets in Kubernetes make sure that when a deployment is made 'x' number of pods for that deployment are always running. For the Planespotter frontend deployment we specified '2' replicas to aways run, take a look at the deployment YAML for Palanespotter frontend here

`nano ~/planespotter/kubernetes/frontend-deployment_all_k8s.yaml`

Notice where it states _replicas: 2_ under the _spec:_ heading.

Now Lets take a look at the number of pods running for the frontend service.

`kubectl get pods -n planespotter`

You should see 2 replicas of the planespotter-frontend running.

Lets delete one of the Pods running the frontend service List the Pods for planespotter (from above) and copy the entire name of one of the pods that starts with 'planespotter-frontent-'

Delete one of the pods in fronend ( change the name of the pod to the one you copied from above)

`kubectl delete pod <name of your planespotter-frontend-pod> -n planespotter`

List the Pods still running for frontend
kubectl get pods -n planespotter

Notice the count of pods for planespotter-frontend has not changed, there are still 2 pods. The name of one of the pods is now different than before ( the unique number in the name) and the age is more recent than the other. Kubernetes just created a new pod after the original pod was deleted in order to maintain declared state.
