# PKS Storage and Persistence 1

This lab guide focuses on examining and deploying persistent volume services using the Planespotter applications MySQL service as an example

This guide is part of a sequence, please complete the [Deploy Planespotter without Persistence]() lab guide prior to continuing

## PKS & Kubernetes Storage and Persistence Overview

Although it is relatively easy to run stateless Microservices using container technology, stateful applications require slightly different treatment. There are multiple factors which need to be considered when handling persistent data using containers, such as:

- Kubernetes pods are ephemeral by nature, so the data that needs to be persisted
    has to survive through the restart/re-scheduling of a pod.
- When pods are re-scheduled, they can die on one host and might get scheduled
    on a different host. In such a case the storage should also be shifted and made
    available on the new host for the pod to start gracefully.
- The application should not have to worry about the volume & data. The
    underlying infrastructure should handle the complexity of unmounting and
    mounting.
- Certain applications have a strong sense of identity (e.g.; Kafka, Elastic) and the
    disk used by a container with certain identity is tied to it. It is important that if a
    pod with a certain ID gets re-scheduled for some reason then the disk associated
    with that ID is re-attached to the new pod instance.
- PKS leverages vSphere Storage for Kubernetes to allow Pods to use enterprise
    grade persistent storage.

Persistent volumes requested by stateful containerized applications can be provisioned
on vSAN, iSCSI, VVol, VMFS or NFS datastores.

Kubernetes volumes are defined in Pod specifications. They reference VMDK files and
these VMDK files are mounted as volumes when the container is running. When the Pod
is deleted the Kubernetes volume is unmounted and the data in VMDK files persists.

PKS deploys Kubernetes clusters with the vSphere storage provider already configured.  In thius guide you will upgrade your existing planespotter application to add persistent volumes and see that even after deleting your pods and recreating them, the application data persists. 

In order to use Persistent Volumes (PV) the user needs to create a
PersistentVolumeClaim(PVC) which is nothing but a request for PVs. A claim must
specify the access mode and storage capacity, once a claim is created PV is
automatically bound to this claim. Kubernetes will bind a PV to PVC based on access
mode and storage capacity but a claim can also mention volume name, selectors and
volume class for a better match. This design of PV-PVCs not only abstracts storage
provisioning and consumption but also ensures security through access control.

Static Persistent Volumes require that a vSphere administrator manually create a
(virtual disk) VMDK on a datastore, then create a Persistent Volume that abstracts the VMDK. A developer would then make use of the volume by specifying a Persistent
Volume Claim.

#### Dynamic Volume Provisioning

With PV and PVCs one can only provision storage statically i.e. PVs first needs to be created before a Pod claims it. However, with the StorageClass API Kubernetes enables dynamic volume provisioning. This avoids pre-provisioning of storage and storage is provisioned automatically when a user requests it. The VMDK's are also cleaned up when the Persistent Volume Claim is removed.

The StorageClass API object specifies a provisioner and parameters which are used to
decide which volume plugin should be used and which provisioner specific parameters
to configure.

## Instructions

_Before proceeding, ensure your `cli-vm` is authenticated to the PKS API server and your local kubeconfig is authenticated to the K8s master for my-cluster, reference the following commands as needed_

```bash
pks login -a pks.corp.local -u pks-admin --skip-ssl-validation
pks get credentials my-cluster
```

1.1 Review the Storage Class spec for the Planespotter-mysql deployment with the command `cat ~/planespotter/kubernetes/storage_class.yaml`

The yaml defines the vSphere volume and the set of parameters the driver supports.

vSphere allows the following parameters:

- **diskformat** which can be thin(default), zeroedthick and eagerzeroedthick
- **datastore** is an optional field which can be VMFSDatastore or VSANDatastore.
    This allows the user to select the datastore to provision PV from, if not specified the default datastore from vSphere config file is used.
- **storagePolicyName** is an optional field which is the name of the SPBM policy to
    be applied. The newly created persistent volume will have the SPBM policy
    configured with it.
- **VSAN Storage Capability Parameters** (cacheReservation, diskStripes,
    forceProvisioning, hostFailuresToTolerate, iopsLimit and objectSpaceReservation)
    are supported by vSphere provisioner for vSAN storage. The persistent volume
    created with these parameters will have these vSAN storage capabilities
    configured with it.

<details><summary>Screenshot 1.1</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.2 Create a storage class and validate with the following commands 

```bash
kubectl apply -f ~/planespotter/kubernetes/storage_class.yaml
kubectl get sc
```

<details><summary>Screenshot 1.2</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.3 Review the planespotter-mysql persistent volume claim with the command `cat ~/planespotter/kubernetes/mysql_claim.yaml`

Dynamic provisioning involves defining a Persistent Volume Claim that refers to a storage class. The mysql_claim.yaml file defines our persistent volume claim and we are using the thin-disk storage class that we just created

<details><summary>Screenshot 1.3</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.4 Create and validate the planespotter-mysql persistent volume claim with the following commands:

```bash
kubectl apply -f mysql_claim.yaml
kubectl get pvc
```

<details><summary>Screenshot 1.4</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.5 Review the planespotter-mysql kubernetes deployment manifest with the command `cat ~/planespotter/kubernetes/mysql_pod.yaml`

<details><summary>Screenshot 1.5</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.6 Update the planespotter deployment you created in the [Deploy Planespotter without Persistence]() lab to attach the persistent volume to the mysql deployment. Observe that even though you are using a different yaml file in this step than you used when you deployed the mysql_pod-noPv.yaml file in the previous lab guide, kubernetes understands that this file is intended to update the current planmespotter-mysql deployment because both files specify the same deployment names

```bash
kubectl apply -f mysql_pod.yaml
kubectl get deployment planespotter-mysql
```

<details><summary>Screenshot 1.6</summary>
<img src="images/2019-01-09-23-47-00.png">
</details>
<br>

1.7 View The Volume in vCenter

- Connect to vcenter client and click on the Storage icon
- Select your datastore RegionA01-iSCSCI01-COMP01 and right click, select Browse Files
- Select the kubevols folder
- Here is the Persistent Volume you just created. Note that the volumeID in the kubectl describe maps to the vmdk name
- Also note that it was thin provisioned based on the storage class specification we used

1.8 Check the external URL/IP address assigned to the service (make note of the first IP addres under External-IP). Copy the IP under the "External-IP" section and point your browser to that location.

- `kubectl get service planespotter-frontend-lb`

A freshly deployed app based on 4 micro-services is ready!
