# vSphere 6.5 to 6.7 upgrade

## Overview

The base PKS Ninja v11 template uses vSphere 6.5U1, and needs to be upgraded prior to NSX-T 2.4 installation. This lab guide will provide specific steps to complete the installation on the PKS Ninja v11 lab template. Please see the vSphere upgrade center for further details and requirements related to the upgrade: https://www.vmware.com/products/vsphere/upgrade-center.html

## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [vSphere Upgrade Center](https://www.vmware.com/products/vsphere/upgrade-center.html)

### Overview of Tasks Covered in Lab 1

- [Step 1:  Deploy NSXT Manager using OVF Install Wizard](#step-1--deploy-nsxt-manager-using-ovf-install-wizard)
- [Step 2: Add NSX Compute Manager](#step-2-add-nsx-compute-manager)
- [Step 3: Deploy NSX Controller](#step-3-deploy-nsx-controller)
- [Step 4: Create IP Pools](#step-4-create-ip-pools)
- [Step 5: Prepare and Configure ESXi Hosts](#step-5-prepare-and-configure-esxi-hosts)
- [Step 6: Deploy NSX Edge](#step-6-deploy-nsx-edge)
- [Step 7: Create Edge Transport Node](#step-7-create-edge-transport-node)
- [Step 8: Create Switches and Routers](#step-8-create-switches-and-routers)
- [Step 9: Create Network Address Translation Rules](#step-9-create-network-address-translation-rules)
- [Step 10: Create IP Blocks for PKS Components](#step-10-create-ip-blocks-for-pks-components)
- [Step 11: Create NSX API Access Certificate](#step-11-create-nsx-api-access-certificate)

NOTE: NSX Manager OVA cannot be installed via HTML5 client, so for installation labs please use the vSphere web client (Flash-based).

If you intend to follow the manual NSX-T install with the automated pipeline for PKS, be sure to match the naming of objects/properties/configurations in this lab guide exactly.

This section follows the standard documentation, which includes additional details and explanations: [NSX Manager Installation](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-A65FE3DD-C4F1-47EC-B952-DEDF1A3DD0CF.html)

-----------------------

## Step 1:  Deploy NSXT Manager using OVF Install Wizard

1.1 In the vSphere web client (not the HTML5 Client), From the Hosts and Clusters view, right click on the RegionA01-MGMT01 Cluster and select `Deploy OVF Template'

<Details><Summary>Screenshot 1.1</Summary>
<img src="Images/2018-10-16-23-43-44.png">
</Details>
<br/>

1.2 On the `Select Template` step, select `Local File` and Navigate to the NSXT Manager OVA file, the filename should start with 'nsx-unified-appliance`. In the reference lab, this is located on the 'E:/Downloads' Directory

<details><summary>Screenshot 1.2</summary>
<img src="Images/2018-10-16-23-48-52.png">
</details>
<br/>