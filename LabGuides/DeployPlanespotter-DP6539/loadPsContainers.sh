#!/bin/bash

#Pull (download) each of the required container from planespotter from the public harbor registry
docker pull harbor.cloudnativeapps.ninja/library/planespotter-app-server:V1
docker pull harbor.cloudnativeapps.ninja/library/planespotter-frontend:V1
docker pull harbor.cloudnativeapps.ninja/library/mysql:5.6
docker pull harbor.cloudnativeapps.ninja/library/redis:latest
docker pull harbor.cloudnativeapps.ninja/library/adsb-sync:V1

#Retage each of the downloaded images to prepare them for loading into your local private harbor.corp.local registry
docker tag harbor.cloudnativeapps.ninja/library/planespotter-app-server:V1 harbor.corp.local/library/planespotter-app-server:V1
docker tag harbor.cloudnativeapps.ninja/library/planespotter-frontend:V1 harbor.corp.local/library/planespotter-frontend:V1
docker tag harbor.cloudnativeapps.ninja/library/mysql:5.6 harbor.corp.local/library/mysql:5.6
docker tag harbor.cloudnativeapps.ninja/library/redis:latest harbor.corp.local/library/redis:latest
docker tag harbor.cloudnativeapps.ninja/library/adsb-sync:V1 harbor.corp.local/library/adsb-sync:V1

#Push the re-tagged images to your local harbor.corp.local registry
docker push harbor.corp.local/library/planespotter-app-server:V1
docker push harbor.corp.local/library/planespotter-frontend:V1
docker push harbor.corp.local/library/mysql:5.6
docker push harbor.corp.local/library/redis:latest
docker push harbor.corp.local/library/adsb-sync:V1