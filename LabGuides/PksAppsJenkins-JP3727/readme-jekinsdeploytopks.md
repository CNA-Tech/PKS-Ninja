# Setting up Jenkins , create Helm charts and Deploy the Planespotter app to PKS

## Overview
This guide walks though setting up Jenkins , creating Helm charts for the planespotter application and deploying the planespotter application to PKS via a Jenkins pipeline


## Jenkins
An open source automation server which enables developers around the world to reliably build, test, and deploy their software.


## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment
- PKS Install (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PksInstallPhase2-IN1916)
- PKS Cluster (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610)

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.3 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-3E0C4CEC-D593-4395-84C4-150CD6285963.html)


### Overview of Tasks Covered in Lab 


- [Step 1: Create a Ubuntu VM](#Step-1:-Create-a-Ubuntu-VM)
- [Step 2: Login to UbuntuVM and update pakages](#Step-2-:-Login-to-UbuntuVM-and-update-pakages)
- [Step 3: Install Helm](#sStep-3:-Install-Helm)
- [Step 4: Install Docker](#Step-4:-Install-Docker)
- [Step 5: Install kubectl](#Step-5:-Install-kubectl)
- [Step 6: Install Jenkins](#Step-6:-Install-Jenkins)
- [Step 7: Setup Jenkins](#Step-6:-Setup-Jenkins)
- [Step 8: Prepare and get credentials from the PKS Environment](#Step-8:-Prepare-and-get-credentials-from-the-PKS-Environment)
- [Step 9: Setup the Jenkins Environment and create your pipeline](#Step-9:-Setup-the-Jenkins-Environment-and-create-your-pipeline)
- [Step 10: Create your first Jenkins pipeline to deploy the plane spotter application](#Step-10:-Create-your-first-Jenkins-pipeline-to-deploy-the-plane-spotter-application)
 
-----------------------

## Step 1: Create a Ubuntu VM

### Create a Ubuntu VM in the lab environment

1.1 Download the ubuntu OVF template (ubuntu-16.04-server-cloudimg-amd64.ova) from https://cloud-images.ubuntu.com/releases/16.04/release/

1.2 Login to vCenter and and select the a region (Eg. RegionA01-MGMT01). Right click and selecxt Deploy OVF Template

<details><summary>Screenshot 1.2</summary>
<img src="Images/deployovf.png">
</details>
<br/> 

1.3 Click on Browse and select the vmdk file that was downloaded in the previous step

<details><summary>Screenshot 1.3</summary>
<img src="Images/browseova.png">
</details>
<br/> 

1.4 Click on Next. Select RegionA01, Change the name Eg. UbuntuWorkerVM and click on Next

<details><summary>Screenshot 1.4</summary>
<img src="Images/nameova.png">
</details>
<br/> 

1.5 Select RegionA01-COMP01 , we select the COMP01 region here so that the HDFS network is on the same network as the compute nodes. This can go into the Management node as well as long as it is reachable from the kubernetes worker nodes. Click on Next


1.6 Click on Next on the Review Details screen


1.7 On the Select Storage screen , select virtual disck format as Thin provision, VM stoarge policy as none and select any of the datastores with over 50GB of space. Click on Next

<details><summary>Screenshot 1.7</summary>
<img src="Images/selectstorage.png">
</details>
<br/> 

1.8 For networks select VM-RegionA01-vDS-COMP and click on Next

<details><summary>Screenshot 1.8</summary>
<img src="Images/selectnetwork.png">
</details>
<br/> 

1.9 On the customize template screem modify the following and click on Next
    Change the hostname Eg. ubuntuvm
    Change the defaultpassword to VMware@12345
    SSH key : (Either generate one or use the sample below)
```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC2sbYtHu65GhgEYk8kUCzCFBWlKM24hMiZwcwJy0mws9KwsCTEEH+aOlt0BvMcYchhV5I2Bxi3nS05vSXMZycoSG8t6Cw0Cw2IYHYNYzl8XCQ5QUtFDXoEK1eGEQTeXissTkR15Fk2CzBYXoGNUKe7mt6TQGKMpwXwNDZe2ZlJXRGsiTgLCdLehYUS+qIIOirQqD2VjBPVfp1ckCztgIydiQoZOilMAQBnJ6KGMr4DiuF8zevgFl4OcFDm7eeuP9cOSYXRtCyAtrB5xvYNGcf+AiMz7yun/HLwMkXab8Nzup1I+90GVtouMddpSp3gZyPpC7CVeToCebhe+EGUjzR riazm@riazm-a01.vmware.com
```
    
<details><summary>Screenshot 1.9</summary>
<img src="Images/customizetemplate.png">
</details>
<br/> 

1.10 Review details and click on Finish


1.11 The ubuntuvm will be displayed under the COMP Region

<details><summary>Screenshot 1.11</summary>
<img src="Images/ubuntuvmonvsphere.png">
</details>
<br/> 

1.12 Select the ubuntuvm, right click and select Edit Settings

<details><summary>Screenshot 1.112</summary>
<img src="Images/editvm.png">
</details>
<br/> 


1.13 Update Memory to 4096 MB (4GB), Click on New Device, Select New Hard Drive and click on Add. Enter 50 GB for the new hard drive and Click on OK

<details><summary>Screenshot 1.13.1</summary>
<img src="Images/addharddrive.png">
</details>
<br/>

<details><summary>Screenshot 1.13.2</summary>
<img src="Images/harddrive.png">
</details>
<br/> 

 1.14 Power on the VM 

 <details><summary>Screenshot 1.14</summary>
<img src="Images/poweron.png">
</details>
<br/> 


### SSH into the UbuntuVM that was created

1.15 Login to the cli-vm

1.16 Create a directory ubuntuvm

```bash
mkdir ubuntuvm
cd ~/ubuntuvm/
```

1.16 Copy the following certificate to a ubuntuvm.pem file

```bash
nano ubuntuvm.pem
```

<details><summary>ubuntuvm.pem</summary>

```yaml
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABDrd4p2Ew
IRlaaxg0lXxi34AAAAEAAAAAEAAAEXAAAAB3NzaC1yc2EAAAADAQABAAABAQDC2sbYtHu6
5GhgEYk8kUCzCFBWlKM24hMiZwcwJy0mws9KwsCTEEH+aOlt0BvMcYchhV5I2Bxi3nS05v
SXMZycoSG8t6Cw0Cw2IYHYNYzl8XCQ5QUtFDXoEK1eGEQTeXissTkR15Fk2CzBYXoGNUKe
7mt6TQGKMpwXwNDZe2ZlJXRGsiTgLCdLehYUS+qIIOirQqD2VjBPVfp1ckCztgIydiQoZO
ilMAQBnJ6KGMr4DiuF8zevgFl4OcFDm7eeuP9cOSYXRtCyAtrB5xvYNGcf+AiMz7yun/HL
wMkXab8Nzup1I+90GVtouMddpSp3gZyPpC7CVeToCebhe+EGUjzRAAAD0Mhc98/OENaDzg
gfZhX9ssp2rgoo0MjnHr+UKPf7i3/Ade2qsZxxBwWfUKCBGjYz5FoKW0mcPYAo9QGjwhzx
sQG7fDtieS2TAz/ngDLWtO3HjbNqPv7yPbakwlgKju/AIpzvmb7UsVzUqBwzdAMIQXSw8y
QVnLmUcnRRauqyN5CNxE8FmPFZubmh7CDVUsVUTHzKjj4VuODYppnDtTe4vd1fkF46H+vf
UE32A1aSNQXhjVoY2lsM+4qRa8EOAcW5wy8sKHrUjHO3mNR7Bu8KJH2dVkyg6Ht1ZrbZer
U9VWg9tRgxJSackeabKmGK/AOrChVNfSqBNfGG9vdeC+RpUV4MWbJ3WQGg29TeqRjQfcaY
ejP7KonlP5YusZQ7ahisz2FzsQmvBFNSX5SiM7PS0wA7YXlctVHke5Mm51AgMWy6Bjp8Mv
m7rK4xGk94hPeK/3RAJVlEJFkB2yp/wVZD9++ES4P9mX2hPTwj8VbOwM14uEyMT5yPam8l
YtnYu2BNGLfdlH7LcusayEzzAMkPb4Wk0SY5gVEcfmfi7KnfyJ8QzJl+oIkkHvY1milyY/
+tW/NHfEOt7YYjliVg4iBBRvF2K/UtaNEJYH3pXye71oiUeJ4xjukfDw60VXDo6djKYttr
X0ybyHA2HIf7GtNXHGOU9DXVdfZvBsmLDlD26bzifKIcZmWXFz5uqk5Btff+PV6zauAGoN
JetRkdtHrhW47drRDjppKzj3n3rLBRBD/txpjhFm0eGI7WInOmqbLVeg2V6Sec1uD3JkVN
WYgy5+FbO8SnNKfG1vKO+R0iTt6DOBPE55/7ZngEamUtcaaxDEnb0ANggsEsu+DelvlT3P
UmvHdDyVE4U6UaWcCb/6XFjR2fM+WddPhkgfwNmBqv9VmdXb6Tp99FsFRfe/+2O+HyawSe
/e0As4Duo0/qTpYWM15O0yuqbJE6VMGHjz+3WP0n/pEJgQ1EcQ0BNj0kHBcP0sTyaUq56Y
D76A2WXM7YKEUBVE2UAQ81tpOljrLhOIcxYFI72e8yKj1IMka/Bf393WbC5hwtdnLxtMpJ
qtziBLWnP62V8FqNSxe5PjpKFWesOn5zfYUm/WAncOT7f6kqVG3IR3UUw5fdt/vFg9WRMr
VuJkMyjSZ98+QS/F052V2Dn8MpSDH91zI0Pla2oWNyDR9SWM/jpCoNI3vB0gG0JhzrJTVB
ZFT7Ouiqmmnf25XgZ6xXf97/r/h1cdKtsxaZ1em8ojoD/VSdCoGDAIAAdechKvhxydOoX3
6gOpE0pq3IxIHOoqKtf2ZjdTYTjyo=
-----END OPENSSH PRIVATE KEY-----
```

</details>
<br/>

1.17 Change permissions on the cert

```bash
chmod 400 ubuntuvm.pem
```

1.18 SSH into the ubuntuvm (The ipadress of the ubuntuvm provisioned can be viewed in vCenter)

```bash
 ssh -i "ubuntuvm.pem" ubuntu@192.168.100.111
```

Enter VMware1! as the password

<details><summary>Screenshot 1.18</summary>
<img src="Images/ubuntuvmip.png">
</details>
<br/> 

1.19 Update the password
 Enter current password as VMware@12345
 Enter new password of your choice (Eg. VMware1!) 
 You should get a prompt password updated successfully


## Step 2 : Login to UbuntuVM and update pakages
2.1 Login to cli-vm 

2.2 Ssh to ubuntuvm created in the aboive step

```bash
cd ~/ubuntuvm/
ssh -i "ubuntuvm.pem" ubuntu@192.168.100.111
```
Use password as VMware1!

2.3 Update /etc/hosts file to include ip and hostname, Change hostname and ip

```bash
sudo vi /etc/hosts

127.0.0.1 localhost ubuntuvm
192.168.100.111 ubuntuvm
```

 2.4 Update Packagelist

```bash
sudo apt-get update
```

2.5 Install Open JDK

```bash
sudo apt install openjdk-8-jdk
```


## Step 3: Install Helm


3.1 Download your desired version

```bash
mkdir helm
cd helm
wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
```

3.2 Unpack the dowloaded tar

```bash
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz
```

3.3 Find the helm binary in the unpacked directory, and move it to /usr/local/bin

```bash
sudo mv linux-amd64/helm /usr/local/bin/helm
```

3.4 Check if helm is installed and working 

```bash
helm version
```


## Step 4: Install Docker

4.1 Uninstall older version of docker if exists

```bash
sudo apt-get remove docker docker-engine docker.io
```

4.2 Install docker


```bash
sudo apt install docker.io
```

4.3 Start docker. The Docker service needs to be setup to run at startup


```bash
sudo systemctl start docker
sudo systemctl enable docker
```

4.4 Check if docker is installed and working 

```bash
docker  --version
```

## Step 5: Install kubectl

5.1 Update system dependencies 

```bash
sudo apt-get install -y apt-transport-https
```

5.2 Add the Google repository

Import the GPG keys of the Google repository using the following wget command:

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

```

The command above should output OK which means that the key has been successfully imported and packages from this repository will be considered trusted.

5.3 Add the Kubernetes repository to the system

```bash
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

5.4 Install kubectl

```bash
sudo apt-get update
sudo apt-get install -y kubectl
```

5.5 Verify kubectl

```bash
kubectl version
```


## Step 6: Install Jenkins


6.1 Add the Jenkins Debian repository

Import the GPG keys of the Jenkins repository using the following wget command:

```bash
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
```

The command above should output OK which means that the key has been successfully imported and packages from this repository will be considered trusted.

6.2 Add the Jenkins repository to the system

```bash
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```

6.3 Install Jenkins

```bash
sudo apt update
sudo apt install jenkins
```

6.4 Verify Jenkins service status

```bash
systemctl status jenkins
```

<details><summary>Screenshot 2.9</summary>
<img src="Images/jenkinsstatus.png">
</details>
<br/> 

6.5 Once Jenkins is successfully installed a jenkins user is created. Check by using the following command

```bash
sudo su - jenkins

exit
```

6.6 Add docker group to the jenkins user (Unless user is not added to the docker group the user does not have persmissions to run docker commands)

```bash
sudo usermod -aG docker jenkins
```


## Step 7: Setup Jenkins

7.1 Navigate to http://<ubuntuvm-ip>:8080 . Eg http://192.168.100.111:8080


<details><summary>Screenshot 7.1</summary>
<img src="Images/unlockjenkins.png">
</details>
<br/> 

NOTE: During the installation, the Jenkins installer creates an initial 32-character long alphanumeric password.

7.2 Retrieve generated password from the ubuntuvm


```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

<details><summary>Screenshot 7.2</summary>
<img src="Images/generatedpassword.png">
</details>
<br/> 

7.3 Copy the password from the terminal, paste it into the Administrator password field and click Continue


<details><summary>Screenshot 7.3</summary>
<img src="Images/gettingstarted.png">
</details>
<br/> 


7.4 Click on Install Suggested Plugins


<details><summary>Screenshot 7.4</summary>
<img src="Images/plugininstall.png">
</details>
<br/> 

7.5 Once the plugins are installed, you will be prompted to set up the first admin user. Fill out all required information and click Save and Continue
 Eg. Create user pksuser with password as VMware1!

<details><summary>Screenshot 7.5</summary>
<img src="Images/adminuser.png">
</details>
<br/> 

7.6 The next page will ask you to set the URL for your Jenkins instance. The field will be populated with an automatically generated URL. Click on Save and Finish

<details><summary>Screenshot 7.6</summary>
<img src="Images/instanceconfig.png">
</details>
<br/>

7.7 Click on start using Jenkins

<details><summary>Screenshot 7.7</summary>
<img src="Images/jenkins.png">
</details>
<br/>  


## Step 8: Prepare and get credentials from the PKS Environment 
Note: Assumption is we have two clusters my-cluster which we will use as our dev environment and prod-cluster that we will use as our prod environment. To create clusters refer to [Deploy First PKS Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610)

8.1 Login to cli-vm

8.2 Login to pks

```bash
pks login -a pks.corp.local -u pksadmin --skip-ssl-validation
```

8.3 Get credentails for cluster

```bash
pks get-credentials my-cluster
```

8.4 Create a Jenkins service account


```bash
kubectl create serviceaccount --namespace kube-system jenkins
```


8.5 Give cluster admin permissions to jenkins

```bash
kubectl create clusterrolebinding jenkins-clusterrolebinding --clusterrole=cluster-admin --serviceaccount=kube-system:jenkins
```

8.6 Fetch the name of the secret used by the jenkins service account

```bash
kubectl get serviceaccounts/jenkins -o yaml -n kube-system
```
<details><summary>Screenshot 8.6</summary>
<img src="Images/jenkinstoken.png">
</details>
<br/>  


8.7 Copy the secret to a clipboard Eg. jenkins-token-nkn5k

8.8 Fetch the token from the secret

```bash
kubectl describe secrets jenkins-token-nkn5k -n kube-system
```

<details><summary>Screenshot 8.8</summary>
<img src="Images/fetchjenkinstoken.png">
</details>
<br/>  

Copy the secret to a clipboard. This will be used later to form the kubeconfig file


8.9 Get the certificate info for the cluster
Every cluster has a certificate that clients can use to encryt traffic. Fetch the certificate and write to a file by running this command. In this case, we are using a file name cluster-cert.txt

```bash
kubectl config view --flatten --minify > my-cluster-cluster-cert.txt
```

The resultant file will look as below.

<details><summary>Screenshot 8.9</summary>
<img src="Images/clustercert.png">
</details>
<br/> 


8.10 Get credentials to the prod-cluster 

```bash
pks get-credentials prod-cluster
```

8.11 Switch context to the prod cluster 

```bash
kubectl config use-context prod-cluster
```

8.12 Create a jenkinsprod service account


```bash
kubectl create serviceaccount --namespace kube-system jenkinsprod
```


8.13 Give cluster admin permissions to jenkinsprod

```bash
kubectl create clusterrolebinding jenkinsprod-clusterrolebinding --clusterrole=cluster-admin --serviceaccount=kube-system:jenkinsprod
```

8.14 Fetch the name of the secret used by the jenkinsprod service account

```bash
kubectl get serviceaccounts/jenkinsprod -o yaml -n kube-system
```

8.15 Repeat steps 8.7 to 8.9 for the prod-cluster. In step 8.9 use prod-cluster-cluster-cert.txt for the file name


## Step 9: Setup the Jenkins Environment and create your pipeline

9.1 Login to the jenkins ubuntu vm

9.2 Change user to jenkins

```bash
sudo su - jenkins
```

9.3 Create a kubeconfig file

```config
apiVersion: v1
kind: Config
users:
- name: <replace with service accoount for jenkins on my-cluster Step 8.4 Eg. jenkins>
  user:
    token: <replace with token for jenkins on my-cluster Step 8.8>
- name: <replace with service accoount for jenkinsprod on prod-cluster Step 8.4 Eg. jenkinsprod> 
  user:
    token: <replace with token for jenkins on my-cluster Step 8.15>
clusters:
- cluster:
    certificate-authority-data: <replace with certificate auth data from the my-cluster-cluster-cert.txt from step 8.9>
    server: <replace with server info from  my-cluster-cluster-cert.txt from step 8.9 Eg.https://my-cluster.corp.local:8443>
  name: <replace with cluster name Eg. my-cluster>
- cluster:
    certificate-authority-data: <replace with certificate auth data from the prod-cluster-cluster-cert.txt from step 8.15>
    server: <replace with server info from  prod-cluster-cluster-cert.txt from step 8.15 Eg.https://prod-cluster.corp.local:8443>
  name: <replace with cluster name Eg. prod-cluster>
contexts:
- context:
    cluster: <replace with cluster name Eg. my-cluster>
    user: <replace with service accoount for jenkins on my-cluster Step 8.4 Eg. jenkins>
  name: <replace with cluster name Eg. my-cluster>
- context:
    cluster: <replace with cluster name Eg. prod-cluster>
    user: <replace with service accoount for jenkins on prod-cluster Step 8.4 Eg. jenkinsprod>
  name: <replace with cluster name Eg. prod-cluster>
```

Example file
```config
apiVersion: v1
kind: Config
users:
- name: jenkins
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJqZW5raW5zLXRva2VuLW5rbjVrIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImplbmtpbnMiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIwYjhlNWFkZC1jMDRjLTExZTktYjk0Ni0wMDUwNTY4OGI4OWIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06amVua2lucyJ9.tnsKYqO_debPhudmU3bwTqahg9Jq8B-9QyonJuwLg1NVr2kuoldY8-Djjw-BG5qupkeGwFfR-2A6DAOp-Ibh-F4Etkf_I9IpTlzaUQBA9SqSuDC7p43bqHue8jtq0qLVcqnZbjX0bTpiW-T6zuxT0lxiAyWT58S9wcSEe727KmdPrmj-WQUpSWV7LJULTOvN3lu2fU09l_CObMEEtO8KXZtYn7cfJR1DyUb4h2uZcj9Qf7y4SbtVyZbmLUTX2vlkhoiOfEQHfKpu5epQqOwOK5psd7AB3OGXJ1TCSCjXaxPfDPoV55ckaq2HNVSqzj3jBE0rWknlyQKoCVwuaoxqtw
- name: jenkinsprod
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJqZW5raW5zcHJvZC10b2tlbi1jeHFkNiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJqZW5raW5zcHJvZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImUxMGE1NjM5LWM1Y2ItMTFlOS1iODk2LTAwNTA1Njg4Y2UzYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpqZW5raW5zcHJvZCJ9.NnhPffcG3vjKebZ5BnHc6cYATN-HsJTCopMEycYgYQfmk7q6s92QpZmyZhETn2AWbdRx0oMw-eVmkn8VoDtqc83oOr9zfK7Q3qE3-lU01Vg8VvMhRdyM-Xu4hoZzAqTLtKj9WBCQBpi0Co_ZN9p1mdr3zZvXGZBPFAAE1vFczrQMIjrY9YF8ekSxioljBRAFlhonR-M3ReyJfDLif-96_1wTCQ5lieeb1fO7_eCzqLpOGh5dKK0TdRVy5a8mII_CVFPqStwtmc8tGExZc1iYUR5E9rjpVaytV9NHfsStjuIitGcYKj2Hc0jVH-8LU1Rdgy-f7oJOfmD418SSvbfp3w
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrekNDQWVPZ0F3SUJBZ0lVWHVsbk1kZ2ZEMSsyWXJIYzdhVjBxK1VxVVRBd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0RURUxNQWtHQTFVRUF4TUNZMkV3SGhjTk1Ua3dNVEkwTWpJME16QTNXaGNOTWpBd01USTBNakkwTXpBMwpXakFOTVFzd0NRWURWUVFERXdKallUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCCkFMdHVnZG8wN0pIa2lLRWJ4a2xnQmFBeDNaS3puZXgxOEM2bU9VbE1Bd2NLcGQ0UlJDK1F3SDd2Y0ZBZUtvcGsKQUViSHJsTkQ1MXVRTlNyamVZT1hZUDh6ZUJybGUyazhzVkRWVUQvMWk4TnVoSGpxdHZEb3Y2WkNabUZYcCtBSgo2R1J6UjlZY1RWSkU3VmNNczVpRWxBV01qVmhXZkxXYjd3SEp2ZzVXMmt6SnRvODZDWVF3QTcrQmdYRElnd2g3CkRlV1BuTlJFcmpPbnNMQWlqSnZ5L0JPeFN2em1PMVdxWFdRSStvanhZb1RzaGQyaHVWT3RZaVNFenc1SEk1UXkKVHRRSytadEZxWmJtQStLd1JzWXZKQWF1TElGSVd6d0JVV0dsb1Bjd3pkbGRlcTJVRlV2bzNJTDNZTElzTnAyagpSUFNnbTRQdGE3L1VmTDdlOE1TTTRqVUNBd0VBQWFOVE1GRXdIUVlEVlIwT0JCWUVGQStXbytwY0gvR0tPZjd5CklvMHIyTFVHRlBnWk1COEdBMVVkSXdRWU1CYUFGQStXbytwY0gvR0tPZjd5SW8wcjJMVUdGUGdaTUE4R0ExVWQKRXdFQi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFJcXlvRWlWME01Tk14VnhFb2Nvb2U0KwpDcFRTRXdReFdxaDVSeFFBUUs1RjZzaDB2bWtyZ2JmV085RTBWZ2ZDZWd3SHhwNWNOdVU2cFRSaWNFNG9EZ1lsCjg5V203REtQMU9vUy9Jb1FqLzNTQ2dVKyt0TDBSTUhMbE94b3lKNVpNRTZOeEQyTHJBNmdyY0wwOWxDVkprZDgKWm9XTzdnWW1JL3o3VTkrNWM4VlBjWnVsQ0tRM3N1dUJPa2xmeFdEcmFqTmNCNFdBWmV0MGpCQkVpMlhOUW01RApCTkZUYVIwcDIxbnpOcHNBazJMckh5WEV1RUUvVFpNNEZOYmhQTkJOM1NXQUllVkcweDlDKzIrZXkrQlZCaXljCnkyUnlXSDg4c2ZtQkNxMzBFMkt3aVNuZHFMazlVN2l4QlVKZy8xWEtOd1BjVStXa1VVUnBnODJjNjNQUlA1dz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQoKLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrekNDQWVPZ0F3SUJBZ0lVZmZoaUt3SENMek9aNzJjRFhISHpZc3ByazVJd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0RURUxNQWtHQTFVRUF4TUNZMkV3SGhjTk1Ua3dNVEkwTWpJME16QTVXaGNOTWpNd01USTBNakkwTXpBNQpXakFOTVFzd0NRWURWUVFERXdKallUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCCkFNSWtyRi82THk5bXl2YkROY2ZtUGJnb1hHSXNnYWJ6KzFRZjFXN2cvckprS1pBYzVwOFhJeDgxUW9CTk13UG0KZ3o4TTI4cHlIWlhBVWpUKytzbjlzZDVhMjdUMnRWdlN4TzZJREErbjl1QTBrMFFVVVhHTzZTOFBVaXVkVGVyZwo3V0lwYzdmS0Y1cHRKV0o2Vi96alJibnRCcWEyWVpzMUlKaWRaQ2hGMkdvL29MYmo3b1ZIV3VlUTl6dHl0a1UyClphaXRNYzc0dTl1eHErKzVrL3lVOExOdFdBOW15QXpRb1hseU9CMlpISE5KMzRBVE9raUowcmVXY2tEMHRuSzYKNGJoMk1XZXprV1dpd1VobXYyajMrZXNrSWhSUGE5ditmZXB6Z3cxR3htZzZpbjRTMnRQZXhTaHYwd3M5YjJORwpJZ3RyT3AyRWU4TENtNWdLMmxxb1NYTUNBd0VBQWFOVE1GRXdIUVlEVlIwT0JCWUVGTFdSOVl1QlpUSUsyZlB2Cmhzckx3WnlkS0hSb01COEdBMVVkSXdRWU1CYUFGTFdSOVl1QlpUSUsyZlB2aHNyTHdaeWRLSFJvTUE4R0ExVWQKRXdFQi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFGZFFJVGtNL2lVUDIxSDF5M2FLanNZego3b2ZlR29iUXYzZnFwYWVKT20yYzd2UG9KbEROa3VabjM3OGhMZWFIK1MwdW1zdzNlbzlNc0xHQktTc2wrakhWCkdhd1dIakhMLzQ2MjhnZVdsWTZUNEtHS2kwL2huNHJ1NmVQNTFaRDRHUG5WMWo3OHc4cFZxQkc4QVA2QTVTZlgKL1I3bkpQZmhsMXFTL0xGelJrWml3V0c0QWM3enhZa0JlTitNMytXdG8vWUFxOFJFZWNOSkYwYjFFRDd3SVVrdgpwOGxvdkIzV1pzeGFWQk1qUml3eGl6K3N0ZU8ySmQrT3VrY2ZrellMbldTSFd6Q3UvRm1vYm10cVFEa0tvYm5ZClFKVitpRUNTejJtRG9ISFdldmNkekxpbkdpdWluV3BFRDcrazJLOUJUaHBBcmpuVjllL2JmWC9wU1QvejZ4UT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    server: https://my-cluster.corp.local:8443
  name: my-cluster
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrekNDQWVPZ0F3SUJBZ0lVWHVsbk1kZ2ZEMSsyWXJIYzdhVjBxK1VxVVRBd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0RURUxNQWtHQTFVRUF4TUNZMkV3SGhjTk1Ua3dNVEkwTWpJME16QTNXaGNOTWpBd01USTBNakkwTXpBMwpXakFOTVFzd0NRWURWUVFERXdKallUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCCkFMdHVnZG8wN0pIa2lLRWJ4a2xnQmFBeDNaS3puZXgxOEM2bU9VbE1Bd2NLcGQ0UlJDK1F3SDd2Y0ZBZUtvcGsKQUViSHJsTkQ1MXVRTlNyamVZT1hZUDh6ZUJybGUyazhzVkRWVUQvMWk4TnVoSGpxdHZEb3Y2WkNabUZYcCtBSgo2R1J6UjlZY1RWSkU3VmNNczVpRWxBV01qVmhXZkxXYjd3SEp2ZzVXMmt6SnRvODZDWVF3QTcrQmdYRElnd2g3CkRlV1BuTlJFcmpPbnNMQWlqSnZ5L0JPeFN2em1PMVdxWFdRSStvanhZb1RzaGQyaHVWT3RZaVNFenc1SEk1UXkKVHRRSytadEZxWmJtQStLd1JzWXZKQWF1TElGSVd6d0JVV0dsb1Bjd3pkbGRlcTJVRlV2bzNJTDNZTElzTnAyagpSUFNnbTRQdGE3L1VmTDdlOE1TTTRqVUNBd0VBQWFOVE1GRXdIUVlEVlIwT0JCWUVGQStXbytwY0gvR0tPZjd5CklvMHIyTFVHRlBnWk1COEdBMVVkSXdRWU1CYUFGQStXbytwY0gvR0tPZjd5SW8wcjJMVUdGUGdaTUE4R0ExVWQKRXdFQi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFJcXlvRWlWME01Tk14VnhFb2Nvb2U0KwpDcFRTRXdReFdxaDVSeFFBUUs1RjZzaDB2bWtyZ2JmV085RTBWZ2ZDZWd3SHhwNWNOdVU2cFRSaWNFNG9EZ1lsCjg5V203REtQMU9vUy9Jb1FqLzNTQ2dVKyt0TDBSTUhMbE94b3lKNVpNRTZOeEQyTHJBNmdyY0wwOWxDVkprZDgKWm9XTzdnWW1JL3o3VTkrNWM4VlBjWnVsQ0tRM3N1dUJPa2xmeFdEcmFqTmNCNFdBWmV0MGpCQkVpMlhOUW01RApCTkZUYVIwcDIxbnpOcHNBazJMckh5WEV1RUUvVFpNNEZOYmhQTkJOM1NXQUllVkcweDlDKzIrZXkrQlZCaXljCnkyUnlXSDg4c2ZtQkNxMzBFMkt3aVNuZHFMazlVN2l4QlVKZy8xWEtOd1BjVStXa1VVUnBnODJjNjNQUlA1dz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQoKLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrekNDQWVPZ0F3SUJBZ0lVZmZoaUt3SENMek9aNzJjRFhISHpZc3ByazVJd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0RURUxNQWtHQTFVRUF4TUNZMkV3SGhjTk1Ua3dNVEkwTWpJME16QTVXaGNOTWpNd01USTBNakkwTXpBNQpXakFOTVFzd0NRWURWUVFERXdKallUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCCkFNSWtyRi82THk5bXl2YkROY2ZtUGJnb1hHSXNnYWJ6KzFRZjFXN2cvckprS1pBYzVwOFhJeDgxUW9CTk13UG0KZ3o4TTI4cHlIWlhBVWpUKytzbjlzZDVhMjdUMnRWdlN4TzZJREErbjl1QTBrMFFVVVhHTzZTOFBVaXVkVGVyZwo3V0lwYzdmS0Y1cHRKV0o2Vi96alJibnRCcWEyWVpzMUlKaWRaQ2hGMkdvL29MYmo3b1ZIV3VlUTl6dHl0a1UyClphaXRNYzc0dTl1eHErKzVrL3lVOExOdFdBOW15QXpRb1hseU9CMlpISE5KMzRBVE9raUowcmVXY2tEMHRuSzYKNGJoMk1XZXprV1dpd1VobXYyajMrZXNrSWhSUGE5ditmZXB6Z3cxR3htZzZpbjRTMnRQZXhTaHYwd3M5YjJORwpJZ3RyT3AyRWU4TENtNWdLMmxxb1NYTUNBd0VBQWFOVE1GRXdIUVlEVlIwT0JCWUVGTFdSOVl1QlpUSUsyZlB2Cmhzckx3WnlkS0hSb01COEdBMVVkSXdRWU1CYUFGTFdSOVl1QlpUSUsyZlB2aHNyTHdaeWRLSFJvTUE4R0ExVWQKRXdFQi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFGZFFJVGtNL2lVUDIxSDF5M2FLanNZego3b2ZlR29iUXYzZnFwYWVKT20yYzd2UG9KbEROa3VabjM3OGhMZWFIK1MwdW1zdzNlbzlNc0xHQktTc2wrakhWCkdhd1dIakhMLzQ2MjhnZVdsWTZUNEtHS2kwL2huNHJ1NmVQNTFaRDRHUG5WMWo3OHc4cFZxQkc4QVA2QTVTZlgKL1I3bkpQZmhsMXFTL0xGelJrWml3V0c0QWM3enhZa0JlTitNMytXdG8vWUFxOFJFZWNOSkYwYjFFRDd3SVVrdgpwOGxvdkIzV1pzeGFWQk1qUml3eGl6K3N0ZU8ySmQrT3VrY2ZrellMbldTSFd6Q3UvRm1vYm10cVFEa0tvYm5ZClFKVitpRUNTejJtRG9ISFdldmNkekxpbkdpdWluV3BFRDcrazJLOUJUaHBBcmpuVjllL2JmWC9wU1QvejZ4UT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    server: https://prod-cluster.corp.local:8443
  name: prod-cluster
contexts:
- context:
    cluster: my-cluster
    user: jenkins
  name: my-cluster
- context:
    cluster: prod-cluster
    user: jenkinsprod
  name: prod-cluster
```


9.4 Login to the ubuntuvm and change user

```bash
 cd ~/ubuntuvm/
 ssh -i "ubuntuvm.pem" ubuntu@192.168.100.111
 sudo su - jenkins
```


9.5 Create a .kube 

```bash
cd ~
mkdir .kube
cd .kube
```

9.6 Create a .config file, that contains the above contents. This is used by jenkins to connect to the pks clusters


```bash
vi config
```

Paste the contents that was created in step 9.3

9.7 Check if the clustes are reachable

```bash
kubectl config use-context my-cluster
```
Should result in 

```bash
Switched to context "my-cluster".
```

9.10 Check for prod-cluster as well

```bash
kubectl config use-context prod-cluster
```
Should result in 

```bash
Switched to context "prod-cluster".
```

## Step 10: Create your first Jenkins pipeline to deploy the plane spotter application

10.1 Login to the jenkins webapplciation using the following url http://IPOFJENKINSVM:8080

10.2 Go to Credentials --> System --> Global Credentials 

<details><summary>Screenshot 10.2</summary>
<img src="Images/globalcreds.png">
</details>
<br/>  

10.3 Click on Add Credentials. Select Kind as SSH Username with private key 

<details><summary>Screenshot 10.3</summary>
<img src="Images/addcrd.png">
</details>
<br/>  


10.4 Enter the ID (Eg. gitjenkins) , username (Eg gitjenkins) and select Provate Key as enter directly --> Add and paste the private key below. This allows an ssh into git so we could pick up the deployment yamls or helm charts from there.


```config
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCKimLS2N6zQR9TQmtNqdFc0EBGB2FpZm5O85NY/gqcDQAAAJjOKCduzign
bgAAAAtzc2gtZWQyNTUxOQAAACCKimLS2N6zQR9TQmtNqdFc0EBGB2FpZm5O85NY/gqcDQ
AAAEDfEm7of4/FZv5XMAWOBrpV/g2pholxoA2w00xvOc4Z5YqKYtLY3rNBH1NCa02p0VzQ
QEYHYWlmbk7zk1j+CpwNAAAAEWVtYWlsQGV4YW1wbGUuY29tAQIDBA==
-----END OPENSSH PRIVATE KEY-----
```


<details><summary>Screenshot 10.4</summary>
<img src="Images/gitcreds.png">
</details>
<br/>  

10.5 Click on the Jenkins Menu 
Click on New Item. Enter Item Name as DeployPlanespotter and select Freestyle project and click on OK



10.6 In the resultant screen
Enter a Description
Select this project is parameterized
Select Choice Parameters (This parameter block will deletermine which target cluster to deploy to)
Enter Choice Parameter Name as TargetEnvironment
Enter Choices as 

```config
prod-cluster
my-cluster
```


<details><summary>Screenshot 10.6.1</summary>
<img src="Images/general.png">
</details>
<br/>  

Add a second parameter block  of type Choice Parameter (This parameter will control what to deploy into the target environment) 
Enter the Choice Parameter name as DeploymentArtifact
Enter Choices as 

```config
all
app-server-deployment_all_k8s.yaml
frontend-deployment_all_k8s.yaml
redis_and_adsb_sync_all_k8s.yaml
storage_class.yaml
mysql_claim.yaml
mysql_pod.yaml

```

<details><summary>Screenshot 10.6.2</summary>
<img src="Images/parameters.png">
</details>
<br/>  

Select the Source Code Management as git (this is where we will be using the credentials we used in the previous step). 
Enter repository url as https://github.com/riazvm/planespotterCloud.git
From the credentials dropdown select the user created in Step 10.4 (Eg. gitjenkins)

<details><summary>Screenshot 10.6.3</summary>
<img src="Images/sourcecode.png">
</details>
<br/>  

In the Build section select Execute Script
Add the following to the scipt 


```bash
#!/bin/bash -xe
set +e 
if [ "${DeploymentArtifact}" == "all" ]
then 
kubectl config use-context ${TargetEnvironment}
kubectl get po --all-namespaces
kubectl create ns planespotter
kubectl apply -f ./planespotter-master/kubernetes/app-server-deployment_all_k8s.yaml
kubectl apply -f ./planespotter-master/kubernetes/frontend-deployment_all_k8s.yaml
kubectl apply -f ./planespotter-master/kubernetes/storage_class.yaml
kubectl apply -f ./planespotter-master/kubernetes/mysql_claim.yaml
kubectl apply -f ./planespotter-master/kubernetes/mysql_pod.yaml
kubectl apply -f ./planespotter-master/kubernetes/redis_and_adsb_sync_all_k8s.yaml
kubectl expose deployment planespotter-frontend --name=planespotter-frontend-lb --port=80 --target-port=80 --type=LoadBalancer --namespace=planespotter
kubectl get po --all-namespaces
else 
kubectl config use-context ${TargetEnvironment}
kubectl apply -f ./planespotter-master/kubernetes/${DeploymentArtifact}
fi

```

Apply and Save

<details><summary>Screenshot 10.6.4</summary>
<img src="Images/buildscript.png">
</details>
<br/>  


10.7 Click on Build with Parameters
Select Target Environment to prod-cluster and DeploymentArtifact to All and click on Build 

<details><summary>Screenshot 10.8</summary>
<img src="Images/buildwithparam.png">
</details>
<br/>  

10.9 Click on the Build number under Build History


<details><summary>Screenshot 10.9</summary>
<img src="Images/buildno.png">
</details>
<br/>  

<details><summary>Screenshot 10.9.1</summary>
<img src="Images/buildnodet.png">
</details>
<br/>  

10.10 Click on Console Output . Check the deployment logs


<details><summary>Screenshot 10.10</summary>
<img src="Images/console.png">
</details>
<br/>  

Here we have seen how to deploy the complete Planespotter applcication including the database and PV

10.11 We will now create the storage class , create a pv and deploy the mysql pods to my-cluster

Click on DeployPlanespotter and click on Build with Parameters

10.12 Select my-cluster as the Target Environment and storage_class.yaml as the Deployment Artifact and click on Build

<details><summary>Screenshot 10.12</summary>
<img src="Images/myclusterbuild.png">
</details>
<br/>  

10.13 Check the console output for the build. The storage class should be created

<details><summary>Screenshot 10.13</summary>
<img src="Images/myclusterconsole.png">
</details>
<br/>  


10.14 Similarly deploy the mysql_claim and mysql_pod to my-cluster

10.15 Login to the cli-vm and check the pods running on both prod-cluster and my-cluster

<details><summary>Screenshot 10.15.1</summary>
<img src="Images/podstatus.png">
</details>
<br/>  






