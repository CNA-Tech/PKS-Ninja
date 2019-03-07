# PKS Intro to PKS Monitoring & Operations

### 1.1 Configure Wavefront in Enterprise PKS

1.1.1 Go to Workspace ONE and search for "Wavefront-sandbox"

<details><summary>Screenshot 1.1.1</summary>
<img src="Images/1.png">
</details>
<br/>

1.1.2 Navigate to Integrations Page in Wavefront and search for "PKS"

<details><summary>Screenshot 1.1.2</summary>
<img src="Images/2.png">
</details>
<br/>

1.1.3 Open the PKS Integration. Navigate to the setup tab inside PKS. Copy the "Wavefront URL" and the "API Token"

<details><summary>Screenshot 1.1.3</summary>
<img src="Images/3.png">
</details>
<br/>

1.1.4 Navigate to Ops Manager at the "opsman.corp.local" and open the PKS Tile

<details><summary>Screenshot 1.1.4</summary>
<img src="Images/4.png">
</details>
<br/>

1.1.5 Select the monitoring tab to open the Wavefront integration page

<details><summary>Screenshot 1.1.5</summary>
<img src="Images/5.png">
</details>
<br/>

1.1.6 Fill in the fields for "Wavefront URL" and "Wavefront Access Token" from step 1.1.3". Remember to press "Save" the configuration.

<details><summary>Screenshot 1.1.6</summary>
<img src="Images/6.png">
</details>
<br/>

1.1.7 Click on the Logging section and enter the following settings:

- Enable Syslog for PKS: No
- Enable VMware vRealize Integration: Yes
- Host: vrli-01a.corp.local
- Enable Sink Resources: Yes
- Click Save

<details><summary>Screenshot 1.1.7</summary>
<img src="Images/7.png">
</details>
<br/>

1.1.8 From the Ops Manager Home page click on the `BOSH Director for vSphere` tile.

<details><summary>Screenshot 1.1.8</summary>
<img src="Images/8.png">
</details>
<br/>

1.1.9 Click on the Syslog tab and enter the following details:

- Do you want to configure syslog for BOSH Director?: Yes
- Address: vrli-01a.corp.local
- Port: 514
- Transport Protocol: UDP

<details><summary>Screenshot 1.1.9</summary>
<img src="Images/9.png">
</details>
<br/>

1.1.10 Return to the Ops Manager Homepage and click `Review Pending Changes`, and then click apply changes. You will need to wait for the redeploy to complete before being able to make use of the updated settings, this could take up to an hour to complete.

<details><summary>Screenshot 1.1.10</summary>
<img src="Images/10.png">
</details>
<br/>
