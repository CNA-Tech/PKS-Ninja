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

Helm works in a client-server model by leveraging a Tiller pod running in the kube-system namespace within a K8's cluster.  In order for Tiller to access the K8s APIs required to deploy Helm Charts, you must create and bind a service account to it.  Then you can use the Helm CLI on your `cli-vm` to send in Helm charts to deploy your applications through Tiller.

## Step 1: Configure Tiller
1.1 - Create a service account for Tiller and bind it to the cluster-admin role

In your `cli-vm`:

Create a new config file ```nano rbac-config.yaml```

<details><summary>Screenshot 1.1.1 </summary>
<img src="images/rbac-config.png">
</details>

1.2 - Copy the below text into the open file
``` apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system```

1.3 Save `ctrl + o` then `enter` and exit `ctrl + x` then `enter`

<details><summary>Screenshot 1.2.1 </summary>
<img src="images/nano-config.png">
</details>

## Step 2: Apply the service account for Tiller created in Step 1

2.1 - Create and bind the Tiller service account</br> ```kubectl create -f rbac-config.yaml```


## Step 3: Ensure Helm is Installed
3.1 - Check that helm is installed, and what version you're using</br> `helm version`

<details><summary>Screenshot 1.2.1 </summary>
<img src="images/helm_version.png">
</details>

## Step 4: Deploy Helm via Tiller service account
4.1 - Helm init will install Tiller into the K8s cluster and configure the required context </br>
`helm init --service-account tiller`
