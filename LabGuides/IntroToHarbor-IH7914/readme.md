# Introduction to Harbor with Planespotter

**Contents:**

- [Step 1: Initialize Harbor Projects and Repositories]()
- [Step 2: Build Docker Image for Planespotter Frontend]()
- [Step 3: Push and Pull Container Images From Harbor]()
- [Step 4: Configure Image Vulnerability Scanning and Enforcement]()
- [Step 4: Configure and validate Content Trust]()

## Overview

This lab guide takes a practical approach to learning VMware's Open Source Harbor container registry by focusing on configuring and preparing Harbor to deploy the Planespotter application

This lab guide is part of a sequence that will show you how to deploy a modern containerized application on kubernetes with VMware PKS. While we use the planespotter application as an example, the point of the exercise is to highlight how virtual infrastructure operators and devops admins can support container application deployments on kubernetes.  The devops processes used in this guide to deploy the planespotter application are essentially the same processes to deploy and support any typical modern containerized appliaction

The Planespotter application was chosen as the example application because it is a production grade application that is not too simple to provide a meaningful real-world application, but complex enough to be realistic and challenging without being overwhelming

Before proceeding with this lab, please review the [Planespotter application overview](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Labrary/Lessons/PlanespotterOverview-PO6830.md) and review the Planespotter application architecture

## Instructions

In this guide you will learn how to fully prepare and configure Harbor for an example enterprise application deployment using the Planespotter application

In subsequent lab modules you will deploy the full Planespotter application from Harbor, providing a practical walkthrough of Harbor's role in an enterprise-grade application deployment

Note: Harbor is included as an enterprise supported product with VMware PKS

## Step 1: Initialize Harbor Projects and Repositories

Harbor organizes images into a set of projects and repositories within those projects. Repositories can have one or more images associated with them. Each of the images
are tagged. Projects can have RBAC (Role Based Access Control) and replication policies associated with them so that administrators can regulate access to images and create
image distribution pipelines across registries that might be geographically dispersed. You should now be at a summary screen that shows all of the projects in this registry.
For our lab, we are interested in a single project called library.

1.1 Login to harbor.corp.local, observe the Projects homepage and note there is already a project named `library` available by default, and it is set to a Public access level

Click on the `library` project to examine further details, and look through the various tabs to familiarize yourself

<details><summary>Screenshot 1.1.1 </summary>
<img src="Images/2018-10-23-01-31-40.png">
</details>

<details><summary>Screenshot 1.1.2 </summary>
<img src="Images/2019-01-14-20-14-13.png">
</details>
<br/>

1.2 From the `library` project page, select the `Configuration` tab and observe the default configuration for the library project. As you proceed through the following steps, you will upload an image to interact with the unsecured library project, and you will also create an additional `trusted` project to interact with content trust, image scanning, and vulnerable image policy enforcement

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-01-14-20-18-37.png">
</details>
<br/>

1.3 Click on the `Projects` link in the left navigational bar to return to the `Projects` page and click on `+ New Project`

<details><summary>Screenshot 1.3 </summary>
<img src="Images/2018-10-23-01-31-40.png">
</details>
<br/>

1.3 On the `New Project` screen, set the `Project Name` to `trusted` and click `OK`

<details><summary>Screenshot 1.3 </summary>
<img src="Images/2018-10-23-01-35-25.png">
</details>
<br/>

1.4 On the `Projects` page, click on `trusted`,  click on the `configuration` tab, enter the following values and click `Save`

- Enable Content Trust: True
- Prevent vulnerable images from running: True
- Automatically scan images on push: True

<details><summary>Screenshot 1.4</summary>
<img src="Images/2018-10-23-02-45-20.png">
</details>
<br/>

## Step 2: Build Docker Image for Planespotter Frontend

In Step 2, you will clone the planespotter repo and use the downloaded source files to build a container for the planespotter frontend app, and prepare Harbor to host containers for the planespotter app deployment

In this case we will only build the planespotter frontend container ourselves, as the planespotter repo already includes K8s deployment manifests configured to download pre-built containers from docker hub. The process of building the containers is the same so for expediency you will only build the frontend to learn the build process

2.1 From the ControlCenter Desktop, open putty and under `Saved Sessions` connect to `cli-vm` and wait for the bash prompt

<details><summary>Screenshot 2.1 </summary>
<img src="Images/2018-10-23-03-04-55.png">
</details>
<br/>

2.2 From the cli-vm prompt, clone the planespotter github repository with the following commands:

```bash
cd ~
git clone https://github.com/CNA-Tech/planespotter.git
```

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-01-13-16-35-48.png">
</details>
<br/>

2.3 View the planespotter frontend dockerfile with the following commands:

```bash
cd ~/planespotter/frontend/
ls
cat Dockerfile
```

<details><summary>Screenshot 2.3 </summary>
<img src="Images/2019-01-13-16-37-22.png">
</details>
<br/>

