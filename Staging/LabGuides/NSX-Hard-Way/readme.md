# NSX-T 2.3 Installation

## Overview

The following installation guide follows the implementation of a functional NSX-T 2.3 Installation configured for PKS 1.2 in a vSphere nested lab environment. This implementation uses variables that function in the lab environment. Anyone is welcome to build a similar lab environment and follow along with the lab exercises, but please note you will need to replace any variables such as IP addresses and FQDNs and replace them with the appropriate values for your lab environment.

The steps provided in this lab guide are intended for a lab implementation and do not necessarily align with best practices for production implementiations. While the instructions provided in this lab guide did work for the author in their lab environment, VMware and/or any contributors to this Guide provide no assurance, warranty or support for any content provided in this guide.

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

### NSX-T

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.3 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-3E0C4CEC-D593-4395-84C4-150CD6285963.html)

#### Install NSX-T Manager

Overview of Tasks Covered in Lab 1

- Step 1: Deploy NSX Manager (= NSX Unified Appliance)
- Step 2: Deploy NSX Controller and Cluster
- Step 3: Connect NSX to vCenter
- Step 4: Create IP Pool
- Step 5: Register and Prepare Hosts
- Step 6: Deploy NSX Edge
- Step 7: Create Edge Transport Node
- Step 8: Create Switches and Routers
- Step 9: Create IP Blocks for PKS 
- Step 10: Create Network Address Translation Rules

NOTE: NSX Manager OVA cannot be installed via HTML5 client, so for installation labs please use the vSphere web client (Flash-based).

This section follows the standard documentation, which includes additional details and explanations: [NSX Manager Installation](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-A65FE3DD-C4F1-47EC-B952-DEDF1A3DD0CF.html)

## Step 1:  Deploy NSXT Manager using OVF Install Wizard

1.1 In the vSphere web client (not the HTML5 Client), From the Hosts and Clusters view, right click on the RegionA01-MGMT01 Cluster and select `Deploy OVF Template'

<Details><Summary>Screenshot 1.1</Summary>
<img src="Images/2018-10-16-23-43-44.png">
</Details>
<br/>

1.2 On the `Select Template` step, select `Local File` and Navigate to the NSXT Manager OVA file. In the reference lab, this is located on the E:/Downloads Directory

<details><summary>Screenshot 1.2</summary>
<img src="Images/2018-10-16-23-48-52.png">
</details>
<br/>

1.3 On the `Select name and location` step, use the name `nsxmgr-01a` and select RegionA01 Datacenter as the location

<details><summary>Screenshot 1.3</summary>
<img src="Images/2018-10-17-00-06-33.png">
</details>
<br/>

1.4 On the `Select a Resource` step, select RegionA01-MGMT

<details><summary>Screenshot 1.4</summary>
<img src="Images/2018-10-16-23-54-05.png">
</details>
<br/>

1.5 On the `Review Details` step, verify details and click `Next`

<details><summary>Screenshot 1.5</summary>
<img src="Images/2018-10-16-23-55-58.png">
</details>
<br/>

1.6 On the `Select Configuration` step, select a Small Configuration

<details><summary>Screenshot 1.6</summary>
<img src="Images/2018-10-16-23-57-38.png">
</details>
<br/>

1.7 On the `Select Storage` step, set the virtual disk format to `Thin Provision` and select the `RegionA01-ISCSI01-COMP01` datastore

<details><summary>Screenshot 1.7</summary>
<img src="Images/2018-10-16-23-59-52.png">
</details>
<br/>

1.8 On the `Select Networks` step, set the Destination Network to `VM-RegionA01-vDS-MGMT

<details><summary>Screenshot 1.8</summary>
<img src="Images/2018-10-17-00-02-21.png">
</details>
<br/>

1.9 On the `Customize Template` step, enter the following variables:

- System Root User Password: VMware1!
- CLI Admin User Password: VMware1!
- CLI Audit User Password: VMware1!
- Hostname: nsxmgr-01a
- Rolename: nsx-manager
- Default Gateway: 192.168.110.1
- Management Network IPv4 Address: 192.168.110.42
- Management Network Netmask: 255.255.255.0
- DNS Server List: 192.168.110.10
- Domain Search List: corp.local
- NTP Server: 192.168.100.1
- Enable SSH: True
- Allow Root SSH Logins: True
- All other options were left as default values

<details><summary>Screenshot 1.8</summary>
<img src="Images/2018-10-17-00-12-14.png">
</details>
<br/>

