#!/bin/bash

#Pull (download) each of the required container from planespotter from the public harbor registry
docker pull 35.209.26.28/library/planespotter-app-server:V1
docker pull 35.209.26.28/library/planespotter-frontend:V1
docker pull 35.209.26.28/library/mysql:5.6
docker pull 35.209.26.28/library/redis:latest
docker pull 35.209.26.28/library/adsb-sync:V1

#Retage each of the downloaded images to prepare them for loading into your local private harbor.corp.local registry
docker tag 35.209.26.28/library/planespotter-app-server:V1 harbor.corp.local/library/planespotter-app-server:V1
docker tag 35.209.26.28/library/planespotter-frontend:V1 harbor.corp.local/library/planespotter-frontend:V1
docker tag 35.209.26.28/library/mysql:5.6 harbor.corp.local/library/mysql:5.6
docker tag 35.209.26.28/library/redis:latest harbor.corp.local/library/redis:latest
docker tag 35.209.26.28/library/adsb-sync:V1 harbor.corp.local/library/adsb-sync:V1

#Push the re-tagged images to your local harbor.corp.local registry
docker push harbor.corp.local/library/planespotter-app-server:V1
docker push harbor.corp.local/library/planespotter-frontend:V1
docker push harbor.corp.local/library/mysql:5.6
docker push harbor.corp.local/library/redis:latest
docker push harbor.corp.local/library/adsb-sync:V1