2.4 Build the planespotter frontend container image with the command `docker build .` and copy the image ID from the last line of the output to the clipboard as shown in the screenshots below

<details><summary>Screenshot 2.4.1 </summary>
<img src="Images/2019-01-13-16-40-45.png">
</details>

<details><summary>Screenshot 2.4.2 </summary>
<img src="Images/2019-01-14-23-43-29.png">
</details>
<br/>

2.5  Enter the command `docker images` and observe that you can now see the docker image with the id you copied from the previous step in in the local docker image cache on `cli-vm`

<details><summary>Screenshot 2.5</summary>
<img src="Images/2019-01-14-23-44-27.png">
</details>

## Step 3: Push and Pull Container Images From Harbor

3.1 Return to your web browser session with Harbor and re-login if needed. From the `Projects` page, click on `library`, and on the Repositories tab, click `PUSH IMAGE`, keep this in mind if you ever need quick and convenient instructions for uploading to a Harbor repo

<details><summary>Screenshot 3.1</summary>
<img src="Images/2018-10-23-03-01-54.png">
</details>
<br/>

3.2 From the `cli-vm` prompt, update the image tag and push to harbor with the following commands - be sure to replace the value `18e4137eeeb9` in the `docker tag` command below with the tag value you gathered in the previous step  

```bash
docker tag 18e4137eeeb9 harbor.corp.local/library/frontend:v1
docker login harbor.corp.local
 - User Name: admin
 - Password: VMware1!
docker push harbor.corp.local/library/frontend:v1
```

If docker push fails with "denied: requested access to the resource is denied", do "docker login harbor.corp.local" with user id=admin, and password = VMware1!, and then do docker push as above.

If the cli-vm doesn't DNS resolve harbor.corp.local:
Find the IP address (10.40.14.5) of the Harbor host from the ControlCenter (RDP desktop) DNS Mgr and add the IP address to /etc/hosts of cli-vm. After that do a docker login and then push!

<details><summary>Screenshot 3.2 </summary>
<img src="Images/2019-01-15-00-10-07.png">
<img src="Images/2019-01-13-16-48-07.png">
</details>
<br/>

3.3 Log into the Harbor UI and navigate to `Projects > library` and click on `library/frontend` to see the image you built and pushed to Harbor in the previous steps

<details><summary>Screenshot 3.3.1</summary>
<img src="Images/2018-10-24-03-27-01.png">
</details>

<details><summary>Screenshot 3.3.2</summary>
<img src="Images/2018-10-24-03-27-29.png">
</details>

<details><summary>Screenshot 3.3.3</summary>
<img src="Images/2018-10-24-03-31-17.png">
</details>
<br/>

3.4 On the `library/frontend` repo page, place your mouse over the copy icon in the `Pull Command` column, you should see a popup that shows the command to pull the image as shown in the screenshots below. Click on the copy icon in the `Pull Command` column to copy this command to the clipboard

<details><summary>Screenshot 3.4</summary>
<img src="Images/2019-01-15-00-18-22.png">
</details>
<br/>

3.5 From the `cli-vm` prompt, delete the local copy of the frontend container with the command `docker rmi harbor.corp.local/library/frontend:v1` and verify the image has been deleted with the command `docker images`

<details><summary>Screenshot 3.3</summary>
<img src="Images/2019-01-15-00-03-55.png">
</details>
<br/>

3.6 From the `cli-vm` prompt, paste the docker pull command you copied in a previous step and verify the image is restored to the `cli-vm` local image cache with the following commands:

```bash
docker pull harbor.corp.local/library/frontend:v1
docker images
```

<details><summary>Screenshot 3.6</summary>
<img src="Images/2019-01-15-00-23-43.png">
</details>
<br/>



<!--

## Step 5 Content Trust & Vulnerability Scanning

Content trust allows admins to require that images be signed in order for the container to run. In this section, you will push untrusted and trusted images to Harbor that we have pre-installed in the `cli-vm` in your the lab vPod, use them to validate the content trust feature You will also trigger a Clair vulnerability scan and view the results. Note that content trust and vulnerability scanning features are independent of one another and can be used seperately

5.1 Resume or if needed reopen your SSH connection to `cli-vm` and upload the untrusted image with the command `docker push harbor.corp.local/trusted/helloworld:V2`

<details><summary>Screenshot 5.1 </summary>
<img src="Images/2018-10-24-04-20-26.png">
</details>
<br/>

5.2 From `cli-vm` configure environmental variables that enable the docker client to validate signed images with Harbor and upload the trusted image with the following commands. Use the passphrase `handsonlab` when prompted

```bash
export DOCKER_CONTENT_TRUST_SERVER=https://harbor.corp.local:4443
export DOCKER_CONTENT_TRUST=1
docker push harbor.corp.local/trusted/nginx:V2
#passphrase = handsonlab
```

<details><summary>Screenshot 5.1 </summary>
<img src="Images/2018-10-24-04-20-26.png">
</details>
<br/>

