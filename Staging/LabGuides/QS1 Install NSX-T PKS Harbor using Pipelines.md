## Quickstart Guide - Install NSX-T, PKS, and Harbor using Concourse pipelines

# 1) Get VMware training lab environment

https://www.vmwarelearningplatform.com/hosted-eval

# 2) Get the IP address of the ControlCenter windows machine
In the lab environment console, launch Chrome browser, run http://myip.oc.vmware.com, get the IP address
Setup RDP client with the IP address as the target

# 3) Install NSX-T using Concourse pipeline
Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/NsxtPipelineInstall-IN7016

script this to run from cli-vm:

~~~
cd concourse
docker-compose up -d
docker ps
#(verify ps results)
cd ~/nsx-t-datacenter-ci-pipelines/pipelines
source nsxt-setup.sh
fly-s
~~~

http://cli-vm.corp.local:8080/teams/main/pipelines/install-nsx-t

admin/VMware1!



# 4) Install PKS using Concourse pipeline

Pipeline has issues. Review Issues list upstream!

Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/PksPipelineInstall-IN2456

# 5) Install Harbor
Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/HarborPipelineInstal-IN4968

Harbor login: admin/VMware1!

# 6) Setup Harbor

Create a new project called "trusted", Configuration Select: Enable..Prevent..Automatically..

On Projects->Library -> Push Image, note commands to tag and push from docker.

Go to OpsMan, install OpsMan Root Cert on Bosh for PKS nodes <> Harbor comms.



  Lab Guide: https://github.com/CNA-Tech/PKS-Ninja/tree/Pks1.4/LabGuides/IntroToHarbor-IH7914
  
  
Add Harbor cert to cli-vm for comms:

Get cert from OpsMan->Harbor-> Settings->Certificate. Copy SSL cert into buffer or text editor

Add the Harbor SSL cert to the Docker certs on cli-vm

~~~ mkdir /etc/docker/certs.d/harbor.corp.local
cd /etc/docker/certs.d/harbor.corp.local
nano ca.crt
#Paste the certificate text into nano, save and close the file
systemctl daemon-reload
systemctl restart docker
~~~


See Guide #2 to setup cluster and deploy apps