1.9 Complete the Deploy OVF Template Wizard

<details><summary>Screenshot 1.9</summary>
<img src="Images/2018-10-17-00-13-27.png">
</details>
<br/>

1.10 In the vSphere web client go to the task console and verify that the Status for Deploy OVF Template is "Completed" before proceeding
<br/>

<details><summary>Screenshot 1.10</summary>
<img src="Images/2018-10-17-00-51-10.png">
</details>
<br/>

1.11 In the vSphere web client go to Hosts and Clusters and on the `Actions` menu for `nsxmgr-01a`, select `Edit Settings`

<details><summary>Screenshot 1.11</summary>
<img src="Images/2018-10-17-02-19-08.png">
</details>
<br/>

1.12 Expand the `Memory` section and set the `Reservation` to `0`

NOTE: This step is provided to help limit the requirements for resource constrained lab environments, if your lab environment has ample hardware resources, you may skip this step

<details><summary>Screenshot 1.12</summary>
<img src="Images/2018-10-17-02-22-04.png">
</details>
<br/>

1.13 In the vSphere web client power on the nsxmgr-01a VM, wait a few minutes for NSX Manager to fully boot up before proceeding to the next step

NOTE: If the option to power on the nsxmgr-01a VM is not available, log out and then log back in to the vSphere web client

<details><summary>Screenshot 1.13</summary>
<img src="Images/2018-10-17-01-23-08.png">
</details>
<br/>

1.14 Using the IP address you assigned to NSX Manager in the Deploy OVF Template Wizard, open a web browser connection to NSX Manager, for example:

`https://nsxmgr-01a.corp.local/login.jsp`

<br/>
NOTE: On your first login, you will be prompted to accept the EULA. Accept EULA and opt out of VMware Customer Experience program.
<br/>
<br/>

<details><summary>Screenshot 1.14</summary>
<img src="Images/2018-10-17-01-34-33.png">
</details>
<br/>
This completes the NSX Manager installation, please proceed on to the Controller installation section below


## Step 2: Add NSX Compute Manager

 2.1 From NSX Manager, click on **Fabric** -> **Compute Managers**

<details><summary>Screenshot 2.1</summary><img src="images/2018-12-15-12-23-49.png"></details><br>

 2.2 Click on **Add** and Configure the New Compute Manager form with following values:

- Name: `vcsa-01a`
- Domain Name/IP Address: `vcsa-01a.corp.local`
- Type: `vCenter`
- Username: `administrator@vsphere.local`
- Password: `VMware1!`
- Clcik **Add**
- Click **Add** again to accept the vCenter certificate thumbprint

<details><summary>Screenshot 2.2.1</summary><img src="images/2018-12-13-16-15-57.png"></details>
<details><summary>Screenshot 2.2.2</summary><img src="images/2018-12-13-16-17-18.png"></details><br>


 3.3 Click **Refresh** in the lower left hand corner and verify the Compute Manager is `Verified` and `Up`

<details><summary>Screenshot 3.3.1</summary><img src="images/2018-12-13-16-19-15.png"></details>
<details><summary>Screenshot 3.3.2</summary><img src="images/2018-12-13-16-20-07.png"></details><br>

## Step 3: Deploy NSX Controller

 3.1 Click on **System** -> **Components**

- Click **Add Controllers** 

<details><summary>Screenshot 3.1.1</summary><img src="images/2018-12-13-16-25-33.png"></details>
<details><summary>Screenshot 3.1.2</summary><img src="images/2018-12-13-16-26-24.png"></details><br>

 3.2 Enable `SSH` and `Root Access`, then complete Add Controller form with the following:

##### 3.2.1
- Compute Manager: `vcsa-01a`
- Shared Secret: `VMware1!`
- CLI Password: `VMware1!`
- ROOT Password: `VMware1!`
- DNS Servers: `192.168.110.10`
- NTP Servers: `192.168.100.1`
<br>(_Note: If you scroll to the bottom of this form, you will see there is no option for Small Controller size. Leave the default of Mediumm, you will change it to a Small config in a later step_)
- Click **Next**

##### 3.2.2
- Host Name/FQDN: `nsxc-1`
- Cluster: `RegionA01-MGMT01`
- Datastore: `RegionA01-ISCSI01-COMP01`
- Network: `VM-RegionA01-vDS-MGMT`
- Management/IP Mask: `192.168.110.31/24`
- Management Gateway: `192.168.110.1`
- Click **Finish**


