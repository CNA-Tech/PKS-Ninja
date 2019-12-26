# PKS Installation with VMware Enterprise PKS Management Console

**Table of Contents**

- [PKS Installation with VMware Enterprise PKS Management Console](#pks-installation-with-vmware-enterprise-pks-management-console)
  - [Lab Access Instructions](#lab-access-instructions)
  - [Prerequisites](#prerequisites)
  - [Install PKS 1.6 with Enterprise PKS Management Console (EPMC)](#install-pks-16-with-enterprise-pks-management-console-epmc)
    - [Step 1: Download EPMC OVF File](#step-1-download-epmc-ovf-file)
    - [Step 2: Deploy the EPMC OVF File](#step-2-deploy-the-epmc-ovf-file)
    - [Step 3: Complete the installation workflow](#step-3-complete-the-installation-workflow)

## Lab Access Instructions

Please see [Getting Access to a Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.6/Courses/GetLabAccess-LA8528) for instructions on accessing lab environments.

Please see the prerequisites section below for mandatory steps you will need to follow to complete this lab guide.

## Prerequisites

This lab guide is designed for the PKS-Ninja-T1-NsxtInstalled Template. If you prefer to install NSX-T yourself, you can load the PKS-Ninja-T1-Baseline template and complete the [NSX-T Manual Installation Lab Guide](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.6/LabGuides/NsxtManualInstall-IN1497). 


## Install PKS 1.6 with Enterprise PKS Management Console (EPMC)

Please be sure to complete the requirements in the [Prerequisites](#prerequisites) section above before proceeding.

### Step 1: Download EPMC OVF File

1.1 Users of this lab will need to use their own access to download the files for EPMC. Please download the EPMC OVA file to control center before proceeding.

### Step 2: Deploy the EPMC OVF File

2.1 From the ControlCenter desktop, open chrome, connect to the vSPhere web client and login using the windows system credentials checkbox. Navigate to the `Hosts and Clusters` page, expand `RegionA01`, right click on the resource pool `pks-mgmt-1` and select `Deploy OVF Template`

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-12-05-16-49-14.png">
</details>
<br/>

2.2  Select the EPMC OVF File from the location where you downloaded it and click `Next`. The default download location is `E:\Downloads`.

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-11-21-14-15-03.png">
</details>
<br/>

2.3 On the `Select Name and Folder` page, set the `Virtual Machine Name` to `epmc-01a` and click `Next`

<details><summary>Screenshot 2.3</summary>
<img src="Images/2019-08-24-00-10-05.png">
</details>
<br/>

2.4 On the `Select a compute resource` page, expand `RegionA01-MGMT01` and select the `pks-mgmt-1` resource pool and click `Next`.


<details><summary>Screenshot 2.4</summary>
<img src="Images/2019-08-24-00-43-31.png">
</details>
<br/>

2.5 On the `Review Details` page, verify the details and click `Next`.

<details><summary>Screenshot 2.5</summary>
<img src="Images/2019-11-21-14-17-30.png">
</details>
<br/>

2.6 On the `License Agreements` page, check the `I accept all license agreements` checkbox and click `Next`.

<details><summary>Screenshot 2.6</summary>
<img src="Images/2019-08-24-00-15-05.png">
</details>
<br/>


2.7 On the `Select Storage` page, **First** select the `RegionA01-ISCSI02-COMP01` datastore, and then set the `virtual disk format` to `Thin Provision` and click `Next`.

<details><summary>Screenshot 2.7</summary>
<img src="Images/2019-08-24-00-17-25.png">
</details>
<br/>

2.8 On the `Select networks` page, set the `VM Network` to `VM-RegionA01-vDS-MGMT` and click `Next`.

<details><summary>Screenshot 2.8</summary>
<img src="Images/2019-08-24-16-17-55.png">
</details>
<br/>

2.9 On the `Customize template` page, enter the following values: (leave any unspecified values to their default setting)

- Root Password: `VMware1!`
- Permit Root Login: `True`
- Network IP Address: `192.168.110.28`
- Network Netmask: `255.255.255.0`
- Default Gateway: `192.168.110.1`
- Domain Name Servers: `192.168.110.10`
- Domain Search Path: `corp.local`
- FQDN: `epmc-01a.corp.local`
- Log Insight Server Host/IP: `vrli-01a.corp.local`
- Click `Next`

<details><summary>Screenshot 2.9</summary>
<img src="Images/2019-11-22-22-33-25.png">
</details>
<br/>

2.10 On the `Ready to complete` page, review the details and click `Finish`

<details><summary>Screenshot 2.10</summary>
<img src="Images/2019-08-24-00-28-47.png">
</details>
<br/>

2.11 On the Control Center desktop, click the windows start key and search for `DNS`, select the top result shown as shown in the following screenshot. 

<details><summary>Screenshot 2.11</summary>
<img src="Images/2019-08-24-00-30-50.png">
</details>
<br/>

2.12 In `DNS Manager` expand `Forward Lookup Zones` and left-click `corp.local` Right click the `corp.local` folder, and select `New Host (A or AAAA)...`


<details><summary>Screenshot 2.12</summary>
<img src="Images/2019-08-24-00-32-57.png">
</details>
<br/>

2.13 In the `New Host` dialogue enter the following values:

- Name: `epmc-01a`
- IP Address: `192.168.110.28`
- Click `Add Host`
- Close DNS Manager

<details><summary>Screenshot 2.13</summary>
<img src="Images/2019-08-24-16-16-58.png">
</details>
<br/>

2.14 Return to the vSphere web client, expand `Recent Tasks` and verify that the epmc ovf package import is complete. If your OVF Package import is not yet completed, please wait until it completes before proceeding.

<details><summary>Screenshot 2.14</summary>
<img src="Images/2019-08-24-00-38-15.png">
</details>
<br/>

2.15 From the `Hosts and Clusters` page, navigate to and expand the `RegionA01-MGMT01 > pks-mgmt-01` resource pool, right click `epmc-01a` and select `Power > Power On`. 

<details><summary>Screenshot 2.15</summary>
<img src="Images/2019-08-24-01-09-42.png">
</details>
<br/>

### Step 3: Complete the installation workflow

3.1 From the Control Center Desktop, open a new browser tab in chrome, and navigate to [https://epmc-01a.corp.local/login](https://epmc-01a.corp.local/login), login with the username `root` and the password `VMware1!`, click `INSTALL`, and then click `START CONFIGURATION`

<details><summary>Screenshot 3.1.1</summary>
<img src="Images/2019-11-21-22-45-47.png">
</details>

<details><summary>Screenshot 3.1.2</summary>
<img src="Images/2019-11-21-22-46-47.png">
</details>
<br/>

3.2 In the `PKS Configuration` Dialogue, enter the following values in section `1. vCenter Account`(leave any unspecified values set to their default value):

- vCenter Server: `vcsa-01a.corp.local`
- Username: `administrator@corp.local`
- Password: `VMware1!`
- Click the `Connect` button
- DataCenter: `RegionA01`
- Click `Next`

<details><summary>Screenshot 3.2</summary>
<img src="Images/2019-08-24-03-14-35.png">
</details>
<br/>

3.3 Enter the following values in section `2. Networking`(leave any unspecified values set to their defaults):

- Container Networking Interface:
  - Select `NSX-T Data Center (Automated NAT Deployment)`
- NSX Manager Details:
  - NSX Manager: `192.168.110.42`
  - Username: `admin`
  - Password: `VMware1!VMware1!`
  - Click `Connect`
- Uplink Network:
  - Uplink CIDR: `192.168.210.0/24`
  - Gateway IP: `192.168.210.1`
  - VLAN ID: `0`
  - T0 Uplink 1 IP: `192.168.210.3`
- Network Resources:
  - Deployment CIDR: `172.31.0.0/24`
  - Deployment DNS: `192.168.110.10`
  - NTP Server: `192.168.100.1`
  - Pod IP Block CIDR: `172.15.0.0/16`
  - Node IP Block CIDR: `172.16.0.0/16`
  - Nodes DNS: `192.168.110.10`
  - Usable Range of Floating IPs
    - From: `10.40.14.2`
    - To: `10.40.14.6`
    - Click `ADD RANGE` to add an additional range of floating IPS with the following values:
      - From: `10.40.14.34`
      - To: `10.40.14.62`
  - Disable SSL Certificates Verification: `True`
- Click `Next`

<details><summary>Screenshot 3.3</summary>
<img src="Images/2019-11-22-01-15-44.png">
</details>
<br/>

3.4 In the `3.Identity`section please enter the following values (leave any unspecified values set to their default value):

- Select `Local user database`
- PKS API FQDN: `pks.corp.local`
- Configure Created CLusters to Use UAA as the OIDC Provider: `True`

<details><summary>Screenshot 3.4</summary>
<img src="Images/2019-11-24-09-33-13.png">
</details>
<br/>

3.5 Enter the following values in section `4. Availability Zones` (leave any unspecified values set to their default value):

- Under `Availability Zone`
  - Name: `PKS-MGMT-1`
  - This is the management availability zone: `True`
  - Compute Resource: `pks-mgmt-1`
  - Click `Save Availability Zone`
- Click `Add Availability Zone`
  - Name: `PKS-COMP`
  - Compute Resource: `pks-comp-1`
  - Click `Save Availability Zone`
- Click `Next`

<details><summary>Screenshot 3.5.1</summary>
<img src="Images/2019-08-24-04-07-54.png">
</details>

<details><summary>Screenshot 3.5.2</summary>
<img src="Images/2019-08-24-04-10-16.png">
</details>
<br/>

3.6 Enter the following values in section `5. Resources & Storage`(leave any unspecified values set to their default value):

- Appliance VM Type:
  - `medium.disk (cpu:2, ram: 4 GB, disk: 32 GB)`
- Ephemeral Storage:
  - Select: `RegionA01-ISCI02-COMP01`
- Kubernetes Persistent Volume Storage:
  - Select: `RegionA01-ISCI02-COMP01`
- Click `Next`

<details><summary>Screenshot 3.6</summary>
<img src="Images/2019-11-22-01-53-26.png">
</details>
<br/>

3.7 Enter the following values in section `6. Plans`(leave any unspecified values set to their default value):

- `Small`
  - Name: `Small`
  - Worker Node Instances: `2`
  - Worker Persistent Disk Size: `30 GB`
  - Enable Priviledged Containers: `True`
  - Click `Save Plan`
- `Medium`
  - To the right of `Save Plan`, click `DELETE` to delete the medium plan
- `Large`
  - To the right of `Save Plan`, click `DELETE` to delete the medium plan
- Click `Next`

<details><summary>Screenshot 3.7</summary>
<img src="Images/2019-08-24-18-00-06.png">
</details>
<br/>

3.8 In the `PKS Configuration` Dialogue, enter the following values in section `7. Integrations`(leave any unspecified values set to their default value):

- `vRealize Log Insight`
  - Enable Log Insight: `True`
  - Host: `vrli-01a.corp.local`
  - Click `Save`
- Click `Next`

<details><summary>Screenshot 3.8</summary>
<img src="Images/2019-11-22-01-59-04.png">
</details>
<br/>

3.9 Enter the following values in section `8. Harbor` (leave any unspecified values set to their default value):

- Enable Harbor: `True`
- Harbor FQDN: `harbor.corp.local`
- Password:   `VMware1!`
- Confirm Password: `VMware1!`
- VM type for harbor-app: `medium.disk (cpu: 2, ram: 4GB, disk: 32GB)`
- Disk size for harbor-app: `50 GB`
- Updater Interval: `1`
- Enable vRealize Log Insight for Harbor: `True`
- Address and port: `harbor.corp.local : 514`
- Click `Next`

<details><summary>Screenshot 3.9</summary>
<img src="Images/2019-11-24-09-36-18.png">
</details>
<br/>

3.10 Enter the following values in section `9. CEIP and Telemetry`(leave any unspecified values set to their default value):

- Please select your participation level in the CEIP and Telemetry Program: `None`
- Please select how you will be using this PKS Installation: `Demo or Proof-of-concept`
- Click `Next`
- Click `Generate Configuration`

<details><summary>Screenshot 3.10</summary>
<img src="Images/2019-08-24-04-37-38.png">
</details>
<br/>

3.11 In the `PKS Configuration` Dialogue, on the `Configuration YAML` screen, review the values and observe that you could edit values with the in-browser text editor if you needed to. Click `APPLY CONFIGURATION`, and on the `Apply Configuration` popup window, select `Continue`

<details><summary>Screenshot 3.11.1</summary>
<img src="Images/2019-08-24-04-40-29.png">
</details>

<details><summary>Screenshot 3.11.2</summary>
<img src="Images/2019-08-24-04-42-03.png">
</details>

<details><summary>Screenshot 3.11.3</summary>
<img src="Images/2019-08-24-04-42-35.png">
</details>
<br/>

3.12 Observe the various steps that the deployment goes through on the `Installing PKS Instance` screen while waiting for the deployment to complete:

<details><summary>Screenshot 3.12</summary>
<img src="Images/2019-08-24-04-46-02.png">
</details>
<br/>

3.13 After the installation completes, click `Go To VMware Enterprise PKS`

<details><summary>Screenshot 3.13</summary>
<img src="Images/2019-08-24-19-37-42.png">
</details>
<br/>

3.14 Observe the information provided, including links to the relevant VM and Network object pages in vCenter and NSX Manager, making it easy to identify and more effectively utlize vSphere tools when supporting the Enterprise PKS Deployment. 

If you look at the cluster and nodes tabs right now they are blank as you have not deployed a cluster yet. After you deploy a cluster revisit the clusters and nodes tabs to easily find exactly which VMs and vsphere/nsx objects are associated with each K8s cluster.

<details><summary>Screenshot 3.14</summary>
<img src="Images/2019-08-24-19-44-54.png">
</details>
<br/>

3.15 Click on `Deployment Metadata` and observe that this tab provides each of the certificates and secrets used during the deployment, providing a simple, central location administrators can go to find access details.

Navigate to the 2nd page of the `Deployment Metadata` screen and observe the IP addresses for each of the VM's deployed by epmc.

<details><summary>Screenshot 3.15.1</summary>
<img src="Images/2019-08-24-19-48-00.png">
</details>

<details><summary>Screenshot 3.15.2</summary>
<img src="Images/2019-08-24-19-55-08.png">
</details>
<br/>

3.16 From Control Center, open DNS Manager and navigate to `corp.local` folder. Update the entries for `harbor`, `opsman` and `pks` to match the IP addresses you observed in the previous step.

<details><summary>Screenshot 3.16</summary>
<img src="Images/2019-08-24-19-57-46.png">
</details>
<br/>

3.17 From Control Center, open a new chrome browser tab and click on the `Harbor` bookmark and login with the username `admin` and the password `VMware1!`

<details><summary>Screenshot 3.17.1</summary>
<img src="Images/2019-09-11-09-51-30.png">
</details>

3.18 To access the Ops Manager UI, from Control Center, get the Ops Manager IP address from `EPMC->Deployment Metadata->Ops Manager Address`, and also get the `Ops Manager Admin User Name` and `Ops Manager Admin User Password`.  Then, open a new chrome browser tab and load up the Ops Manager IP address and login with the username and password you retrieved.

<details><summary>Screenshot 3.18.1</summary>
<img src="Images/2019-09-11-13-56-20.png">
</details>

<details><summary>Screenshot 3.18.2</summary>
<img src="Images/2019-08-24-20-07-29.png">
</details>

<details><summary>Screenshot 3.18.3</summary>
<img src="Images/2019-08-24-20-08-17.png">
</details>
<br/>

3.19 Return to the `epmc-01a` web console, navigate to the `Deployment Metadata` and find the `Enteprise PKS Admin User Name` and `Password` You will use this information in the next step to log into the PKS API.

<details><summary>Screenshot 3.19</summary>
<img src="Images/2019-08-24-20-14-59.png">
</details>
<br/>

3.20 From the control center desktop, open a putty session to `ubuntu@cli-vm` and from the prompt, enter the following command to login to the PKS API. Be sure to use the password you gathered in the previous step:

`pks login -a pks.corp.local -u admin -p ReplaceWithPassword -k` 

<details><summary>Screenshot 3.20</summary>
<img src="Images/2019-08-24-20-18-45.png">
</details>
<br/>

**End of lab**




