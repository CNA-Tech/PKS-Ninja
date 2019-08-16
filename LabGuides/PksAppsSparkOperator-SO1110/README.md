# Setting up HDFS and running Spark Jobs using Spark Operator

## Overview
This guide walks though setting up HDFS and running a word count java spark application in PKS using a spark operator


## HDFS
A distributed Java-based file system for storing large volumes of data, HDFS and YARN form the data management layer of Apache Hadoop. YARN is the architectural center of Hadoop, the resource management framework that enables the enterprise to process data in multiple ways simultaneously—for batch, interactive and real-time data workloads on one shared dataset. YARN provides the resource management and HDFS provides the scalable, fault-tolerant, cost-efficient storage for big data.

HDFS is a Java-based file system that provides scalable and reliable data storage, and it was designed to span large clusters of commodity servers. HDFS has demonstrated production scalability of up to 200 PB of storage and a single cluster of 4500 servers, supporting close to a billion files and blocks. When that quantity and quality of enterprise data is available in HDFS, and YARN enables multiple data access applications to process it, Hadoop users can confidently answer questions that eluded previous data platforms.

HDFS is a scalable, fault-tolerant, distributed storage system that works closely with a wide variety of concurrent data access applications, coordinated by YARN. HDFS will “just work” under a variety of physical and systemic circumstances. By distributing storage and computation across many servers, the combined storage resource can grow linearly with demand while remaining economical at every amount of storage.

## Spark Operator

The Kubernetes Operator for Apache Spark aims to make specifying and running Spark applications as easy and idiomatic as running other workloads on Kubernetes. It uses Kubernetes custom resources for specifying, running, and surfacing status of Spark applications. For a complete reference of the custom resource definitions, please refer to the API Definition. For details on its design, please refer to the design doc. It requires Spark 2.3 and above that supports Kubernetes as a native scheduler backend.

There are two methods for Spark to interact with Kubernetes and both are experimental or in Beta (although several organizations are using them in production).
Spark-Submit.
Kubernetes Spark Operator.
Spark-Submit:
With Spark 2.3 and above, Spark can run clusters managed by Kubernetes using native Kubernetes scheduler. 
Spark jobs submitted to Kubernetes clusters using spark-submit CLI, similar to submitting to Yarn or Apache Mesos. 
Lacking management and monitoring functionality. Spark 3.0 will close the gap
Limited capabilities regarding Spark job management,

Kubernetes Operator for Spark:
The Operator tries to provide useful tooling around spark-submit to make running Spark jobs on Kubernetes easier in a production setting
A suite of tools for running Spark jobs on Kubernetes.
The implementation is based on the typical Kubernetes operator pattern.
It uses spark-submit under the hood and hence depends on it.
Supports mounting volumes and ConfigMaps in Spark pods to customize them, a feature that is not available in Apache Spark as of version 2.4.
Provides a useful CLI to manage jobs.


The Kubernetes Operator for Apache Spark currently supports the following list of features:

- Supports Spark 2.3 and up.
- Enables declarative application specification and management of applications through custom resources.
- Automatically runs spark-submit on behalf of users for each SparkApplication eligible for submission.
- Provides native cron support for running scheduled applications.
- Supports customization of Spark pods beyond what Spark natively is able to do through the mutating admission webhook, e.g., mounting ConfigMaps and volumes, and setting pod affinity/anti-affinity.
- Supports automatic application re-submission for updated SparkAppliation objects with updated specification.
- Supports automatic application restart with a configurable restart policy.
- Supports automatic retries of failed submissions with optional linear back-off.
- Supports mounting local Hadoop configuration as a Kubernetes ConfigMap automatically via sparkctl.
- Supports collecting and exporting application-level metrics and driver/executor metrics to Prometheus.


## Helm
Helm is a tool that streamlines installing and managing Kubernetes applications. Think of it like apt/yum/homebrew for Kubernetes.

