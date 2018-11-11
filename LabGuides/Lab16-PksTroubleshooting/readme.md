# Lab 16 - PKS Troubleshooting

**Contents:**

- [Step 1: Validate Base Environment]() <!-- Validate MTU, Base vCenter, components external to NSX and PKS -->
- [Step 2: Validate NSX-T Control Plane Health]()
- [Step 3: Validate Ops Manager & BOSH Director Health]()
- [Step 4: Validate PKS Control Plane Health]()
- [Step 5 Common Troubleshooting Scenarios]()
- [Next Steps]()

## Overview

In this section you will review the core troubleshooting tools used in PKS troubleshooting with a focus on core product CLI and UI tools not inclusive of external monitoring and operational tools such as the vRealize suite or Wavefront, which are covered in different sections

When facing a troubleshooting scenario, there are a few common steps that should be taken in nearly every scenario:

- First, it is almost always a best practice to open a support case early in any scenario where problems may occur to help ensure customer satisfaction. VMware support teams for PKS recommend opening proactive support requests (SRs) even for POC engagements, installation and planned updates in addition to unplanned outage support.
  - Plan to open a proactive support request for planned work engagements, and in the event of a problem scenario, it is recommended that you open a ticket as early as possible. This allows your request to be routed and in queue for a support agent while you take additional steps
  - While in queue you can continue to engage in troubleshooting steps and in the event you are not able to resolve the issue yourself, this method will ensure the quickest path to a support agent to help assure an optimal resolution
- Next, attain a functional understand of the target environment and ensure you have sufficient documentation, understanding and access to the environment to move forward towards a successful resolution
- Next, validate the last known working state of the environment, and identify any potential changes that have occurred in the environment that may have affected the previously known working state

In this lab guide, we will initially focus on validating all the core PKS components following a standard installation. The steps will follow the order by which PKS and related software are typically installed and configured, just as you performed in Labs 2 and 3.

This is not necessarily an ideal order to follow in a troubleshooting scenario as you may have error messages or other contextual information that lead you on a more direct path, however in lieu of more direct information running through an all-around validation of core components is an excellent excercise to help identify error conditions with details that can lead towards problem resolution

## Step 1: Validate Base Environment

**Stop:** Prior to beginning this lab, you should have a functional PKS deployment running in a non-production lab environment. For students following the Ninja course, all steps from labs 2-5 should be completed in your lab environment before proceeding.

1.1 Install vSphere PKS Plugin

The vSphere PKS plugin is a plugin for the vSphere HTML5 client that is optimized to support common workflows for virtual infrastructure administrators supporting PKS environments, and is a very useful tool for validating the health of the PKS environment and rapidly identifying and accessing related assets and tools to accelerate problem resolution

1.1.0 From the control center desktop, open a web browser connection to `https://labs.vmware.com/flings/vsphere-pks-plugin`, accept the license agreement and download the OVA file for the vSphere PKS Plugin.

<details><summary>Screenshot 1.1.0 </summary>
<img src="Images/2018-11-09-14-53-01.png">
</details>
<br/>

1.1.1 Open a web browser connection to the vSphere client at `https://vcsa-01a.corp.local/vsphere-client`. Do not use the HTML5 Client for the OVF deploy. On the `Hosts and Clusters` page, right click the `RegionA01-MGMT01` cluster and select `Deploy OVF Template`

<details><summary>Screenshot 1.1.1</summary>
<img src="Images/2018-11-10-01-53-41.png">
</details>
<br/>

1.1.2 On the `Select Template` screen, select `local file` and select the vSphere PKS Plugin OVA File in the `E:\Downloads` directory

<details><summary>Screenshot 1.1.2</summary>
<img src="Images/2018-11-09-23-09-37.png">
</details>
<br/>

1.1.3 On the `Select name and location` screen, set the `Name` to `pks-ui` and click `Next`

<details><summary>Screenshot 1.1.3</summary>
<img src="Images/2018-11-09-23-11-42.png">
</details>
<br/>

1.1.4 On the `Select a resource` screen, select the `RegionA01-MGMT01` cluster and click `Next`

<details><summary>Screenshot 1.1.4</summary>
<img src="Images/2018-11-10-01-55-47.png">
</details>
<br/>

1.1.5 On the `Review Details` screen, click `Next`

<details><summary>Screenshot 1.1.5</summary>
<img src="Images/2018-11-09-23-25-17.png">
</details>
<br/>

1.1.6 On the `Accept license agreements` screen, click `Accept` and then click `Next`

<details><summary>Screenshot 1.1.6</summary>
<img src="Images/2018-11-09-23-26-26.png">
</details>
<br/>

1.1.7 On the `Select Storage` screen, set the virtual disk format to `Thin provision`, set the `Datastore` to `RegionA01-ISCSI01-COMP01` and then click `Next`