<details><summary>Screenshot 3.2.1</summary><img src="images/2018-12-13-19-35-03.png"></details>
<details><summary>Screenshot 3.2.2</summary><img src="images/2018-12-13-19-43-08.png"></details>
<details><summary>Screenshot 3.2.3</summary><img src="images/2018-12-15-12-44-01.png"></details><br>

 3.3 Verify Management and Controller Cluster Connectivity **Up**

<details><summary>Screenshot 3.3.1</summary><img src="images/2018-12-13-20-12-05.png"></details><br>

_Optional:_

- On the cli-vm, create and open terminal emulator SSH sessions, as described in Screenshots 3.3.2 and 3.3.3, and execute the following commands to check control plane health 

    - <details><summary>Screenshot 3.3.2</summary><img src="images/2018-12-13-20-23-33.png"></details>
    - <details><summary>Screenshot 3.3.3</summary><img src="images/2018-12-13-20-33-16.png"></details>

- From the Manager command line, execute the following command
    - `get management-cluster status`
- From the Controller command line, execute the following commands
    - `get control-cluster status`
    - `get managers`
- Verify that all  status indicates Active/Stable/True/Connected

    - <details><summary>Screenshot 3.3.4</summary><img src="images/2018-12-13-20-36-28.png"></details>
    - <details><summary>Screenshot 3.3.5</summary><img src="images/2018-12-13-20-37-41.png"></details><br>

 3.4 Resize Controller

_Note: Confirm that step 3.3 has completed before performinng step 3.4. This step is for lab resource efficiency only. We are resizing the Controller VM to be the equivelant of a Small factor. This is only applicable for a lab environment._

- Login to the vCenter web client with Windows authentication
- Shutdown the **nsxc-01a** VM
- Edit the settings for the **nsxc-01a** VM
- Set CPU: `2`
- Set Memory: `8 GB`
- Click **Ok** and restart the VM

<details><summary>Screenshot 3.4</summary><img src="images/2018-12-15-12-58-05.png"></details><br>

## Step 4: Create IP Pool

 4.1 Click **Inventory** -> **Groups**

- Click on **IP Pools**

<details><summary>Screenshot 4.1</summary><img src="images/2018-12-14-11-03-53.png"></details><br>

 4.2 Create the TEP IP Pool, click **Add** and complete with the following values

- Name: `tep-ip-pool`
- Click `Add` under Subnets
- IP Range: `192.168.130.51-192.168.130.75`
- Gateway: `192.168.130.1`
- CIDR: `192.168.130.0/24`
- Click **Add**

<details><summary>Screenshot 4.2</summary><img src="images/2018-12-14-11-09-57.png"></details><br>

## Step 5: Prepare and Configure ESXi Hosts

 5.1 Click on **Fabirc** -> **Nodes**

- Click **Hosts**

<details><summary>Screenshot 5.1</summary><img src="images/2018-12-14-11-18-47.png"></details><br>

 5.2 Select **vcsa-01a** from the **Managed by** dropdown

<details><summary>Screenshot 5.2</summary><img src="images/2018-12-14-11-19-49.png"></details><br>

 5.3 Configure Cluster RegionA01-MGMT01

- Select **RegionA01-MGMT01**
- Click **Configure Cluster**

<details><summary>Screenshot 5.3.1</summary><img src="images/2018-12-14-11-21-52.png"></details>

- Enable `Automatically Install NSX` and `Automatically Create Transport Node`
- Click on **Or Create New Transport Zone**  under Transport Zone

<details><summary>Screenshot 5.3.2</summary><img src="images/2018-12-14-11-24-32.png"></details>

- Name: `overlay-tz`
- N-VDS Name: `hostswitch-overlay`
- N-VDS Mode: `Standard`
- Traffic Type: `Overlay`
- Click **Add**

<details><summary>Screenshot 5.3.3</summary><img src="images/2018-12-14-11-27-25.png"></details>

- Uplink Profile: `nsx-default-uplink-hostswitch-profile`
- Ip Assignment: `Use IP Pool`
- IP Pool: `tep-ip-pool`
- Physical NICs: `vmnic1`
- Click **Add**

<details><summary>Screenshot 5.3.4</summary><img src="images/2018-12-14-11-29-20.png"></details><br>

 5.4 Configure RegionA01-COMP01

- Select **RegionA01-COMP01**
- Click **Configure Cluster**

<details><summary>Screenshot 5.4</summary><img src="images/2018-12-14-11-35-42.png"></details>

