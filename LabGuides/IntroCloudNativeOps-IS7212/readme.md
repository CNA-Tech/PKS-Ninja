# Infrastructure support for Devops & Cloud Native Operations with PKS

## 1.0 Review Devops and Cloud Native Application Support & Operations

### 1.1 Explore Cloud Native Application Architecture

A large number of popular applications are hosted on github, many of which are well maintained by vendors or communities. End users can utilize popular github repositories to access a broad array of software and put it to use to provide value for organizational or personal projects

1.4.1 From the `cli-vm` prompt, enter the following commands to clone the planespotter application files from github.com to a local directory:

*Note: you can view the planespotter repository in a browser at [https://github.com/CNA-Tech/planespotter](https://github.com/CNA-Tech/planespotter)*

```bash
mkdir ~/cloned
cd ~cloned
git clone https://github.com/CNA-Tech/planespotter.git
```

<details><summary>Screenshot 1.4.1</summary>
<img src="Images/2019-03-02-04-20-48.png">
</details>
<br/>

1.4.2 Navigate to the subdirectory for the planespotter frontend application, which provides the files to build a custom nginx based frontend for the planespotter app, and review the Dockerfile for the frontend app with the following commands:

```bash
cd ~/cloned
ls planespotter/
cd planespotter/frontend
ls
cat dockerfile
```

<details><summary>Screenshot 1.4.2</summary>
<img src="Images/2019-03-02-04-26-01.png">
</details>
<br/>

1.4.3 From the `cli-vm` prompt, build the planespotter frontend container image and tag it with the name `planespotter-frontend` with the command `docker build . -t planespotter-frontend`

<details><summary>Screenshot 1.4.3</summary>
<img src="Images/2019-03-02-04-33-37.png">

***Output Abbreviated for Brevity***
<img src="Images/2019-03-02-04-34-46.png">
</details>
<br/>

1.4.4 Run the planespotter-frontend server with the command `docker run -p 8080:80 --name=planespotter-frontend-container -d planespotter-frontend` and verify it is running with the `docker ps` command.

<details><summary>Screenshot 1.4.4</summary>
<img src="Images/2019-03-02-04-39-52.png">
</details>
<br/>

1.4.5 From the Main Console (ControlCenter) desktop, open a chrome browser session with `http://cli-vm.corp.local:8080/` and refresh the page. You should now see the planesotter frontend page.

<details><summary>Screenshot 1.4.5</summary>
<img src="Images/2019-03-02-04-43-24.png">
</details>
<br/>

1.4.6 Enter the following commands to clean up your `planespotter-frontend` containers in preparation for the following exercises

```bash
docker stop planespotter-frontend-container
docker rm planespotter-frontend-container
docker rmi -f planespotter-frontend
docker ps -a
docker images
```

<details><summary>Screenshot 1.4.6</summary>
<img src="Images/2019-03-02-04-47-06.png">
<img src="Images/2019-03-02-05-06-48.png">
</details>
<br/>

### 1.2 Fork a copy of the Planespotter Repo

2.1.1 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to review the kubernetes manifest for the planespotter frontend application and edit the file to change the ingress host value from `planespotter.demo.yves.local` to `planespotter.corp.local` as shown in the following screenshot:

```bash
cd ~/cloned/planespotter/kubernetes/
nano frontend-deployment_all_k8s.yaml
```

<details><summary>Screenshot 2.1.1</summary>
<img src="Images/2019-03-02-05-15-17.png">
<img src="Images/2019-03-02-06-28-54.png">
</details>
<br/>

2.1.2 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to deploy the planespotter frontend application using its kubernetes manifest:

```bash
pks login -a pks.corp.local -u pksadmin -k -p VMware1!
pks get-credentials my-cluster
kubectl create ns planespotter
kubectl config set-context my-cluster --namespace planespotter
kubectl create -f frontend-deployment_all_k8s.yaml
```

<details><summary>Screenshot 2.1.2</summary>
<img src="Images/2019-03-02-05-32-15.png">
</details>
<br/>

2.1.3 Review the objects created by the planespotter `frontend-deployment_all_k8s.yaml` manifest with the following commands:

```bash
kubectl get ns
kubectl get deployments
kubectl get pods
kubectl get services
kubectl get ingress
```

Gather the ip address shown in the output of the `kubectl get ingress` command as shown in the screenshot below. The address in the screenshot below is `10.40.14.36`, the ip address of your ingress service may be different but should still be in the 10.40.14.x/24 subnet, if the ip address for your ingress is different, please use the ip address from your environment in the next step.

<details><summary>Screenshot 2.1.3</summary>
<img src="Images/2019-03-02-05-43-04.png">
</details>
<br/>

2.1.4 From the Main Console (ControlCenter) desktop, click the windows button, enter the value `dns` in the search box, and select the top result `DNS` as shown in the following screenshot to open DNS Manager.

<details><summary>Screenshot 2.1.4</summary>
<img src="Images/2019-03-02-06-31-53.png">
</details>
<br/>

2.1.5 In DNS Manager, expand `ControlCenter > Forward Lookup Zones`, right click on `corp.local`, and select `New Host (A or AAAA)...`

<details><summary>Screenshot 2.1.5</summary>
<img src="Images/2019-03-02-06-34-59.png">
</details>
<br/>

2.1.6 In the `New Host` window, enter the following values to create an dns A record for planespotter.corp.local:

- Name: `planespotter`
- *Please be sure to use the ip address from your deployment from the output of `kubectl get ingress` in the preceeding steps*
- IP Address: `10.40.14.36`
- Uncheck `Create associated pointer (PTR) record
- Click `Add Host` to add the new dns record for `planespotter.corp.local`

<details><summary>Screenshot 2.1.6</summary>
<img src="Images/2019-03-02-06-42-30.png">
</details>

2.1.7 From the Main Console (ControlCenter) desktop, open a https browser session to `http://planespotter.corp.local` to see the planespotter frontend page.

<details><summary>Screenshot 2.1.4.2</summary>
<img src="Images/2019-03-02-06-44-38.png">
</details>
<br/>

### 1.3 Automating Containter Builds with Github and Docker Hub

In addition to the frontend app, planespotter has 3 additional microservice applications that must be deployed to enable the complete planespotter application features. In this section, you will execute the additional commands required to deploy the remaining planespotter components, review the objects created to support the deployement, and review the planespotter application to validate its successful deployment and operation.

2.2.1 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to deploy the remaining components in the planespotter application:

```bash
cd ~/cloned/planespotter/kubernetes
kubectl create -f storage_class.yaml
kubectl create -f mysql_claim.yaml
kubectl create -f mysql_pod.yaml
kubectl create -f app-server-deployment_all_k8s.yaml
kubectl create -f redis_and_adsb_sync_all_k8s.yaml
```

<details><summary>Screenshot 2.2.1</summary>
<img src="Images/2019-03-02-07-03-12.png">
</details>
<br/>

2.2.2 Review the objects created by the planespotter manifests with the following commands:

```bash
kubectl get pvc
kubectl get deployments
kubectl get pods
kubectl get services
kubectl get ingress
```

<details><summary>Screenshot 2.2.2</summary>
<img src="Images/2019-03-02-07-04-58.png">
</details>
<br/>

2.2.3 From the Main Console (ControlCenter) desktop, open a https browser session to `http://planespotter.corp.local` to see the fully functional planespotter web app, click around on the various links to explore

<details><summary>Screenshot 2.2.3.1</summary>
<img src="Images/2019-03-02-07-09-09.png">
</details>

<details><summary>Screenshot 2.2.3.2</summary>
<img src="Images/2019-03-02-07-09-54.png">
</details>

<details><summary>Screenshot 2.2.3.3</summary>
<img src="Images/2019-03-02-07-11-06.png">
</details>

<details><summary>Screenshot 2.2.3.4</summary>
<img src="Images/2019-03-02-07-11-37.png">
</details>
<br/>

2.2.4 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to clean up the planespotter application deployment in preparation for the subsequent exercises:

```bash
cd ~/cloned/planespotter/kubernetes
kubectl delete -f frontend-deployment_all_k8s.yaml
kubectl delete -f mysql_pod.yaml
kubectl delete -f storage_class.yaml
kubectl delete -f mysql_claim.yaml
kubectl delete -f app-server-deployment_all_k8s.yaml
kubectl delete -f redis_and_adsb_sync_all_k8s.yaml
kubectl delete ns planespotter
```

<details><summary>Screenshot 2.2.4</summary>
<img src="Images/2019-03-02-07-19-15.png">
</details>
<br/>

### 1.4 Automating Containter Builds with Github and Docker Hub
### 1.5 Update K8s Manifests for Deployment from your Repository
### 1.6 Enforcing Image Authenticity and Security with Harbor

**Thank you for completing the Infrastructure support for Devops & Cloud Native Operations with PKS Lab!**