<details><summary>Screenshot 1.1.7</summary>
<img src="Images/2018-11-10-01-57-51.png">
</details>
<br/>

1.1.8 On the `Select networks` screen, set both `VM Network` and `PKS Deployment Network` to `ESXi-RegionA01-vDS-MGMT` and then click `Next`

<details><summary>Screenshot 1.1.8</summary>
<img src="Images/2018-11-10-01-58-54.png">
</details>
<br/>

1.1.9 On the `Customize template` screen, enter the following values:

- VC Address where the UI plugin will be running: vcsa-01a.corp.local
- Root Password: VMware1!
- Permit Root Login: True
- Network IP Address: 172.31.0.8
- Network Netmask: 255.255.255.0
- Default Gateway: 172.31.0.1
- Domain Name Servers: 192.168.110.10
- Domain Search Path: corp.local
- FQDN: pks-ui.corp.local
- Leave other settings to their default values and click `Next`

<details><summary>Screenshot 1.1.9</summary>
<img src="Images/2018-11-09-23-39-13.png">
</details>
<br/>

1.1.10 On the `Ready to complete` screen, validate configuration data and click `Finish`

<details><summary>Screenshot 1.1.10</summary>
<img src="Images/2018-11-09-23-45-59.png">
</details>
<br/>

Note: If there are insufficient resources to deploy the OVA, edit the settings for the NSX-T Controller, Edge & Manager to remove resource reservations

Please proceed through the following steps while the OVA template is deploying

1.2 Confirm all VM's installed and configured during NSX-T and PKS installation are running and in good health in vCenter

1.2.1 Login to the vSphere web client, Navigate to `Hosts and Clusters`, and verify that the `nsxt-manager`, `nsxc-1` and `nsxedge-1.corp.local` virtual machines are powered on. View the summary screen of each VM to ensure there are no error messages and overall VM health appears good

<details><summary>Screenshot 1.2.1 </summary>
<img src="Images/2018-11-09-03-20-33.png">
</details>
<br/>

1.2.2 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-mgmt-1` resource pool and check the summary tab of the `opsman`, BOSH and Harbor VM's. The BOSH and Harbor VM's have automatically generated VM names that are hard to identify. If you look under the `pks-mgmt-1` resource pool, you should see two virtual machines that have names beginning with "vm-", if you click on each of these VM's, on the summary tab under `Custom Attributes`, the value for the `Deployment` parameter should be `p-bosh` for the BOSH VM and `harbor-container-registry-...` for the harbor VM, as shown in the following screenshots

Note: You should also see some VM's in the `pks-mgmt-1` resource pool that have names beginning with "sc-". These VMs are used by BOSH when processing certain tasks, these VMs may be off or on under normal healthy state, however if they are powered on it indicates BOSH is processing a task and should be checked as it could be related to other unexpected behavior in the environment

<details><summary>Screenshot 1.2.2.1</summary>
<img src="Images/2018-11-09-03-38-24.png">
</details>

<details><summary>Screenshot 1.2.2.2</summary>
<img src="Images/2018-11-09-03-39-00.png">
</details>

<details><summary>Screenshot 1.2.2.3</summary>
<img src="Images/2018-11-09-03-42-20.png">
</details>
<br/>

1.2.3 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-mgmt-2` resource pool and check the summary tab to verify the health of the PKS control plane VM. This should be the only VM running in the `pks-mgmt-2` resource pool, which can be confirmed by verifying the `Deployment` value under `Custom Attributes` includes `pivotal-container-service-...` as shown in the following screenshot

<details><summary>Screenshot 1.2.3</summary>
<img src="Images/2018-11-09-03-50-12.png">
</details>
<br/>

1.2.4 From the control center desktop, open a putty session with cli-vm, login, authenticate to the PKS API, get the kubectl context for `my-cluster` and view the the kubernetes node ID's for `my-cluster` with the following commands. You will need to reference the node names provided here in the following steps

