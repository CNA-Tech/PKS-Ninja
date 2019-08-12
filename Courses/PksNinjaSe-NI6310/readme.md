# PKS Ninja SE Course Guide

- [Introduction](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#introduction)
- [Instructions](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#instructions)
- [Sample Lab Agenda](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#sample-ninja-lab-agenda)
  - [Session 1 Labs List](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#ninja-labs-part-1-agenda)
  - [Session 2 Labs List](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#ninja-labs-part-2-agenda)

**Note:** If you are a student in an in-person live Ninja class, please skip ahead to the [Sample Ninja Lab Agenda](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksNinjaSe-NI6310#sample-ninja-lab-agenda) section to find the list of lab guides for your class

## Introduction

This guide is an online version of the PKS Ninja Course for SE's, which is a VMware internal class offering. While the live class offering is restricted, the lab guides used in the program are available freely on this site. In addition to the lab guides used in the live class, the PKS Ninja online community offers many additional regularly updated courses and lab guides to support many additional topics and the continuing education of community participants

The live PKS Ninja for SEs course agenda includes both lecture and lab components, whereas the online version only includes lab guides and not lectures. Rather than including the same lecture components on the github site, the lab guides will be enhanced to include detailed instructions and links to additional resources to enable independent learners to fully understand the course materials. This approach was chosen as smaller lecture components integrated in-line with lab materials is an effective learning model for independent and asynchronous participants

While the live ninja course is a limited access offering, anyone can gain a fully equivalent level of knowledge independently and validate their knowledge by going through the Ninja lab guides provided on this site. The main focus of the PKS Ninja course is practical hands on skill, not just theoretical knowledge. Any participant who is able to get through the lab guides and fully understand the exercises provided has attained the learning outcome intended for the course, whether they attend the live course or complete the lab guides independently

## Instructions

To get started with the PKS Ninja lab guides, the first thing you will need is access to an appropriately prepared lab environment. Please see the [Getting Access To a Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GetLabAccess-LA8528) page for further instructions

Once you have access to a compatible lab environment, you can proceed through the lab guides. You can choose to go through the lab guides in the same order as the Live Ninja class, but that is not necessary and may not be the best approach for many students

All of the LabGuides currently available on this site can be completed on the standard ninja lab environment. Lab guides can be divided into 2 categories, installation guides, and guides that can be completed after the installation of NSX-T, PKS Control Plane, and Harbor. Once you have completed the installation, you should be able to proceed through any of the additional lab guides in any order

### Step 1: Choose a method to install NSX-T, PKS Control Plane, and Harbor

There are lab guides for manual installation, and for automated installation. Regardless of which method you choose, the completed installation is identical. The Live ninja class has students complete the manual installation on week 1, then when students return for the 2nd week of the program, they start with a pipeline based installation

This is not an ideal method for everyone, many students may prefer to start with a simple automated installation and proceed through some additional lab guides to gain experience and comfort with a working implementation before embarking on the manual installation process, which is fairly complex.

- If you prefer to start with a manual installation, please follow the instructions in [PKS The Hard Way](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksTheHardWay-PH7885)
- If you prefer to start with an automated (pipeline-based) installation, please follow the instructions in [PKS The Easy Way]()

There are lab guides on this site that only require kubernetes and can be completed on different kubernetes environments without requiring PKS, however all labs can be completed on the standard ninja lab topology

### Step 2: Choose which lab guides to take next

After installation, you should be able to proceed through any of the other available labs. If you have a need to learn about a specific technology like NSX-T or Persistent Storage, you can proceed directly to the lab guide you prefer, referencing the lab guides listed in Step 3 below or select from the complete list of lab guides on the [lab guide homepage](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides) which includes additional content beyond what is included in the live class

If you would like to proceed through the standard sequence of lab guides, that is a great way to gain experience with PKS, Kubernetes and other related cloud native topics

## Sample Ninja Lab Agenda

The Live Ninja class is delivered over two seperate 3 day sessions. At the beginning of each session, students start with a fresh lab environment and complete an installation before proceeding with additional labs

The Live Ninja course includes a combination of lecture and lab sessions, however the online version on this site does not include the same lecture components. Lab guides provide highly detailed instructions, enabling newer students with limited experience to successfully complete the exercises. At the time of writing, most of the available lab guides do not include detailed explanations of the underlying technologies; however additional detailed explanations, images and links to external and multimedia content will be added to the lab guides to provide lessons and explanations that deliver a deeper understanding of the technologies implemented in the lab exercises

### Ninja Labs Part 1 Agenda

- Complete the following lab guides:
  - [NSXT Installation with Concourse Pipeline](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/NsxtPipelineInstall-IN7016)
  - [PKS Install Phase 1](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksInstallPhase1-IN3138)
  - [PKS Install Phase 2](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksInstallPhase2-IN1916)
  - [Harbor Tile Install](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/HarborTileInstall-HI3943)
  - [Deploy First Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployFirstCluster-DC1610)
  - [Introduction to Harbor](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/IntroToHarbor-IH7914)
  - [Deploy Planespotter](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployPlanespotter-DP6539)
  - [PKS Storage and Persistence 1](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksStorageAndPersist-SP7357)
  - [PKS Wavefront Integration 1](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksWavefrontInt-WA9983)
  - [PKS Monitoring and Operations 1](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksMonitoringAndOps-MO2189)

### Ninja Labs Part 2 Agenda

- Load a fresh copy of the PKS Ninja lab template
- Complete the following lab guides:
  - [PKS the Easy Way](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/PksTheEasyWay-PE6650)
  - [Deploy First Cluster](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/DeployFirstCluster-DC1610)
  - [Git Learning Path](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/Courses/GitLearningPath-GP5125)
  - [Intro to Helm](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/IntroToHelm-HE4490)
  - [Deploy More Apps Labs](../DeployMoreApps-DA6020/readme.md)
  - [PKS Troubleshooting](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksTroubleshooting-PT8251)
  - [PKS Control Plane and BOSH](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksControlPlaneBosh-CP3546)

**This completes the labs included in the live Ninja course, for additional course and lab guides, please see the [courses](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides) and [lab guides](https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides) homepages**