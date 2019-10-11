# PKS-Lab
 
The first step is to login to the PKS CLI and issue a command to create a Kubernetes cluster.   

Login to the cli-vm by using putty and selecting cli-vm  

Once logged into the server via ssh issue the following command to login to PKS CLI

    pks login -a pks.corp.local -u pksadmin --skip-ssl-validation

 - Password: VMware1!

Check for any existing servers

    pks clusters
    
We can view the available plans (starting sizing of clusters) to PKS 

    pks plans

We will review the plan details post starting the deployment of a cluster

Deploy a small cluster with the following command:

**NOTE: If you are using the HOL-2031 environment, you will not be able to create the additional "throwaway" cluster due to sizing restrictions in the lab environment. Instead please review the screenshots below to observe the cluster deployment process**

    pks create-cluster throwaway --external-hostname throwaway.corp.local --plan small

Breaking the command line down we have
 - create-cluster : pks command to execute
 - throwaway : reference name of the cluster (user friendly name for reference with future commands)
 - external-hostname : DNS hostname to reach the cluster (preloaded into DNS in our case)
 - plan : sets the plan for the initial deployment
 
 The creation of your cluster will take a few minutes while you wait for the cluster deployment we will continue the lab with my-cluster that was already deployed you can check the status of your cluster that is deploying using 
 
     pks clusters throwaway

#Learning PKS

Use putty to login to the cli-vm

See available clusters

    pks clusters

Get my-cluster credentials 

    pks get-credentials my-cluster
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P1.PNG)


List all namespaces on your cluster

    kubectl get ns
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P2.PNG)

As you can see we have the four originally created name spaces
 - default
 - kube-public
 - kube-system
 - pks-infrastructure
 
 Each of these namespaces have their own NSX-T router to ensure logical seperation.  Let's examine this connection by logging into NSX-T.  
 
 First we need the UUID of the cluster
 
    pks clusters
 
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/P3.PNG)
 
 Copy the UUID from the output 
 
 Open Chrome & Click the bookmark for NSX-T Manager
 
 Login to NSX-T
  - Username: admin
  - Password: VMware1!
  
  Once logged into the system locate the search bar at the top of the screen.
 
  Paste the UUID into the search bar and press enter to search.  
  
