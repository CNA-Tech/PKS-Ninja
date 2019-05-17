This repo contains a yaml based approach to deploying Whack-a-Pod. The original repository was by Terrance Ryan and can be found at https://github.com/tpryan/whack_a_pod.

From the original repo:

"This is a demo that can be used to show how resilient services running on Kubernetes can be. Main app shows a giant sign that flashes in various random colors. Those colors come a Kubernetes powered microservice. If the service goes down, the sign turns red. Your goal is to try and knock the service down by killing the Kubernetes pods that run the service. You can do that by whacking the pods wich are respresented as moles."

![whackapod](https://user-images.githubusercontent.com/19333241/51939263-a6ccf680-23d4-11e9-814b-a0347a648526.png)

There is also a less busy verison of the game available at /next.html. This version has an advanced mode that allows someone to do a more visual explanation of the mechanics.

![next](https://user-images.githubusercontent.com/19333241/51939317-c95f0f80-23d4-11e9-8b32-8170fbdbbdd1.png)

The original repo directions assumed you were using Google Cloud Platform to take advantage of Container Engine to build a manage your Kubernetes cluster.

With the help of @nvpnathan, this repo provides a deployment methodology based on yaml files to deploy the required resources and configs for deployment of the application. The container images used in these yaml files are the same from the original repo.

On your environment, download or clone the files the .yaml files to a directory of your choice


###Step 1.1: Deploy Namespaces

Two namespaces are deployed for this application. The first is wap-admin and the second is wap-game. The wap-admin namespace is where the containers supporting the admin, api and game deployment will reside. The wap-game namespace is used by the game for the deployment of simulated kubernetes pods that you will attempt to "whack" or "kill".

Once authenticated to your environment delpoy the namespaces:

```
kubectl apply -f namespace.yaml
```

###Step 1.2: Switch context to the 'wap-admin' namespace

```
kubectl config set-context <your cluster> --namespace wap-admin
```

*note if you have kubens installed, you can use

```
kubens wap-admin
```

###Step 1.3: Deploy Service Account and Cluster Role Binding

This yaml will create a service account 'wap-admin' and bind it to a cluster admin role. It is important that this step be completed prior to the deployment of the 'admin-deployment.yaml'. The service account will be applied to that deployment and you cannot change the service account once the pods for a given deployment are already deployed.

```
kubectl apply -f service-account-cluster-role.yaml
```

###Step 1.4: Deploy Whack-a-Pod Application Tiers

This will deploy 12 replicas for the "api" tier, 4 replicas for the "game" tier and 1 pod for the "admin" teir. In addition, each yaml will define and expose a service for each deployment. As mentioned above, the "admin-deployment" tier will also apply the previously created 'wap-admin' service tier and specify the 'wap-game' namespace for the deployment of the simulated kubernetes pods that will be the target of the game.

```
kubectl apply -f api-deployment.yaml
kubectl apply -f game-deployment.yaml
kubectl apply -f admin-deployment.yaml
```

###Step 1.5:  Add Heptio Contour to your cluster <Optional>

Contour is an Ingress controller for Kubernetes that works by deploying the Envoy proxy as a reverse proxy and load balancer. Unlike other Ingress controllers, Contour supports dynamic configuration updates out of the box while maintaining a lightweight profile.

```
kubectl apply -f https://j.hept.io/contour-deployment-rbac
```

###Step 1.6:  Add an Ingress Route<Optional>

Add An Ingress Route. You may need to change the host value in line 9.

```
kubectl apply -f contour-ingress-route.yaml
```

###Step 1.7:  Get external IP <Optional>

Browse to whackapod.corp.local. If the fqdn does not sesolve then check the external IP of the heptio contour service. Make the necessary entries in the host file .

```
kubectl get -n heptio-contour service contour -o wide
```

###Step 1.8: Deploy an Ingress

This yaml will deploy and ingress for the application. You may need to change the host value in line 23 if you are using a different environment than the PKS Ninja vPOD. 

```
kubectl apply -f wap-ingress.yaml
```

That's it! You should be able to use your use your ingress IP or hostname value (provided you have the appropriate DNS config) to log into the application.

This is my first repo, so special thanks to @nvpnathan for his help and again to Terrance Ryan for the original application repo.
