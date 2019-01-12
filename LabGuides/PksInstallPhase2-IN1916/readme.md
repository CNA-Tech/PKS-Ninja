# Lab: PKS Installation Phase 2

**Contents:**

- [Step 1: Install PKS](#step-1-install-pks)
- [Step 2: Install Harbor](#step-2-install-harbor)

## Step 1: Install PKS

1.1 Login to the Ops Manager UI and locate `Pivotal Container Service` in the lefthand column. Click the `+` icon as shown in screenshot 1.1 and the `Pivotal Container Service` tile will be added to the `Installation Dashboard` 

<details><summary>Screenshot 1.1</summary>
<img src="Images/2018-10-22-21-34-37.png">
</details>
<br/>

1.2 Click on the orange PKS tile view the tile configuration

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-22-01-55-47.png">
</details>
<br>

1.3 Select the `Assign AZs and Network Assignments` tab and enter the following values:

- Place singleton jobs in : PKS-MGMT-1
- Balance other jobs in: PKS-MGMT-1
- Network: PKS-MGMT
- Service Network: PKS-COMP
- Click `Save`

<details><summary>Screenshot 1.3</summary><img src="Images/2019-01-06-17-31-07.png"></details><br>

1.4 Select the `PKS API` tab and enter the following values:

- API Hostname: pks.corp.local
- Click `Generate RSA Certificate`
  - to generate the certificate, use the value `*.corp.local` and click `Generate`
- Click `Save`

<details><summary>Screenshot 1.4.1</summary>
<img src="Images/2018-10-31-13-51-49.png">
</details>

<details><summary>Screenshot 1.4.2</summary>
<img src="Images/2018-10-31-13-51-09.png">
</details>
<br/>

1.5 Select the `Plan 1` tab and enter the following values:

- Master/ETCD Availability Zones: PKS-COMP
- Worker Persistent Disk Type: 10gb
- Worker Availability Zone: PKS-COMP
- Enable Priviledged Containers: true
- Click `Save`

<details><summary>Screenshot 1.5</summary>
<img src="Images/2018-10-22-19-31-47.png">
</details>
<br/>

1.6 Select the `Plan 2` tab and enter the following values:

- Active: True
- Master/ETCD Node Instances: 1
- Master/ETCD VM Type: medium (cpu: 2, ram: 4 GB, disk: 8 GB)
- Master Availability Zone: PKS-COMP
- Worker VM Type: large (cpu: 2, ram: 8 GB, disk: 16 GB)
- Worker Persistent Disk Type: 10gb
- Worker Availability Zone: PKS-COMP
- Enable Privileged Containers: True
- Click `Save`

<details><summary>Screenshot 1.6</summary>
<img src="Images/2018-10-22-19-37-39.png">
</details>
<br/>

1.7 Select the `Plan 3` tab, set the value for `Plan` to `Inactive` and click `Save`

<details><summary>Screenshot 1.7</summary>
<img src="Images/2018-10-22-19-39-35.png">
</details>
<br/>

1.8 Select the `Kubernetes Cloud Provider` tab and enter the following values:

- Choose your IaaS: vSphere
- vCenter Master Credentials: administrator@vsphere.local
  - Password: VMware1!
- vCenter Host: vcsa-01a.corp.local
- Datacenter Name: RegionA01
- Datastore Name: RegionA01-ISCSI01-COMP01
- Stored VM Folder: pks_vms
- Click `Save`

<details><summary>Screenshot 1.8</summary>
<img src="Images/2018-10-22-19-45-25.png">
</details>
<br/>

1.9 Prepare Variables to Configure the `Networking` tab

_Note: Use Notepad++ to keep track of the values you will locate below._

1.9.1 Log into the NSX Manager UI, go to `Networking > IPAM`, and on the IPAM page and gather the ID for the `ip-block-pods-deployments` and `ip-block-nodes-deployments` and keep note of the values
Login for NSX Manager UI is: admin/VMware1!

<details><summary>Screenshot 1.9.1.1</summary>
<img src="Images/2018-10-22-19-56-07.png">
</details>

<details><summary>Screenshot 1.9.1.2</summary>
<img src="Images/2018-10-22-19-54-15.png">
</details>
<br>

1.9.2 In the NSX Manager UI, go to `Networking > Routing`, click on t0-pks and gather the t0-pks ID value

<details><summary>Screenshot 1.9.2</summary>
<img src="Images/2018-10-22-19-59-01.png">
</details>
<br/>

1.9.3 In the NSX Manger UI, go to the `Inventory > Groups > IP Pools` click on the ID value for `ip-pool-vips` and a pop-up window will display the entire ID value, keep note of it

<details><summary>Screenshot 1.9.3</summary>
<img src="Images/2018-10-22-20-12-07.png">
</details>
<br/>

1.10 Return to the Ops Manager UI, go to the settings page for Pivotal Container Service, click on the `Networking` tab and enter the following values:

- Container Networking Interface: NSX-T
- NSX Manager Hostname: nsxmgr-01a.corp.local
- NSX Manager Super User Principal Identity Certificate: Use the PI certificate and key values you copied to Notepad++ in the PKS Install Phase 1 lab, pasting the certificate in the first box and the key in the second box
- NSX Manager CA Cert: Use the NSX MGR certificate value you copied to Notepad++ in the PKS Install Phase 1 lab
- Disable SSL certificate verification: True
- NAT mode: True
- Pods IP Block ID: Use the value you gathered in step 1.9.1.1 above
- Nodes IP Block ID: Use the value you gathered in step 1.9.1.2 above
- T0 Router ID: Use the value you gathered in step 1.9.2 above
- Floating IP Pool ID: Use the value you gathered in step 1.9.3 above
- Nodes DNS: 192.168.110.10
- vSphere Cluster Names: RegionA01-COMP01
- Enable outbound internet access: True
- Click `Save`

<details><summary>Screenshot 1.10.1</summary>
<img src="Images/2018-10-22-20-28-14.png">
</details>
<br/>

<details><summary>Screenshot 1.10.2</summary>
<img src="Images/2018-10-22-20-29-03.png">
</details>
<br/>

1.11 Select the `UAA` tab, click the radio button for `Internal UAA` and click `Save`

<details><summary>Screenshot 1.11</summary>
<img src="Images/2018-10-22-20-30-52.png">
</details>
<br/>

1.12 Select the `Usage Data` tab, select `No, I do not want to join the CEIP and Telemetry Program for PKS` and click `Save`

<details><summary>Screenshot 1.12</summary>
<img src="Images/2018-10-31-14-07-35.png">
</details>
<br/>

1.13 Select the `Errands` tab and enter the following values:

- NSX-T Validation Errand: On
- Delete all clusters errand: On
- Click `Save`

<details><summary>Screenshot 1.13.1</summary>
<img src="Images/2018-10-22-20-33-01.png">
</details>
<br/>

_**Stop: Verify that BOSH tile has completed before continuing. Make sure that `Applying changes` no longer appears in the opsman banner, as seen in screenshot 1.13.2**_

<details><summary>Screenshot 1.13.2</summary><img src="Images/2019-01-12-00-35-16.png"></details><br>

1.14 In the Ops Manager UI on the top menu bar click `Installation Dashboard`, next select `Review Pending Changes` and on the `Review Pending Changes`, select `Apply Changes`

<details><summary>Screenshot 1.14</summary>
<img src="Images/2018-10-22-21-09-16.png">
</details>
<br/>

_Note: After you click `Apply Changes` BOSH will begin deploying PKS and it will take a while to complete. In the nested example lab, the PKS deployment took ~1 hour to complete. Leave the `Applying Changes` window open and check it periodically for status. While waiting for the deployment, use another browser tab to open a second connection to the Ops Manager UI and use the second browser session to complete the harbor configuration in the next section._

### Step 2: Install Harbor

2.1 On a new browser tab, open a connection to the Ops Manager UI, click on `Import a Product` select the Harbor file and click `Open`. It can take a few minutes to import the Harbor file

<details><summary>Screenshot 2.1.1 </summary>
<img src="Images/2018-10-22-21-23-55.png">
</details>

<details><summary>Screenshot 2.1.2 </summary>
<img src="Images/2018-10-22-01-27-45.png">
</details>
<br/>

2.2 In the left hand column of the Ops Manager homepage under `VMware Harbor Registy`, click on the `+` icon to add the Harbor tile to the `Installation Dashboard`

<details><summary>Screenshot 2.2 </summary>
<img src="Images/2018-10-22-21-45-54.png">
</details>
<br/>

2.3 Click on the `VMware Harbor Registry` tile to open its configuration settings

<details><summary>Screenshot 2.3 </summary>
<img src="Images/2018-10-22-21-47-27.png">
</details>
<br/>

2.4 Select the `Assign AZs and Networks` tab and enter the following values:

- Singleton Availability Zone: PKS-MGMT-1
- Balance other jobs in: PKS-MGMT-1
- Network: PKS-MGMT
- Click `Save`

<details><summary>Screenshot 2.4</summary>
<img src="Images/2018-10-22-21-53-32.png">
</details>
<br/>

2.5 Select the `General` tab and set the `Hostname` to `harbor.corp.local` , Click `Save`

<details><summary>Screenshot 2.5</summary>
<img src="Images/2018-10-22-21-57-03.png">
</details>
<br/>

2.6 Select the `Certificate` tab, select `Generate RSA Certificate`, enter `harbor.corp.local` and click `Generate`

<details><summary>Screenshot 2.6</summary>
<img src="Images/2018-10-31-15-24-23.png">
</details>
<br/>

2.7 On the `Certificate` tab, click `Save`

<details><summary>Screenshot 2.7</summary>
<img src="Images/2018-10-22-22-11-03.png">
</details>
<br/>

2.8 On the `Credentials` tab, set the `Admin Password` to `VMware1!` and click `Save`

<details><summary>Screenshot 2.8</summary>
<img src="Images/2018-10-22-22-13-53.png">
</details>
<br/>

2.9 On the `Resource Config` tab, set the `Persistent Disk Type` to `20 GB`

<details><summary>Screenshot 2.9</summary>
<img src="Images/2018-10-22-22-18-57.png">
</details>
<br/>

**STOP**: Before proceeding, ensure that the PKS tile deployment has completed.  There will be a blue bar across the top that will show `Applying Changes` and a button for `Show Progress` as it continues to apply

2.10 In the Ops Manager UI on the top menu bar click `Installation Dashboard`, next select `Review Pending Changes` and on the `Review Pending Changes`, select `Apply Changes`. Monitor the `Applying Changes` screen until the deployment is complete

<details><summary>Screenshot 2.10</summary>
<img src="Images/2018-10-22-22-22-46.png">
</details>
<br/>

**You have now completed the PKS installation**

***End of lab***
