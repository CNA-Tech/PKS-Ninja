# Getting Access to a PKS Ninja Lab Environment

## PKS Ninja Lab Environments

To be able to use the lab guides on this site, you will need access to a compatible lab environment

PKS Ninja uses a standard lab topology and configuration which is currently defined in onecloud templates. Available templates are versioned, and it is important you select the NinjaLab version that aligns with the git branch you are using. The main branch of the github site will always reflect the latest published template, and seperate git branches are maintained for older template versions. 

At the time of writing, the current template version is v11, for most users, you can load a v11 template and proceed with the lab guides on the site. If you would like to use an older version, load the older template, and navigate to the appropriate branch on the pks ninja repository to find content specific to your version. 

There are 3 onecloud templates available for the v11 template:
- CNABU-2019-01-PKS-Ninja-v11 
  - This template has vcenter pre-installed and prepared to do a NSX-t and PKS installation as documented in the [PKS the Easy Way](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/PksTheEasyWay-PE6650) or the [PKS the Hard Way](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/PksTheHardWay-PH7885) Courses
- CNABU-PKS-Ninja-v11-NsxtInstalled
  - This is the same as the above base v11 template, but with NSX-T Preinstalled. This template could take 30-60 minutes to load into a fully operational state
- CNABU-PKS-Ninja-v11-PksInstalled-1.1
  - This template is built on the base v11 template but has the following pre-installed: NSX-T, OpsMan, Bosh, PKS, Harbor, vRLI
  - This template will take around 40 minutes to fully load
- CNABU-PKS-Ninja-v11-ClusterReady-1.1
  - This template is built PksInstalled-1.1 but already has a cluster deployed so once you load it up its all ready to use for demos or work on feature lab guides
  - This template will take around 40 minutes to load into a fully operational state
  
Note: NinjaLab v10 templates are also available with PKS 1.2. IF you would like to use a v10 template, please switch to the v10 branch of the PKS-Ninja Repo. If you use the PKS Ninja v10 template, you must install the [v10 template patch](https://github.com/natereid72/PKS-Ninja-Lab-Patch) before proceeding. 
  
Each of these templates should be available both in onecloud and VLP, please see the corresponding link below for further instructions:

- VMware Employees with access to Onecloud, please see [Accessing the PKS Ninja Lab with OneCloud](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/OnecloudNinjaLab-OL2089)
- VMware or Pivotal or Dell Tech employees without access to Onecloud, please see [Accessing the PKS Ninja Lab with VMware Learning Platform](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/VlpNinjaLab-VL6532)
- For all others, we are actively working on tutorials for creating compatible lab environments. Until further instructions are available, please reach out on the slack channel or pks-ninja-labs@googlegroups.com and we would can provide further documentation that can help you prepare a compatible lab environment
  
<!--
- For instructions on building a single server nested PKS Ninja Lab, please see [Building a Nested Single Server PKS Ninja Lab](https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/NestedNinjaLab-NL3985)
-->
