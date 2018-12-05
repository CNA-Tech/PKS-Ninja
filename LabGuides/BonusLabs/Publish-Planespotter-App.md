The planespotter app has been deployed with micro-services created for each of the sub-components of the app, however, if you take a look at the services created they are all using the IP addresses from the clusters pool. These are not routable from outside the cluster. In order to expose a service to take incoming connections, we can create a node-port service type or a Load Balancer service type. For the plane spotter app we will be exposing the 'frontend' service with a load balancer. since we are using a cluster within VKE an AWS Load Balancer will be automatically provisioned to do this. IF you are deploying the same app on Pivotal Container Service (PKS) then an NSX Load Balancer would be automatically created

Issue the below command to expose the planespotter-frontend

**Please change the name of the Load balancer to include your cluster name **

`kubectl expose deployment planespotter-frontend --name=<planespotter-frontend-lb-your-cluster-name> --port=80 --target-port=80 --type=LoadBalancer --namespace=planespotter`

Check the external URL/IP address assigned 
**please wait for 2-5 minutes for the Load Balancer to be spun up**

****Replace the name below with the name you used in the previous step****

`kubectl get svc <planespotter-frontend-lb-your-cluster-name> -o wide --namespace planespotter`

Copy the URL/IP under the "External-IP" section and point your browser to that location.

A freshly deployed app based on 4 micro-services is ready!

## Next Exercise: Understanding how Kubernetes Maintains state by looking at an example of ReplicaSets. Follow Kubernetes ReplicaSets
https://github.com/Boskey/run_kubernetes_with_vmware/wiki/Kubernetes-Replicasets