- Enable `Automatically Install NSX` and `Automatically Create Transport Node`
- Transport Zone: `overlay-tz`
- Uplink Profile: `nsx-default-uplink-hostswitch-profile`
- Ip Assignment: `Use IP Pool`
- IP Pool: `tep-ip-pool`
- Physical NICs: `vmnic1`
- Click **Add**

## Step 6: Deploy NSX Edge

 6.1 Click on **Fabric** -> **Nodes**

- Click on **Edges**

<details><summary>Screenshot 6.1.1</summary><img src="images/2018-12-13-21-19-56.png" width=75%></details>
<details><summary>Screenshot 6.1.2</summary><img src="images/2018-12-13-21-22-06.png"></details><br>

 6.2 Add an NSX Edge

##### 6.2.1 - Name and Description

- Click on `Add EDge VM`
- Name: `nsxedge-1`
- Host name/FQDN: `nsxedge-1.corp.local`
- Form Factor: `Large` _(PKS currently requires the NSX Edge to be Large size)_
- Click on **Next**

<details><summary>Screenshot 6.2.1</summary><img src="images/2018-12-15-13-40-28.png"></details><br>

##### 6.2.2 - Credentials

- CLI Password: `VMware1!`
- System Root Password: `VMware1!`
- Click **Next**

<details><summary>6.2.2</summary><img src="images/2018-12-13-21-40-15.png"></details>

##### 6.2.3 - Configure Deployment

- Compute Manager: `vcsa-01a`
- Cluster: `RegionA01-MGMT01`
- Datastore: `RegionA01-ISCSI01-COMP01`
- Click **Next**

<details><summary>Screenshot 6.2.3</summary><img src="images/2018-12-13-21-41-18.png"></details>

#### 6.2.4 - Configure Ports

- Assignment: `Static`
- Management IP: `192.168.110.91/24`
- Default Gateway: `192.168.110.1`
- Management Interface: `VM-RegionA01-vDS-MGMT`
- Datapath Interfaces: 
    - `Uplink-RegionA01-vDS-MGMT`
    - `Transport-RegionA01-vDS-MGMT`
    - `Transport-RegionA01-vDS-MGMT`
- Clcik **Finish**

<details><summary>Screenshot 6.2.4</summary><img src="images/2018-12-14-12-14-48.png"></details><br>

 6.3 Monitor deployment status until **Deployment Status** shows **Node Ready** and **Manager Connectivity  Up**. You may need to hit the **Refresh** link in the lower-left corner.

<details><summary>Screenshot 6.3</summary><img src="images/2018-12-15-13-52-12.png"></details>

_Note: If the status doesn't update after a few minutes, try navigating to the Hosts tab and then back to teh Edges tab._ 

<br>

 6.4 Verify that the edge vm has been created and powered on in vCenter web client

<details><summary>Screenshot 6.4</summary><img src="images/2018-12-15-13-53-04.png"></details><br>

## Step 7: Create Edge Transport Node

 7.1 Configure the **nsxedge-1** edge as a transport node

- Click on **Fabric** -> **Nodes**
- Click **Edges**
- Select `nsxedge-1`
- Click the gear dropdown
- Select Configure as Tansport Node

<details><summary>Screenshot 7.1</summary><img src="images/2018-12-14-12-32-36.png"></details><br>

 7.2 Create a new transport zone for VLAN connection

- Click on **Create New Transport Zone** 
- Name: `vlan-tz`
- N-VDS Name: `hostswitch-vlan`
- N-VDS Mode: `Standard`
- Traffic Type: `VLAN`
- CLick **Add**

<details><summary>Screenshot 7.2.1</summary><img src="images/2018-12-15-14-01-41.png"></details>
<details><summary>Screenshot 7.2.2</summary><img src="images/2018-12-14-12-37-38.png"></details><br>

 7.3 Configure the **General** tab with the following inputs

- Name: `edge-tn-1`
- Select `overlay-tz` in **Available**
- Click on the `>` to move vlan-tz to **Selected**

<details><summary>Screenshot 7.3</summary><img src="images/2018-12-14-12-40-22.png"></details><br>

 7.4 Configure the **N-VDS** tab with the following inputs

- Click on **N-VDS** tab 
- Edge Switch Name: `hostswith-vlan`
- Uplink Profile: `nsx-default-edge-vm-uplink-hostswitch-profile`
- Virtual NICs: `fp-eth0`
- Click **Add N-VDS**

