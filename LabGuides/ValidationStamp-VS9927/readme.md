# Commit a Validation Stamp

In the directory for every LabGuide on the PKS Ninja Github site, there should be a file called `validation.md`, please add your github username and the version number of the PKS Lab Template you are using to the validation.md file as described in the [Instructions](#instructions) section below.

For additional details and explanations, please see the other sections of this page per the table of contents below.

## Contents

- [Commit a Validation Stamp](#commit-a-validation-stamp)
  - [Contents](#contents)
  - [Introduction](#introduction)
  - [Prereqs](#prereqs)
  - [Understanding the Git Pull Request Process](#understanding-the-git-pull-request-process)
  - [Instructions](#instructions)

## Introduction

When you complete a lab guide on the PKS Ninja Github site, please enter a validation stamp to confirm that you were able to get through the lab without problems. It is very easy and quick to add a validation stamp.

*If you do not complete a LabGuide successfully, DO NOT ADD A VALIDATION STAMP*

If you had any problems and could not complete a lab guide, please open an issue as shown in the [Reporting an Issue on Github](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/ReportingAnIssue-RI7933)

Validation Stamps are a very important part of the continuous integration model that the PKS Ninja Community uses to keep lab guides up to date. The PKS Ninja Lab template is continuously updated, and accordingly there is a need to continuously validate the lab guides with the latest version of the template, and it is a huge help to the community when you take an extra moment to leave a validation stamp.

## Prereqs

For this lab, you will need access to a PKS Ninja lab environment. Please see the [Getting Access to a PKS Ninja Lab Environment] (https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) course for further instructions on lab access.

## Understanding the Git Pull Request Process

On any project where multiple people contribute updates, a system is needed so that project leaders can recieve and have an approval process to ensure that updates are desirable and do not conflict with updates other people are making. 

On modern software and devops projects, version control systems are used for this purpose, and Git is the industry standard version control system for Linux, Cloud Native and Open Source projects. 

Git uses a "Pull Request" process when a user wants to make an update to a community repository. This is because to make an update, the user first makes a their own seperate copy of the repository, updates their seperate copy, and then opens a pull request, which sends a request to the admin of the git repository you want to update, requesting that they pull the updates from the users copy into the main repository. 

The image below from the Kubernetes developers guide provides a visual overview of the full Pull request process. Please note that to commit a validation stamp, you will be using a highly simplified version of this process:

<img src="https://github.com/kubernetes/community/blob/master/contributors/guide/git_workflow.png">

In the [Instructions](#instructions) section below, you will use Github's in-browser text editor to add your validation stamp to the validation file for this LabGuide. When you use the in-browser editor to make an update, github automatically creates a fork and branch for you making it very quick and easy to do simple updates. 

This same process can be used to contribute updates to most modern open source and private development projects.

When you are making more complex updates or contribute to a project regularly, it is usually desirable to edit files on your local workstation where you can use more advanced editing tools. While it is not needed for simple updates, if you plan to work supporting cloud native and devops processes, you should plan to also learn the complete pull request process. The [Create your student folder](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/CreateStudentFolder-SF6361) lab  is designed to help students new to Git to learn the full pull request process. 

Note: If you have worked with your own personal Git repository before, the pull request process may be new to you as users do not need to do a pull request to update their own repositories. 

## Instructions

1.1 Open a web browser to `https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/` and click on the `validate.md` file

<details><summary>Screenshot 1.1</summary><img src="Images/2019-01-19-02-17-40.png"></details><br>

1.2 In the file editor toolbar, click on the pencil icon to edit the file

<details><summary>Screenshot 1.2</summary><img src="Images/2019-01-18-20-19-57.png"></details><br>

1.3 In the text editor window, on a new line, enter your validation stamp

Your validation stamp is your github username followed by a semicolon, followed by the PKS Template Version number you are using in your lab environment, followed by `<br/>`, which is an html line break tag to ensure a line break follows your stamp. Include both major and minor version numbering if a minor version is used. 

Example #1: 

`yourGithubUsername;vX.y,br/>`

Example #2 - the github user `afewell` using PKS Lab Template `v11`, would enter the following stamp:

`afewell;v11<br/>`

Please see the screenshots below for an additional example. Be sure to use your own github username in your validation stamps

<details><summary>Screenshot 1.2</summary><img src="Images/2019-01-18-20-19-57.png"></details><br>