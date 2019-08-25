# Under Development, Please Check back Soon
HOL Pod Prep for PKS Ninja Labs

Many PKS Ninja Lab Guides that have been validated for the HOL-2031 lab environment require a common set of preparatory steps. Please follow the steps below to prepare your lab environment to enable successful completion of any guides that reference or link to this document. 

## 1.0 Prepare `cli-vm` to use the required HTTP/s Proxy

The HOL lab environment only permits limited internet access sufficient to complete exercises in any lab guides that have been prepared for HOL-2031 compatibility. Any host in the lab environment that needs to access the limited internet resources must use the lab proxy server. The following steps will show how to prepare the `cli-vm` ubuntu host to use the labs internet proxy. 

1.1 From the Main Console (ControlCenter) desktop, open putty and under saved sessions, open a ssh connection to `ubuntu@cli-vm`

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-08-24-00-52-43.png">
</details>
<br/>

1.2 From the `cli-vm` prompt, enter the commans `sudo nano ~/.bashrc` and enter the sudo password `VMware1!` to use the nano text editor to edit the .bashrc file for the root user on cli-vm. The .bashrc file is a special file that loads commands and environmental variables into the bash shell each time you open a new shell session (including ssh sessions) with `cli-vm`. 

While it is possible to export the required environmental variables directly from the `cli-vm` prompt, exporting directly from the bash prompt only loads the environmental variables in the currently running session, so if you were to close your ssh session to `cli-vm`, or if the ssh session were to timeout, the environmental variables would no longer be populated the next time you connected to `cli-vm`. 

By placing the required environmental variables in the .bashrc file, it will ensure that the proxy configuration is still present each time you connect to `cli-vm` during your active session with a HOL-2031 pod. If at any point you end your HOL-2031 session or your lease times out and you need to re-enroll to launch a new HOL-2031 session, you will need to repeat these steps. (If your HOL-2031 session has a temporary timeout and allows you to "Resume your lab", you do not need to repeat these steps)

<details><summary>Screenshot 1.1</summary>
<img src="Images/2019-08-24-02-20-31.png">
</details>
<br/>

1.3 In the nano editor, scroll to the very bottom of the .bashrc file, and enter the following lines at the very end of the file. After you have entered the following lines, enter the key combination `ctrl o` then hit the `enter` key to save the file, and then enter the key combination `ctrl x`to close the file.

```bash

```

<details><summary>Screenshot 1.3</summary>
<img src="Images/2018-12-14-02-09-13.png">
</details>
<br/>

1.4 Create and checkout a new branch to make your updates on. It is a common practice on github to create a temporary branch to submit your update, and then later after your update is accepted, you can delete the update branch as it will be no longer needed and it helps ensure a clean process if you make a new temporary update branch each time you plan to make updates and do a pull request.

In this example you can use `update-1` as the branch name, the name you use doesnt matter but if in the future you create an update branch and find it already exists, it may mean you forgot to delete it after a previous update so be sure to create a new branch and if needed delete any existing temporary branches that may be leftover from previous updates.

Enter the followwing commands to create and checkout a new `update-1` branch

```bash
git branch
git checkout -b update-1
git branch
```

<details><summary>Screenshot 1.4</summary>
<img src="Images/2019-02-09-15-44-24.png">
</details>
<br/>

1.5 From the `cli-vm` prompt, enter the following commands to create a new folder with your github username under the students directory and initialize a readme file in that folder.

When you create a new folder in a git repository, the folder will not be added to the repository until you have a file in it. The `echo` command included below passes the text in quotations and if not present create a file named readme.md in your directory. You can replace the text "my snarky comment" with any string you would like.

**Make sure you replace the string "yourGithubUsername" in the commands below with your unique github username**

```bash
ls
mkdir yourGithubUsername # Replace every instance of "yourGithubUsername" with your unique github.com ausername
echo "my snarky comment" > yourGithubUsername/readme.md
cat yourGithubUsername/readme.md
cd yourGithubUsername/
ls
```

<details><summary>Screenshot 1.5</summary>
<img src="Images/2019-02-09-17-20-46.png">
</details>
<br/>

1.6 From the `cli-vm` prompt ensure you are in the `~/Forked/Students` directory and connect your forked clone back to the source PKS-Ninja repository, then validate the upstream configuration is correct.  If your shell prompt does not show current directory, use command `pwd` to show your current working directory.

```bash
pwd
git remote add upstream https://github.com/CNA-Tech/Students.git
git remote -v
```

<details><summary>Screenshot 1.6</summary>
<img src="Images/2018-12-14-02-51-58.png">
</details>
<br/>

1.7 From the `cli-vm` prompt ensure you are in the `~/Forked/Students` directory and of you have not already, ensure your standard git defaults are set with the following commands, being sure to use your github username and the email associated with your github account.  If your shell prompt does not show current directory, use command `pwd` to show your current working directory.

```bash
pwd
git config --global user.name "Your Name"
git config --global user.email you@example.com
git config --global push.default simple
```

<details><summary>Screenshot 1.7</summary>
<img src="Images/2019-02-09-18-09-06.png">
</details>
<br/>

