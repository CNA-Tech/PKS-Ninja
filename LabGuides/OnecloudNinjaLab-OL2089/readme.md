# Accessing the PKS Ninja Lab with OneCloud

**Onecloud is available to VMware Employees only, please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) for lab access options for non VMware employees**

The PKS Ninja vApp Template is available in the Global Field Enablement catalogs and is currently accessible on the NASA, EMEA and APAC Onecloud Sandbox environments

## Instructions

1.1 Open a web browser, navigate to workspace one and launch your onecloud environment

**Note:** your onecloud org may not be the same as in the image below, please use the onecloud org you have access to

<details><summary>Screenshot 1.1</summary>
<img src="Images/2018-12-24-16-58-07.png">
</details>
<br/>

1.2 From the vCloud Director page on the `Virtual Machines` tab, select `See this page in vCloud Director Web Console`

<details><summary>Screenshot 1.2</summary>
<img src="Images/2019-01-11-02-33-59.png">
</details>

1.3 Click on `Add vApp fron Catalog`, select `Public Catalogs`, click on `All Templates`, in the search box type `ninja`, select the pks-ninja template and click `Next`

<details><summary>Screenshot 1.3.1</summary>
<img src="Images/2018-12-24-17-20-51.png">
</details>

<details><summary>Screenshot 1.3.2</summary>
<img src="Images/2019-01-11-02-37-06.png">
</details>
<br/>

1.4 On the `Select Name and Location` screen, enter a name for your vApp template and click `Next`

<details><summary>Screenshot 1.4</summary>
<img src="Images/2018-12-24-17-28-17.png">
</details>
<br/>

1.5 On the `Configure Resources` screen, click `Finish` and wait for your new template to finish loading

<details><summary>Screenshot 1.5</summary>
<img src="Images/2018-12-24-17-29-40.png">
</details>
<br/>

1.6 On the tile view of your new vApp template, click `Open`, Click on the `Networking` tab, in the `Connection` column dropdown field for `vAppNet-single`, select the only available network connection, ensure `Nat` is checked, and `Firewall` is __not checked__ click `Apply` and wait for the configuration change to be completed by verifying there are `0 Running` tasks in the lower lefthand corner of the webpage, per the screenshots below

<details><summary>Screenshot 1.6.1</summary>
<img src="Images/OnClouNinjaLab.PNG">
</details>

<details><summary>Screenshot 1.6.2</summary>
<img src="Images/2019-01-11-02-47-55.png">
</details>
<br/>

1.7 Click on the `Home` button to return to your onecloud home page, on the tile view of your new vApp template, click the play icon to run the vPod, wait for a few minutes for it to be in a fully running state before proceeding

<details><summary>Screenshot 1.7</summary>
<img src="Images/2018-12-24-17-32-06.png">
</details>
<br/>

1.8 On the tile view of your new vApp template, click `Open`, Click on the `Virtual Machines` tab, record the `External IP` address value

<details><summary>Screenshot 1.8.1</summary>
<img src="Images/2018-12-24-17-34-44.png">
</details>

<details><summary>Screenshot 1.8.2</summary>
<img src="Images/2018-12-24-17-36-41.png">
</details>
<br/>

1.9 Open a remote desktop application, and connect to the external IP address from the step above with the `username: administrator@corp.local` `password: VMware1!`

<details><summary>Screenshot 1.9.1</summary>
<img src="Images/2018-12-24-17-39-30.png">
</details>

<details><summary>Screenshot 1.9.2</summary>
<img src="Images/2018-12-24-17-40-00.png">
</details>

<details><summary>Screenshot 1.9.3</summary>
<img src="Images/2018-12-24-17-41-17.png">
</details>
<br/>

1.10 You must run a script to make some minor updates to the lab environment before beginning any lab guides [per the instructions here](https://github.com/CNA-Tech/PKS-Ninja/blob/master/Labrary/Microlabs/NinjaLabPrepScript-CI4231.md)

### You have now completed this exercise, you will need to complete either the [PKS the Easy Way](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/PksTheEasyWay-PE6650) or the [PKS The Hard Way](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/PksTheHardWay-PH7885) course to install PKS, and then you can use this lab environment to complete available courses and lab guides
