# PKS Ninja Community Getting Started Guide

- [Step 1: Prepare and Connect](#step-1-prepare-and-connect)
- [Step 2: Try some courses or labs](#step-2-try-some-courses-or-labs)
- [Step 3: Engage in the Ninja Learning Model](#step-3-engage-in-the-ninja-learning-model)
- [Step 4: Become a Regular PKS Ninja Contributor](#step-4-become-a-regular-pks-ninja-contributor)
- [Step 5: Stay in the loop!](#step-5-stay-in-the-loop)

## Step 1: Prepare and Connect

### 1.1 Prerequisite and foundational skills

Basic Linux Skills and awareness of computer operating systems and common system administration concepts typically taught in a standard introductory Linux course are needed for all students. 

Also Many of the lab guides on this site do not provide thorough explanation of concepts. 

Please review the [Community Foundational and Prerequisite Skills](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/FoundationalSkills-FS8954) to find online learning resources to help with foundational skills to compliment the Ninja lab guides with additional details and explanations of important concepts explored in the exercises.
  
### 1.2 Getting in the loop

The PKS Ninja community maintains active public communication channels so participants can stay in the loop with the latest updates and reach out to fellow community members for support or to discuss other community topics. Please see details to sign up to the community mailing list and slack channel below

#### 1.2.1 Mailing List

The PKS Ninja community has a public google group to provide a mailing list service. Any important updates for the community will be sent to this list, and members are free to send appropriate requests for PKS Ninja Community related discussions to the list

To sign up for the list, please [click here to visit the pks-ninja-labs google group](https://groups.google.com/forum/#!forum/pks-ninja-labs/join) and click on the link to "Apply for membership" and your request should be approved as quickly as staff can. There is no special requirement for membership, we currently only require approval to make sure we know and can offer support and a welcome message when a new participant joins the group

#### 1.2.2 Slack Channel

The community hosts an active #pksninjalabs channel on the public VMware Code Slack domain. To sign up, [click here and follow the instructions to sign up for VMware Code](https://code.vmware.com/join)

After you sign up you will get access to the VMware Code Slack domain, login and search for the #pksninjalabs channel and request to join to be added

## Step 2: Try some courses or labs

### 2.1 Get access to a compatible lab environment

While the materials on this site can be used for reference, to take full advantage of the materials you will need to have access to a running PKS environment. We highly recommend using a PKS Ninja Lab environment as the lab guides provide validated, exact steps that work in the PKS Ninja Lab environment exactly. 

For VMware employees, Onecloud templates are available for the PKS Ninja lab, for all others we can provide instructions on how you can build your own compatible lab environment. 

Please see [Getting Access to a Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528) for more details.

You can also attempt to complete the lab exercises on your own PKS installation, however you will need to make any adjustments needed to the materials for your specific environment

### 2.2 Before you start

While it is not required, we ask all participants who try using a course or lab guide to let us know if it worked or if you run into any problems. 

If you complete a lab guide, we ask that you add your name to a simple text file quickly so we know it worked for you, the process takes under a minute, and you will learn the easiest way to contribute to nearly any open source github project, and your public github profile will display new commits each time you validate a guide! 

#### 2.2.1 Please start with the [Commit a Validation Stamp](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/ValidationStamp-VS9927) lab to learn this quick process before taking any courses so you can help with this important process while learning valuable cloud native skills. 

#### 2.2.2 If you run into any problems or have any suggestions, please create an issue, it takes under a minute and ensures that we have a record to fix the problem. 

Opening an issue is as easy as clicking on the issues tab for the repo and submitting a simple ticket explaining the problem in your own words, be sure to include the url of the page you are having a problem with. If you would like further instructions, please see [Opening an Issue on Github](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/ReportingAnIssue-RI7933)

If you are unsure if there is a problem or your mistake, dont worry, issues can be opened for any reason, this community is designed to be supportive of people new to this process. 

Github issues are used in this manner in most open source and cloud native projects on github, so when you use issues, you are developing a critical cloud native skill. 

### 2.3 Try Some Labs!

This section provides details on how to get started trying some labs - however please note before you try to many labs, review step 3 below, as it is important to know before you get too far into the lab exercises to maximize your learning experience.

#### 2.3.1 [Courses]

Lab guides are the central aspect of the learning materials in the pks ninja github site, and are designed to be small and modular, which allows them to be adapted to different course formats and user needs more easily. To support this modular design, lab guides are broken down into smaller sections, and often completing a learning exercises may require completing several lab guides in a particular sequence. 

For example, if you wanted to learn to install core PKS components using automated pipelines, the standard process currently involves 3 distinct steps: run the nsxt install pipeline, then run the opsman/bosh/pks install pipeline, then run the Harbor install pipeline

Per the modular design principles of the site, each of these steps is detailed in a seperate lab guide. But, with this model, there needs to be a way for people to know the order and sequence of the lab guides to be able to complete an installation. This is what [Courses](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses) are for.

[Courses](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses) are just text documents that provide instructions needed to understand and complete exercises that involve multiple lab guides, for example, the [PKS the Easy Way](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksTheEasyWay-PE6650) course provides instructions and lists the order in which the required lab guides must be executed to complete the automated installation. 

#### 2.3.2 Independent Lab Guides

Some lab guides arent especially useful independently, for example the [Deploy First PKS Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployFirstCluster-DC1610) lab guide is very short and really only useful in the context of a course. 

As a result, the LabGuides directory is not the best way to find independent lab guides. 

If you would like to find lab guides that are easy to navigate without an associated [Course]((https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses)), please see the [Try Some Labs!]((https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses)) page, which provides a listing of LabGuides that are valuable without requiring a course guide. 

## Step 3: Engage in the Ninja Learning Model

Most modern cloud native and devops projects operate around a standard git based workflow as the center of how all the various roles that support the project contribute their respective parts to the project in a manageable way. 

The PKS Ninja Github site implements the standard git based workflow to manage all content on the site. This aspect is a core part of the learning experience, enabling participants to learn and participate in a real implementation of this core cloud native/devops workflow with a specially designed model to support participants who are new to this process and experienced git committers alike. 

The first step in learning how to participate in git projects starts with the  [Commit a Validation Stamp](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/ValidationStamp-VS9927) lab per step 2 above, which teaches a simple but very effective way to execute the industry standard "pull request" (PR) process to commit updates. The same exact method can be used to contribute to most modern cloud native and open source projects. 

**Note: For your own personal git repos, you do not typically do a pull request (PR). The PR process is implemented on projects with multiple contributors including most professional and open source projects, including the PKS Ninja repositories**

While the simple method to do PR's is very useful for simple updates, if you plan to work regularly on git based projects or want to develop this important skill, the more advanved method of doing a pull request is important, as it allows you to make your updates on a copy of the git repository that you download to your local workstation where you can use more advanced editing tools and functions. 

The advanced pull request method is a fairly simple, repetive process that is really easy and quick *once you get used to the process*, However, the process is very intimidating for new users. Its a lot like riding a bicycle, which can seem like an active of gravity-defying complexity if youve never done it, but it can be learned pretty quickly and once you learn it is very easy. 

### 3.1 Create your student folder

To get started learning the advanced pull request method, the [Creating your Student Folder](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/CreateStudentFolder-SF6361) guide is a specially designed exercise designed to help new students get comfortable quickly with this process. 

In this exercise, participants create a student folder on the dedicated [student folder repository](), where each student creates a subdirectory using their github username, ensuring that every student can have their own unique space where they can practice committing to a shared git repository using the industry standard pull request process. 

Once you have completed creating your student folder, to reinforce your understanding and comfort with the steps in the advanced pull request process it is essential that you practice this process several times. To get this practice, whenever you take any course or lab guide, any time you create or modify a file as part of an exercise, you should save a copy of the file to your student repository, which requires you to do execute the pull request process. This method removes coding or other complex unrelated things that are used in most git examples to highlight the exact steps of the pull request in a very clear way, and if you follow this practice the advanced pull request steps will become like second nature very quickly. 

After you get comfortable with the advanced PR process with your student folder, the next step in advancing your skill level is to use the advanced pull request process to commit updates to the PKS Ninja repository, which is covered in the following section.

## Step 4: Become a Regular PKS Ninja Contributor

While the simple pr method to contribute updates covered in the [Commit a Validation Stamp](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/ValidationStamp-VS9927) lab is a great way to handle simple updates, if you would like to be a regular contributor to the PKS Ninja repo, you should also know how to use the advanced pull request process to make updates to the PKS Ninja Repo. 

### 4.1 Set up your Contributor Workspace

The [Setting up your Contributor Workspace](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/ContributorWorkspace-CW4267) guide provides instructions to setup your environment and execute the advanced pull request process to update the PKS-Ninja repository. 

This guide also provides important information and guidelines for site contribution.

## Step 5: Stay in the loop! 

Cloud native technologies constantly evolve, and people who work with these technologies need effective ways to keep their skills up to date and to continue to build additional skills and depth. New courses and lab guides for all levels from beginner to expert are added regularly, so keep an eye out for email updates to the community mailing list and visit the site regularly to enhance and grow your knowledge and skills with devops and cloud native technologies

**This completes the getting started guide, thank you for participating in the PKS Ninja Community!**

<!-- 
- Step : Review the [Building your Devops Workstation](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DevopsWorkstation-DW5008) lab guide to learn practical tips and tricks for optimizing your workstation/jumpbox environments, using IDE's and other common tools that will make your life easier and more productive when working with devops and cloud native platforms 
-->
