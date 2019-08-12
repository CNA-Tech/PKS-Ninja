# NSX-T 2.4 Manual Installation for PKS Installation Wizard

This guide is only recommended for students who need to practice using the PKS Installation Wizard or who otherwise need to practice or test NSX High Availability features. IF you are planning on using any lab guides other than the PKS Installation Wizard lab guide, please use the standard NSXT Manual or Pipeline-based installation lab guides. 

This guide walks through a standard NSX-T 2.4 installation including 3 NSX Managers and 2 NSX Edges for high availability, which is required for production installations and currently required for the PKS Installation Wizard for PKS 1.4. 

For lab environments however, running 3 NSX Managers and 2 NSX Edges requires additional overhead that can be a burden to small and oversubscribed lab environments that do not require high availability. The OneCloud/HOL based labs that most students use for PKS Ninja Github Lab Guides runs much better with only a single NSX Manager and Single NSX edge as detailed in the standard NSXT Manual Installation and Pipeline Installation Lab Guides. 

## Overview

The following installation guide follows the implementation of a functional NSX-T 2.4 Installation. This implementation uses variables that function in the lab environment. Anyone is welcome to build a similar lab environment and follow along with the lab exercises, but please note you will need to replace any variables such as IP addresses and FQDNs and replace them with the appropriate values for your lab environment.

The steps provided in this lab guide are intended for a lab implementation and do not necessarily align with best practices for production implementiations. While the instructions provided in this lab guide did work for the author in their lab environment, VMware and/or any contributors to this Guide provide no assurance, warranty or support for any content provided in this guide.

## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.4 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.4/nsxt_24_install.pdf)

### Overview of Tasks Covered in Lab 1

