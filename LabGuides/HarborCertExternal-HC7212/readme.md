# Enable Harbor Client Secure Connections

Harbor's integration with PKS natively enables the PKS Control Plane hosts and Kubernetes nodes for certificate based communications with Harbor, but most environments have additional external hosts that need to negotiate communication with harbor other than just K8s nodes. For example, developer workstations, pipeline tools,etc

To ensure developer and automated workflows can have secure interaction with Harbor, a certificate should be installed on the client machine

In the following exercise, you will install the Harbor self-signed certificate on the `cli-vm` host preparing it to interact with Harbor services

1.1 From the Ops Manager homepage, click on the `VMware Harbor Registry` tile, go to the `Certificate` tab and copy the SSL certificate text from the top textbox

<details><summary>Screenshot 1.1.1</summary>
<img src="Images/2018-10-24-01-50-50.png">
</details>

<details><summary>Screenshot 1.1.2</summary>
<img src="Images/2018-10-24-01-48-15.png">
</details>
<br/>

1.2 From the ControlCenter Desktop, open putty and under `Saved Sessions` connect to `cli-vm`.

<details><summary>Screenshot 1.2 </summary>
<img src="Images/2018-10-23-03-04-55.png">
</details>
<br/>

1.3 Install the cert as a trusted source on the cli-vm by navigating to the `/etc/docker/certs.d/harbor.corp.local` directory (create this directory if it doesn't already exist) and creating a `ca.crt` file with the certificate text you copied in the previous step using the following commands:

```
mkdir -p /etc/docker/certs.d/harbor.corp.local
nano /etc/docker/certs.d/harbor.corp.local/ca.crt
```

Paste the certificate text into nano, save and close the file

<details><summary>Screenshot 1.3</summary>
<img src="Images/2018-10-24-02-15-15.png">
</details>

1.3.1 Create a directory within Docker on the cli-vm to allow TLS communication between Docker on the client and Harbor
```
mkdir -p ~/.docker/tls/harbor.corp.local\:4443/
```

1.3.2 Copy the Harbor cert into the Docker tls directory you just created, as well as your local user certificate directory
```
cp /etc/docker/certs.d/harbor.corp.local/ca.crt  ~/.docker/tls/harbor.corp.local\:4443/
cp /etc/docker/certs.d/harbor.corp.local/ca.crt /usr/local/share/ca-certificates/
```

1.3.3 Update your certificates and restart Docker service
```
update-ca-certificates
service docker restart
```


#### You have now prepared `cli-vm` for secure communication with Harbor