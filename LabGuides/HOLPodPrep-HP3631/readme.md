# Under Development, Please Check back Soon
HOL Pod Prep for PKS Ninja Labs

Many PKS Ninja Lab Guides that have been validated for the HOL-2031 lab environment require a common set of preparatory steps. Please follow the steps below to prepare your lab environment to enable successful completion of any guides that reference or link to this document. 

## 1.0 Prepare `cli-vm` to use the required HTTP/s Proxy

The HOL lab environment only permits limited internet access sufficient to complete exercises in any lab guides that have been prepared for HOL-2031 compatibility. Any host in the lab environment that needs to access the limited internet resources must use the lab proxy server. The following steps will show how to prepare the `cli-vm` ubuntu host to use the labs internet proxy. 

1.1 From the Main Console (ControlCenter) desktop, open putty and under saved sessions, open a ssh connection to `ubuntu@cli-vm`

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-08-24-00-52-43.png">
</details>
<br/>

1.2 From the `cli-vm` prompt, enter the commans `sudo nano ~/.bashrc` and enter the sudo password `VMware1!` to use the nano text editor to edit the .bashrc file for the root user on cli-vm. The .bashrc file is a special file that loads commands and environmental variables into the bash shell each time you open a new shell session (including ssh sessions) with `cli-vm`. 

While it is possible to export the required environmental variables directly from the `cli-vm` prompt, exporting directly from the bash prompt only loads the environmental variables in the currently running session, so if you were to close your ssh session to `cli-vm`, or if the ssh session were to timeout, the environmental variables would no longer be populated the next time you connected to `cli-vm`. 

By placing the required environmental variables in the .bashrc file, it will ensure that the proxy configuration is still present each time you connect to `cli-vm` during your active session with a HOL-2031 pod. If at any point you end your HOL-2031 session or your lease times out and you need to re-enroll to launch a new HOL-2031 session, you will need to repeat these steps. (If your HOL-2031 session has a temporary timeout and allows you to "Resume your lab", you do not need to repeat these steps)

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-08-24-02-20-31.png">
</details>
<br/>

1.3 In the nano editor, scroll to the very bottom of the .bashrc file, and enter the following lines at the very end of the file. After you have entered the following lines, enter the key combination `ctrl o` then hit the `enter` key to save the file, and then enter the key combination `ctrl x`to close the file.

```bash

```

<details><summary>Screenshot 1.3</summary>
<img src="Images/2018-12-14-02-09-13.png">
</details>
<br/>

1.4 Create and checkout a new branch to make your updates on. It is a common practice on github to create a temporary branch to submit your update, and then later after your update is accepted, you can delete the update branch as it will be no longer needed and it helps ensure a clean process if you make a new temporary update branch each time you plan to make updates and do a pull request.

In this example you can use `update-1` as the branch name, the name you use doesnt matter but if in the future you create an update branch and find it already exists, it may mean you forgot to delete it after a previous update so be sure to create a new branch and if needed delete any existing temporary branches that may be leftover from previous updates.

Enter the followwing commands to create and checkout a new `update-1` branch

```bash
git branch
git checkout -b update-1
git branch
```

<details><summary>Screenshot 1.4</summary>
<img src="Images/2019-02-09-15-44-24.png">
</details>
<br/>

1.5 From the `cli-vm` prompt, enter the following commands to create a new folder with your github username under the students directory and initialize a readme file in that folder.

When you create a new folder in a git repository, the folder will not be added to the repository until you have a file in it. The `echo` command included below passes the text in quotations and if not present create a file named readme.md in your directory. You can replace the text "my snarky comment" with any string you would like.

**Make sure you replace the string "yourGithubUsername" in the commands below with your unique github username**

```bash
ls
mkdir yourGithubUsername # Replace every instance of "yourGithubUsername" with your unique github.com ausername
echo "my snarky comment" > yourGithubUsername/readme.md
cat yourGithubUsername/readme.md
cd yourGithubUsername/
ls
```

<details><summary>Screenshot 1.5</summary>
<img src="Images/2019-02-09-17-20-46.png">
</details>
<br/>

1.6 From the `cli-vm` prompt ensure you are in the `~/Forked/Students` directory and connect your forked clone back to the source PKS-Ninja repository, then validate the upstream configuration is correct.  If your shell prompt does not show current directory, use command `pwd` to show your current working directory.

```bash
pwd
git remote add upstream https://github.com/CNA-Tech/Students.git
git remote -v
```