![DockerOutput](https://github.com/gortee/pictures/blob/master/P5.PNG)
 
 Click on the name logical routers tab
 
![DockerOutput](https://github.com/gortee/pictures/blob/master/P6.PNG)
  
 As you can see we have a logical router for each namespace and load balancers (lb)
 
 Switch back to the cli-vm and lets create a new namespace
 
     kubectl create ns development
     
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/P7.PNG)
 
 Looking again in NSX-T on Chrome perform the search again and select logical routers
 
 You can see the creation of the development router for the development name space.
 
  ![DockerOutput](https://github.com/gortee/pictures/blob/master/P8.PNG)
 
 This automation is made possible via the NCP provider in Kubernetes.  Let's remove our namespace back on the cli:
 
     kubectl delete ns development
    
   ![DockerOutput](https://github.com/gortee/pictures/blob/master/P9.PNG)
 
 Return to the NSX-T console and see that the router for development has been automatically removed.  Using just Kubernetes constructs you can adjust networking on demand without knowledge of the networking constructs.  
 
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/P10.PNG)
 
 
 If you have multiple clusters you can switch between them on the command line using 
 
     kubectl config use-context <cluster-name>

 
 The PKS command line essentially has only commands to create, update, delete Kubernetes clusters.   PKS commands are documented here:  https://docs.pivotal.io/runtimes/pks/1-3/managing-clusters.html 
 
 You can resize a cluster with a single command:
 
     pks resize my-cluster --num-nodes 4
     
 ![DockerOutput](https://github.com/gortee/pictures/blob/master/P11.PNG) 
 
 Log into vCenter in order to watch progress.  
 
 Go to Chrome open a new tab and select the folder RegionA and the bookmark for RegionA vCenter (https://vcsa-01a.corp.local/vsphere-client/?cs)  
  - Username: administrator@corp.local
  - Password: VMware1!
  
  Once logged in check recent tasks to see PKS in action.  The new additional worker node will be added to Region01->RegionA01-COMP01->pks-comp1.  As you can see in the attributes it is listed as a worker node.
  
![DockerOutput](https://github.com/gortee/pictures/blob/master/P12.PNG) 
 
 You can also check the status of this resize via the cli by running:
 
     pks cluster my-cluster
     
![DockerOutput](https://github.com/gortee/pictures/blob/master/P13.PNG)

Continue with the lab we will check back on this later in the lab.
  
  
 
 # Interacting with Bosh and PKS
 BOSH provide the key elements of life cycle management for PKS.   Let's examine how BOSH interacts with the environment.  
 
 Open the Chrome web browser and open a new tab locate the bookmark titled Opsman and click it.   Accept the self signed certificate.   If it asks for a decryption password type VMware1! and press enter.   Once presented with a login page login with:
 - Email: admin
 - Password: VMware1!
 
You will be presented with three tiles:
- BOSH director for vSphere
- Pivotal container service
- VMware Harbor registry  

Click on the Pivotal container service tile.  
 
![DockerOutput](https://github.com/gortee/pictures/blob/master/P18.PNG) 

On the left you will see the configuration variables used to setup PKS via Opsman.   These can be changed and then Opman will rollout the changes.   Let's take a look at the plans on the left side by clicking plan 1.  

This should display the small plan details including number of Master nodes (never use 1 unless it's poc) & number of worker nodes and sizing.  

![DockerOutput](https://github.com/gortee/pictures/blob/master/P19.PNG) 

As show the number of worker nodes can be changed once deployed using the PKS command line this only denotes sizing and initial state. Do not change anything in here!  Feel free to review plan 2 for the medium.  Remember you can see the plans in the cli-vm using (pks plans)    

Click on the Kubernetes Cloud Provider to see the vCenter connection and Networking to see the NSX-T connection.   You can explore the other tabs to better understand the deployment.   

Changes made to PKS tile can be reviewed and deployed.  Everything in BOSH has a smoketest to identify potential functionality problems with deployments.  If you fat finger something inside the tile the change will not be deployed.   

One of the great strengths of BOSH is it provides desired state management for Kubernetes which means if a worker node fails it corrects the issue.   This is true for master nodes assuming you have more than one deployed.  In our case we only have one master node so we will not simulate a failure of the master node.   

Login to vSphere using Chrome:
- Click on the RegionA Folder
- Click on RegionA vCenter
- Login with
  - Username: administrator@corp.local
  - Password: VMware1!
- Wait for the console to load up
- Expand RegionA01
- Expand RegionA01-COMP01
- Expand pks-comp-1
- Click on the a virtual machine (vm-ID)
- Click on the Summary Tab 
- Scroll down on Custom Attributes looking for job
- Choose different virtual machines until you identify a job that is worker

![DockerOutput](https://github.com/gortee/pictures/blob/master/P20.PNG) 

This is a worker nodes in your cluster.  Make sure you have a worker node selected.  We are going to power it down to simulate a worker node failure.  

- Right click on the VM
- Highlight Power
- Select Power off
- Confirm you want to power it off
- Expand recent tasks on the right side to show it has been powered off

![DockerOutput](https://github.com/gortee/pictures/blob/master/P21.PNG)

This will take a little time for PKS to identify it as failed and take action but it will remove the old virtual machine and provision a new worker node.  You can continue to monitor via the recent tasks for the replacement to complete.   
 
 # Harbor
Harbor is an open source repository that provides image security scanning and reporting.  Harbor organizes images into a set of projects and repositories within those projects. Repositories can have one or more images associated with them. Each of the images are tagged. Projects can have RBAC (Role Based Access Control) and replication policies associated with them so that administrators can regulate access to images and create image distribution pipelines across registries that might be geographically dispersed. You should now be at a summary screen that shows all of the projects in this registry. For our lab, we are interested in a single project called library.

In order to use harbor you need to setup secure communications between harbor and your virtual machine. This step is NOT required for HOL-2031 users. Follow these instructions (https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/HarborCertExternal-HC7212)

Once you have the certificates completed return to this lab.

Login to Harbor
- Go to Chrome
- Locate the Harbor.corp.local bookmark or type (https://harbor.corp.local/harbor/sign-in)
- Login to harbor using
  - Username: admin
  - Password: VMware1!

Once logged into Harbor you can see a project name library that already exists.  Click on library to explore the elements that comprise a library.  Click the following tabs and read the options:

- Members -  RBAC Access controls
- Replication - Ability to replicate images across multiple repositories
- Labels - Metadata assigned
- Configuration - Security options (public or private, deployment security controls, image scanning)
 
Click on the Projects tab to return to the login screen. 

Let's create a new project for one of our docker images.  

- Left click on + New Project
- Type trusted for the project name
- Click OK (accepting default access level)

![DockerOutput](https://github.com/gortee/pictures/blob/master/P28.PNG)

- Left click on trusted project
- Left click on the Configuration tab
- Enable the following
   - Enable content trust
   - Automatically scan images on push
- Click on Save

![DockerOutput](https://github.com/gortee/pictures/blob/master/P29.PNG)

Return to the cli-vm putty window.  We are going to check in our first docker image into Harbor - pull the ping image down from harbor.cloudnativeapps.ninja.  

    docker pull harbor.cloudnativeapps.ninja/ping:v1
 
From the cli-vm prompt, update the image tag and push to harbor with the following commands - be sure to replace the value ee3cc31c901b in the docker tag command below with the tag value you gathered in the previous step

    docker tag harbor.cloudnativeapps.ninja/ping:v1 harbor.corp.local/ping:v1
    docker login harbor.corp.local
     - User Name: admin
     - Password: VMware1!
    docker push harbor.corp.local/library/ping:v1

If docker login fails with "Error response from daemon: Get https://harbor.corp.local/v2/: x509: certificate signed by unknown authority", you need to prepare the cli-vm docker engine configuration with the Harbor certificate, as documented in the [Installing Harbor Cert on External Clients Lab Guide](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/HarborCertExternal-HC7212)

Log into the Harbor UI and navigate to Projects > library and click on library/ping to see the image you built and pushed to Harbor in the previous steps.

On the library/ping repo page, place your mouse over the copy icon in the Pull Command column, you should see a popup that shows the command to pull the image as shown in the screenshots below. Click on the copy icon in the Pull Command column to copy this command to the clipboard

![DockerOutput](https://github.com/gortee/pictures/blob/master/P31.PNG)

From the cli-vm prompt, delete the local copy of the frontend container with the command docker rmi harbor.corp.local/library/ping:v1 and verify the image has been deleted with the command docker images

    docker rmi harbor.corp.local/library/ping:v1
    docker images
    
From the cli-vm pull down the docker image from harbor with the command:

    docker pull harbor.corp.local/library/ping:v1
    docker images

![DockerOutput](https://github.com/gortee/pictures/blob/master/P32.PNG)

# Harbor Content trust & Scanning
The content trust feature allows admins to require that images be signed in order for the container to run, enabling a business process to be used where only images that meet policy requirements are signed and able to be deployed from repositories where content trust is enabled.  We enabled content trust and scanning on the trusted project.  

From the cli-vm prompt, update the image tag to prepare the ping:v1 image for upload to the trusted repository and push to harbor with the following commands:

    docker tag harbor.corp.local/library/ping:v1 harbor.corp.local/trusted/ping:v1
    docker push harbor.corp.local/trusted/ping:v1

Let's scan this image by navigating to the Harbor UI Projects -> library -> repositories -> trusted/ping.  Select the checkbox next to v1 and choose to scan it. Once this is completed you can mouse over the vilnerability line to identify any concerns from the scan.  Navigate to Projects > trusted and click on trusted/ping to see the image you built and pushed to Harbor in the previous steps. Observe that the vulnerability scan has already been completed, which is because you enabled the Automatically scan images on push feature when you created the trusted project

From the cli-vm prompt, delete all local copies of the frontend container image and verify the image has been deleted with the command docker images

    docker rmi harbor.corp.local/trusted/ping:v1
    docker images
    
From the cli-vm prompt, enter the command docker pull harbor.corp.local/trusted/ping:v1. You should now see an error message indicating the unsigned image is blocked from being downloaded, as shown in the following screenshot

    docker pull harbor.corp.local/trusted/ping:v1
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P33.PNG)

 From cli-vm configure environmental variables that enable the docker client to validate signed images with Harbor

    export DOCKER_CONTENT_TRUST_SERVER=https://harbor.corp.local:4443
    export DOCKER_CONTENT_TRUST=1
    
From the cli-vm prompt, enter the command docker pull harbor.corp.local/trusted/ping:v1. Observe that despite enabling content trust on the client, you are still prevented from downloading the image, which is because the image itself was never signed

    docker pull harbor.corp.local/trusted/ping:v1
    
From the cli-vm prompt, download a local unsigned copy of the ping ping:v1 image from the library/ping repository on harbor. (NOTE: you may need to set DOCKER_CONTENT_TRUST to 0 in order to download from the library, set it back to 1 when download is complete: export DOCKER_CONTENT_TRUST=0) Update the tag to prepare for uploading to the trusted project where content trust is enabled. Note that when after you enter the push command, you will be prompted to enter passphrases for image signing, use the passphrase VMware1!

    export DOCKER_CONTENT_TRUST=0
    docker pull harbor.corp.local/library/ping:v1
    export DOCKER_CONTENT_TRUST=1
    docker tag harbor.corp.local/library/ping:v1 harbor.corp.local/trusted/ping:v2
    docker push harbor.corp.local/trusted/ping:v2

While you are still pushing the same unsigned image to harbor, because you enabled content trust on the cli-vm docker client, it will automatically sign an image when pushed (Use the password VMware1!)

![DockerOutput](https://github.com/gortee/pictures/blob/master/P34.PNG)

You can see the new v2 image in the trusted project.   

![DockerOutput](https://github.com/gortee/pictures/blob/master/P35.PNG)


Delete all local copies of the image 

    docker rmi harbor.corp.local/trusted/ping:v2

Download the secured and signed version from harbor

    docker pull harbor.corp.local/trusted/ping:v2
    
Observe you are now able to download the signed image from the trusted repository with content trust restrictions enabled. Enter Docker images to verify that the frontend:v2 image is now in your local image cache.

Clean up by setting trust to 0 

    export DOCKER_CONTENT_TRUST=0

 # Checking on resizing
 
 Lets check on our resizing operation using the pks command line
 
     pks cluster my-cluster
     
      
![DockerOutput](https://github.com/gortee/pictures/blob/master/P14.PNG)

Resize it back to three nodes

    pks resize my-cluster --num-nodes 3
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P15.PNG)

You can monitor it via the 

    pks cluster my-cluster 
   
![DockerOutput](https://github.com/gortee/pictures/blob/master/P16.PNG)

You can see it was deleted in vCenter as well

![DockerOutput](https://github.com/gortee/pictures/blob/master/P17.PNG)

# Check on Throwaway cluster
Let's check the status of the throwaway cluster we created in the cli-vm.  
**NOTE: If you are using the HOL-2031 environment, you will not be able to create the additional "throwaway" cluster due to sizing restrictions in the lab environment. Instead please review the screenshots below to observe the cluster deployment process**
    pks clusters
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P22.PNG)

Once succeed we cab login to the cluster and create a namespace.   Remember this is a completely seperate cluster with a completely different potential user base.  

In this way (assuming DNS is configured) you can have seperate Kubernetes clusters all managed by PKS to allow role seperation.   You can implement rolling upgrades from the PKS API or command line across all clusters thus reducing the time required to do day two operations.   Let's configure DNS so we can test our throwaway cluster.   

First identify the IP address for the throwaway cluster with 
**NOTE: If you are using the HOL-2031 environment, you will not be able to create the additional "throwaway" cluster due to sizing restrictions in the lab environment. Instead please review the screenshots below to observe the cluster deployment process. Alternatively you can review the below commands using the cluster that is deployed in the HOL-2031 lab which is named "my-cluster" instead of the "throwaway" cluster**
    pks cluster throwaway
    
![DockerOutput](https://github.com/gortee/pictures/blob/master/P24.PNG)  

As shown my cluster IP is 10.40.14.42 (yours may be different)

- Click on the Windows Start icon
- Type DNS
- Click on the DNS icon
- Expand Forward Lookup Zones
- Expand corp.local

![DockerOutput](https://github.com/gortee/pictures/blob/master/P23.PNG)

- Right click on corp.local
- Left click on New host (a or aaaa) record
- Type the name throwaway
- Type the ip address learned in last step (mine is 10.40.14.42)
- Click Add host

 ![DockerOutput](https://github.com/gortee/pictures/blob/master/P25.PNG)  
 
 Now let's try to login to the cluster and create a namespace.  
 
     pks get-credentials throwaway
     
 This should log us into throwaway.corp.local
 
 Let's see the namespaces created by default in our new cluster
 
     kubectl get namespaces
     
![DockerOutput](https://github.com/gortee/pictures/blob/master/P26.PNG)
  
  Creating a new namespace is simple
  
      kubectl create namespace test
      kubectl get namespaces
 
![DockerOutput](https://github.com/gortee/pictures/blob/master/P27.PNG)

As shown before this cluster and namespace has it's own routing and Kubernetes cluster independant of my-cluster.   For resource constraint purposes we need to remove the throwaway cluster.
**NOTE: If you are using the HOL-2031 environment, you will not be able to create the additional "throwaway" cluster due to sizing restrictions in the lab environment. Instead please review the screenshots below to observe the cluster deployment process**
    pks delete-cluster throwaway
    
This command will remove and cleanup everything about the cluster except the DNS record you manually created.   