- [NSX-T 2.4 Manual Installation for PKS Installation Wizard](#nsx-t-24-manual-installation-for-pks-installation-wizard)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Installation Notes](#installation-notes)
    - [Overview of Tasks Covered in Lab 1](#overview-of-tasks-covered-in-lab-1)
  - [Step 1: Deploy NSXT Manager using OVF Install Wizard](#step-1-deploy-nsxt-manager-using-ovf-install-wizard)
  - [Step 2: Add NSX Compute Manager](#step-2-add-nsx-compute-manager)
  - [Step 3: Configure NSX-T Manager Cluster](#step-3-configure-nsx-t-manager-cluster)
  - [Step 4: Add Edge Nodes, Transport Zones and Uplink Profiles with the NSX-T Guided Preparation Workflow](#step-4-add-edge-nodes-transport-zones-and-uplink-profiles-with-the-nsx-t-guided-preparation-workflow)
  - [Step 5: Prepare and Configure ESXi Hosts as NSX-T Transport Nodes](#step-5-prepare-and-configure-esxi-hosts-as-nsx-t-transport-nodes)

-----------------------

## Step 1:  Deploy NSXT Manager using OVF Install Wizard

Note: Prior to Step 1, you will need to download the NSX-T 2.4 Installation Files and binaries. The Installation binaries are not included in the lab, users will need to provide their own access and licensing to download and use NSX-T 2.4. 

1.1 In the vSphere client, From the Hosts and Clusters view, right click on the RegionA01-MGMT01 Cluster and select `Deploy OVF Template'

<Details><Summary>Screenshot 1.1</Summary>
<img src="Images/2019-06-11-07-26-48.png">
</Details>
<br/>

1.2 On the `Select Template` step, select `Local File` and Navigate to the NSXT Manager OVA file, the filename should start with 'nsx-unified-appliance`. In the reference lab, this is located on the 'E:/Downloads' Directory

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-06-11-07-36-11.png">
</details>
<br/>

1.3 On the `Select name and location` step, use the name `nsxmgr01a-1` and select `RegionA01` Datacenter as the location

<details><summary>Screenshot 1.3</summary>
<img src="Images/2019-06-11-07-36-55.png">
</details>
<br/>

1.4 On the `Select a computer resource` step, select `RegionA01-MGMT01` and click `Next`

<details><summary>Screenshot 1.4</summary>
<img src="Images/2019-06-11-07-37-23.png">
</details>
<br/>

1.5 On the `Review Details` step, verify details and click `Next`

<details><summary>Screenshot 1.5</summary>
<img src="Images/2019-06-11-07-37-50.png">
</details>
<br/>

1.6 On the `Select Configuration` step, select a Small Configuration

<details><summary>Screenshot 1.6</summary>
<img src="Images/2019-06-11-07-38-30.png">
</details>
<br/>

1.7 On the `Select Storage` step, set the virtual disk format to `Thin Provision` and select the `RegionA01-ISCSI02-COMP01` datastore

<details><summary>Screenshot 1.7</summary>
<img src="Images/2019-06-11-07-39-42.png">
</details>
<br/>

1.8 On the `Select Networks` step, set the Destination Network to `VM-RegionA01-vDS-MGMT`

<details><summary>Screenshot 1.8</summary>
<img src="Images/2019-06-11-07-40-00.png">
</details>
<br/>

1.9 On the `Customize Template` step, enter the following variables:

- Application
  - System Root User Password: VMware1!VMware1!
  - CLI Admin User Password: VMware1!VMware1!
  - CLI Audit User Password: VMware1!VMware1!
- DNS
  - DNS Server List: 192.168.110.10
  - Domain Search List: corp.local
- Network Properties
  - Default Gateway: 192.168.110.1
  - Hostname: nsxmgr01a-1
  - Management Network IPv4 Address: 192.168.110.31
  - Management Network Netmask: 255.255.255.0
  - Rolename: nsx-manager
- Services Configuration
  - Allow Root SSH Logins: True
  - Enable SSH: True
  - NTP Server: 192.168.100.1
- All other options were left as default values

<details><summary>Screenshot 1.8</summary>
<img src="Images/2019-06-11-07-41-53.png">
</details>
<br/>

1.9 On the Ready to Complete screen, click `Finish` to complete the Deploy OVF Template Wizard

<details><summary>Screenshot 1.9</summary>
<img src="Images/2019-06-11-07-42-09.png">
</details>
<br/>

1.10 In the vSphere web client go to the task console and verify that the Status for Deploy OVF Template is "Completed" before proceeding
<br/>

<details><summary>Screenshot 1.10</summary>
<img src="Images/2018-10-17-00-51-10.png">
</details>
<br/>

1.11 In the vSphere web client power on the nsxmgr01a-1 VM, wait a few minutes for NSX Manager to fully boot up before proceeding to the next step

NOTE: If the option to power on the nsxmgr-01a VM is not available, log out and then log back in to the vSphere web client

<details><summary>Screenshot 1.11</summary>
<img src="Images/2018-10-17-01-23-08.png">
</details>
<br/>

1.12 Open a web browser connection to NSX Manager, for example:

[https://nsxmgr01a-1.corp.local/login.jsp](https://nsxmgr01a-1.corp.local/login.jsp)

Login as:

- User: admin
- Password: VMware1!VMware1!

_NOTE: On your first login, you will be prompted to accept the EULA. Accept EULA and opt out of VMware Customer Experience program._

<details><summary>Screenshot 1.12</summary>
<img src="Images/2018-10-17-01-34-33.png">
</details>
<br/>

## Step 2: Add NSX Compute Manager

In this step, you create a connection between the NSX manager and your vCenter. This enables NSX manager to deploy VIBs to the hosts, controller and edge VMs, etc.

 2.1 Click anywhere on the screen to skip the "Welcome to NSX-T" Screen, click on the `System` tab and then on the left navigation bar Click `Fabric`, and then click `Compute Managers`

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-05-20-09-21-29.png">
</details>
<br/>

 2.2 Click on **Add** and Configure the New Compute Manager form with following values:

- Name: `vcsa-01a`
- Domain Name/IP Address: `vcsa-01a.corp.local`
- Type: `vCenter`
- Username: `administrator@vsphere.local`
- Password: `VMware1!`
- Clcik **Add**
- Click **Add** again to accept the vCenter certificate thumbprint

_NOTE: in a production implementation, you would first copy the vCenter thumbprint and then provide it in the form to properly authenticate the intial connection._

<details><summary>Screenshot 2.2.1</summary>
<img src="Images/2019-05-20-09-24-32.png">
</details>

<details><summary>Screenshot 2.2.2</summary>
<img src="Images/2018-12-13-16-17-18.png">
</details>
<br/>

 2.3 Click **Refresh** in the lower-left hand corner and verify the Compute Manager is `Registered` and `Up`

<details><summary>Screenshot 2.3.1</summary>
<img src="Images/2018-12-16-16-54-09.png">
</details>

<details><summary>Screenshot 2.3.2</summary>
<img src="Images/2018-12-16-16-55-15.png">
</details>
<br/>

## Step 3: Configure NSX-T Manager Cluster

It is a best practice to have redundancy for your NSX-T Managers. In this section we will add 2 additional NSX-T Manager nodes and configure a management cluster and a virtual IP for acccessing the cluster

 3.1 In NSX-T Manager from the `System` screen click `Overview` in the left navigation bar, and then click `Add Nodes`

<details><summary>Screenshot 3.1</summary>
<img src="Images/2019-05-20-09-32-00.png">
</details>
<br/>

 3.2 On the `Add Nodes > Common Attributes` screen, enable ssh and root access, enter the password `VMware1!VMware1!` for each of the password fields, scroll down and select the `Small` form factor and click `Next`

<details><summary>Screenshot 3.2</summary>
<img src="Images/2019-05-20-09-37-22.png">
</details>
<br/>

3.3 On the `Nodes` screen, add 2 nodes with the following attributes. Leave any parameters not defined below on their default values:

- nsxmgr01a-2
  - Name: nsxmgr01a-2
  - Cluster: RegionA01-MGMT01
  - Datastore: RegionA01-ISCI02-COMP01
  - Network: VM-RegionA01-vDS-MGMT
  - Management IP/Netmask: 192.168.110.32/24
  - Management Gateway: 192.168.110.1
  - On the top of the window, click "+ Add Node"
- nsxmgr01a-3
  - Name: nsxmgr01a-3
  - Cluster: RegionA01-MGMT01
  - Datastore: RegionA01-ISCI02-COMP01
  - Network: VM-RegionA01-vDS-MGMT
  - Management IP/Netmask: 192.168.110.33/24
  - Management Gateway: 192.168.110.1
  - Click Finish to complete the Add Nodes dialogue

**Wait for the additonal nodes to complete deploying prior to proceeding**

<details><summary>Screenshot 3.3.1</summary>
<img src="Images/2019-05-20-09-47-16.png">
</details>

<details><summary>Screenshot 3.3.2</summary>
<img src="Images/2019-05-20-09-49-34.png">
</details>
<br/>

 3.4 Configure Virtual IP Address for Management Cluster

 In NSX-T Manager on the `System > Overview` Screen, confirm you Management Cluster is `Stable`, and that the `Cluster Connectivity` value for all 3 manager nodes is `Up`. Next to the `Virtual IP` field, click `Edit`

<details><summary>Screenshot 3.4</summary>
<img src="Images/2019-05-20-10-23-39.png">
</details>
<br/>

 3.5 On the `Change Virtual IP` window, set the virtual IP to `192.168.110.42` and click `Save`. Wait for the change virtual IP workflow to complete before proceeding.

<details><summary>Screenshot 3.4.1</summary>
<img src="Images/2019-05-20-10-25-32.png">
</details>

<details><summary>Screenshot 3.4.2</summary>
<img src="Images/2019-05-20-10-27-22.png">
</details>
<br/>

 3.6 In your browser connection to NSX-T Manager, observe that until now, you have been connecting to nsxmgr01a-1.corp.local, which connects directly to the first nsx-t manager. Close your browser tab to NSX-T Manager and open a new browser tab to [https://nsxmgr-01a.corp.local/login.jsp](https://nsxmgr-01a.corp.local/login.jsp) and login with username `admin` and password `VMware1!VMware1!` 

 Note that the nsxmgr-01a.corp.local hostname resolves to 192.168.110.42, which is the new virtual IP address you configured in the previous step. Now that the NSX-T manager cluster is configured, you should typically connect to this virtual IP rather than connecting to a specific manager node. 

<details><summary>Screenshot 3.6</summary>
<img src="Images/2019-05-20-10-39-33.png">
</details>
<br/>

 3.7 Log into the vsphere client, navigate to the `Hosts and Clusters` view, select `nsxmgr01a-1` and in the actions menu select `Edit Settings`. Expand the `Memory` section and set the `Reservation` value to `0 MB` and click `OK`

 **Repeat this step for nsxmgr01a-2 and nsxmgr01a-3** to ensure the memory reservation for all 3 nsx managers is set to 0.

<details><summary>Screenshot 3.7.1</summary>
<img src="Images/2019-06-12-01-46-04.png">
</details>

<details><summary>Screenshot 3.7.2</summary>
<img src="Images/2019-06-12-01-45-21.png">
</details>
<br/>

## Step 4: Add Edge Nodes, Transport Zones and Uplink Profiles with the NSX-T Guided Preparation Workflow

 4.1 From the NSX-T Manager Homepage at the bottom of the `System` section, click `Get Started`, and then click `Setup Transport Nodes`

<details><summary>Screenshot 4.1.1</summary>
<img src="Images/2019-05-20-11-06-11.png">
</details>

<details><summary>Screenshot 4.1.2</summary>
<img src="Images/2019-05-20-11-09-26.png">
</details>
<br/>

 4.2 On the `Select Node Type` screen, select `NSX Edge VM` and click `Next`

<details><summary>Screenshot 4.2</summary>
<img src="Images/2019-05-20-12-19-28.png">nsxedge-
</details>
<br/>

 4.3 On the `Select NSX Edge` Screen, click `Add New Edge`

<details><summary>Screenshot 4.3</summary>
<img src="Images/2019-05-20-12-21-02.png">
</details>
<br/>

 4.4 Complete the Add Edge VM workflow with the following values:

 - Name: nsxedge-1
 - FQDN: nsxedge-1.corp.local   
 - Form Factor: medium
 - Click Next
 - CLI Password: VMware1!VMware1!
 - System Root Password: VMware1!VMware1!
 - Compute Manager: vcsa-01a
 - Cluster: RegionA01-MGMT01
 - Datastore: RegionA01-ISCSI02-COMP01
 - Click Next
 - Management: VM-RegionA01-vDS-MGMT
 - Select "Static" (not DHCP)
 - Management IP: 192.168.110.91/24
 - Gateway IP: 192.168.110.1
 - fp-eth0: Uplink-RegionA01-vDS-MGMT
 - fp-eth1: Transport-RegionA01-vDS-MGMT
 - fp-eth2: VM-RegionA01-vDS-MGMT
 - Click Finish

<details><summary>Screenshot 4.4.1</summary>
<img src="Images/2019-05-20-13-21-34.png">
</details>

<details><summary>Screenshot 4.4.2</summary>
<img src="Images/2019-05-20-13-22-43.png">
</details>

<details><summary>Screenshot 4.4.3</summary>
<img src="Images/2019-06-11-23-58-16.png">
</details>

<details><summary>Screenshot 4.4.4</summary>
<img src="Images/2019-05-20-13-32-49.png">
</details>
<br/>

 4.5 On the `Select NSX Edge` screen, Click `Add New Edge` to add the second edge VM just like in the previous step, but using the variables below. After you finish the add new edge workflow, wait for both edges to complete installing before proceeding to the next step.

 - Name: nsxedge-2
 - FQDN: nsxedge-2.corp.local   
 - Form Factor: medium
 - Click Next
 - CLI Password: VMware1!VMware1!
 - System Root Password: VMware1!VMware1!
 - Compute Manager: vcsa-01a
 - Cluster: RegionA01-MGMT01
 - Datastore: RegionA01-ISCSI01-COMP01
 - Click Next
 - Management: VM-RegionA01-vDS-MGMT
 - Select "Static" (not DHCP)
 - Management IP: 192.168.110.92/24
 - Gateway IP: 192.168.110.1
 - fp-eth0: Uplink-RegionA01-vDS-MGMT
 - fp-eth1: Transport-RegionA01-vDS-MGMT
 - fp-eth2: VM-RegionA01-vDS-MGMT
 - Click Finish
 - Wait for the edge node deployments to complete before proceeding.

<details><summary>Screenshot 4.5.1</summary>
<img src="Images/2019-05-20-13-38-07.png">
</details>

<details><summary>Screenshot 4.5.2</summary>
<img src="Images/2019-05-20-13-38-50.png">
</details>

<details><summary>Screenshot 4.5.3</summary>
<img src="Images/2019-05-20-13-22-43.png">
</details>

<details><summary>Screenshot 4.5.4</summary>
<img src="Images/2019-06-11-23-58-16.png">
</details>

<details><summary>Screenshot 4.5.5</summary>
<img src="Images/2019-05-20-13-32-49.png">
</details>
<br/>

 4.6 If Your NSX Manager Session times out while the edges are being deployed, log back in and return to the System > Get Started page, click `Setup Transport Nodes` and then select `NSX Edge VM` to return to the `Select NSX Edge` page. 


 4.7 On the `Select NSX Edge` screen select `nsxedge-1` from the `Edge Node` Pulldown Menu and click `Next` 

<details><summary>Screenshot 4.7</summary>
<img src="Images/2019-05-25-08-28-38.png">
</details>
<br/>

 4.8 On the `Select Transport Zone East-West` Screen, select `Create Overlay Transport Zone`

<details><summary>Screenshot 4.8</summary>
<img src="Images/2019-05-25-08-31-55.png">
</details>
<br/>

 4.9 In the `Add Transport Zone` workflow, enter the following values:

- Name: `overlay-tz`
- N-VDS Name: `hostswitch-overlay`
- Traffic Type: `Overlay`
- Click **Add** 

<details><summary>Screenshot 4.9</summary>
<img src="Images/2019-05-25-08-35-54.png">
</details>
<br/>

 4.10 On the `Select Transport Zone East-West` scree, select `overlay-tz` from the `Overlay Transport Zone` pulldown menu and click `Next` 

<details><summary>Screenshot 4.10</summary>
<img src="Images/2019-05-25-08-37-51.png">
</details>
<br/>

 4.11 On the `Select Uplink Profile East-West` screen, select `nsx-edge-single-nic-uplink-profile` from the `Select Uplink Profile` pulldown menu and click `Next`

<details><summary>Screenshot 4.11</summary>
<img src="Images/2019-05-28-10-31-42.png">
</details>
<br/>

 4.12 On the `Link to Transport Zone East-West` screen for `Assignment IP Address` select `Use IP Pool` and click `Create IP Pool`

<details><summary>Screenshot 4.12</summary>
<img src="Images/2019-05-25-09-04-14.png">
</details>
<br/>

 4.13 On the `Add IP Pool` screen, enter the following values:

- Name: `tep-ip-pool`
- Click `Add` under Subnets
- IP Range: `192.168.130.51-192.168.130.75`
- Gateway: `192.168.130.1`
- CIDR: `192.168.130.0/24`
- DNS Servers:  `192.168.110.10`
- DNS Suffix: `Corp.local`
- Click **Add**

<details><summary>Screenshot 4.13</summary>
<img src="Images/2019-05-25-10-05-37.png">
</details>
<br/>

 4.14 On the `Link to Transport Zone East-West` screen in the `NSX Edge NIC Connections` section, set the value for `fp-eth1` to `uplink-1` and click `Next`

<details><summary>Screenshot 4.14</summary>
<img src="Images/2019-05-28-10-37-23.png">
</details>
<br/>

 4.15 On the `Select Transport Zone North-South` screen, click `Create VLAN Transport Zone`

<details><summary>Screenshot 4.15</summary>
<img src="Images/2019-05-28-10-39-48.png">
</details>
<br/>

 4.16 On the `Add Transport Zone` screen, add a transport zone with the following parameters:

 - Name: vlan-tz
 - N-VDS Name: hostswitch-vlan
 - Traffic Type: VLAN
 - Click **Add**

<details><summary>Screenshot 4.16</summary>
<img src="Images/2019-05-28-10-42-04.png">
</details>
<br/>

 4.17 On the `Select Transport Zone North-South` screen, select `vlan-tz` from the pulldown menu for `VLAN Transport Zone` and click `Next`

<details><summary>Screenshot 4.17</summary>
<img src="Images/2019-05-28-10-43-45.png">
</details>
<br/>

 4.18 On the `Select Uplink Profile North-South` screen, select `nsx-edge-single-nic-uplink-profile` from the `Select Uplink Profile` pulldown menu and click `Next`

<details><summary>Screenshot 4.18</summary>
<img src="Images/2019-05-28-10-45-56.png">
</details>
<br/>

 4.19 On the `Link To Transport Zone North-South` screen, leave the `Assignment IP Address` value blank/empty as shown in the screenshot below. In the `NSX Edge NIC Connections` section, set the value for `fp-eth0` to `uplink-1` and click `Next`

<details><summary>Screenshot 4.19</summary>
<img src="Images/2019-05-28-11-30-21.png">
</details>
<br/>

 4.20 On the `Add To NSX Edge Cluster` screen, select `Add To New NSX Edge Cluster (system created)` field, set the `NSX Edge Cluster Name` value to `edge-cluster-1` and click `Next`

<details><summary>Screenshot 4.20</summary>
<img src="Images/2019-05-28-11-43-35.png">
</details>
<br/>

 4.21 On the `Review` screen, set the `Transport Node Name` to `edge-tn-1` and click `Finish`

<details><summary>Screenshot 4.21</summary>
<img src="Images/2019-05-28-11-46-06.png">
</details>
<br/>

4.22 Next you need to complete the setup of your second NSX Edge node and connect it to the edge cluster. 

On the `Setup Transport Nodes`screen, click `Setup Transport Nodes`

<details><summary>Screenshot 4.22</summary>
<img src="Images/2019-05-20-11-09-26.png">
</details>
<br/>

 4.23 On the `Select Node Type` screen, select `NSX Edge VM` and click `Next`

<details><summary>Screenshot 4.23</summary>
<img src="Images/2019-05-20-12-19-28.png">
</details>
<br/>

 4.24 On the `Select NSX Edge` screen select `nsxedge-2` from the `Edge Node` Pulldown Menu and click `Next` 

<details><summary>Screenshot 4.24</summary>
<img src="Images/2019-05-28-12-05-33.png">
</details>
<br/>

 4.25 On the `Select Transport Zone East-West` scree, select `overlay-tz` from the `Overlay Transport Zone` pulldown menu and click `Next` 

<details><summary>Screenshot 4.25</summary>
<img src="Images/2019-05-25-08-37-51.png">
</details>
<br/>

 4.26 On the `Select Uplink Profile East-West` screen, select `nsx-edge-single-nic-uplink-profile` from the `Select Uplink Profile` pulldown menu and click `Next`

<details><summary>Screenshot 4.26</summary>
<img src="Images/2019-05-28-10-31-42.png">
</details>
<br/>

 4.27 On the `Link to Transport Zone East-West` screen for `Assignment IP Address` select `Use IP Pool` and select `tep-ip-pool` as the value for `IP Pool`. In the `NSX Edge NIC Connections` section, set the value for `fp-eth1` to `uplink-1` and click `Next`

<details><summary>Screenshot 4.27</summary>
<img src="Images/2019-05-28-12-13-32.png">
</details>
<br/>

 4.28 On the `Select Transport Zone North-South` screen, select `vlan-tz` from the pulldown menu for `VLAN Transport Zone` and click `Next`

<details><summary>Screenshot 4.28</summary>
<img src="Images/2019-05-28-10-43-45.png">
</details>
<br/>

 4.29 On the `Select Uplink Profile North-South` screen, select `nsx-edge-single-nic-uplink-profile` from the `Select Uplink Profile` pulldown menu and click `Next`

<details><summary>Screenshot 4.29</summary>
<img src="Images/2019-05-28-10-45-56.png">
</details>
<br/>

 4.30 On the `Link To Transport Zone North-South` screen, leave the `Assignment IP Address` value blank/empty as shown in the screenshot below. In the `NSX Edge NIC Connections` section, set the value for `fp-eth0` to `uplink-1` and click `Next`

<details><summary>Screenshot 4.30</summary>
<img src="Images/2019-05-28-11-30-21.png">
</details>
<br/>

 4.31 On the `Add To NSX Edge Cluster` screen, select `Add To Existing NSX Edge Cluster` field, set the `NSX Edge Cluster Name` value to `edge-cluster-1` and click `Next`

<details><summary>Screenshot 4.31</summary>
<img src="Images/2019-05-28-12-17-30.png">
</details>
<br/>

 4.32 On the `Review` screen, set the `Transport Node Name` to `edge-tn-2` and click `Finish`

<details><summary>Screenshot 4.32</summary>
<img src="Images/2019-05-28-12-18-32.png">
</details>
<br/>

 4.33 On the `System` tab in NSX Manager UI, In the left navigation bar expand the `Fabric` section and select `Nodes`. Select the `Edge Transport Nodes` tab, verify that `edge-tn-1` and `edge-tn-2` have a `Configuration State` of `Success`, a `Node Status` of `UP`, and are members of `edge-cluster-1`

<details><summary>Screenshot 4.33</summary>
<img src="Images/2019-06-12-00-20-59.png">
</details>
<br/>

 4.34 Log into the vsphere client, navigate to the `Hosts and Clusters` view, select `nsxedge-1` and select `Power > Shut Down Guest OS` to shut down `nsxedge-1`. From the actions menu for `nsxedge-1` select `Edit Settings`. Expand the `Memory` section, **uncheck** the box for `Reserve all guest memory (All Locked)`, set the `Reservation` value to `0 MB` and click `OK`

 **Repeat this step for nsxedge-2** and ensure that the box for the `Reserve all guest memory` value is unchecked and `Reservation` is set to `0 MB` for nsxedge-2, and that nsxedge-2 is powered down.

In a normal environment, you would not need to shut down the nsx edge vm's, however in the highly-oversubsribed and low performance lab environment, the host preparation we will do in the following steps is more reliable if we power off the edge's now and power them back on after the ESXi hosts are prepped for NSX-T. 

<details><summary>Screenshot 4.34.1</summary>
<img src="Images/2019-06-13-12-29-00.png">
</details>

<details><summary>Screenshot 4.34.2</summary>
<img src="Images/2019-06-13-12-29-36.png">
</details>

<details><summary>Screenshot 4.34.3</summary>
<img src="Images/2019-06-12-02-12-33.png">
</details>
<br/>

## Step 5: Prepare and Configure ESXi Hosts as NSX-T Transport Nodes

Preparing hosts entails NSX Manager deploying and installing NSX VIBs (i.e.kernel modues) and configuring the NSX tunnel endpoints and participation in the N-VDS overlay fabric.

 5.1 From the NSX Manager UI go to the `System > Get Started` page and click `SET UP TRANSPORT NODES` 

<details><summary>Screenshot 5.1</summary>
<img src="Images/2019-05-20-11-09-26.png">
</details>
<br/>

 5.2 On the `Select Node Type` screen select `Host Cluster` and click `Next`

<details><summary>Screenshot 5.2</summary>
<img src="Images/2019-05-29-08-38-02.png">
</details>
<br/>

 5.3 On the `Select Host Cluster` Screen, set the value for `Host Cluster` to `RegionA01-COMP01`, when you make this selection, the page will prompt you to `Confirm Installation`, click `Install`. Do not proceed until the status in the `NSX` column for `esx-01a`, `esx-02a` and `esx-03a` is `NSX Installed`, and that `NSX Manager Connectivity` is `Up` for each host as shown in the screenshots below.

<details><summary>Screenshot 5.3.1</summary>
<img src="Images/2019-05-29-08-40-38.png">
</details>

<details><summary>Screenshot 5.3.2</summary>
<img src="Images/2019-06-12-00-26-45.png">
</details>

<details><summary>Screenshot 5.3.3</summary>
<img src="Images/2019-06-12-00-39-14.png">
</details>
<br>

 5.4 On the `Select Transport Zone East-West` screen set the value for `Overlay Transport Zone` to `overlay-tz` and click `Next`

<details><summary>Screenshot 5.4</summary>
<img src="Images/2019-06-12-00-43-34.png">
</details>
<br/>

 5.5 On the `Select Uplink Profile East-West` screen, set the value for `Select Uplink Profile` to `nsx-default-uplink-hostswitch-profile` and click `Next`

<details><summary>Screenshot 5.5</summary>
<img src="Images/2019-06-12-00-45-10.png">
</details>
<br/>

 5.6 On the `Link to Transport Zone East-West` screen, set the value for `Assignment IP Address` to `Use IP Pool` and set the value for `IP Pool` to `tep-ip-pool`

<details><summary>Screenshot 5.6</summary>
<img src="Images/2019-06-12-00-48-07.png">
</details>
<br/>

 5.7 On the `Link to Transport Zone East-West` screen, in the `Host NIC Connections` section, set the value for `vmnic` to `uplink-1` and click `Next`

<details><summary>Screenshot 5.7</summary>
<img src="Images/2019-06-12-00-50-07.png">
</details>
<br/>

 5.8 On the `Review` screen, click `Finish`

<details><summary>Screenshot 5.8</summary>
<img src="Images/2019-06-12-00-51-31.png">
</details>
<br/>

 5.9 From the NSX Manager UI go to the `System > Get Started` page and click `SET UP TRANSPORT NODES` 

<details><summary>Screenshot 5.9</summary>
<img src="Images/2019-05-20-11-09-26.png">
</details>
<br/>

 5.10 On the `Select Node Type` screen select `Host Cluster` and click `Next`

<details><summary>Screenshot 5.10</summary>
<img src="Images/2019-05-29-08-38-02.png">
</details>
<br/>

 5.11 On the `Select Host Cluster` Screen, set the value for `Host Cluster` to `RegionA01-MGMT01`, when you make this selection, the page will prompt you to `Confirm Installation`, click `Install`. Do not proceed until the status in the `NSX` column for `esx-04a`, `esx-05a` and `esx-06a` is `NSX Installed`, and that `NSX Manager Connectivity` is `Up` for each host as shown in the screenshots below.

<details><summary>Screenshot 5.11.1</summary>
<img src="Images/2019-06-12-00-54-41.png">
</details>

<details><summary>Screenshot 5.11.2</summary>
<img src="Images/2019-06-12-00-55-02.png">
</details>

<details><summary>Screenshot 5.11.3</summary>
<img src="Images/2019-06-12-02-10-40.png">
</details>
<br>

 5.12 On the `Select Transport Zone East-West` screen set the value for `Overlay Transport Zone` to `overlay-tz` and click `Next`

<details><summary>Screenshot 5.12</summary>
<img src="Images/2019-06-12-00-43-34.png">
</details>
<br/>

 5.13 On the `Select Uplink Profile East-West` screen, set the value for `Select Uplink Profile` to `nsx-default-uplink-hostswitch-profile` and click `Next`

<details><summary>Screenshot 5.13</summary>
<img src="Images/2019-06-12-00-45-10.png">
</details>
<br/>

 5.14 On the `Link to Transport Zone East-West` screen, set the value for `Assignment IP Address` to `Use IP Pool` and set the value for `IP Pool` to `tep-ip-pool`

<details><summary>Screenshot 5.14</summary>
<img src="Images/2019-06-12-00-48-07.png">
</details>
<br/>

 5.15 On the `Link to Transport Zone East-West` screen, in the `Host NIC Connections` section, set the value for `vmnic` to `uplink-1` and click `Next`

<details><summary>Screenshot 5.15</summary>
<img src="Images/2019-06-12-00-50-07.png">
</details>
<br/>

 5.16 On the `Review` screen, click `Finish`

<details><summary>Screenshot 5.16</summary>
<img src="Images/2019-06-12-00-51-31.png">
</details>
<br/>

 5.17 Log into the vSphere client, navigate to the `Hosts and Clusters` screen, select the `nsxedge-1` VM and from the actions menu select `Power > Power On`. Repeat this step to power on `nsxedge-2`. Wait a few minutes for the NSX Edge VM's to fully boot up before proceeding to the next step. 

<details><summary>Screenshot 5.17</summary>
<img src="Images/2019-06-13-12-38-01.png">
</details>
<br/>

 5.18 On the `System` tab in NSX Manager UI, In the left navigation bar expand the `Fabric` section and select `Nodes`. Select the `Edge Transport Nodes` tab, verify that `edge-tn-1` and `edge-tn-2` have a `Configuration State` of `Success`, a `Node Status` of `UP`, and are members of `edge-cluster-1`

<details><summary>Screenshot 5.18</summary>
<img src="Images/2019-06-12-00-20-59.png">
</details>
<br/>

**You have now completed the NSX-T Manual Install for PKS Installation Wizard lab guide**