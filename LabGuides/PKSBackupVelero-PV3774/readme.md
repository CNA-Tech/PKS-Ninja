# PKS Backup and Restore using VMWare Heptio Velero

## Overview

### Heptio Velero
 - Heptio Velero (formerly Heptio Ark) gives you tools to back up and restore your Kubernetes cluster resources and persistent volumes. 

 - Velero Feature
   Take backups of your cluster and restore in case of loss.
   Copy cluster resources to other clusters.
   Backup and restore PV's
   Scheduled Backups
   Replicate your production environment for development and testing environments.
   Filtering (namespaces, resources, label selectors)
   Restore into different namespaces

- Velero Extensibility
  Hooks
  Plugins

- Velero consists of:
  A server that runs on your cluster
  A command-line client that runs locally

### Persistent Volumes 
  In this sample , Velero leverages vSphere Storage for Kubernetes to allow Minio to use enterprise grade persistent storage to store the backup.
  Persistent volumes requested by stateful containerized applications can be provisioned on vSAN, iSCSI, VVol, VMFS or NFS datastores.

  Kubernetes volumes are defined in Pod specifications. They reference VMDK files and these VMDK files are mounted as volumes when the container is running. When the Pod is deleted the Kubernetes volume is unmounted and the data in VMDK files persists.
  
  PKS deploys Kubernetes clusters with the vSphere storage provider already configured. 

  In order to use Persistent Volumes (PV) the user needs to create a PersistentVolumeClaim(PVC) which is nothing but a request for PVs. A claim must specify the access mode and storage capacity, once a claim is created PV is automatically bound to this claim. Kubernetes will bind a PV to PVC based on access mode and storage capacity but a claim can also mention volume name, selectors and volume class for a better match. This design of PV-PVCs not only abstracts storage provisioning and consumption but also ensures security through access control.

  Static Persistent Volumes require that a vSphere administrator manually create a (virtual disk) VMDK on a datastore, then create a Persistent Volume that abstracts the VMDK. A developer would then make use of the volume by specifying a Persistent Volume Claim.

  Dynamic Volume Provisioning
  With PV and PVCs one can only provision storage statically i.e. PVs first needs to be created before a Pod claims it. However, with the StorageClass API Kubernetes enables dynamic volume provisioning. This avoids pre-provisioning of storage and storage is provisioned automatically when a user requests it. The VMDK's are also cleaned up when the Persistent Volume Claim is removed.

  The StorageClass API object specifies a provisioner and parameters which are used to decide which volume plugin should be used and which provisioner specific parameters to configure.


## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment
- PKS Install (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PksInstallPhase2-IN1916)
- PKS Cluster (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610)
- Planespotter Application (https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/BonusLabs/Deploy%20Planespotter%20Lab)

## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.3 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-3E0C4CEC-D593-4395-84C4-150CD6285963.html)


## LabGuide

[Velero 1.0 backup and restore guide](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PKSBackupVelero-PV3774/readmevelerov10.md)

[Velero 1.1 backup and restore guide](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PKSBackupVelero-PV3774/readmevelerov11.md)
