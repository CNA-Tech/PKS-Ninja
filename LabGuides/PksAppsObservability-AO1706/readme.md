# PKS Monitoring & Observability using Prometheus, Grafana and Jaeger

## Overview

 - Observability: 
   Monitoring related data made available from the applications and other components. If observability is not built-in, data should be gathered by traditional ways.

 - Monitoring:
   Collects, aggregates and displays observability data.

 - Analysis: 
   Automatic or manual analysis of collected monitoring data to instrument and take actions.


### Prometheus
 - Prometheus: is a systems and service monitoring system. 
 - Server scrapes and stores time-series data
 - Client libraries instrument application code
 - The Push Gateway routes metrics from jobs that cannot be scraped
 - Exporters support third-party systems or short-lived jobs
 - The Alertmanager generates alerts and notifications

### Grafana
 - An analytics and monitoring tool used for visualization

### Jaeger
 - Distributed transaction tracing
 - Root cause Analysis
 - Service dependency analysis
 - Performance / latency optimization
 - Natively supports Opentracing
 - Exposes Prometheus metrics by default
 - Distributed transaction monitoring

### Prometheus Operator
 - Create/configure/manage Prometheus clusters atop Kubernetes 
 - The default installation is intended to suit monitoring a kubernetes cluster the chart is deployed onto. It closely matches the kube-prometheus project.



## Prerequisites

- Please see [Getting Access to a PKS Ninja Lab Environment](https://github.com/CNA-Tech/PKS-Ninja/tree/master/Courses/GetLabAccess-LA8528) to learn about how to access or build a compatible lab environment
- PKS Install (https://github.com/riazvm/PKS-Ninja/tree/master/LabGuides/PksInstallPhase2-IN1916)
- PKS Cluster (https://github.com/riazvm/PKS-Ninja/tree/master/LabGuides/DeployFirstCluster-DC1610)


## Installation Notes

Anyone who implements any software used in this lab must provide their own licensing and ensure that their use of all software is in accordance with the software's licensing. This guide provides no access to any software licenses.

For those needing access to VMware licensing for lab and educational purposes, we recommend contacting your VMware account team. Also, the [VMware User Group's VMUG Advantage Program](https://www.vmug.com/Join/VMUG-Advantage-Membership) provides a low-cost method of gaining access to VMware licenses for evaluation purposes.

This lab follows the standard documentation, which includes additional details and explanations: [NSX-T 2.3 Installation Guide](https://docs.vmware.com/en/VMware-NSX-T/2.2/com.vmware.nsxt.install.doc/GUID-3E0C4CEC-D593-4395-84C4-150CD6285963.html)

### Overview of Tasks Covered in Lab 1
Deploy Prometheus Operator helm chart which includes the following
    prometheus-operator
    prometheus
    alertmanager
    node-exporter
    kube-state-metrics
    grafana
    service monitors to scrape internal kubernetes components
    kube-apiserver
    kube-scheduler
    kube-controller-manager
    etcd
    kube-dns/coredns With the installation, the chart also includes dashboards and alerts

Deploy Prometheus operator in a secured environment 

Deploy Jaeger

Deploy opentracing instrumented application

Test Grafana Charts

Test transaction logs

<IN PROGRESS>