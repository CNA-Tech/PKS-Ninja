## Quickstart Guide - PKS using Concourse pipelines

# 1) Get VMware training lab environment

https://www.vmwarelearningplatform.com/hosted-eval

# 2) Get the IP address of the ControlCenter windows machine
In the lab environment console, launch Chrome browser, run http://myip.oc.vmware.com, get the IP address
Setup RDP client with the IP address as the target

# 3) Install NSX-T using Concourse pipeline
Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/NsxtPipelineInstall-IN7016

script this to run from cli-vm:

cd concourse

docker-compose up -d

docker ps

(verify ps results)

cd ~/nsx-t-datacenter-ci-pipelines/pipelines

source nsxt-setup.sh

fly-s



# 4) Install PKS using Concourse pipeline
Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/PksPipelineInstall-IN2456

# 5) Install Harbor
Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/HarborPipelineInstal-IN4968

# 6) Deploy App
