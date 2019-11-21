# Harbor Tile Installation

- [Harbor Tile Installation](#harbor-tile-installation)
  - [Install Harbor](#install-harbor)
  - [Enable Harbor Client Secure Connections](#enable-harbor-client-secure-connections)

## Install Harbor

1.0 To download Harbor Installation Binaries, from the control center desktop, open a browser to Pivnet [https://network.pivotal.io/products/harbor-container-registry/](https://network.pivotal.io/products/harbor-container-registry/) and sign in. If you do not have an account, you can easily create one, no special entitlements are required. Download the Harbor Container registry. At the time of writing, `VMware Harbor Container Registry for PCF 1.8.5` was used to prepare this lab guide, however feel free to try with the latest Harbor version if you prefer.

1.1 On a new browser tab, open a connection to the Ops Manager UI, click on `Import a Product` select the Harbor file from the `E:\Downloads` directory and click `Open`. It can take a few minutes to import the Harbor file

<details><summary>Screenshot 1.1.1 </summary>
<img src="Images/2018-10-22-21-23-55.png">
</details>

<details><summary>Screenshot 1.1.2 </summary>
<img src="Images/2018-10-22-01-27-45.png">
</details>
<br/>

1.2 In the left hand column of the Ops Manager homepage under `VMware Harbor Registry`, click on the `+` icon to add the Harbor tile to the `Installation Dashboard`

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-22-21-45-54.png">
</details>
<br/>

1.2b Depending on the version and build of PKS you used for installation, you may be required to install a stemcell for Harbor. If you are required to install an additional stemcell, the `VMware Harbor Registry` tile on the Ops Manager homepage will say `Missing Stemcell` as shown in the image below. If the tile does not say `Missing Stemcell`, you can skip this step.

If you see the `Missing Stemcell` message, click it and you will be directed to the stemcell page. On the row for `VMware Harbor Registry`. the required stemcell version will be displayed in the `Required` column. Go to pivnet per the instrucitons in step 1.0, look for the `Pivotal Stemcells (Ubuntu Xenial)` product, select the version number needed for Harbor, and download the relevant stemcell for vsphere.

After you have downloaded the required stemcell, return to the `Stemcell Library` page. On the row for `VMware Harbor Registry`, click `Import Stemcell` select the stemcell file you downloaded and click open. This will bring up the `Import Stemcell` prompt, click `Apply Stemcell to Products`.

NOTE: You may see an error message saying opsman was unable to apply the stemcell, you should be able to ignor this error message. I (the lab author) did get this error message, but returned to the opsman homepage and no longer saw the missing stemcell message and was able to proceed with harbor tile configuration, so it appears this is not a valid error message.

<details><summary>Screenshot 1.2b.1</summary>
<img src="Images/2019-11-21-01-45-24.png">
</details>

<details><summary>Screenshot 1.2b.2</summary>
<img src="Images/2019-11-21-01-48-52.png">
</details>

<details><summary>Screenshot 1.2b.3</summary>
<img src="Images/2019-11-21-01-49-49.png">
</details>

<details><summary>Screenshot 1.2b.4</summary>
<img src="Images/2019-11-21-01-53-16.png">
</details>

<details><summary>Screenshot 1.2b.5</summary>
<img src="Images/2019-11-21-01-55-19.png">
</details>
<br/>

1.3 Click on the `VMware Harbor Registry` tile to open its configuration settings

<details><summary>Screenshot 1.3 </summary>
<img src="Images/2018-10-22-21-47-27.png">
</details>
<br/>

1.4 Select the `Assign AZs and Networks` tab and enter the following values:

- Singleton Availability Zone: PKS-MGMT-1
- Balance other jobs in: PKS-MGMT-1
- Network: PKS-MGMT
- Click `Save`

<details><summary>Screenshot 1.4</summary>
<img src="Images/2018-10-22-21-53-32.png">
</details>
<br/>

1.5 Select the `General` tab and set the `Hostname` to `harbor.corp.local`, and set the `Static IP Address` to `172.31.0.5` , Click `Save`

<details><summary>Screenshot 1.5</summary>
<img src="Images/2019-08-14-21-05-55.png">
</details>
<br/>

1.6 Select the `Certificate` tab, select `Generate RSA Certificate`, enter `harbor.corp.local` and click `Generate`

<details><summary>Screenshot 1.6</summary>
<img src="Images/2018-10-31-15-24-23.png">
</details>
<br/>

1.7 On the `Certificate` tab, click `Save`

<details><summary>Screenshot 1.7</summary>
<img src="Images/2018-10-22-22-11-03.png">
</details>
<br/>

1.8 On the `Credentials` tab, set the `Admin Password` and the `Admin Password to run smoke test` to `VMware1!` and click `Save`

<details><summary>Screenshot 1.8</summary>
<img src="Images/2019-11-21-02-02-03.png">
</details>
<br/>

1.9 On the `Clair Settings` tab, set the `Updater Interval` to `1` and click `Save`

<details><summary>Screenshot 1.9</summary>
<img src="Images/2019-11-21-02-02-41.png">
</details>
<br/>

1.10 On the `Resource Config` tab, for the `harbor-app` job, set the `Persistent Disk Type` to `50 GB` and click `Save`

<details><summary>Screenshot 1.10</summary>
<img src="Images/2018-10-22-22-18-57.png">
</details>
<br/>

1.11 In the Ops Manager UI on the top menu bar click `Installation Dashboard`, next select `Review Pending Changes`. Uncheck the checkbox by `Pivotal Container Service` and click `Apply Changes`. Monitor the `Applying Changes` screen until the deployment is complete

**Please proceed with Step 2 below while Harbor is deploying, you do not need the Harbor deployment to finish to complete the remaining steps in this guide**

<details><summary>Screenshot 1.11</summary>
<img src="Images/2019-01-12-02-25-47.png">
</details>

## Enable Harbor Client Secure Connections

Harbor's integration with PKS natively enables the PKS Control Plane hosts and Kubernetes nodes for certificate based communications with Harbor, but most environments have additional external hosts that need to negotiate communication with harbor other than just K8s nodes. For example, developer workstations, pipeline tools,etc

To ensure developer and automated workflows can have secure interaction with Harbor, a certificate should be installed on the client machine

Please complete the [Installing Harbor Cert on External Clients](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/HarborCertExternal-HC7212) lab guide to learn the required steps and prepare cli-vm with needed configuration to complete other harbor exercises if you plan to proceed with additional harbor lab guides.

This lab guide does not include steps to validate the harbor installation because it takes time to deploy harbor, so after installation and client prep is a good natural break. To continue with validation, please continue with the next step from your course guide, or refer to the [PKS Ninja SE course guide agenda](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.6/Courses/PksNinjaSe-NI6310#ninja-labs-part-1-agenda) for next steps

***End of lab***