<details><summary>Screenshot 1.6</summary>
<img src="Images/2018-12-14-02-51-58.png">
</details>
<br/>

1.7 From the `cli-vm` prompt ensure you are in the `~/Forked/Students` directory and of you have not already, ensure your standard git defaults are set with the following commands, being sure to use your github username and the email associated with your github account.  If your shell prompt does not show current directory, use command `pwd` to show your current working directory.

```bash
pwd
git config --global user.name "Your Name"
git config --global user.email you@example.com
git config --global push.default simple
```

<details><summary>Screenshot 1.7</summary>
<img src="Images/2019-02-09-18-09-06.png">
</details>
<br/>

### Step 2: Setup http proxy on docker client

2.1 From the ControlCenter desktop, open chrome, connect to the vSPhere web client and login using the windows system credentials checkbox. Navigate to the `Hosts and Clusters` page, expand `RegionA01`, right click on cluster `RegionA01-MGMT01` and select `Deploy OVF Template`

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-08-23-23-53-53.png">
</details>
<br/>

2.2  Select the EPMC OVF File from the location where you downloaded it and click `Next`. The default download location is `E:\Downloads`.

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-08-24-00-07-33.png">
</details>
<br/>

2.3 On the `Select Name and Folder` page, set the `Virtual Machine Name` to `epmc-01a` and click `Next`

<details><summary>Screenshot 2.3</summary>
<img src="Images/2019-08-24-00-10-05.png">
</details>
<br/>

2.4 On the `Select a compute resource` page, expand `RegionA01-MGMT01` and select the `pks-mgmt-1` resource pool and click `Next`.


<details><summary>Screenshot 2.4</summary>
<img src="Images/2019-08-24-00-43-31.png">
</details>
<br/>

2.5 On the `Review Details` page, verify the details and click `Next`.

<details><summary>Screenshot 2.5</summary>
<img src="Images/2019-08-24-00-13-13.png">
</details>
<br/>

2.6 On the `License Agreements` page, check the `I accept all license agreements` checkbox and click `Next`.

<details><summary>Screenshot 2.6</summary>
<img src="Images/2019-08-24-00-15-05.png">
</details>
<br/>


2.7 On the `Select Storage` page, **First** select the `RegionA01-ISCSI02-COMP01` datastore, and then set the `virtual disk format` to `Thin Provision` and click `Next`.

<details><summary>Screenshot 2.7</summary>
<img src="Images/2019-08-24-00-17-25.png">
</details>
<br/>

### Step 3: Prepare CLI-VM with the public harbor servers certificate so it can establish secure connectivity to the registry

 3.1 From the Control Center desktop, open the chrome browser and click on the link to `NSX Manager` in the bookmarks bar. Login with the username `admin` and the password `VMware1!VMware1!`. Navigate to the `Advanced Networking & Security > Networking > NAT` page, ensure the `Logical Router` value is set to `t0-pks` and delete all existing NAT rules

<details><summary>Screenshot 3.1</summary>
<img src="Images/2019-08-24-03-53-37.png">
</details>
<br/>

3.2 From the `Advanced Networking & Security > Networking > NAT` page, ensure the `Logical Router` value is set to `t0-pks` and click `+ADD` to add a SNAT rule for epmc-01a. In the `New NAT Rule` dialogue, enter the following values (leave any unspecified values set to their default value):

- Priority: `1020`
- Action: `SNAT`
- Source IP: `172.31.0.8`
- Translated IP: `10.40.14.8`
- Click `ADD`

<details><summary>Screenshot 3.2</summary>
<img src="Images/2019-01-08-19-55-48.png">
</details>
<br/>

3.3 From the `Advanced Networking & Security > Networking > NAT` page, ensure the `Logical Router` value is set to `t0-pks` and click `+ADD` to add a DNAT rule for epmc-01am and enter the following values in the `New NAT Rule` dialogue:

- Priority: `1024`
- Action: `DNAT`
- Destination IP: `10.40.14.8`
- Translated IP: `172.31.0.8`
- Click `ADD`

<details><summary>Screenshot 3.3</summary>
<img src="Images/2019-08-24-02-57-48.png">
</details>
<br/>

3.4 From the Control Center Desktop, open a new browser tab in chrome, and navigate to [https://epmc-01a.corp.local/login](https://epmc-01a.corp.local/login), login with the username `root` and the password `VMware1!`

<details><summary>Screenshot 3.4</summary>
<img src="Images/2019-08-24-03-04-27.png">
</details>
<br/>