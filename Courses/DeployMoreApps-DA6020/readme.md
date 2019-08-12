# Deploy More Apps

## Introduction

The Deploy More Apps course provides a list of lab guides that are focused on installing an application. You can link to lab guides on pks-ninja, and you can also link to external sites that have good instructions - IF you have verified that you can complete the external exercise on the PKS Ninja Lab Environment. 

The `K8s Apps` section below provides a listing of lab guides that cover installing an application using K8s manifests. 

The `Helm Apps` section below provides a listing of lab guides that cover installing an application using Helm Charts. 

Please proceed to try any of the lab guides listed below, and if you do install apps that are not listed below, please consider creating a lab guide with instructions or just linking to the external instructions if you have validated they work on the PKS Ninja lab. 

If an external site has a great guide that covers a k8s app installation, but there is some adaptation to the steps required to make it work in the PKS Ninja lab environment, you can also create a lab guide with the adaptation steps and a link to the original external source. 


## K8s Apps

- [Deploy Whackapod](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployWhackapod-DW3947)
- [Deploy Planespotter without Persistence](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployPlanespotter-DP6539)
- [Deploy Planespotter with Persistent Storage](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksStorageAndPersist-SP7357)

## Helm Apps

- [Installing Istio in New Kubernetes Clusters Created by PKS with NSX-T Using Helm](https://github.com/CNA-Tech/Apps-on-PKS/tree/master/istio)
  - This is an external lab guide. I have validated that it works on the PKS Ninja Lab environment per the following notes:
    - The instructions here say to create a medium load balancer, this is not needed, you do not need to create a new cluster or load balancer. You can skip the steps related to creating a new cluster and use your existing deployed cluster
    - Helm is already installed on cli-vm, so you can skip the steps listed for helm installation
    - other than that following the exact steps on the pks ninja lab this worked great for me, excellent lab


