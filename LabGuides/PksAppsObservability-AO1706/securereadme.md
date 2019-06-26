
# Steps to Prometheus Operator to a Secure Environment
## Step 1: Identify all the images that are being pulled from the public repo

Currently the following images are being pulled

### prometheusOperator:
image:
    repository: quay.io/coreos/prometheus-operator
    tag: v0.29.0

configmapReloadImage:
    repository: quay.io/coreos/configmap-reload
    tag: v0.0.1

prometheusConfigReloaderImage:
    repository: quay.io/coreos/prometheus-config-reloader
    tag: v0.29.0
    
hyperkubeImage:
    repository: k8s.gcr.io/hyperkube
    tag: v1.12.1

### prometheusSpec:
image:
      repository: quay.io/prometheus/prometheus
      tag: v2.9.1
      
### alertmanagerSpec:     
image:
      repository: quay.io/prometheus/alertmanager
      tag: v0.17.0
### grafana      
image:
   repository: grafana/grafana
   tag: 6.2.0


testFramework:
   image: "dduportal/bats"
   tag: "0.4.0"

downloadDashboardsImage:
   repository: appropriate/curl
   tag: latest

image:
     repository: busybox
     tag: "1.30"

  NOTE: The tag / versions of the images require to be checked as per your helm charts


## Step 2: Add all the images to private registry (Harbor)

Example step to pull tag and push an image to a harbor repository 

```bash
docker pull quay.io/coreos/prometheus-operator:v0.29.0
docker tag quay.io/coreos/prometheus-operator:v0.29.0  hostharbor.local.net/monitoring/prometheus-operator:v0.29.0
docker push hostharbor.local.net/monitoring/prometheus-operator:v0.29.0
```

## Step 3: Update helm charts and dependencies


```bash
cd ~/helm/charts/stable/prometheus-operator/charts
  cp -r ../../kube-state-metrics .
  cp -r ../../grafana .
  cp -r ../../prometheus-node-exporter .
  ls -rlt
  tar -cvzf kube-state-metrics-1.1.0.tgz kube-state-metrics
  tar -cvzf  prometheus-node-exporter-1.4.2.tgz prometheus-node-exporter
  tar -cvzf grafana-3.3.9.tgz grafana
```

## Step 4: Deploy Prometheus Operator

```bash
helm install ~/helm/charts/stable/prometheus-operator --name prometheus --namespace monitoring  --set prometheusOperator.createCustomResource=false
```

## Step 5: Follow Step 2 of the main guide