<details><summary>Screenshot 7.4.1</summary><img src="images/2018-12-15-14-27-01.png"></details>

- Edge Switch Name: `hostswitch-overlay`
- Uplink Profile: `nsx-default-edge-vm-uplink-hostswitch-profile`
- IP Assignment: `Use IP Pool`
- IP Pool: `tep-ip-pool`
- Virtual NICs: `fp-eth1`
- Click **Add**

<details><summary>Screenshot 7.4.2</summary><img src="images/2018-12-14-12-45-21.png"></details>
<details><summary>Screenshot 7.4.3</summary><img src="images/2018-12-14-12-48-26.png"></details><br>

 7.5 Add an Edge Cluster

- Click on **Fabric** -> **Nodes**
- Click on **Edge Clusters**
- Click on **Add**
- Name: `edge-cluster-1`
- Edge Cluster Profile: `nsx-default-edge-high-availability-profile`
- Member Type: `Edge Node`
- Select `edge-tn-1` from **Available** and click on ``>`` to move it to **Selected**
- Click **Add**

<details><summary>Screenshot 7.5</summary><img src="images/2018-12-14-12-52-40.png"></details><br>

 7.6 Click on **Transport Nodes** and verify edge-tn-1 status is **Success** and **Up**

<details><summary>Screenshot 7.6</summary><img src="images/2018-12-14-12-54-08.png"></details><br>


## Step 8: Create Switches and Routers

 8.1 Create VLAN Uplink Switch

- Click on **Networking** -> **Switching**
- Click on **Add**
- Name: `uplink-vlan-ls`
- Transport Zone: `vlan-tz`
- VLAN: `0`
- Click on **Add**

<details><summary>Screenshot 8.1.1</summary><img src="images/2018-12-14-20-06-42.png"></details>
<details><summary>Screenshot 8.1.2</summary><img src="images/2018-12-14-20-03-39.png"></details><br>

 8.2 Create PKS Management Switch

- Clcik on **Add**
- Name: `ls-pks-mgmt`
- Transport Zone: `overlay-tz`
- Click on **Add**

<details><summary>Screenshot 8.2</summary><img src="images/2018-12-15-14-56-24.png"></details><br>

 8.3 Create PKS Compute Switch

- Clcik on **Add**
- Name: `ls-pks-service`
- Transport Zone: `overlay-tz`
- Click on **Add**

<details><summary>Screenshot 8.3</summary><img src="images/2018-12-15-14-57-10.png"></details><br>

 8.4 Create T0 Router

- Click on **Networking** -> **Routers**
- Click on **Add** -> **T0 Router**

