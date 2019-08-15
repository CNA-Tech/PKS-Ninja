# Lab: PKS Installation Phase 2

## Install PKS

1.1 Login to the Ops Manager UI and click on the orange PKS tile view the tile configuration

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-22-01-55-47.png">
</details>
<br>

1.2 Select the `Assign AZs and Networks` tab and enter the following values:

- Place singleton jobs in : PKS-MGMT-1
- Balance other jobs in: PKS-MGMT-1
- Network: PKS-MGMT
- Service Network: PKS-MGMT
- Click `Save`

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-06-20-17-32-54.png">
</details>
<br/>

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
- Worker Node Instances: 2
- Worker Persistent Disk Type: 20gb
- Worker Availability Zone: PKS-COMP
- Enable Priviledged Containers: true
- Click `Save`

<details><summary>Screenshot 1.5</summary>
<img src="Images/2018-10-22-19-31-47.png">
</details>
<br/>

1.6 Select the `Plan 2` tab and ensure the plan is set to `Inactive`

<details><summary>Screenshot 1.6</summary>
<img src="Images/2019-07-15-16-23-29.png">
</details>
<br/>

1.7 Select the `Plan 3` tab, set the value for `Plan` to `Inactive` and click `Save`

<details><summary>Screenshot 1.7</summary>
<img src="Images/2018-10-22-19-39-35.png">
</details>
<br/>

1.8 Select the `Kubernetes Cloud Provider` tab and enter the following values:

- Choose your IaaS: `vSphere`
- vCenter Master Credentials: `administrator@corp.local`
  - Password: `VMware1!`
- vCenter Host: `vcsa-01a.corp.local`
- Datacenter Name: `RegionA01`
- Datastore Name: `RegionA01-ISCSI02-COMP01`
- Stored VM Folder: `pks_vms`
- Click `Save`

<details><summary>Screenshot 1.8</summary>
<img src="Images/2019-07-15-16-25-57.png">
</details>.corp.local
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

- Container Networking Interface: `NSX-T`
- NSX Manager Hostname: `192.168.110.42`
- NSX Manager Super User Principal Identity Certificate: Use the PI certificate and key values you copied to Notepad++ in the PKS Install Phase 1 lab, pasting the certificate in the first box and the key in the second box
- NSX Manager CA Cert: Use the NSX MGR certificate value you copied to Notepad++ in the PKS Install Phase 1 lab, this should also be saved as nsx.crt on your desktop
- Disable SSL certificate verification: `True`
- NAT mode: `True`
- Pods IP Block ID: Use the value you gathered above
- Nodes IP Block ID: Use the value you gathered above
- T0 Router ID: Use the value you gathered above
- Floating IP Pool ID: Use the value you gathered above for ip-pool-vips
- Nodes DNS: `192.168.110.10`
- vSphere Cluster Names: `RegionA01-COMP01`
- Enable outbound internet access: `True`
- Click `Save`

<details><summary>Screenshot 1.10.1</summary>
<img src="Images/2018-10-22-20-28-14.png">
</details>
<br/>

<details><summary>Screenshot 1.10.2</summary>
<img src="Images/2018-10-22-20-29-03.png">
</details>
<br/>

1.11 Select the `UAA` tab, click the radio button for `Internal UAA` and then click `Save`

<details><summary>Screenshot 1.11</summary>
<img src="Images/2018-10-22-20-30-52.png">
</details>
<br/>

1.12 Select the `Logging` tab, check the box to `Enable VMware vRealize Log Insight Integration` and enter the following values:

- Host: `vrli-01a.corp.local`
- Disable SSL Certificate Validation: `True`
- Click Save

<details><summary>Screenshot 1.12</summary>
<img src="Images/2019-07-15-16-37-27.png">
</details>
<br/>

1.13 Select the `Usage Data` tab, select `No, I do not want to join the CEIP and Telemetry Program for PKS` and click `Save`

<details><summary>Screenshot 1.13</summary>
<img src="Images/2018-10-31-14-07-35.png">
</details>
<br/>

1.14 Select the `Resource Config` tab and set the `VM Type` for the `Pivotal Container Service` job to `medium.disk`

<details><summary>Screenshot 1.14</summary>
<img src="Images/2019-07-15-16-42-18.png">
</details>
<br/>

_**Stop: Verify that BOSH tile has completed before continuing.**

1.15 In the Ops Manager UI on the top menu bar click `Installation Dashboard`, next select `Review Pending Changes` and on the `Review Pending Changes`, select `Apply Changes`

<details><summary>Screenshot 1.15</summary>
<img src="Images/2018-10-22-21-09-16.png">
</details>
<br/>

_Note: After you click `Apply Changes` BOSH will begin deploying PKS and it will take a while to complete. In the nested example lab, the PKS deployment took ~1 hour to complete. Leave the `Applying Changes` window open and check it periodically for status. While waiting for the deployment, use another browser tab to open a second connection to the Ops Manager UI and use the second browser session to complete the harbor configuration in the next section._

**You have now completed the PKS installation**

***End of lab***