## Click here to proceed to [Lab 5: Deploy your First PKS Cluster & Planespotter app](../Lab5-DeployFirstCluster)



**Login to Harbor UI**

1. Click on Google Chrome
2. Click on Harbor.corp.local bookmark
3. Login to Harbor with Username: admin and Password: VMware1!

**View Projects and Repositories**



The library project contains five repositories and has no access control. it is available to
the public.

1. Click on library to see the repos

You now see the five different repos. The restreview repos will be used in Module 4 to
deploy our restaurant review application.


**View Restreview-ui Repo Images**

1. Click on the library/restreview-ui repo

**View Image Vulnerability Summary**

Notice that there are two images. During lab preparation two versions of the same
image were uploaded so that we could upgrade our application in Module 4.
Vulnerability scanning is part of PKS deployed Harbor registry.


1. Click on either of the images to see its vulnerability threat report.

**View Image Vulnerability Report**

Each vulnerability is detailed, along with the package containing it, and the correct
package version to fix the vulnerability.


**Create Trusted Project**

So far you have been using unsigned images. Now we want to have a production
project that only contains images that are trusted. In order to do that we must sign the
images. Let's start by creating a new project.

1. Click on Projects

**Create New Project**

1. Click on + Projects


**Enter Project Name**

1. Enter trusted for the project name and click OK

**Verify Project Created**

Note: The name of the project MUST be "trusted", in all lower case. We have tagged
images with that path for you to use later in the lab. Using a different name will cause
the image push to fail.

1. click on trusted to open your new project


**Enable Content Trust on Your Project**

1. Click on Configuration


We have options to Enable Content Trust and prevent vulnerable images from running.
The image vulnerability restricts the pulling of images with CVEs that were identified in
the image scans we saw previously. Enabling content trust means that only signed
images can be pulled from this project.

1. Enable content trust and click Save

**Push Unsigned Image**


1. Type docker push harbor.corp.local/trusted/helloworld:V2

We have an existing unsigned image that we want to push into our trusted project.

Let's go back to the Harbor UI and see our image.

**View Unsigned Image**

1. Click on Repositories
2. Click on the Repo name to see the individual image tags
3. Note that the image is unsigned

Now let's go back to the CLI

**Enable Docker Content Trust**

1. Type export DOCKER_CONTENT_TRUST_SERVER=https://harbor.corp.local:4443
2. Type export DOCKER_CONTENT_TRUST=1

These two commands enable image signing through Docker content trust and point to
the Notary server. Our notary server is our Harbor registry


**Push Signed Image**

1. Type docker push harbor.corp.local/trusted/nginx:V2
2. Type passphrase at all prompts: handsonlab

The root passphrase is only entered the first time you push a new image to your project.
Note that you should not use the standard hol password 'VMware1!'. Docker notary
doesn't seem to like the !. handsonlab was used as the password in testing.

Let's return to Harbor and see our signed image.

**View Signed Image**


1. Click on Respositories in Harbor so your nginx image is visible
1. Click on trusted/nginx image and verify that it was signed

Let's create Kubernetes pods from our two images and see what happens. Return to
the CLI.

**Create Pod From Unsigned Image**

1. Type kubectl apply -f /home/ubuntu/apps/hello-trusted-unsigned.yaml
2. Type kubectl get pods

Notice that there was an error pulling the image. Let's investigate further.


**Describe Pod To Find Error**

1. Enter kubectl describe po/helloworld-v2-#########

Replace the ###### with the pod id from your previous kubectl get pods command.
You can see why the pod failed to create. The image was not signed. Now let's run a
pod with our signed image.

First let's clean up.

**Clean Up Pod**

1. Type kubectl delete -f /home/ubuntu/apps/hello-trusted-unsigned.yaml

This command will delete our deployment.

**Create Pod From Signed Image**

The first thing we need to do is create a secret. This will be mounted on our pod and
shared with Harbor for authentication when pulling our image from the registry.

1. Type kubectl create secret docker-registry regsecret
    --docker-server=http://harbor.corp.local --docker-username=admin
    --docker-password=VMware1! --docker-email=admin@corp.local


The secret contains the information needed to login to the registry. Let's now take a
look at the yaml file for our signed image.

**View Yaml To Create Pod From Signed Image**

1. Type cat nginx-trusted-signed.yaml

Note the imagePullSecrets refers to the secret we just created. Now we will create our
pod from the signed image.


**Create Pod**

1. Type kubectl apply -f nginx-trusted-signed.yaml
2. Type kubectl get pods

**Describe Pod To Verify Successful Image Pull**

1. Type kubectl describe po/nginx-##### where ###### is the number for your pod
    in the get pods command


**Clean Up Deployment**

1. Type kubectl delete -f nginx-trusted-signed.yaml


### Conclusion.............................................................................................................

**You should now have an understanding of Harbor Container Registry**

**You've finished Lab 4**

Congratulations on completing Lab 4!
--!>
