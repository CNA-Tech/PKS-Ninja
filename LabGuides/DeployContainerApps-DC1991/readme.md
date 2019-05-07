#Deploying Containerized Applications

## 1.0 Using a Private Image Registry with Harbor

In most production environments, it is usually desired to use a private container registry rather than pulling images from docker hub. It is great to be able to pull images from docker hub, however after you do it is a good practice to upload these to a private image registry and ideally utilize features like image scanning, notary, and local accounts governed by corporate policy before deploying to production.

In this exercise, you will prepare and upload the nginx image you previously downloaded to a local harbor server in your lab.

1.0 From the cli-vm prompt, check to see if you have any local containers running with the command `docker ps`. If the my_web_server container is still running, stop it with the command `docker stop my_web_server` and verify there are no containers running with the `docker ps` command. If you have any other containers running, use the `docker stop` command to stop them.

<details><summary>Screenshot 1.0</summary>
<img src="Images/2019-05-06-01-57-26.png">
</details>
<br/>

1.1 In the previous step, you pulled the `nginx:latest` image from docker hub. From the CLI-VM prompt, enter the command `docker images` to display the images saved in the local docker image cache.

Note this will also display additional images that have been previously downloaded in the lab template.

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-05-06-01-35-04.png">
</details>
<br/>

1.2 From the Main Console (Control Center) desktop, open a chrome browser session with Harbor by clicking on the harbor shortcut on the bookmarks bar, login with `username: admin` `password: VMware1!`, and click on the `library` project.

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-03-04-23-30-58.png">
</details>
<br/>

1.3 To upload an image to a private repository, you must first assign a tag to the image with the url of your private image repository.

In this step you will assign this tag to the nginx image you previously downloaded. You will need to gather the "Image ID" for the nginx image from the output of the `Docker Images` command you issued in step 1.1.

**Note - replace the value YourImageId in the command below with the image id from your local environment**

Enter the command `docker tag YourImageId harbor.corp.local/library/nginx:v1` and then enter the command `docker images` to verify the results.

<details><summary>Screenshot 1.3</summary>
<img src="Images/2019-05-06-01-59-07.png">
</details>
<br/>

1.4 Prepare `cli-vm` with Harbor's certificate which is required for a client to connect to Harbor. Follow the instructions in [Enable Harbor Client Secure Connections](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/HarborCertExternal-HC7212) and then return to this lab guide and proceed with the following step.

1.5 From the `cli-vm` prompt, push the updated mysql image to Harbor with the following commands:

```bash
docker login harbor.corp.local # Enter username: admin password: VMware1!
docker push harbor.corp.local/library/nginx:v1
```

<details><summary>Screenshot 1.5</summary>
<img src="Images/2019-05-06-02-10-35.png">
</details>
<br/>

1.6 From the Main Console (Control Center) desktop, return to your chrome browser session with Harbor, if needed re-login with `username: admin` `password: VMware1!`, and if needed click on the `library` project or refresh the page. Observe there is now a nginx repository - click on the `library/nginx` repository to view your uploaded image details.

<details><summary>Screenshot 1.6.1</summary>
<img src="Images/2019-05-06-02-13-49.png">
</details>

<details><summary>Screenshot 1.6.2</summary>
<img src="Images/2019-05-06-02-14-23.png">
</details>
<br/>

## 2.0 Deploying Containerized apps to Kubernetes with Kubectl

You typically deploy applications to kubernetes using a manifest file, however you can run a container from a kubectl cli command and the system will generate a manifest file for you with using common default values. In this exercise, you will deploy nginx using kubectl CLI commands and review the auto-generated manifest files.

2.1 From the cli-vm prompt, enter the following commands to log in to pks, view the deployed cluster, and pull down the credentials to connect to your cluster.

```
pks login -a pks.corp.local -u pksadmin -k -p VMware1!
pks clusters
pks get-credentials my-cluster
```

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-05-06-17-30-31.png">
</details>
<br/>

2.2 Enter the command following commands to run your nginx container in the default namespace of your kubernetes cluster and verify.

```
kubectl run my-nginx --image=harbor.corp.local/library/nginx:v1 --replicas=2
kubectl get pods
kubectl get deployments
kubectl describe deployment my-nginx
```

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-05-06-17-42-36.png">
</details>
<br/>

2.3 Enter the command `kubectl get deployment my-nginx -o yaml` to view the automatically generated manifest for your nginx deployment.

Note that viewing the autogenerated manifest displays all of the default values, including ones that arent commonly changed, and also autocreated variables like creation timestamp, when creating a manifest from scratch it is common to pull an example manifest from the kubernetes documentation, which we will do in the next exercise.

Also many application developers provide sample kubernetes deployment manifests, as we will review in the Deploying Apps from Github lab later.

<details><summary>Output 2.3</summary>

```
root@cli-vm:~# kubectl get deployment my-nginx -o yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: 2019-05-07T00:34:33Z
  generation: 1
  labels:
    run: my-nginx
  name: my-nginx
  namespace: default
  resourceVersion: "890802"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/my-nginx
  uid: e2414581-705f-11e9-856e-005056884152
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      run: my-nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: my-nginx
    spec:
      containers:
      - image: harbor.corp.local/library/nginx:v1
        imagePullPolicy: IfNotPresent
        name: my-nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: 2019-05-07T00:34:43Z
    lastUpdateTime: 2019-05-07T00:34:43Z
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: 2019-05-07T00:34:33Z
    lastUpdateTime: 2019-05-07T00:34:43Z
    message: ReplicaSet "my-nginx-98ff6c9c9" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2
```

</details>
<br/>

2.4 At this point you have deployed some pods which do have local IP addresses assigned, however pods are ephemeral and in any case if a pod needs to be restarted kubernetes will provide a different IP address.

In kubernetes instead of using a pod IP address, you will generate a service that will provide a load balancer with a virtual interface to provide a stable DNS name and IP address for the service. Kubernetes will automate the setup and ongoing dynamic configuration of services, so you never have to assign IPs to the load balancer pool or change them when you add a new pod or a pod restarts etc, kubernetes will take care of the configuration automatically.

Kubernetes itself provides the default "Cluster-IP" service which provides a stable name and ip address for the service for pod-to-pod communications within a cluster. If you want to enable external access to your pod, you will need to define an additional services such as a load balancer, or an Ingress controller to permit external access.

Like deployments, services are typically defined and created using a manifest file, however for a simple deployment or dry run where the default values are acceptable, you can create the service through a kubectl CLI command and let kubernetes automatically generate the manifest for you.

Enter the following commands to create a clusterIP and a Load Balancer service for you my-nginx deployment.

```
kubectl expose my-nginx
```

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-05-06-17-42-36.png">
</details>
<br/>

## 3.0 Deploying Containerized apps to Kubernetes with Manifests

3.1 Deploying COTS Image

1.1 In the previous step, you pulled the `nginx:latest` image from docker hub. From the CLI-VM prompt, enter the command `docker images` to display the images saved in the local docker image cache.

Note this will also display additional images that have been previously downloaded in the lab template.

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-05-06-01-35-04.png">
</details>
<br/>

3.2 Prepare & Deploy Custom Image

Deploy then rebuild with notary & clair

1.1 In the previous step, you pulled the `nginx:latest` image from docker hub. From the CLI-VM prompt, enter the command `docker images` to display the images saved in the local docker image cache.

Note this will also display additional images that have been previously downloaded in the lab template.

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-05-06-01-35-04.png">
</details>
<br/>