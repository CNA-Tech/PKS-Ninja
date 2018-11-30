# PKS Ninja Labs Contributors Preview

Welcome, the Ninja Labs contributors preview!

This program provides early access to the new lab environment which is prepared for the Ninja labs. The lab guides are largely complete, and though not quite finished can offer a valuable learning experience for contributors

There are several known issues with the current lab guides which are described below further. There is no specific expectation as to what or how much any participant should contribute, the community is grateful for any level of contribution

At minimum all participants are expected to provide feedback by creating an issue on the [github issues page](https://github.com/CNA-Tech/PKS-Ninja/issues)for this site. Ideally though we ask that if you provide updates or corrections, that you fork the repo, commit updates and use a pull request to merge the updates, as described in the [Contributors Guide]() 

## Getting Started

We anticipate most contributors will want to go through the lab exercises first and while going through the exercise identify any issues for correction, and then create a github issue for the needed correction or just make the correction directly and use the PR process to merge your update

In addition to going through the materials to find issues, contributors can go directly to the github issues page, review open issues and resolve any issues you can 

To get started going through the labs, you need some additional background information that is not described well in the current lab guides (feel free to help fix)

The live version of the Ninja course is broken up into 2 seperate sessions, the first session includes labs 1-8, and the second session includes labs 9-16. The students in the live version of the course install PKS during the first session, and then start with a fresh lab environment for the second session where students perform a pipeline-based installation

The above paragraph is not clearly explained in the current lab guides, to people viewing the labs on github it is currently not clear how this is broken down, this will be clarified but for the time being it is important that you as reviewers understand this point

If you would like to go through the labs in sequence, keep in mind you will need to install NSX-T before you can begin lab 2, as the first week of ninja included a manual PKS Install, but NSXT was preinstalled on the base pod at that time. You can use the pipeline install covered in lab 9 to install nsx-t and then proceed with lab 2 if you want to go in order from the beginning. 

If you finish labs 1-8 and want to proceed with lab 9-16, you will need to reload a fresh Ninja pod when you begin lab 9 so you can complete the installation. If you would like to proceed through all the labs without restarting the pod to do a pipeline installation, you should be able to do so. The results of the manual installation should be identical to the pipeline installation, so you should be able to complete either installation process, and then proceed to any of the other labs. 

## What needs the most help?

This community aspires to grow significantly, there is tremendous room for all types of contributions, however the current sprint is focused on completing the core Ninja lab guides

Lab 1: Still branded for VKE, needs terminology and screenshots updated for new Cloud PKS branding. If you go through this lab to do the exercise, you can simply take updated screenshots as you go for any screenshots where the existing screenshots are out of date

Lab 2-5: These lab guides were completed on an earlier version of the base template, and I think some steps, variables and screenshots may not be exactly right and need to be updated. For anyone going through these labs, please first reference the variables used in the pipeline variables files on the cli-vm, as shown in labs 9-11. When you go through the steps in labs 2-5, cross reference the pipeline variables and ensure you are using the variables from the pipeline files. If you see anything incorrect in the current lab please update via PR or at minimum open an issue on the github page

Lab 6-8: These labs are incomplete and need significant updates. If you would like to update these labs, please use the standard format and style that you see in the other lab guides that are completed. Note that if you would like to add updates to this lab, you do not need to finish the entire thing, any/all updates are appreciated!

Lab 13-14: Need content, nothing there right now. 

Lab 16: This lab is light on content, needs more. 

All of the labs are at best in 1.0 state, if you see anything that you would recommend for improvement, feel free to make any suggestions via email, slack channel, google group or most ideally through a github issue or pull request. 

Also, you may want to add net new content not covered in the current labs, PLEASE DO THIS! It is a huge goal for the community to add additional content that students can just run through. If you build any new lab exercises yourself using the lab template, anyone else in the community should be able to easily do the exercise themselves where the shared resources make it easier on content contributors as they dont need to document the base lab and only the steps to build on the exisitng ninja labs and we are hoping to build a large and continuously growing set of exercises in the /LabGuides/BonusLabs directory. 

## How to access the labs

Once you have confirmed your participation by emailing afewell@vmware.com, I will set up your account on https://www.vmwarelearningplatform.com/hosted-eval/ and you should recieve an email with login instructions from VMware Learning Platform (VLP). 

Once you have logged in, on the left navigation bar you should see the `PKS-Eval-LongLease` catalog, and in that catalog you should see the PKS-Ninja-Base-v7 template, enroll in that template and start the labs. The VLP environment is nearly identical to the HOL environment and so you should be familiar with how to access the lab once you have logged into the portal. 

VMware staff can connect to their labs using View/ VPN + RDP. Once they have launched their labs, then they can find the lab IP address by going to the following URL in a browser on the Control Center VM:
http://myip.oc.vmware.com/ 

If needed, you can [view the VLP FAQ here](https://communities.vmware.com/docs/DOC-24916)



Thanks so much for contributing to the PKS Ninja Labs effort!!





##



