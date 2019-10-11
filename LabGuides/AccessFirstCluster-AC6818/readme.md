# Accessing First PKS Cluster

**HOL-2031 Users: for some of the steps in this lab guide, you will need to complete an alternative step that is slightly adjusted to work in the HOL-2031 lab environment. Each step below that requires a modification for HOL-2031 will be clearly indicated. All HOL-2031 users will need to complete [HOL POD Prep for PKS Ninja Lab Guides](../HOLPodPrep-HP3631/readme.md) before proceeding. Please note you will not be able to browse the internet from the HOL-2031, if any steps require you to browse a public internet site, you will need to do so from a seperate browser tab from your local machine, outside of the HOL lab environment. If there are any steps that require you to download an external file, please follow the instructions provided**

## Step 1: Obtain Kubernetes Cluster Config File via PKS CLI

Before starting this lab, your lab environment will need to have Enterprise PKS installed and a kubernetes cluster deployed. You can either load a template that already has a cluster provisioned, or if you are installing PKS please be sure to provision your cluster as instructed in the [Deploy First Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployFirstCluster-DC1610) lab.

1.1 If needed, login to the PKS api from cli-vm with the command `pks login -a pks.corp.local -u pksadmin -p VMware1! -k`

After ensuring you have logged into the PKS CLI, verify your cluster has been provisioned succesfully:

~~~
pks clusters
pks clusters my-cluster
~~~

<details><summary>Screenshot 1.1 </summary>
<img src="Images/1.png">
</details>
<br/>

1.2 In order to access the Kubernetes cluster via the `kubectl` CLI tool, we need to pull down the Kubernetes cluster config file via the PKS CLI with the following command:<br/>

~~~
pks get-credentials my-cluster
~~~

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2.png">
</details>
<br/>

**Note**: This will pull the kubernetes config file down to `cli-vm` and place it in the default location `kubectl` will look for when trying to access a cluster (`~/home/.kube/config`)

## Step 2: Verify Cluster Access with `kubectl`

2.1 Verify that you are able to use the `kubectl` command to examine the 2 worker nodes in the cluster:

~~~
kubectl get nodes
~~~

<details><summary>Screenshot 2.1 </summary>
<img src="Images/3.png">
</details>
<br/>

**Note**: Use `kubectl get nodes -o wide` to gather additional information about the worker nodes

2.2 Use `kubectl` to examine existing pods deployed on the cluster. This will include pods the Kubernetes cluster uses for internal services as well as PKS-specific pods:

~~~
kubectl get pods --all-namespaces
~~~

<details><summary>Screenshot 2.2 </summary>
<img src="Images/4.png">
</details>
<br/>

## Step 3: Deploy a Test Application

3.1 Run the following command to deploy an `nginx` application and expose it for access within the Kubernetes cluster on port 80:

~~~
kubectl run nginx-test --image=nginx --restart=Never --port=80 --expose
~~~
<details><summary><b>HOL-2031 Users:</b> Please expand this section and use the alternate command below</summary>

```bash
kubectl run nginx-test --image=harbor.corp.local/library/nginx:V1 --restart=Never --port=80 --expose
```

</details>
<br/>

This command will deploy a pod named `nginx-test` utilizing the `nginx` image. It will also open up port 80 on the pod and create a service of type `ClusterIP` to serve out the default `nginx` homepage within the Kubernetes cluster.

<details><summary>Screenshot 3.1 </summary>
<img src="Images/5.png">
</details>
<br/>

3.2 Use `kubectl` to get the internal IP of the `nginx-test` service. This will be the IP we will use to test access to the `nginx` hompage:

~~~
kubectl get services
~~~

<details><summary>Screenshot 3.2 </summary>
<img src="Images/6.png">
</details>
<br/>

3.3 Run the following command to create a temporary `busybox` pod that you will use to test access to the `nginx-test` pod's homepage. This command will create a `busybox` pod and drop you into a shell within the pod:

~~~
kubectl run busybox --rm --image=busybox -it --restart=Never -- sh
~~~

<details><summary><b>HOL-2031 Users:</b> Please expand this section and use the alternate commands below</summary>

```bash
# First download the busybox image from the public PKS Ninja Labs Harbor registry, Retag and push the image to the harbor.corp.local registry server in your local lab with the following commands:  

sudo docker login harbor.corp.local -u admin -p VMware1!
sudo docker pull harbor.cloudnativeapps.ninja/library/busybox
sudo docker tag  harbor.cloudnativeapps.ninja/library/busybox harbor.corp.local/library/busybox
sudo docker push harbor.corp.local/library/busybox

# Enter the following command to run this container in your kubernetes cluster:

kubectl run busybox --rm --image=harbor.corp.local/library/busybox -it --restart=Never -- sh
```
</details>
<br/>

<details><summary>Screenshot 3.3 </summary>
<img src="Images/7.png">
</details>
<br/>

3.4 Once inside the `busybox` pod, run the following `wget` command to verify you are able to access the default `nginx` homepage. Be sure to utilize the IP address from the `nginx-test` service you retrieved in step 3.2:

~~~
/ # wget -O- <nginx-test service IP>
~~~

<details><summary>Screenshot 3.4 </summary>
<img src="Images/8.png">
</details>
<br/>

3.5 Type `exit` in the `busybox` shell to exit the pod. Note, the `busybox` pod will automatically be deleted as we created the pod with the `--rm` flag.

3.6 Use `kubectl` to clean up the `nginx-test` pod and service:

~~~
kubectl delete pod nginx-test
~~~
~~~
kubectl delete service nginx-test
~~~

<details><summary>Screenshot 3.5 </summary>
<img src="Images/9.png">
</details>
<br/>

**You have now tested access and functionality of your Kubernetes cluster, please return to your course guide for details on additional steps and exercises for your course**

