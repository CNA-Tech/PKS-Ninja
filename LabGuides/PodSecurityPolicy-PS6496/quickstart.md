# Quick start Guide to run apps when PSP is enabled

## Introduction

The purpose of this guide is to be able to run apps without getting into detialed understanding of PSPs. For more comprehensive understanding of the PSP feature, please refer to the [readme](readme.md).

## Prerequisites

1. Kubernetes Cluster deployed using Enterprise PKS
2. PodSecurityPolicies enabled in Ops Manager for the plan used to deploy this k8s cluster
3. kube config file pointing to the one of the namespaces in this k8s cluster
4. Plese navigate to the demo folder in this directory. All commands will run from that directory

## Running Apps with Restrictive Access

We will deploy the busybox deployment by using the *pks-restrictive* psp. This deployment is using the default ServiceAccount in the current namespace. The RoleBinding has been also modified to apply to the default ServiceAccount in the current namespace.

1. Let's take a look at the role-binding and then deploy it

    ```yaml
    $ cat quick-restricted/role-binding.yml
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
    name: psp:demo-psp-restricted
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: psp:restricted
    subjects:
    - kind: ServiceAccount
    # If ServiceAccount in application is not specified, default ServiceAccount is used in each namespace.
    #  For deploying apps that are using a different SA, change the field below to the name of the ServiceAccount
    name: default
    ```

    Note that the Rolebinding is applied to the default ServiceAccount.

    Now create the RoleBinding on this namespace

    ```bash
    $ kubectl apply -f quick-restricted/role-binding.yml
    rolebinding.rbac.authorization.k8s.io/psp:demo-psp-restricted created
    ```

2. Now we will deploy the busybox deployment. Let's take a look at the yaml for this deployment.

    ```yaml
    $ cat quick-restricted/busybox.yml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: busybox
    spec:
    selector:
        matchLabels:
        app: busybox
    replicas: 3
    template:
        metadata:
        labels:
            app: busybox
        spec:
        containers:
        - name: busybox
            image: busybox
            command: [ "sh", "-c", "while true; do echo $(hostname) v1; sleep 60; done" ]
            securityContext:
            runAsUser: 500
    ```

    Note that this deployment is not associated to any ServiceAccount. Hence, k8s will use the default ServiceAccount to create this deployment.

    ```bash
    $ kubectl apply -f quick-restricted/busybox.yml
    deployment.apps/busybox created
    ```

3. Verify that the busybox deployment is up and running

    ```bash
    $ kubectl get pods
    NAME                       READY   STATUS    RESTARTS   AGE
    busybox-755747d686-qkpzf   1/1     Running   0          34s
    busybox-755747d686-v4zrp   1/1     Running   0          34s
    busybox-755747d686-wjtth   1/1     Running   0          34s
    ```

    This concludes the running of deployment with unrestricted priviliges.

## Running Apps with Privileged Access

In this example, we will deploy the nginx deployment which will run nginx containers as root users on our cluster.

1. The first thing to create is a ClusterRole. By default, the pks-privileged PSP does not have ClusterRole associated to it but pks-restrictive does. That is why we didn't create a ClusterRole in the above example.

    ```yaml
    $ cat quick-privileged/role.yml
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
    annotations:
    name: psp:privileged
    rules:
    - apiGroups:
    - extensions
    resourceNames:
    - pks-privileged
    resources:
    - podsecuritypolicies
    verbs:
    - use
    ```

    Let's create this ClusterRole

    ```bash
    $ kubectl apply -f quick-privileged/role.yml
    clusterrole.rbac.authorization.k8s.io/psp:privileged created
    ```

2. Now, let's create the rolebinding for psp:priviliged

    ```yaml
    $ cat quick-privileged/role-binding.yml
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
    name: psp:demo-psp-privileged
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: psp:privileged
    subjects:
    - kind: ServiceAccount
    name: default
    ```

    Note that default ServiceAccount is being used here to associate with psp:privileged ClusterRole.

    ```bash
    $ kubectl apply -f quick-privileged/role-binding.yml
    rolebinding.rbac.authorization.k8s.io/psp:demo-psp-privileged created
    ```

3. Let's take a look at nginx deployment

    ```yaml
    $ cat quick-privileged/nginx.yml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: nginx
    spec:
    selector:
        matchLabels:
        app: nginx
    replicas: 3
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
        - name: nginx
            image: nginx:1.13-alpine
            ports:
            - containerPort: 80
            securityContext:
            runAsUser: 0
    ```

    Deploy the nginx deployment

    ```bash
    $ kubectl apply -f quick-privileged/nginx.yml
    deployment.apps/nginx created
    ```

4. Verify that nginx pods are running

    ```bash
    $ kubectl get pods
    NAME                     READY   STATUS    RESTARTS   AGE
    nginx-5ccd576c8c-26f4j   1/1     Running   0          5s
    nginx-5ccd576c8c-5k9x8   1/1     Running   0          5s
    nginx-5ccd576c8c-7km8h   1/1     Running   0          5s
    ```

    This shows that our nginx containers are running as root with PSP enabled.