Note: If you do not currently have a cluster deployed, please deploy a cluster per the instructions in [Step 2 of Lab5](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/Lab5-DeployFirstCluster#step-2-login-to-pks-cli-and-create-cluster) before proceeding

```bash
pks login -a pks.corp.local -u pksadmin -k -p VMware1!
pks get-credentials my-cluster
kubectl get nodes
```

<details><summary>Screenshot 1.2.4</summary>
<img src="Images/2018-11-09-18-15-24.png">
</details>
<br/>

1.2.5 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-comp-1` resource pool and view the VM's in the resource pool. In the current configuration, all master and node VM's for all Kubernetes clusters created with this PKS instance will be deployed to the `pks-comp-1` resource pool.

Currently in your lab environment you should have one small kubernetes deployment. In Lab3, the small plan settings were configured to provision a single master and 3 worker nodes (The same configuration is also applied during pipeline execution). Accordingly you should see four virtual machines in the resource pool.

Review the output of the `kubectl get nodes` command from the previous step. Observe that there are only 3 nodes listed, which is because the master does not run the kubectl agent, only the nodes.

Click on one of the VM's in the `pks-comp-1` resource pool, navigate to the `Summary` tab and scroll down as needed in the `Custom Attributes` to observe the value for the `job` attribute. If the value is `master`, click on a different VM in the `pks-comp-1` resource pool, repeat the preceding steps and verify that the value of the `job` attribute for the vm you have selected is `worker`. 

Near the top of the `Summary` page for the selected VM, observe the value for `DNS Name`, and compare this value to the output of the `kubectl get nodes` command from the previous step, one of the entries should match.

Part of the point of this step is to demonstrate the complexity of correlating Kubernetes constructs to vSphere constructs without additional tools. Keep in mind there is currently only a single cluster deployed, in a production environment there can be hundreds of nodes and dozens of clusters

<details><summary>Screenshot 1.2.5</summary>
<img src="Images/2018-11-09-22-58-38.png">
</details>
<br/>

1.3 Configure the vSphere PKS UI Plugin

1.3.1 In the vSphere web client, navigate to the `Hosts and Clusters` view, expand the `pks-mgmt-2` resource pool, right-click the `pks-ui` VM, select `Edit Settings`, set `Network adapter 1` to `ls-pks-mgmt` and click `OK`

<details><summary>Screenshot 1.3.1</summary>
<img src="Images/2018-11-10-00-06-01.png">
</details>
<br/>

1.3.2 In the vSphere web client, right-click the `pks-ui` VM and select `Power > Power On`

<details><summary>Screenshot 1.3.2</summary>
<img src="Images/2018-11-10-00-08-26.png">
</details>
<br/>

1.3.3 In the vSphere web client, right-click the `pks-ui` VM and select `Open Console`

<details><summary>Screenshot 1.3.3</summary>
<img src="Images/2018-11-10-00-19-55.png">
</details>
<br/>

1.3.4 In the console connection to the `pks-ui` VM, wait for the VM to complete booting and login with username `root` and password `VMware1!`

<details><summary>Screenshot 1.3.3</summary>
<img src="Images/2018-11-10-00-21-38.png">
</details>
<br/>

1.3.5 In v1.0 of the PKS UI technical preview, the OVF deploy does not provide an option to configure a static IP address for its 2nd NIC connection to the VM network. In the student lab environment DHCP is not configured to properly assign an approprate address for this interface, so in the following steps you will configure Photon OS, which is the OS used for the PKS UI VM, with a static IP address for the PKS UI VM's 2nd NIC.

1.3.6 From the console connection to the 'pks-ui' VM, make a copy of the network configuration file for the eth0 interface, naming the copy appropriately to define the settings for the eth1 interface with the command `cp /etc/systemd/network/09-pks.network /etc/systemd/network/10-vm.network`, and then use VI to edit the copied file with the command `vi /etc/systemd/network/10-vm.network`

<details><summary>Screenshot 1.3.6</summary>
<img src="Images/2018-11-10-00-32-29.png">
</details>
<br/>

1.3.7 Use VI to update the copied file to match the contents of the screenshot below, save the updates and exit VI

<details><summary>Screenshot 1.3.7</summary>
<img src="Images/2018-11-10-00-38-27.png">
</details>
<br/>

1.3.8 From the console connection to the `pks-ui` VM, restart network services with the command `systemctl restart systemd-networkd`, and then close the browser tab to the `pks-ui` console

<details><summary>Screenshot 1.3.8</summary>
<img src="Images/2018-11-10-00-41-35.png">
</details>
<br/>

1.3.9 Open a new web browser tab and navigate to https://192.168.100.72, login with the username `administrator@vsphere.local` and password `VMware1!`, and on the `Complete PKS plugin registration` screen, click `CONTINUE`

<details><summary>Screenshot 1.3.9</summary>
<img src="Images/2018-11-10-02-16-41.png">
</details>
<br/>

1.3.10 Continue with the `Complete PKS plugin registration` screen, click `REGISTER` and wait for the registration process to complete

<details><summary>Screenshot 1.3.10</summary>
<img src="Images/2018-11-10-02-18-40.png">
</details>
<br/>

1.3.10 Finish the `Complete PKS plugin registration` dialogue by clicking `LOGOUT`

<details><summary>Screenshot 1.3.10</summary>
<img src="Images/2018-11-10-02-21-56.png">
</details>
<br/>

1.3.11 From the control center desktop, if you have any open connections to the vSphere web or HTML5 client, log out of your sessions and close the tabs. Open a new browser window and log into the vSphere HTML5 Client, you should now see an option for `VMware PKS` on the Home screen, Shortcuts screen and in the pulldown menu

<details><summary>Screenshot 1.3.11</summary>
<img src="Images/2018-11-10-02-26-49.png">
</details>
<br/>