### Persistent Volumes and Kubernetes Storage Policy

Although it is relatively easy to run stateless Microservices using container technology,
stateful applications require slightly different treatment. There are multiple factors
which need to be considered when handling persistent data using containers, such as:

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

PKS deploys Kubernetes clusters with the vSphere storage provider already configured.
In Module 4 you will upgrade an existing application to add persistent volumes and see
that even after deleting your pods and recreating them, the application data persists. In
order to use Persistent Volumes (PV) the user needs to create a
PersistentVolumeClaim(PVC) which is nothing but a request for PVs. A claim must
specify the access mode and storage capacity, once a claim is created PV is
automatically bound to this claim. Kubernetes will bind a PV to PVC based on access
mode and storage capacity but a claim can also mention volume name, selectors and
volume class for a better match. This design of PV-PVCs not only abstracts storage
provisioning and consumption but also ensures security through access control.

Static Persistent Volumes require that a vSphere administrator manually create a
(virtual disk) VMDK on a datastore, then create a Persistent Volume that abstracts the
VMDK. A developer would then make use of the volume by specifying a Persistent
Volume Claim.

**Dynamic Volume Provisioning**

With PV and PVCs one can only provision storage statically i.e. PVs first needs to be
created before a Pod claims it. However, with the StorageClass API Kubernetes enables
dynamic volume provisioning. This avoids pre-provisioning of storage and storage is
provisioned automatically when a user requests it. The VMDK's are also cleaned up
when the Persistent Volume Claim is removed.


The StorageClass API object specifies a provisioner and parameters which are used to
decide which volume plugin should be used and which provisioner specific parameters
to configure.

**Get Kubernetes Credentials**

1. Type pks get-credentials my-cluster

The login credentials for our cluster are stored in PKS. The get credentials command
updates the kubectl CLI config file with the correct context for your cluster. We will
spend more time on this in Module 3.

**Create Storage Class**

Let's start by creating a Storage Class

1. Type cd /home/ubuntu/apps
2. Type cat redis-sc.yaml

The yaml defines the vSphere volume and the set of parameters the driver supports.

vSphere allows the following parameters:

- **diskformat** which can be thin(default), zeroedthick and eagerzeroedthick


- **datastore** is an optional field which can be VMFSDatastore or VSANDatastore.
    This allows the user to select the datastore to provision PV from, if not specified
    the default datastore from vSphere config file is used.
- **storagePolicyName** is an optional field which is the name of the SPBM policy to
    be applied. The newly created persistent volume will have the SPBM policy
    configured with it.
- **VSAN Storage Capability Parameters** (cacheReservation, diskStripes,
    forceProvisioning, hostFailuresToTolerate, iopsLimit and objectSpaceReservation)
    are supported by vSphere provisioner for vSAN storage. The persistent volume
    created with these parameters will have these vSAN storage capabilities
    configured with it.
3. Type kubectl apply -f redis-sc.yaml

Let's apply this yaml to create the storage class

4. Type kubectl get sc

The command shows the created storage class.

**Create Persistent Volume Claim**

Dynamic provisioning involves defining a Persistent Volume Claim that refers to a
storage class. Redis-slave-claim is our persistent volume claim and we are using the
thin-disk storage class that we just created.

1. Type cat redis-slave-claim.yaml

Let's create our Persistent Volume Claim


2. Type kubectl apply -f redis-slave-claim.yaml
1. Type kubectl get pvc

This shows that our Persistent Volume claim was created and bound to a Volume. The
Volume is a vSphere VMDK. Let's look at it in more detail.

2. Type kubectl describe pvc redis-slave-claim

Here you can see that the provisioning of the volume succeeded. Let's go to vCenter
and see the volume.

**View The Volume in vCenter**

1. Connect to vcenter client and click on the Storage icon
2. Select your datastore RegionA01-iSCSCI01-COMP01 and right click, select Browse Files
3. Select the kubevols folder
4. Here is the Persistent Volume you just created. Note that the volumeID in the
    kubectl describe maps to the vmdk name.

Also note that it was thin provisioned based on the storage class specification we used.