- Helm has two parts: a client (helm) and a server (tiller)
- Tiller runs inside of your Kubernetes cluster, and manages releases (installations) of your charts.
- Helm runs on your laptop, CI/CD, or wherever you want it to run.
- Charts are Helm packages that contain at least two things:
    A description of the package (Chart.yaml)
    One or more templates, which contain Kubernetes manifest files
    Charts can be stored on disk, or fetched from remote chart repositories (like Debian or RedHat packages)

## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment
- PKS Install (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PksInstallPhase2-IN1916)
- PKS Cluster (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610)

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.3 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-3E0C4CEC-D593-4395-84C4-150CD6285963.html)


### Overview of Tasks Covered in Lab 

- [Step 1: Create Ubuntu VM](#step-1--Create-Ubuntu-VM)
- [Step 2: Setup Standalone HDFS](#step-2--Setup-Standalone-HDFS )
- [Step 3: Start the HDFS Cluster](#step-3--Start-the-HDFS-Cluster)
- [Step 4: Creating the environment to run spark](#step-4--Creating-the-environment-to-run-spark)
- [Step 5: Deploy Spark Operator](#step-5--Deploy-Spark-Operator)
- [Step 6: The Word Counter Spark Project](#step-6--The-Word-Counter-Spark-Project)
- [Step 7: Run Word count sample in PKS using spark operator](#step-7--Run-Word-Count-sample-in-PKS-using-spark-operator)
-----------------------

## Step 1: Create Ubuntu VM

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

## Step 2: Setup Standalone HDFS

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

127.0.0.1 localhost ubuntuguestvm1
192.168.100.111 ubuntuguestvm1
```



 2.4 Update Packagelist

```bash
sudo apt-get update
```

2.5 Install Open JDK

```bash
sudo apt-get install default-jdk
```

2.6 Setup passwordless SSH

```bash
sudo apt-get install openssh-server openssh-client 
```
2.7 Generate Public and Private Key Pairs with the following command.  Use all default values

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

2.8 Verify the password-less ssh configuration

```bash
ssh localhost
exist
```

2.9  Install Hadoop
Go to http://hadoop.apache.org/releases.html and get the download link for the latest Hadoop distro
Eg: http://mirrors.gigenet.com/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz


```bash
mkdir hdfs
cd ~/hdfs
wget http://mirrors.gigenet.com/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
```

2.10 Extract tar

```bash
tar -xzvf hadoop-3.1.2.tar.gz
```

2.11 Move Hadoop to the usr/local directory 

```bash
sudo mv hadoop-3.1.2 /usr/local/hadoop
```


2.12 Configure Hadoop JAVA HOME

To find the default java path run the followin command

```bash
readlink -f /usr/bin/java | sed "s:bin/java::"
```

2.13 Edit hadoop-env.sh to include the java path

```bash
sudo nano /usr/local/hadoop/etc/hadoop/hadoop-env.sh
```
Include to the end of the file the java path from the previous step

```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
```

2.14 Setup the following Environment variables .


```bash
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/usr/local/hadoop/etc/hadoop"}
```

Source the .bashrc in current login session


```bash
source ~/.bashrc
```


2.15 Update Configuration files. All files are under /usr/local/hadoop/etc/hadoop

Note: Change ip where required

2.15.1 Update core-site.xml

<details><summary>core-site.xml</summary>

```xml
<configuration>
	<property>
	<name>fs.defaultFS</name>
	<value>hdfs://192.168.100.111:9000</value>
	</property>
	<property>
	<name>hadoop.tmp.dir</name>
	<value>/home/ubuntu/hdfs/hadooptmpdata</value>
	</property>

</configuration>

```
</details>
<br/>

2.15.2 Create a hadooptmpdata directory under /usr/local/hadoop. 


```bash
mkdir /usr/local/hadoop/hadooptmpdata
```
 
2.15.3 Update hdfs-site.xml

<details><summary>hdfs-site.xml</summary>

```xml
<configuration>
        <property>
			<name>dfs.replication</name>
			<value>1</value>
			<name>dfs.name.dir</name>
			<value>file:///home/ubuntu/hdfs/namenode</value>
			<name>dfs.data.dir</name>
			<value>file:///home/ubuntu/hdfs/datanode</value>
		</property>
</configuration>
```
</details>
<br/>

2.15.4 Create a hdfs/namenode and hdfs/datanode directory under the user home (Eg. /home/ubuntu)


```bash
mkdir -p /home/ubuntu/hdfs/namenode
mkdir -p /home/ubuntu/hdfs/datanode
```

2.15.5 Update mapred-site.xml

<details><summary>mapred-site.xml</summary>

```xml
<configuration>
        <property>
			<name>mapreduce.framework.name</name>
			<value>yarn</value>
		</property>
</configuration>

```
</details>
<br/>

2.15.6 Update yarn-site.xml

<details><summary>yarn-site.xml</summary>

```xml
<configuration>

<!-- Site specific YARN configuration properties -->
	<property>
		<name>mapreduceyarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
	</property>
</configuration>


```
</details>
<br/>

## Step 3: Start the HDFS Cluster

3.1 Format the namenode before using it for the first time. As HDFS user run the below command to format the Namenode.

```bash
hdfs namenode -format
```

3.2 Start HDFS

Navigate to /usr/local/hadoop/sbin

```bash
./start-dfs.sh
```

3.3 Start Yarn

```bash
./start-yarn.sh
```

3.4 Check Daemon status

```bash
jps
```

<details><summary>Screenshot 3.4</summary>
<img src="Images/jps.png">
</details>
<br/> 

### 4 Creating the environment to run spark

4.1 Create a hdfs input and output directory and a jar directory to store the SparkTestApp-1.0.jar

```bash
hdfs dfs -mkdir -p /home/ubuntu/hdfs/input
hdfs dfs -mkdir -p /home/ubuntu/hdfs/output
hdfs dfs -mkdir -p /home/ubuntu/hdfs/jars
hdfs dfs -chown -R root /home/ubuntu/hdfs
```

4.2 Clone the sparkwordcountonk8 git repository

```bash
cd ~/hdfs
git clone https://github.com/riazvm/sparkwordcountonk8.git
```

4.3 Copy SparkTestApp/pks.txt to hdfs input dir

```bash
  hdfs dfs -put ~/hdfs/sparkwordcountonk8/SparkTestApp/pks.txt /home/ubuntu/hdfs/input
```

4.4 Copy SparkTestApp/build/libs/SparkTestApp-1.0.jar to hdfs jar dir

This is from where we will be running our spark job in K8

```bash
 hdfs dfs -put SparkTestApp-1.0.jar /home/ubuntu/hdfs/jars
```

## Step 5: Deploy Spark Operator

5.1 SSH to the cli-vm

5.2 Login to pks  

```bash
pks login -a pks.corp.local -u pksadmin --skip-ssl-validation
pks get-credentials my-cluster
```

5.3 Download and install the [Helm CLI](https://github.com/helm/helm/releases) if you haven't already done so.
  
5.4 Create a service account for Tiller and bind it to the cluster-admin role. 


```bash
kubectl create serviceaccount --namespace kube-system tiller

kubectl create clusterrolebinding tiller-clusterrolebinding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
```

5.5 Deploy Helm using the service account by running the following command:

```bash
helm init --service-account tiller
```

5.6 Download the latest helm charts from GIT

```bash
git clone https://github.com/helm/charts.git
```

5.7 Create namespaces for sparkoperator to run in and a spark-jobs namespace on which the spark jobs would run.

```bash
kubectl create ns spark-operator
kubectl create ns spark-jobs
```


5.8 Deploy the spark operator

Navigate to /charts

The Helm chart has a configuration option called sparkJobNamespace which defaults to default. For example, If you would like to run your Spark job in another namespace called spark-operator, then first make sure it already exists and then install the chart with the command

```bash
helm install --name=sparkv1 incubator/sparkoperator --namespace spark-operator --set sparkJobNamespace=spark-jobs --set serviceAccounts.spark.name=spark
```
<details><summary>Screenshot 5.8</summary>
<img src="Images/sparkoperator.png">
</details>
<br/> 



## Step 6: The Word Counter Spark Project
 
6.1 The project SparkTestApp contains a java spark application called MyWordCounter. It can be found under https://github.com/riazvm/sparkwordcountonk8

Create a jar file of the project. Build the project using gradle clean build command , this will create a SparkTestApp-1.0.jar

The pks.txt file contains a sample file which will be processed by the Word Counter program to output the number of instances each word occurs in the file


### Step 7: Run Word count sample in PKS using spark operator

7.1 Define the Spark Application deployment
     Copy the below contents to a file spark-word.yml . This yaml defines a Spark application . 
     metadata:name - name of applciation
     metadata:namespace - namespace that the spark job will run in. This will be the same as the one defined when we created the spark operator
     spec:type - The Spark application is written in Java 
     spec:mainClass - Mainclass along with Packagename
     mainApplicationFile - The main Spark Class to be executed. Replace the ip with the HDFS host ip
     arguments - we pass the input directory as the first argument in which the pks.txt file exists and the output directory as the second argument. Ip's need to be changed as per the HDFS host
     Note: This can be a local directory that is accessible to all nodes in the cluster Eg: NFS
     Can be S3 or http as well
     arguments - Change the ip's to the HDFS host. Here we pass two arguments one for the input directory and the other for the output. 

<details><summary>spark-w.yml</summary>


```yml
apiVersion: "sparkoperator.k8s.io/v1beta1"
kind: SparkApplication
metadata:
  name: spark-w
  namespace: spark-jobs
spec:
  type: Java
  mode: cluster
  image: "gcr.io/spark-operator/spark:v2.4.0"
  imagePullPolicy: Always
  mainClass: com.test.sprak.k8.sample.MyWordCounter
  mainApplicationFile: "hdfs://192.168.100.111:9000/home/ubuntu/hdfs/jars/SparkTestApp-1.0.jar"
  arguments:
    - "hdfs://192.168.100.111:9000/home/ubuntu/hdfs/input"
    - "hdfs://192.168.100.111:9000/home/ubuntu/hdfs/output/k8-"
  sparkVersion: "2.4.0"
  restartPolicy:
    type: Never
  volumes:
    - name: "test-volume"
      hostPath:
        path: "/tmp"
        type: Directory
  driver:
    cores: 0.1
    coreLimit: "200m"
    memory: "512m"
    labels:
      version: 2.4.0
    serviceAccount: spark
    volumeMounts:
      - name: "test-volume"
        mountPath: "/tmp"
  executor:
    cores: 1
    instances: 1
    memory: "512m"
    labels:
      version: 2.4.0
    volumeMounts:
      - name: "test-volume"
        mountPath: "/tmp"

```


</details>
<br/>

7.2 Run the spark-word applciation
    Running the  command will create a SparkApplication object named spark-w

```bash
 kubectl apply -f spark-w.yml
```

7.3 Set context to spark-jobs namespace

```bash
 kubectl config set-context my-cluster --namespace spark-jobs
```
7.4 Check the object by running the following command:

```bash
kubectl get sparkapplications spark-w -o=yaml
```
7.5 To check events for the SparkApplication object, run the following command

```bash
kubectl describe sparkapplication spark-w
```

<details><summary>Screenshot 7.5</summary>
<img src="Images/sparkjobs.png">
</details>
<br/> 



7.6 To check pods running

```bash
kubectl get po --all-namespaces
```
<details><summary>Screenshot 7.6</summary>
<img src="Images/sparkpo.png">
</details>
<br/> 

7.7 To check logs

```bash
kubectl logs spark-w-driver 
```
<details><summary>Screenshot 7.7</summary>
<img src="Images/sparkcomp.png">
</details>
<br/> 

7.8 Check if the output was sucessful

```bash
hdfs dfs -ls /home/ubuntu/hdfs/output
```
 
 You should find a k8-<timestamp directory>