The planespotter app has been deployed with micro-services created for each sub-components; however, if you take a closer look at the services created, you will see they are all using IP addresses from the k8s cluster pool. These are not routable outside of the cluster. In order to expose a service to external connections, we can create a node-port service type or a Load Balancer service type. For the plane spotter app we will be exposing the 'frontend' service with a load balancer. PKS utilizes an automatically created NSX Load Balancer in this case.

1. Issue the below command to expose the planespotter-frontend

`kubectl expose deployment planespotter-frontend --name=planespotter-frontend-lb --port=80 --target-port=80 --type=LoadBalancer --namespace=planespotter`

2. Check the external URL/IP address assigned to the service (make note of the first IP addres under External-IP).

'kubectl get service planespotter-frontend-lb'

Copy the IP under the "External-IP" section and point your browser to that location.

A freshly deployed app based on 4 micro-services is ready!

## Next Exercise: Understanding how Kubernetes Maintains state by looking at an example of ReplicaSets. Follow Kubernetes ReplicaSets
