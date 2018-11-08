# Lab 11 - PKS Troubleshooting

**Contents:**

- [Step 1: Validate Base Environment]() <!-- Validate MTU, Base vCenter, components external to NSX and PKS -->
- [Step 2: Validate NSX-T Control Plane Health]()
- [Step 3: Validate Ops Manager & BOSH Director Health]()
- [Step 4: Validate PKS Control Plane Health]()
- [Step 5 Common Troubleshooting Scenarios]()
- [Next Steps]()

## Overview

In this section you will review the core troubleshooting tools used in PKS troubleshooting with a focus on core product CLI and UI tools not inclusive of external monitoring and operational tools such as the vRealize suite or Wavefront, which are covered in different sections

When facing a troubleshooting scenario, there are a few common steps that should be taken in nearly every scenario:

- First, it is almost always a best practice to open a support case early in any scenario where problems may occur to help ensure customer satisfaction. VMware support teams for PKS recommend opening proactive support requests (SRs) even for POC engagements, installation and planned updates in addition to unplanned outage support.
  - Plan to open a proactive support request for planned work engagements, and in the event of a problem scenario, it is recommended that you open a ticket as early as possible. This allows your request to be routed and in queue for a support agent while you take additional steps
  - While in queue you can continue to engage in troubleshooting steps and in the event you are not able to resolve the issue yourself, this method will ensure the quickest path to a support agent to help assure an optimal resolution
- Next, attain a functional understand of the target environment and ensure you have sufficient documentation, understanding and access to the environment to move forward towards a successful resolution
- Next, validate the last known working state of the environment, and identify any potential changes that have occurred in the environment that may have affected the previously known working state

In this lab guide, we will initially focus on validating all the core PKS components following a standard installation. The steps will follow the order by which PKS and related software are typically installed and configured, just as you performed in Labs 2 and 3.

This is not necessarily an ideal order to follow in a troubleshooting scenario as you may have error messages or other contextual information that lead you on a more direct path, however in lieu of more direct information running through an all-around validation of core components is an excellent excercise to help identify error conditions with details that can lead towards problem resolution

## Step 1: Validate Base Environment

**Stop:** Prior to beginning this lab, you should have a functional PKS deployment running in a non-production lab environment. The reference lab used to develop this guide was built following the steps in Labs 2-5 of this course

1.1 Review and attain familiarity with the environment topology. If needed gather details and build some basic topology and reference documents to reference throughout additional troubleshooting steps

This lab guide focuses on troubleshooting steps for the specific topology used herein. PKS does however have multiple different topology and deployment options and it is important to fully understand the details of the environment you are working in to identify optimal resolution steps.

The following screenshots and files document the topology and relevant configuration variables that represent the last known good configuration state for the lab environment.

<details><summary>Screenshot 1.1 </summary>
<img src="Images/2018-10-23-01-31-40.png">
</details>
<br/>

1.2 On the `New Project` screen, set the `Project Name` to `trusted` and click `OK`

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-23-01-35-25.png">
</details>
<br/>

1.3 On the `Projects` page, click on `trusted`,  click on the `configuration` tab and enter the values as shown in Screenshot 1.3

<details><summary>Screenshot 1.3</summary>
<img src="Images/2018-10-23-02-45-20.png">
</details>
<br/>