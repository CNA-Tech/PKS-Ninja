# Lab 5: Deploy First PKS Cluster & Planespotter

**Contents:**

- [Step 1: Prepare Projects and Repositories]()
- [Step 2: Install OpsMan Root Cert on BOSH for PKS/K8s <-> Harbor communications]()
- [Step 3: Install Harbor certificate on `cli-vm`]()
- [Step 4: Build Docker Image for Planespotter Frontend]()
- [Step 5 Content Trust & Vulnerability Scanning]()
- [Next Steps]()

## Step 1: Create UAA Account for PKS User

1.1 Login to Ops Manager UI, Click on the PKS tile and then click on the `Credentials` tab, look for `Pks Uaa Management Admin Client` , click `Link to Credential`

<details><summary>Screenshot 1.1 </summary>
<img src="Images/2018-10-24-05-19-50.png">
</details>
<br/>

1.2 Copy the value of the secret to the clipboard as shown in Screenshot 1.2

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-24-05-21-27.png">
</details>
<br/>

1.3 Resume or if needed reopen you ssh session with `cli-vm`, target your UAA server and request a token with the following commands. Be sure to replace the string `LtrWeSarpeGbnM_h0kJB5Ddxy0emt5qr` with the secret that you gathered in the previous step 1.2

```bash:
uaac target https://pks.corp.local:8443 --skip-ssl-validation
uaac token client get admin -s LtrWeSarpeGbnM_h0kJB5Ddxy0emt5qr
```

<details><summary>Screenshot 1.3 </summary>
<img src="Images/2018-10-24-05-37-12.png">
</details>
<br/>

1.4 From `cli-vm`, enter the following commands to create a UAA account and assign admin rights to new user `pksadmin`:

```bash:
uaac user add pksadmin --emails pksadmin@corp.local -p VMware1!
uaac member add pks.clusters.admin pksadmin
```

<details><summary>Screenshot 1.4 </summary>
<img src="Images/2018-10-24-05-43-06.png">
</details>
<br/>

## Step 2 Login to PKS CLI and Create Cluster

2.1 From `cli-vm`, Login to the PKS CLI with the following command:

`pks login -a pks.corp.local -u pksadmin -p VMware1! --skip-ssl-verification`

<details><summary>Screenshot 2.1 </summary>
<img src="Images/2018-10-24-05-43-06.png">
</details>
<br/>

2.2 From `cli-vm`, verify there are no existing clusters and create a cluster with the following commands

```bash
pks clusters
pks create-cluster my-cluster --external-hostname my-cluster --plan small
```

Note: It will take ~10 minutes for the cluster to deploy, you may proceed with step 3 while the cluster deployment is in progress, however do not proceed to step 4 until the cluster has been fully deployed

Also, it may be interesting for you to look at the `Tasks` menu in vCenter to observe some of the vSphere tasks that occur on cluster creation

<details><summary>Screenshot 2.2 </summary>
<img src="Images/2018-10-24-06-00-15.png">
</details>
<br/>

## Step 3: Prepare Planespotter K8s Manifests for Deployment

3.1 From `cli-vm`, use nano or another text editor to change the image pull location in the frontend deploymnent manifest to pull the image you created and pushed to harbor previously