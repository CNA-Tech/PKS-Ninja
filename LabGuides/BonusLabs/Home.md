# Welcome to the **Run Kubernetes with VMware workshop wiki!**

The wiki has instructions for the Hands on exercises that will be conducted during the Workshop. We will be using VMware Kubernetes Engine(VKE) for the labs. VKE already has Kubernetes clusters pre-provisioned for this workshop. You have been assigned to a pre-provisioned cluster in VKE. The clusters will be available 24 hours after the workshop if you need to continue working on them.

## Setup/Configuration

### 1. Register/Login to VKE
* By now you should have an invitation email to login to VMware Kubernetes Engine (VKE), please follow instructions in the email to sign-up as a user for VKE 
* In order to register for VKE, you will need to have a login in 'My VMware'. If you already have a login in 'My VMware' using the same email address you used for registration you don't have to create a new one. Else, you will be directed to create a 'My VMworld' ID.
* One of the Proctors for the Workshop should have assigned you a Kubernetes Cluster <name> that's already pre-created and assigned to you, please have the cluster name handy. 
* If you haven't received the invitation email or do not know the name of the Kubernetes Cluster assigned to you, please reach out to one of the proctors.

### 2. Download VKE CLI and Kubectl
The VKE CLI will help us interact with the platform, fetch us the tokens needed to get authenticated access to the Kubernetes cluster

#### Procedure
1. In a browser, launch the VMware Cloud Services console.
https://console.cloud.vmware.com/
2. Log in to your VMware Cloud services organization.
3. On the VMware Kubernetes Engine tile, click Open.
This takes you to the VKE console.
4. Click on 'Developer Center', once there click the text 'DOWNLOAD THE VKE CLI'. Click on 'Downloads' and select the version based on the operating system you are working on.
5. Also on the same page, download `kubectl` by clicking the downalod button under the kubectl tile.
6. After the download completes, move the vke executable to a common bin directory (for example,
~/bin or %UserProfile%\bin).
*  For Linux or Mac OS X:
`% mkdir ~/bin`
`% cp vke ~/bin`
*  For Windows:
`mkdir %UserProfile%\bin`
`copy vke.exe %UserProfile%\bin`
7. Make sure your bin directory is accessible on your PATH.
 * For Linux or Mac OS X:
`% export PATH=$PATH:/Users/your-user-name/bin`
* For Windows:
`set PATH=%PATH%;%UserProfile%\bin`
8. Make the file executable.
*  For Linux or Mac OS X:
`% chmod +x ~/bin/vke`
 * For Windows:
`attrib +x %UserProfile%\bin\vke.exe`
9. Now change to a different directory and check the version to verify that the CLI is ready to use.
`vke --version`

`Kubectl` is a command line interface for Kubernetes, it lets you interact with the Kubernetes cluster. Once logged in to the cluster Kubectl will be used anytime you want to deploy apps/services/provision storage etc. or need to query the cluster for existing pods/nodes/apps/services etc.

Kubectl is also available to download from the VKE Console page, once logged in to the console, 
Click on Developer-->click on <name of your cluster>-->Actions -->Download kubectl

Once downloaded, save the file in your environment <PATH> for you to be able to access it from any directory. Just like the vke CLI above.

You can also interact with Kubernetes using the kubernetes dashboard if you prefer UI over CLI, the Kubernetes dashboard is available from the VKE console-->_Your-Cluster-Name_>-->Actions-->Open K8's UI

### 3. Login to VKE via vke CLI

So far we have downloaded the vke CLI and kubectl CLI, now we will login to VKE via the CLI to fetch the access tokens needed to talk to the clusters hosted in VKE via Kubectl

Get access to the Organization ID and Refresh Tokens

1.  Go back to the VKE web interface
Click on 'Developer Center' and click the Overview tab, once there you will see the CLI to login to VKE with the organization ID , copy the entire command like and store it in a note pad.

2. On the same page, click on 'Get your Refresh Token', this will redirect the browser to the 'My Accounts' page and you will see your OAuth Refresh Token, copy the token. If there is no token click "Generate Key" and copy it.
 Save the 'refresh token' 

**Please treat this Refresh Token as your Password and DO NOT SHARE it with others**

Login using the Organization ID and Refresh Token
1. Login to vke, copy paste the VKE Login command from above (step1) and replace 'your-refresh-token' with the one you retrieved above (step 2)(omit the quotes).

`vke account login -t 'your-organization-id' -r 'your-refresh-token'`

2. Set folder and project within VKE 

`vke folder set SharedFolder`

`vke project set SharedProject`

3.  Fetch Kubectl auth for your cluster, **replace <your-cluster-name> with the name of the cluster assigned to you in the command below**

`vke cluster merge-kubectl-auth <your-cluster-name>`

### 5. Access Kubernetes Cluster via Kubectl 

You should now be able to interact with your cluster using kubectl, give kubectl a try , run below commands to see your cluster Pods and Services

* `kubectl get pods` - Fetches the pods currently deployed in the cluster.
* `kubectl get svc` - Fetches the various services currently created in the cluster.

## Next: Proceed to Deploying you app on Kubernetes Cluster here https://github.com/Boskey/run_kubernetes_with_vmware/wiki/Deploy-Plane-Spotter
