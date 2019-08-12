# Upgrade vSphere 6.5U1 to 6.5U2

For NSXT 2.3 Manual Installation, please see the Pks1.3 Branch

## Overview

If you are using a Ninja-v11 template, you will need to upgrade your vSphere environment to vSphere 6.5U2 prior to installing NSX-T 2.4. In the base v11 template, the pre-installed vSphere is running 6.5U1, and this must be updated prior to the installation of NSX-t 2.4. vSphere 6.5U2 is a listed requirement for 1.4 installations, however in the lab it is possible to install PKS 1.4 with NSX-T 2.3 without needing to update to vSphere 6.5U2. 

## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment

This lab is only required for PKS v11 and earlier templates, when PKS v12 templates are published (Still in planning at time this was written) they will include vSphere 6.7 and will not be required or compatible with this lab guide.

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing requirements. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

### Overview of Tasks Covered in this Lab Guide

- [Step 1:  Upgrade vCenter Server Appliance & Platform Services Controller](#)
- [Step 2: Upgrade ESXi Hosts](#)

## Step 1:  Upgrade VCSA Appliance with Embedded PSC

1.1 From the Controle Center desktop, open a web browser tab and connect to the vcsa appliance management at url [https://vcsa-01a.corp.local:5480/#/login?locale=en](https://vcsa-01a.corp.local:5480/#/login?locale=en). Login with the username `root` and password `VMware1!`

<Details><Summary>Screenshot 1.1</Summary>
<img src="Images/2019-05-16-23-33-11.png">
</Details>
<br/>

1.2 On the Summary page, ensure the Helth Statuses are all Good, and click on the update tab

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-05-18-06-51-52.png">
</details>
<br/>

1.3 On the Update page click `Check Updates` > `Check Repository`

<details><summary>Screenshot 1.3</summary>
<img src="Images/2019-05-18-06-54-56.png">
</details>
<br/>

1.4 In the `Available Updates` section, click `Install Updates` > `Install All Updates`. When Prompted, accept the EULA, and on the `Configure CEIP` screen, click `Install` and wait for installation to complete and press `OK`.

<details><summary>Screenshot 1.4.1</summary>
<img src="Images/2019-05-18-06-57-45.png">
</details>

<details><summary>Screenshot 1.4.2</summary>
<img src="Images/2019-05-18-06-59-46.png">
</details>

<details><summary>Screenshot 1.4.3</summary>
<img src="Images/2019-05-18-07-15-06.png">
</details>
<br/>

1.5 CLick the option to `Logout` of the vCenter Server Appliance manager, and then log back into the vCenter Server Appliance Manager. When you log back in, you should see a `Reboot required` message, click `Reboot` and wait for the reboot operation to complete.

<details><summary>Screenshot 1.5.1</summary>
<img src="Images/2019-05-18-07-32-42.png">
</details>

<details><summary>Screenshot 1.5.2</summary>
<img src="Images/2019-05-18-07-23-26.png">
</details>
<br/>

**You have Now Completed the Upgrade of VCSA & PSC**

## Step 2:  Upgrade ESXi Hosts in your vCenter

2.1 From the Controle Center desktop, open a web browser tab and connect to the vSphere Web Client (Not the HTML5 Client) at url [https://vcsa-01a.corp.local/vsphere-client/](https://vcsa-01a.corp.local/vsphere-client/). Check the box to use windows session authentication and login.

Note: It may take a few minutes after the VCSA Upgrade & Reboot before you can login successfully

2.2 Hover your mouse over the pulldown menu and select `Update Manager` as shown in the screenshot below

<Details><Summary>Screenshot 2.2</Summary>
<img src="Images/2019-05-18-07-39-12.png">
</Details>
<br/>

2.3 In the Navigator section on the left side of the screen, click `vcsa-01a.corp.local`

<Details><Summary>Screenshot 2.3</Summary>
<img src="Images/2019-05-18-07-40-59.png">
</Details>
<br/>

2.4 On the Update Manager page, click on the `Manage` Tab and click on the `ESXi Images` tab

<Details><Summary>Screenshot 2.4</Summary>
<img src="Images/2019-05-18-07-44-46.png">
</Details>
<br/>

2.5 Open an additional browser tab and go to my.vmware.com and login with your personal login information

Note: You will need a my vmware account, if you do not have one, sign up

<Details><Summary>Screenshot 2.5</Summary>
<img src="Images/2019-05-18-07-48-43.png">
</Details>
<br/>

2.6 Click on `All Downloads`, In the list find `VMware vSphere Hypervisor (ESXi)` and click `View Download Components` , and then select the option to download `VMware vSphere Hypervisor 6.5`

<Details><Summary>Screenshot 2.6.1</Summary>
<img src="Images/2019-05-18-07-50-56.png">
</Details>

<Details><Summary>Screenshot 2.6.2</Summary>
<img src="Images/2019-05-18-07-52-45.png">
</Details>

<Details><Summary>Screenshot 2.6.3</Summary>
<img src="Images/2019-05-18-07-55-00.png">
</Details>
<br/>

2.7 If required, click the `Register` button to register for access to download ESXi and accept the EULA

<Details><Summary>Screenshot 2.7</Summary>
<img src="Images/2019-05-18-07-57-33.png">
</Details>
<br/>

2.8 Find and expand the list item for `VMware vSphere Hypervisor 6.5.0 Update 2 - Binaries`, and in the `VMware vSphere Hypervisor (ESXi ISO) image (Includes VMware Tools)` section, click `Manually Download` and save the download in the `E:\Downloads` folder

<Details><Summary>Screenshot 2.8.1</Summary>
<img src="Images/2019-05-18-08-01-45.png">
</Details>

<Details><Summary>Screenshot 2.8.2</Summary>
<img src="Images/2019-05-18-08-02-58.png">
</Details>
<br/>

2.9 Return to your vsphere web client tab on the `Update Manager > Manage > ESXi Images` screen and click `Import ESXi Image`. Browse and select the updated esxi image you downloaded in the previous step, wait for the image to upload and then click `Close`

<Details><Summary>Screenshot 2.9.1</Summary>
<img src="Images/2019-05-18-08-05-08.png">
</Details>

<Details><Summary>Screenshot 2.9.2</Summary>
<img src="Images/2019-05-18-08-06-22.png">
</Details>

<Details><Summary>Screenshot 2.9.3</Summary>
<img src="Images/2019-05-18-08-07-08.png">
</Details>

<Details><Summary>Screenshot 2.9.4</Summary>
<img src="Images/2019-05-18-08-08-13.png">
</Details>
<br/>

2.10 On the upper right hand side of page, click `Go to Compliance View`

<Details><Summary>Screenshot 2.10</Summary>
<img src="Images/2019-05-18-08-09-51.png">
</Details>
<br/>

2.11 Click `Attach Baseline`, and then click `New Host Baseline` 

<Details><Summary>Screenshot 2.11.1</Summary>
<img src="Images/2019-05-18-08-11-19.png">
</Details>

<Details><Summary>Screenshot 2.11.2</Summary>
<img src="Images/2019-05-18-08-29-14.png">
</Details>
<br/>

2.12 In the `Name` Field, type `ESXi 6.5U2 Baseline`, and under `Baseline Type`, select `Host Upgrade` and click `Next`

<Details><Summary>Screenshot 2.12</Summary>
<img src="Images/2019-05-18-08-31-48.png">
</Details>
<br/>

2.13 On the ESXi Image screen, select the ESXi Image and click `Next`, and on the `Ready to Complete` page, click `Finish`

<Details><Summary>Screenshot 2.13.1</Summary>
<img src="Images/2019-05-18-08-33-48.png">
</Details>

<Details><Summary>Screenshot 2.13.2</Summary>
<img src="Images/2019-05-18-08-35-53.png">
</Details>
<br/>

2.14 On the `Attach Baseline or Baseline Group` page, click the checkbox for `ESXi 6.5U2 Baseline` and click `OK`

<Details><Summary>Screenshot 2.14</Summary>
<img src="Images/2019-05-18-08-38-01.png">
</Details>
<br/>

2.15 On the Update Manager screen, click `Remediate`

<Details><Summary>Screenshot 2.15</Summary>
<img src="Images/2019-05-18-08-39-52.png">
</Details>
<br/>

2.16 On the Remediate screen, select the `ESXi 6.5U2 Baseline` and click `Next`

<Details><Summary>Screenshot 2.16</Summary>
<img src="Images/2019-05-18-08-41-06.png">
</Details>
<br/>

2.17 On the Select Target Objects screen, select all the hosts and click `Next`

<Details><Summary>Screenshot 2.17</Summary>
<img src="Images/2019-05-18-08-43-17.png">
</Details>
<br/>

2.18 Proceed with the default options on the `EULA`, `Advanced Options`, `Host Remediateion Options`, and `Cluster Remediation Options` steps, and on the `Ready to Complete` screen, click `Finish`

<Details><Summary>Screenshot 2.18.1</Summary>
<img src="Images/2019-05-18-08-45-59.png">
</Details>

<Details><Summary>Screenshot 2.18.2</Summary>
<img src="Images/2019-05-18-08-46-26.png">
</Details>

<Details><Summary>Screenshot 2.18.3</Summary>
<img src="Images/2019-05-18-08-46-56.png">
</Details>

<Details><Summary>Screenshot 2.18.4</Summary>
<img src="Images/2019-05-18-08-47-34.png">
</Details>

<Details><Summary>Screenshot 2.18.5</Summary>
<img src="Images/2019-05-18-08-48-13.png">
</Details>
<br/>

2.19 Hover over the home pulldown menu and select `Tasks`

<Details><Summary>Screenshot 2.17</Summary>
<img src="Images/2019-05-18-08-50-33.png">
</Details>
<br/>

2.20 On the Task Console page, observe there is an active task called `Remediate entity`, this task is upgrading the ESXi Hosts, observe the task until it is complete, at which point all ESXi Hosts will be upgraded.

<Details><Summary>Screenshot 2.20</Summary>
<img src="Images/2019-05-18-08-53-37.png">
</Details>
<br/>

**You have now completed upgrading your vSphere deployment to 6.5U2**