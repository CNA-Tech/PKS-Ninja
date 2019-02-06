# Introduction to Helm

**Contents:**

- [Step 1: Configure Tiller and apply RBAC configuration file to create]()
- [Step 2: Apply the service account for Tiller created in Step 1]()
- [Step 3: Confirm you have Helm Installed]()
- [Step 4: Deploy Helm via Tiller service account]()

## Overview

This lab guide will walk you through enabling Tiller and Helm in your lab environment so you can deploy Helm Chart applications.  Helm is a very popular way to package and deploy Kubernetes based applications.

## Instructions
To complete this lab, you must have completed the `DeployFirstCluster-DC1610`

Helm works in a client-server model by leveraging a Tiller pod on the kube-system namespace within a K8's cluster.  In order for Tiller to access the APIs required to deploy Helm Charts, you must create and bind a service account to it.  Then you can use the Helm CLI on your `cli-vm` to send in Helm charts to deploy your applications through Tiller.

## Step 1: Configure Tiller
1.1 - Create a service account for Tiller and bind it to the cluster-admin role

In your `cli-vm`:

```git clone https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/IntroToHelm-HE4490/rbac-config.yaml```

1.2 - View the RBAC configuration file and see what is being created:

```cat rbac-config.yaml```


## Step 2: Apply the service account for Tiller created in Step 1

2.1 - Create and bind the Tiller service account</br> ```kubectl create -f rbac-config.yaml```


## Step 3: Ensure Helm is Installed
3.1 - Check that helm is installed, and what version you're using `helm version`


## Step 4: Deploy Helm via Tiller service account
