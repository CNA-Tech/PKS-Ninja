# Deploy Planespotter

## Step 1: Prepare Planespotter K8s Manifests for Deployment

1.1 From `cli-vm`, use nano or another text editor to change the image pull location in the frontend deployment manifest to pull the image you, created and pushed to harbor in the Harbor Lab, from  `harbor.corp.local/library/frontend:v1`. Use the following commands to open the manifest in nano and then reference Screenshot 1.1 as needed to complete the update and save the file

_Note: If you have no `/planespotter/kuberenetes/` directory, complete the Harbor lab_

```bash
cd ~/planespotter/kubernetes
nano frontend-deployment_all_k8s.yaml
# update file per image 1.1, save and close
```

<details><summary>Screenshot 1.1 </summary>
<img src="images/2018-10-24-06-46-07.png">
</details>
<br/>

1.2 View the `app-server-deployment_all_k8s.yaml` file, observe the container image value is `yfauser/planespotter-app-server:1508888202fc85246248c0892c0d27dda34de8e1` which is a working configuration. You may notice this does not specify the location of the registry it is using, and that is because this container is located on docker hub, which is a default search location for docker hosts including PKS deployed K8s nodes

<details><summary>Screenshot 1.2 </summary>
<img src="images/2018-10-24-07-07-26.png">
</details>
<br/>

You should now understand the differences in how to configure a kubernetes manifest to pull from docker hub or from Harbor

## Step 2: Deploy Planespotter App

2.1 Before proceeding, verify that your cluster has successfully deployed by entering the command `pks clusters` from `cli-vm`

<details><summary>Screenshot 2.1 </summary>
<img src="images/2018-10-24-07-15-44.png">
</details>
<br/>

2.2 Pull down the kubernetes config and credentials for `my-cluster` with the command 

```
pks get-credentials my-cluster
```

<details><summary>Screenshot 2.2 </summary>
<img src="images/2018-10-24-07-17-19.png">
</details>
<br/>

Please use the instructions at [this link](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/BonusLabs/Deploy%20Planespotter%20Lab) to complete deployment of the planespotter app