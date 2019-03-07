# PKS Intro to PKS Monitoring & Operations

### 1.1 Review Wavefront PKS Dashboard

1.1.1 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to prepare you kubernetes cluster for planespotter deployment:

<details><summary>Screenshot 1.1.1</summary>
<img src="Images/1.png">
</details>
<br/>

1.1.2 Resume your ssh session with `cli-vm` and from the prompt, enter the following commands to deploy the planespotter application:

```bash
cd ~/forked/planespotter/kubernetes
kubectl create -f storage_class.yaml
kubectl create -f mysql_claim.yaml
kubectl create -f mysql_pod.yaml
kubectl create -f app-server-deployment_all_k8s.yaml
kubectl create -f redis_and_adsb_sync_all_k8s.yaml
kubectl create -f frontend-deployment_all_k8s.yaml
```

<details><summary>Screenshot 1.1.2</summary>
<img src="Images/2.png">
</details>
<br/>

1.1.3 From the Main Console (Control Center) desktop, open a putty session to `cli-vm` and from the prompt, enter the following commands to clone the planespotter application files from github.com to a local directory:

**Make sure to replace the string in the `git clone` command below with the git url you copied from the previous step to clone your personal fork of the planespotter repo.**

```bash
mkdir ~/forked
cd ~/forked
git clone https://github.com/yourGithubUsername/planespotter.git
```

<details><summary>Screenshot 1.1.3</summary>
<img src="Images/3.png">
</details>
<br/>

1.1.4 Take a few moments to review the kubernetes manifest for the planespotter mysql deployment with the 

<details><summary>Screenshot 1.1.4</summary>
<img src="Images/4.png">
</details>
<br/>

</details>
<br/>

1.1.5 From the `cli-vm` prompt, pull the `mysql:5.6` image to the local image cache and assign a tag to prepare it for upload to the Harbor repository in your local PKS Ninja lab environment with the following commands:

```bash
docker pull mysql:5.6
docker images
docker tag mysql:5.6 harbor.corp.local/library/mysql:5.6
docker images
```

<details><summary>Screenshot 1.1.5</summary>
<img src="Images/5.png">
</details>
<br/>

1.1.6 Prepare `cli-vm` with Harbor's certificate which is required for a client to connect to Harbor. Follow the instructions in [Enable Harbor Client Secure Connections](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/HarborCertExternal-HC7212) and then return to this lab guide and proceed with the following step. 

1.1.7 From the `cli-vm` prompt, push the updated mysql image to Harbor with the following commands:

```bash
docker login harbor.corp.local # Enter username: admin password: VMware1!
docker push harbor.corp.local/library/mysql:5.6
```

<details><summary>Screenshot 1.1.6</summary>
<img src="Images/6.png">
</details>
<br/>

1.1.7 From the Main Console (Control Center) desktop, open a chrome browser session with Harbor by clicking on the harbor shortcut on the bookmarks bar, login with `username: admin` `password: VMware1!`, and click on the `library` project.

<details><summary>Screenshot 1.1.7</summary>
<img src="Images/7.png">
</details>
<br/>

1.1.8 From the Main Console (Control Center) desktop, open a chrome browser session with Harbor by clicking on the harbor shortcut on the bookmarks bar, login with `username: admin` `password: VMware1!`, and click on the `library` project.

<details><summary>Screenshot 1.1.8</summary>
<img src="Images/8.png">
</details>
<br/>

1.1.9 From the Harbor UI on the library project page, click on the new `library/mysql` repository you created in the previous step, and observe that the `mysql:5.6` image is now saved in your local harbor repository.

<details><summary>Screenshot 1.1.9</summary>
<img src="Images/9.png">
</details>
<br/>

1.1.10 From the Harbor UI on the library project page, click on the new `library/mysql` repository you created in the previous step, and observe that the `mysql:5.6` image is now saved in your local harbor repository.

<details><summary>Screenshot 1.1.10</summary>
<img src="Images/10.png">
</details>
<br/>