# Enable Harbor Client Secure Connections

Harbor's integration with PKS natively enables the PKS Control Plane hosts and Kubernetes nodes for certificate based communications with Harbor, but most environments have additional external hosts that need to negotiate communication with harbor other than just K8s nodes. For example, developer workstations, pipeline tools,etc

To ensure developer and automated workflows can have secure interaction with Harbor, a certificate should be installed on the client machine

**Table of Contents:**

- [Enable Harbor Client Secure Connections](#enable-harbor-client-secure-connections)
  - [1.0 Prepare `cli-vm` with the certificates to connect to the local harbor.corp.local server](#10-prepare-cli-vm-with-the-certificates-to-connect-to-the-local-harborcorplocal-server)
  - [Addendum: Certificate prep for to connect to the public PKS Ninja Lab harbor backup server](#20-prepare-cli-vm-with-the-certificates-to-connect-to-the-public-pks-ninja-lab-harbor-server)


## 1.0 Prepare `cli-vm` with the certificates to connect to the local harbor.corp.local server

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

1.3 Install the cert as a trusted source on the cli-vm by navigating to the `/etc/docker/certs.d/harbor.corp.local` directory (create this directory if it doesn't already exist) and creating a `ca.crt` file with the certificate text you copied in the previous step using the following commands. You'll need to use `sudo` for some of the commands below. The `ubuntu` user's password is `VMware1!`:

```
sudo mkdir -p /etc/docker/certs.d/harbor.corp.local
sudo nano /etc/docker/certs.d/harbor.corp.local/ca.crt
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
sudo cp /etc/docker/certs.d/harbor.corp.local/ca.crt  ~/.docker/tls/harbor.corp.local\:4443/
sudo cp /etc/docker/certs.d/harbor.corp.local/ca.crt /usr/local/share/ca-certificates/
```

1.3.3 Update your certificates and restart Docker service
```
sudo update-ca-certificates
sudo service docker restart
```

**You have now prepared `cli-vm` for secure communication with harbor.corp.local

## 2.0 Prepare `cli-vm` with the certificates to connect to the public PKS Ninja Lab harbor backup server

The primary pks ninja labs harbor server is at https://harbor.cloudnativeapps.ninja - if you are able to access this server, you do not need to complete the steps below. If for any reason the harbor.cloudnativeapps.ninja server is not available, you may be able to access the backup harbor server at 35.209.26.28, however you will need to follow the steps below prior to accessing the server.

2.1 From the Control Center desktop, open a putty session with `ubuntu@cli-vm` and from the prompt, enter the following commands to create the required directory to keep registry certificates in the docker client, and to use the nano text editor to create a file for the PKS Ninja Labs Public Harbor server CA certificate:

 ```bash
 sudo mkdir -p /etc/docker/certs.d/35.209.26.28/
 sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt
``` 

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-08-24-20-53-46.png">
</details>
<br/>

2.2 Expand the `35.209.26.28.crt` section below, copy and paste the text into the nano editor you have open on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

<details><summary>Expand to see `35.209.26.28.crt`</summary>

```text
-----BEGIN CERTIFICATE-----
MIIFkzCCA3ugAwIBAgIJAPfzHiX8Tz4SMA0GCSqGSIb3DQEBDQUAMGAxCzAJBgNV
BAYTAlVTMQswCQYDVQQIDAJDQTELMAkGA1UEBwwCQ0ExDzANBgNVBAoMBnZtd2Fy
ZTEPMA0GA1UECwwGaGFyYm9yMRUwEwYDVQQDDAwzNS4yMDkuMjYuMjgwHhcNMTkw
ODA5MDc0OTA3WhcNMjkwODA2MDc0OTA3WjBgMQswCQYDVQQGEwJVUzELMAkGA1UE
CAwCQ0ExCzAJBgNVBAcMAkNBMQ8wDQYDVQQKDAZ2bXdhcmUxDzANBgNVBAsMBmhh
cmJvcjEVMBMGA1UEAwwMMzUuMjA5LjI2LjI4MIICIjANBgkqhkiG9w0BAQEFAAOC
Ag8AMIICCgKCAgEAlWslbk8Q2U7ZDo/L4IQxJixJ5dOt8/XCQJ0/jL4O62rb+grl
EHxqp2xcwsZIOw5Rkt9K4ZLlf/2CqlsQ3XwEjscXuXeoe+YANG2DahdAAgp+uD6e
1c4074Z2gnf1lq2q2fcLP71eI1qP9aaP8G/fOskeZA4fB3JETUSkk8ah8mtow9uj
8pUe2BWqsP/j9cuf5ROmy86QlEVmMbgiZA29m+LTX611wMV9rgfVLxmRF4GvQKzb
SDMrSH4ZMsB0q2nGo3QFP+NF3/Tbg50aYLgMp66RqWLvcAmKQhnp+yemT5RSXh/A
xEKr0a8fZatd5zthpAI1R7UHTE9S9nl0oEUrx0j9XP6Zpzz4RJ9/XzRGDsZDjCEt
bdkRcafkSkEMiVLHCYhlPCHoZCeJi6/9EyFIothJMc33RaAJgUAsqeqs9/2aj4nz
rhAocokBwj/GM8XNQ+Eh2xUQGoaKjlaaSB/rAbsoqHxatUs6oTZmAv8Mz48eTVyG
bFMXcj1P86c4QCl2yhjq3i9dnyjRkLehw5riFhMYkIqJq5lQTt0dWOwLV92LoydE
zphx/3OL8gRiM3morAt2rWRVh/piqOTGzqsrTtLtZfgOeLAK8LoZ40Ub3SC4i0rI
BvtUGM6Z/6ByOU8gQn5LFrqWR02zI56O+57XvISjute5DQFRKd7a2GjPIpcCAwEA
AaNQME4wHQYDVR0OBBYEFCAA+ryv70UY10lfFQxsI8pc+9FFMB8GA1UdIwQYMBaA
FCAA+ryv70UY10lfFQxsI8pc+9FFMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEN
BQADggIBAHYWnN7u4Mlz1D2wR0h1UHqiy46zzy4XC0wi5RsBeqWYloHlLxto+3VX
S4zLO/Tu9ahHTgzBYRRfGKkZrjHN3Brxdj5tVAA4N4NPeEYEe1k10tqWdfW7s16P
qJPm87bT8qiZ1BIT8o00URvCQ1kRIpMVGv/0kpZOJKfS5hVQar3NpYFVc2S5Xx3H
aKYxnlokp24UlaeFeM7BFqvbDaIQoAtv/dsgkk3a5agSNrVFVW/pBjuKW6tykRD7
S9jE4m3P6jhCtk75QX/+iqY/hynAXpqvtfaSl6dcD4TuBlxKcycdTuhHVU6A0Z+R
rXl9IqyXvzA/8n5JcPrCxyZk0lHbY5vutoA5Z+rQ1W/gxJpmTsK5H0YBzQf3lu12
TrKAzbXn9RderTrutMZKKYyd+9ZHvZJqadge4tpFsn3bTWdh/IgBchUCux2Zkksv
rJ9E0SAxY8MM971QMCk0xAjbcJh8VGD7EOjcyrcbQ8Z/Ag0G26XX39WLhFGelinF
l4z4O43/HVJLcWcbvieQdUldXN4DEIIeSHOsvlw7cIyiGCCvnb+W3piauBqPRMkD
LDwY5cbbUcDZ+CU6Qla+fWSGsEwa4TnBE7AOF0nh4YYf84ZRSEAkTJVgOhedu0HV
mJr/8bFERygpi0jloPRX3pAz6cbqeh5fmiM78Dm6qQA9aJ1cOJjq
-----END CERTIFICATE-----
```

</details>

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-08-24-21-04-46.png">
</details>
<br/>

2.3 At the `cli-vm` prompt, enter the command `sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.cert` to create a file to save the Harbor server certificate. Expand the `35.209.26.28.cert` section below, copy the certificate text and paste it into the nano editor on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

<details><summary>Expand to see `35.209.26.28.cert`</summary>

```text
-----BEGIN CERTIFICATE-----
MIIFpDCCA4ygAwIBAgIJAJqO1qydBWlbMA0GCSqGSIb3DQEBDQUAMGAxCzAJBgNV
BAYTAlVTMQswCQYDVQQIDAJDQTELMAkGA1UEBwwCQ0ExDzANBgNVBAoMBnZtd2Fy
ZTEPMA0GA1UECwwGaGFyYm9yMRUwEwYDVQQDDAwzNS4yMDkuMjYuMjgwHhcNMTkw
ODA5MDc1OTEyWhcNMjkwODA2MDc1OTEyWjBgMQswCQYDVQQGEwJVUzELMAkGA1UE
CAwCQ0ExCzAJBgNVBAcMAkNBMQ8wDQYDVQQKDAZ2bXdhcmUxDzANBgNVBAsMBmhh
cmJvcjEVMBMGA1UEAwwMMzUuMjA5LjI2LjI4MIICIjANBgkqhkiG9w0BAQEFAAOC
Ag8AMIICCgKCAgEA2RLWHiiaiHZHtbymeRgdftTAgBnxFNUxx+IR/11vEi5P4yvk
qho2sv8h0Gp5vqnM0JgKg6MTkhFlApYw1JeI84BsikK+ESPgMEDAcB8jdgFmOs0K
+4uusMJbRyAWIS4BJMiHERGNLZzExzLxm4Tz3lCVt8O6VIP8GQR43BI8t9sw41uY
9vrc41o5fnQdRJNxSPxg2W3sxa0UurJHEjJXsgLxFWAnZRQzkeBZ2NNJw9826saF
aJzx9TuwDC5VE5O630cA6RJ8nqLWirj5tnkTPRK5WG5xJMxenZFn8sWUIM/hUC2G
yWuyhI/ribXReB/x5RdHs/PZRESLDMvqQa7zwPsyV/bkes1WqGAC9vY7Ngv9KrzI
0g1YUfiA/P4QfLE2bTg29VW98Zsr+h9PAPIy5egMQkse3Hux6hSlVywoETCMRtq+
Rin4I6NMb/EJ0PIgP9FcENlkUX33dbJ3ykLpo1jKMy1wXCuDZdZgemr/+Ty/jGJ/
frjpbHxv+pALuwS8xXziFGf1mGwC6pYDERPgMqTGj23DpuYj07J1nG7M/mhuSeQT
+M6OeplZRCYtY/mytVApQUzWHQlphEdWHh5iEGIenO52MOwwb1I4/6HRJgQE/eG+
rR2/8CghLVE00Tevx/M8rzk2mH7xQTxk92mZsK/BFwPvl9VVuJVFc+HB7kkCAwEA
AaNhMF8wHwYDVR0jBBgwFoAUIAD6vK/vRRjXSV8VDGwjylz70UUwCQYDVR0TBAIw
ADALBgNVHQ8EBAMCBPAwEwYDVR0lBAwwCgYIKwYBBQUHAwEwDwYDVR0RBAgwBocE
I9EaHDANBgkqhkiG9w0BAQ0FAAOCAgEAY5Cj8IZnbCyaa5/vWqOsCBUFfycjZ6AZ
iJ5rRs6StH7eDNIZxmlF0GcDPlpZCWCNKvAeA+bRI4+qmYCSwahnyK0YzsDXnkZq
P8/tfzUKdUViH3VtJoirbXowfhqujSyIWeBMTpvCVCA1po7+70LxLnRjCCWhB3zf
YcNhHv7Ilm2lLVDjqVZjGH7iaaRFUVkbaCjzF2Z52GQ8+aN6rHfgki1yvzT4Ia9u
lUYDm8JcKFTwSEKKIECnTOe6efmSkdFllYKhfmOlJrWov3Cv8j59DPVJAo3ZsdoS
21mzu1q/9XSZiobnV5fXm+wgVvAgYBsIsxuEenXqyKnDKauCqcpXb1zyEvIjVXL1
wIKJQYlyqf4E1u9y+YGXSYqs6kOsXmXFtY1iAa1Hpx3gIPmAOoBhRgf/gN2Frwa+
/NJXz38JQbBWAtv78eKVQI+Xvy/R/HG+Tq/lqi6wXIz+T4QVd7K/2KnC+KkXFc+k
x/TYS8Vw1DTcPK4bFBQB5Y3SC5ssbvILTy/KKJsdtTLUD8YQuL7Qtrl9DaVIPYlS
u4wyZXLSjAEcwQZHSKtgSaDhEqnOmL3hChO+11zwop+bGkEIOSgUD8HOeFtGfPkP
KlGuJJyrgfFfH2eUR6ikbxEQy+aDTYvoOkiGPwuUJSCFR09/ytEE2rZ1Sxj8Hvpq
aAcJCS19dUo=
-----END CERTIFICATE-----
```

</details>

<details><summary>Screenshot 2.3</summary>
<img src="Images/2019-08-24-21-06-18.png">
</details>
<br/>

2.4 At the `cli-vm` prompt, enter the command `sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.key` to create a file to save the Harbor server public key. Expand the `35.209.26.28.key` section below, copy the certificate text and paste it into the nano editor on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

<details><summary>Expand to see `35.209.26.28.key`</summary>

```text
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
```

</details>

<details><summary>Screenshot 2.4</summary>
<img src="Images/2019-08-24-21-08-44.png">
</details>
<br/>

 2.5 From your putty session with `ubuntu@cli-vm` enter the following commands to create the required directory to keep registry certificates in the docker client to enable tls, which is required to use the Notary feature, and to copy the Harbor CA certificate to this directory. 

 ```bash
 sudo mkdir -p ~/.docker/tls/35.209.26.28\:4443/
 sudo cp /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt ~/.docker/tls/35.209.26.28\:4443/
``` 

<details><summary>Screenshot 2.5</summary>
<img src="Images/2019-08-24-21-14-30.png">
</details>
<br/>

 2.6 From your putty session with `ubuntu@cli-vm` enter the following commands to create the required directory to keep registry certificates in the docker client to enable tls, which is required to use the Notary feature, to copy the Harbor CA certificate to this directory, and to update and restart the docker service to apply the certificates.

 ```bash
 sudo mkdir -p ~/.docker/tls/35.209.26.28\:4443/
 sudo cp /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt ~/.docker/tls/35.209.26.28\:4443/
 sudo update-ca-certificates
 sudo service docker restart
``` 

<details><summary>Screenshot 2.6</summary>
<img src="Images/2019-08-24-21-14-30.png">
</details>
<br/>

