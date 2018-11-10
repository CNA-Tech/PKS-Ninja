# Lab 11 - PKS Troubleshooting

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

1.1 Confirm all VM's installed and configured during NSX-T and PKS installation are running and in good health in vCenter

1.1.0 From the control center desktop, open a web browser connection to `https://labs.vmware.com/flings/vsphere-pks-plugin`, accept the license agreement and download the OVA file for the vSphere PKS Plugin. This will be used in later steps and is being downloaded first to ensure the download completes when needed later in the lab guide.

<details><summary>Screenshot 1.1.0 </summary>
<img src="Images/2018-11-09-14-53-01.png">
</details>
<br/>

1.1.1 Login to the vSphere web client, Navigate to `Hosts and Clusters`, and verify that the `nsxt-manager`, `nsxc-1` and `nsxedge-1.corp.local` virtual machines are powered on. View the summary screen of each VM to ensure there are no error messages and overall VM health appears good

Note: In a typical environment, you should also reference the NSX-T and PKS documentation and ensure that the vCenter environment, ESXi hosts and NSX Management physical and virtual hosts have been configured with the approprate hardware and environment preparation required. In the student lab environment, due to resource limitations many of the resources are configured with suboptimal resource configurations that should never be used in POC or Production settings. The lab hardware has been preconfigured, and students have already completed and familiar with the installation steps used, so a comprehensive validation of the base environment is not needed in the lab steps, however additional validation should be considered in a production deployment

<details><summary>Screenshot 1.1.1 </summary>
<img src="Images/2018-11-09-03-20-33.png">
</details>
<br/>

1.1.2 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-mgmt-1` resource pool and check the summary tab of the `opsman`, BOSH and Harbor VM's. The BOSH and Harbor VM's have automatically generated VM names that are hard to identify. If you look under the `pks-mgmt-1` resource pool, you should see two virtual machines that have names beginning with "vm-", if you click on each of these VM's, on the summary tab under `Custom Attributes`, the value for the `Deployment` parameter should be `p-bosh` for the BOSH VM and `harbor-container-registry-...` for the harbor VM, as shown in the following screenshots

Note: You should also see some VM's in the `pks-mgmt-1` resource pool that have names beginning with "sc-". These VMs are used by BOSH when processing certain tasks, these VMs may be off or on under normal healthy state, however if they are powered on it indicates BOSH is processing a task and should be checked as it could be related to other unexpected behavior in the environment

<details><summary>Screenshot 1.1.2.1</summary>
<img src="Images/2018-11-09-03-38-24.png">
</details>

<details><summary>Screenshot 1.1.2.2</summary>
<img src="Images/2018-11-09-03-39-00.png">
</details>

<details><summary>Screenshot 1.1.2.3</summary>
<img src="Images/2018-11-09-03-42-20.png">
</details>
<br/>

1.1.3 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-mgmt-2` resource pool and check the summary tab to verify the health of the PKS control plane VM. This should be the only VM running in the `pks-mgmt-2` resource pool, which can be confirmed by verifying the `Deployment` value under `Custom Attributes` includes `pivotal-container-service-...` as shown in the following screenshot

<details><summary>Screenshot 1.1.3</summary>
<img src="Images/2018-11-09-03-50-12.png">
</details>
<br/>

1.1.4 From the control center desktop, open a putty session with cli-vm, login, authenticate to the PKS API, get the kubectl context for `my-cluster` and view the the kubernetes node ID's for `my-cluster` with the following commands. You will need to reference the node names provided here in the following steps

Note: If you do not currently have a cluster deployed, please deploy a cluster per the instructions in [Step 2 of Lab5](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/Lab5-DeployFirstCluster#step-2-login-to-pks-cli-and-create-cluster) before proceeding

```bash
pks login -a pks.corp.local -u pksadmin -k -p VMware1!
pks get-credentials my-cluster
kubectl get nodes
```

<details><summary>Screenshot 1.1.4</summary>

</details>
<br/>

1.1.4 In the vSphere web client, on the `Hosts and Clusters` page, expand the `pks-comp-1` resource pool and view the VM's in the resource pool. In the current configuration, all master and node VM's for all Kubernetes clusters created with this PKS instance will be deployed to the `pks-comp-1` resource pool. 

Currently in your lab environment you should have one small kubernetes deployments, which the small plan settings are currently configured to provision a single master and 3 worker nodes. Accordingly you should see four virtual machines

<details><summary>Screenshot 1.1.3</summary>
<img src="Images/2018-11-09-03-50-12.png">
</details>
<br/>