### Step 2: Setup http proxy on docker client

2.1 From the ControlCenter desktop, open chrome, connect to the vSPhere web client and login using the windows system credentials checkbox. Navigate to the `Hosts and Clusters` page, expand `RegionA01`, right click on cluster `RegionA01-MGMT01` and select `Deploy OVF Template`

<details><summary>Screenshot 2.1</summary>
<img src="Images/2019-08-23-23-53-53.png">
</details>
<br/>

2.2  Select the EPMC OVF File from the location where you downloaded it and click `Next`. The default download location is `E:\Downloads`.

<details><summary>Screenshot 2.2</summary>
<img src="Images/2019-08-24-00-07-33.png">
</details>
<br/>

2.3 On the `Select Name and Folder` page, set the `Virtual Machine Name` to `epmc-01a` and click `Next`

<details><summary>Screenshot 2.3</summary>
<img src="Images/2019-08-24-00-10-05.png">
</details>
<br/>

2.4 On the `Select a compute resource` page, expand `RegionA01-MGMT01` and select the `pks-mgmt-1` resource pool and click `Next`.


<details><summary>Screenshot 2.4</summary>
<img src="Images/2019-08-24-00-43-31.png">
</details>
<br/>

2.5 On the `Review Details` page, verify the details and click `Next`.

<details><summary>Screenshot 2.5</summary>
<img src="Images/2019-08-24-00-13-13.png">
</details>
<br/>

2.6 On the `License Agreements` page, check the `I accept all license agreements` checkbox and click `Next`.

<details><summary>Screenshot 2.6</summary>
<img src="Images/2019-08-24-00-15-05.png">
</details>
<br/>


2.7 On the `Select Storage` page, **First** select the `RegionA01-ISCSI02-COMP01` datastore, and then set the `virtual disk format` to `Thin Provision` and click `Next`.

<details><summary>Screenshot 2.7</summary>
<img src="Images/2019-08-24-00-17-25.png">
</details>
<br/>

### Step 3: Prepare CLI-VM with the public harbor servers certificate so it can establish secure connectivity to the registry

 3.1 From the Control Center desktop, open a putty session with `ubuntu@cli-vm` and from the prompt, enter the following commands to create the required directory to keep registry certificates in the docker client, and to use the nano text editor to create a file for the PKS Ninja Labs Public Harbor server CA certificate:

 ```bash
 sudo mkdir -p /etc/docker/certs.d/35.209.26.28/
 sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt
``` 

<details><summary>Screenshot 3.1</summary>
<img src="Images/2019-08-24-20-53-46.png">
</details>
<br/>

3.2 Expand the `35.209.26.28.crt` section below, copy and paste the text into the nano editor you have open on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

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

<details><summary>Screenshot 3.2</summary>
<img src="Images/2019-08-24-21-04-46.png">
</details>
<br/>

3.3 At the `cli-vm` prompt, enter the command `sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.cert` to create a file to save the Harbor server certificate. Expand the `35.209.26.28.cert` section below, copy the certificate text and paste it into the nano editor on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

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

<details><summary>Screenshot 3.3</summary>
<img src="Images/2019-08-24-21-06-18.png">
</details>
<br/>

3.4 At the `cli-vm` prompt, enter the command `sudo nano /etc/docker/certs.d/35.209.26.28/35.209.26.28.key` to create a file to save the Harbor server public key. Expand the `35.209.26.28.key` section below, copy the certificate text and paste it into the nano editor on `cli-vm` and then press `ctrl o` and `enter` to save the file and `ctrl x` to close the file.

<details><summary>Expand to see `35.209.26.28.key`</summary>

```text
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
```

</details>

<details><summary>Screenshot 3.4</summary>
<img src="Images/2019-08-24-21-08-44.png">
</details>
<br/>

 3.5 From your putty session with `ubuntu@cli-vm` enter the following commands to create the required directory to keep registry certificates in the docker client to enable tls, which is required to use the Notary feature, and to copy the Harbor CA certificate to this directory. 

 ```bash
 sudo mkdir -p ~/.docker/tls/35.209.26.28\:4443/
 sudo cp /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt ~/.docker/tls/35.209.26.28\:4443/
``` 

<details><summary>Screenshot 3.5</summary>
<img src="Images/2019-08-24-21-14-30.png">
</details>
<br/>

 3.6 From your putty session with `ubuntu@cli-vm` enter the following commands to create the required directory to keep registry certificates in the docker client to enable tls, which is required to use the Notary feature, to copy the Harbor CA certificate to this directory, and to update and restart the docker service to apply the certificates.

 ```bash
 sudo mkdir -p ~/.docker/tls/35.209.26.28\:4443/
 sudo cp /etc/docker/certs.d/35.209.26.28/35.209.26.28.crt ~/.docker/tls/35.209.26.28\:4443/
 sudo update-ca-certificates
 sudo service docker restart
``` 

<details><summary>Screenshot 3.6</summary>
<img src="Images/2019-08-24-21-14-30.png">
</details>
<br/>
