# Lab - PKS / Wavefront Integration
## -- Under Construction -- _Please use proper PR process to contribute to this lab guide. It is recommended that you work on a single section per PR. For file paths, screenshots, URLs, etc., attempt to maintain 'look and feel' of other sections_

**Contents:**

- [Lab Access Instructions](#lab-access-instructions)
- [Step 1: Review Current Cluster Pods](#step-1-review-current-cluster-pods)
- [Step 2: Log into Wavefront and Collect API Info](#step-2-log-into-wavefront-and-collect-api-info)
- [Step 3: Configure PKS Tile for Wavefront Monitoring](#step-3-configure-pks-tile-for-wavefront-monitoring)
- [Step 4: Confirm Wavefront Proxy Deployment](#step-4-confirm-wavefront-proxy-deployment)
- [Step 5: Create a Wavefront Dashboard](#step-5)
- [Next Steps]()

<br>

## Lab Access Instructions

For this lab, you will need access to ControlCenter desktop with cli-vm, ops manager via web browser, and an active Wavefront subscription with API access.

*If you haven't already, register for a 30 day trial Wavefront subscription at https://www.wavefront.com/sign-up/. (If you are a VMware employee, you will need to provide a personal email address.)*

<br>

## Step 1: Review Current Cluster Pods

1.1 From the ControlCenter desktop, open putty, connect to `cli-vm`, and issue the following command: 

`kubectl get pods --all-namespaces` (I'll change this once I install Wavefront integration and get the correct namespace)

Review the currently running pods. We will run this command again after configuring the PKS tile for Wavefront monitoring to observe the addition of the Wavefront proxy pod.

<br>
<details><summary>Screenshot 1.1</summary>
<img src="Images/---.png">>
</details>
<br/>

1.2 

1.3 

## Step 2: Log into Wavefront and Collect API Info

## Step 3: Configure PKS Tile for Wavefront Monitoring

## Step 4: Confirm Wavefront Proxy Deployment

## Step 5: Create a Wavefront Dashboard

<br/>

## Next Steps

### [Please click here to proceed to ..
