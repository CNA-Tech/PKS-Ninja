# Creating your Student Folder

This section is currently under development and is incomplete, please check back soon for additional updates

Forking and Pull requests lab exercises
--

2.2.1 Open a web browser,  log into your github.com account and from the same tab, navigate to the PKS Ninja Repo at [https://github.com/cna-tech/pks-ninja](https://github.com/cna-tech/pks-ninja). Click the `Fork` button on the upper right hand corner of the page as shown in the screenshot below

Note to lab proctors: If your account is listed as an admin for the CNA-Tech or PKS-Ninja repos, you will not be able to fork the repo unless you login with a different account

<details><summary>Screenshot 2.2.1</summary>
<img src="Images/2018-11-14-11-26-54.png">
</details>
<br/>

2.2.2 After the fork is completed, your browser will be redirected to the github page for the new forked repo. Click the `Clone or download' link and copy the url as shown in the screenshot below

<details><summary>Screenshot 2.2.2</summary>
<img src="Images/2018-11-14-11-33-50.png">
</details>
<br/>

2.2.3 From the control center destop use putty to connect to `cli-vm` and enter the following commands to clone the repo. Note that first you will create a seperate directory for the forked clone in case anyone has cloned the source repo to their environment, this will prevent confusion. There is no requirement to have any special naming of folders where forked directories are cloned. 

Note: Be sure to replace the URL in the `git clone` command with the URL of your fork of the PKS-Ninja repo

```bash
mkdir ~/Forked
cd ~/Forked
git clone https://github.com/yourAccountName/PKS-Ninja.git # replace the url with the url to your fork of the PKS-Ninja repo
cd PKS-Ninja
```

<details><summary>Screenshot 2.2.3</summary>
<img src="Images/2018-11-14-11-42-45.png">
<img src="Images/2018-11-14-11-43-13.png">
</details>
<br/>

2.2.4 From the `cli-vm` prompt ensure you are in the `/root/Forked/PKS-Ninja` dirctory with the command `pwd` and connect your forked clone back to the source PKS-Ninja repository with the command `git remote add upstream https://github.com/CNA-Tech/PKS-Ninja.git`, and validate the upstream configuration with the command `git remote -v`

<details><summary>Screenshot 2.2.4</summary>
<img src="Images/2018-11-14-11-56-55.png">
</details>
<br/>

2.2.5 From the `cli-vm` prompt, enter the following commands to create a new folder with your github username under the students directory and initialize a readme file in that folder

**Make sure you replace the string "yourGithubUsername" in the commands below with your unique github username**

```bash
ls
cd Students
mkdir yourGithubUsername
touch yourGithubUsername/readme.md
cd ~/Forked/PKS-Ninja/
```

<details><summary>Screenshot 2.2.5</summary>
<img src="Images/2018-11-14-12-03-03.png">
</details>
<br/>

2.2.6 From the `cli-vm` prompt, enter the following commands to stage, commit and push these changes up to your forked github repository

**Make sure you replace the string "yourGithubUsername" in the commands below with your unique github username**

```bash
git add Students/yourGithubUsername/
git add Students/yourGithubUsername/readme.md
git commit -m "added PKS-Ninja/Students/yourGithubUsername subdirectory and readme. file"
git push origin master
```

<details><summary>Screenshot 2.2.6</summary>
<img src="Images/2018-11-14-12-14-14.png">
<img src="Images/2018-11-14-12-14-57.png">
</details>
<br/>

2.2.7 Open a web browser connection to the source PKS-Ninja repo at `https://github.com/cna-tech/pks-ninja` and click on `New Pull Request` as shown in the image below

<details><summary>Screenshot 2.2.7</summary>
<img src="Images/2018-11-14-12-17-20.png">
</details>
<br/>

2.2.8 On the `Open a pull request` page, click on the `compare across forks` link and select CNA-Tech/PKS-Ninja as the `base fork` on the left and yourGithubUsername/PKS-Ninja as the head fork on the right and click `create pull request` as shown in the screenshot below

<details><summary>Screenshot 2.2.8</summary>
<img src="Images/2018-11-14-12-21-50.png">
</details>
<br/>

2.2.9 After you submit the pull request, an administrator of the PKS-Ninja repo can visit the pull requests tab and merge the requested changes. The screenshot below shows an administrator-level view, you should also be able to view the pull request in the CNA-Tech/PKS-Ninja repository on the pull requests tab, but you will not have the rights to merge the pull request

<details><summary>Screenshot 2.2.9</summary>
<img src="Images/2018-11-14-12-27-26.png">
</details>
<br/>

2.2.10 From your web browser, navigate to the [https://github.com/CNA-Tech/PKS-Ninja/tree/master/Students](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Students) page. After an administrator merges your pull request, you should see a folder with yourGitHubUsername on this page

<details><summary>Screenshot 2.2.10</summary>
<img src="Images/2018-11-14-12-35-10.png">
</details>
<br/>

### You now know how to contribute to CNABU, VMware and other Github repos, we need your contribution to build the best learning community we can! Using the fork/pull request process you executed in the above steps, you could even post updates as simple as correcting a typo you find on a page or making bigger contributions! We can definitely use your help and look forward to growing VMware CNA learning communities together!

### Thank you for completing the PKS Ninja Intro to Git lab!
