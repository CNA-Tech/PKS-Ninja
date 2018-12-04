# Lab 11 - Harbor Pipeline Install

The Harbor pipeline install generally follows the PKS pipeline install. If you have recently completed the pks pipeline install and still have a web browser to concourse open you can simply click on the `harbor-install-standalone` pipeline and kick it off, as detailed in the steps below

## Harbor Pipeline Kickoff

In this guide you will navigate to the Harbor Installation Pipeline in Concourse and start the pipeline

1.1 Using a web browser navigate to the concourse URL

Note: If you are already logged in, your screen should resemble screenshot 1.1.2, and you can skip ahead to step 1.3. If you screen resembles screenshot 1.1.1, then proceed with step 1.2

`http://cli-vm.corp.local:8080`

<details><summary>Screenshot 1.1.1</summary>
<img src="Images/2018-11-30-15-44-11.png">
</details>

<details><summary>Screenshot 1.1.2</summary>
<img src="Images/2018-11-30-15-45-51.png">
</details>
<br/>

1.2 If you are not already logged in, in the upper right-hand corner login to Concourse

```yaml
Username: admin
Password: VMware1!
```

Note: Early versions of the lab template used login `Username: NSX Password: VMware`

<details><summary>Screenshot 1.2.1</summary>
<img src="Images/2018-11-30-15-44-59.png">
</details>

<details><summary>Screenshot 1.2.2</summary>
<img src="Images/2018-12-04-09-53-22.png">
</details>
<br/>

1.3 Click on `install-pks-with-nsx` tile, click on the `harbor-install-standalone` pipeline, and then click on the `upload-harbor` task as shown in the following screenshots

<details><summary>Screenshot 1.3.1</summary>
<img src="Images/2018-12-04-10-43-27.png">
</details>

<details><summary>Screenshot 1.3.2</summary>
<img src="Images/2018-12-04-10-44-05.png">
</details>

<details><summary>Screenshot 1.3.3</summary>
<img src="Images/2018-12-04-10-45-28.png">
</details>
<br/>

1.4 On the upper right hand corner of the upload-harbor task screen, click the plus + icon to kick off the pipeline

<details><summary>Screenshot 1.4.1</summary>
<img src="Images/2018-12-04-10-47-45.png">
</details>

<details><summary>Screenshot 1.4.2</summary>
<img src="Images/2018-12-04-10-48-35.png">
</details>
<br/>

1.5 Grab some coffee and watch the magic happen! 

<img src="Images/automate-all-things.png">

1.6 After coffee :coffee: and around ~45 minutes all the boxes in the pipeline should be green

Note: If the pipline fails, you can click the job that failed and click the + sign to restart the failed task and the pipeline will resume