<details><summary>Screenshot 8.4.1</summary><img src="images/2018-12-14-20-17-20.png"></details>

    Be sure to configure HA Mode as `Active-Standby

- Name: `t0-pks`
- Edge Cluster: `edge-cluster-1`
- High Availabilty Mode: **`Active-Standby`**
- Failover Mode: `Non-Preemptive`
- Click **Add**

<details><summary>Screenshot 8.4.2</summary><img src="images/2018-12-15-15-09-20.png"></details><br>

 8.5 Create PKS Managent T1 Router

- Click **Add** -> **Tier-1 Router**
- Name: `t1-pks-mgmt`
- Tier-0 Router: `t0-pks`
- Edge Cluster: `edge-cluster-1`
- Edge Cluster Members: `edge-tn-1`
- Click **Add**

<details><summary>Screenshot 8.5</summary><img src="images/2018-12-15-15-11-39.png"></details><br>

 8.6 Create PKS Compute T1 Router

- Click **Networking** -> **Routers**
- Click **Add** -> **Tier-1 Router**
- Name: `t1-pks-service`
- Tier-0 Router: `t0-PKS`
- Edge Cluster: `edge-cluster-1`
- Edge Cluster Members: `edge-tn-1`
- Click **Add**

<details><summary>Screenshot 8.6</summary><img src="images/2018-12-15-15-13-17.png"></details><br>

 8.7 Configure T0 Router VLAN Uplink Port

- Click on **t0-PKS**
- Select **Configuration** -> **Router Ports**
<details><summary>Screenshot 8.7.1</summary><img src="images/2018-12-14-21-14-59.png"></details>
<details><summary>Screenshot 8.7.2</summary><img src="images/2018-12-14-21-16-34.png"></details>

- Click **Add**

<details><summary>Screenshot 8.7.3</summary><img src="images/2018-12-15-15-15-09.png"></details>

- Name: `t0-uplink-1`
- Type: `Uplink`
- Transport Node: `edge-tn-1`
- Logical Switch: `uplink-vlan-ls`
- IP Address/mask: `192.168.200.3/24`
- Click **Add**

 <details><summary>Screenshot 8.7.3</summary><img src="images/2018-12-14-20-36-31.png"></details><br>

 8.8 Add T0 Static Route

- Clcik on **Routing** -> **Static Routes**

<details><summary>Screenshot 8.8.1</summary><img src="images/2018-12-14-20-40-48.png"></details>

- Click on **Add**
- Network: `0.0.0.0/0`
- Click on **Next Hops +Add**
- Click on the `Pencil` icon under `Next Hop`
- Input: `192.168.200.1`
- Click outside of the input area to save input
- Click **Add** 

 <details><summary>Screenshot 8.8.2</summary><img src="images/2018-12-14-20-48-34.png"></details>

- From the `cli-vm`, ping the uplink port address `192.168.200.3` to test connectivity

 8.9 Configure PKS Compute T1 Ports

- Click **Networking** -> **Routers**
- Click on **t1-pks-service** (_Verify that the router name is now listed over 'Overview'_)

<details><summary>Screenshot 8.9.1</summary><img src="images/2018-12-15-15-24-02.png"></details>

- Click on **Configuration** -> **Router Ports**
- Click on **Add**
- Name: `ls-pks-serviceRouterPort`
- Type: `Downlink`
- Logical Switch: `ls-pks-service`
- IP Address/mask: `172.31.2.1/24`
- Click **Add**

<details><summary>Screenshot 8.9.2</summary><img src="images/2018-12-15-15-28-05.png"></details><br>

 8.10 Configure PKS Management T1 Ports and Route Advertisement

- Click on **t1-pks-mgmt** (_Verify that the router name is now listed over 'Overview'_)
- Click on **Configuration** -> **Router Ports**
- Click on **Add**
- Name: `ls-pks-mgmtRouterPort`
- Type: `Downlink`
- Logical Switch: `ls-pks-mgmt`
- IP Address/mask: `172.31.0.1/24`
- Click **Add**

 8.11 Enable T1 Route Advertisement

- Select `t1-pks-mgmt`
- Click on **Routing** -> **Route Advertisement**
- Click on `Edit`
- Enable 
    - Status
    - Advertise All NSX Cnnected Routes
    - Advertise All NAT Routes
    - Click `Save`
    <br>

<details><summary>Screenshot 8.11</summary><img src="images/2018-12-15-15-36-08.png"></details>

- Repeat step for T1 Router `t1-pks-service`

## Step 9: Create IP Blocks for PKS Components

 9.1 Create Node IP Block

- Click on **Networking** -> **IPAM**

<details><summary>Screenshot 9.1.1</summary><img src="images/2018-12-14-22-29-36.png"></details>

- Click **Add**
- Name: `ip-block-nodes`
- CIDR: `172.15.0.0/16`

<details><summary>Screenshot 9.1.2</summary><img src="images/2018-12-14-22-36-20.png"></details><br>

 9.2 Create Node IP Block

- Click **Add**
- Name: `ip-block-pods`
- CIDR: `172.15.0.0/16`
- Click **Add**

<details><summary>Screenshot 9.2</summary><img src="images/2018-12-14-22-39-32.png"></details><br>

## Step 10: Create Network Address Translation Rules

 10.1 Define NAT Rules

- Click on **Networking** -> **Routers**
- Select the t0-PKS Router
- Click on **Services** -> **NAT**

<details><summary>Screenshot 10.1.1</summary><img src="images/2018-12-14-22-44-32.png"></details>

- Click on **Add**
- Action: `SNAT`
- Source IP: `172.31.0.0/24`
- Translated IP: `10.40.14.12`
- Click **Add**

_Note: Leaving an entry blank is the method to set it as `Any`_

<details><summary>Screenshot 10.1.2</summary><img src="images/2018-12-14-22-57-47.png"></details><br>

 10.2 Repeat the steps above to complete the remaining rules in Screenshot 11.2

<details><summary>Screenshot 10.2</summary><img src="images/2018-12-14-22-54-37.png"></details><br>


## You have now completed the NSX-T Installation for PKS lab. Click on the dashboard to check that it matches the image below. It may have some yellow based on your lab CPU activity, but the numbers should match.

><img src="images/2018-12-14-23-07-35.png">
