# Accessing the PKS Ninja Lab with VMware Learning Platform Hosted Eval Tenant

**The Hosted Eval VLP Tenant is only accessible to select VMware and Pivotal employees unless your VMware account representative has given you access, please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) for lab access options for non VMware/Pivotal employees**

If you are a VMware or Pivotal employee and would like access to VLP, please contact afewell@vmware.com

VMware employees will only be eligible for access to VLP Hosted-Eval if they do not have functional access to a PKS Ninja vApp Template from OneCloud

## Instructions

1.1 Open a web browser, navigate to https://www.vmwarelearningplatform.com/hosted-eval/catalogs/, login, select the `PKS-Eval-LongLease` Catalog and launch the `PKS-Ninja-v10` template

<details><summary>Screenshot 1.1</summary>
<img src="Images/2018-12-24-17-50-53.png">
</details>
<br/>

1.2 When Using the PKS Ninja v10 template, you must run a script to make some minor updates to the lab environment before beginning any lab guides. The following steps must be completed each time you load a new instance of the Ninja v10 template

You can run this script after deploying your v10 lab template, to fix the DNS client issue and the PKS pipeline issue.

1.2.1 From the control center desktop, open an ssh connection to cli-vm, git clone https://github.com/natereid72/PKS-Ninja-Lab-Patch.git

1.2.2 As [per the readme](https://github.com/natereid72/PKS-Ninja-Lab-Patch), execute the shell script (Execute source cc-p1.sh at the command line on cli-vm)

1.2.3 then follow lab guides as normal
No need to copy or edit files this way. Just run the script and v10 will work per the guides