## High-level guide to setup a Kubernetes cluster and deploy the first app
Pre-req: QS1 - PKS ready with Harbor

# 1. Setup UAA user

From cli-vm or opsman (if cli-vm doesn't have uaac)

UAA login via ssh to opsman

opsman ip 10.40.14.3 ubuntu/VMware1! (v10 template)

uaac target https://pks.corp.local:8443 --skip-ssl-validation

uaac token client get admin -s <<creds for UAA Admin from Ops Manager>>
  
  e.g.: uaac token client get admin -s vtYb4E0GLG8xCzX8nHX0bdhNkW-nM2DO
  
add user:

uaac user add pksadmin --emails pksadmin@corp.local -p VMware1!

uaac member add pks.clusters.admin pksadmin


Got errors the users exists :)

Continuing on...

# 2. Setup first cluster

From cli-vm, do pks login to execute CLI

pks login -a pks.corp.local -u pksadmin -p VMware1! --skip-ssl-validation

pks clusters

pks create-cluster my-cluster --external-hostname my-cluster.corp.local --plan small

For detsils see lab guide:

Follow https://github.com/CNA-Tech/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610

# 3. Deploy first app
