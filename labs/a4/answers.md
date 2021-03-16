## Generating and using SSH keys

### Ubuntu server 18.04 server, Laptop client

#### 1. Paste the contents of ~/.ssh/authorized_keys from your student VM.

```
cat ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjTiHnaNnns7/5+kdbWMZNUjWDfrd2cGxO355DUItkjcK9d2iJ0hFJFuGgg2s3y+iTXuoRZWhA8CzDRc4b0wGz+XpginBOqT+KB4vmyzbQgwfoebcbNexWryL/skTcQrsmvGY4nm6q/jFS61PtL8DyaW0cZ69Z0W+RAldN4eZ2Z975qiup4Rwer+LwTKA12HRTAlx7F6YvDFNz/lcO2rAIQYb6fvMK5wZOuiu6zhIQzT5pBDTYwVKHn6mQBiLSjbQxXx1O/Pmq+15EyQ7Z6gK9GN3+u3M3EN0RJ35v2CXGGCN5T1iEakP0mpQXicg0mLEIMJHRHtUF/uo5DZNTBnugAD66sP5+Ppmyd3lc+5VOR065Q1uV6oAbJwP+bijCc4+nPeADyMBRpiLnouvON3vqK8doK3VPZSROZZ2cPKNOXfN/m8ZW7kO3WpygcoFbtd+dv8lhooPWHmXDdlYEyGRrGHR4SKx07OjjJgcndNjgfyzhv3JGzoqOGwZW/gAb2dZ3ZdCwmG8prvdsUTxbxNnVRMOjV1RuDgNKivHq/r00qNb7ytWIWL0rvdR1TwALWNHQ2KIXA5/cJlrJeypcS/iUYM5EqnFjPczcJMSexmT56OrudycuJw/CHzkB7nVwkISLgId5TDYNvJ+cN0h6Bn+9tW66QKzjaZN6hFIYes/icQ== me@mylaptop
```

#### 2. What are the permissions on your public key and private key? Why do you think they are the way they are?

See below

### Attemps from archvm hosted in Ubuntu server

Executing ```ssh-keygen -t rsa -b 4096``` (and any attempt at generating rsa keys for that matter) would hang (```strace``` shows repeated a loop repeatedly calling ```getpid```).

However generating ec25519 keys worked just fine.

Tried replacing the openssh package with an older one from https://archive.archlinux.org/packages/o/openssh/, but had the same problem again.

#### 1. Paste the contents of ~/.ssh/authorized_keys from your student VM.

In my case, I generated the keys inside the Ubuntu server host, and copied the arch VM I installed in Lab 3.

```
$ cat ~/.ssh/authorized_keys 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/Dc4hE/soHfuv75Wg2Sle/4qn+O9SoXJDBX7jQMNgi me@myhost
```

#### 2. What are the permissions on your public key and private key? Why do you think they are the way they are?

```
$ ls -l ~/.ssh
total 16
-rw------- 1 me me 411 Mar 15 14:35 id_ed25519
-rw-r--r-- 1 me me  97 Mar 15 14:35 id_ed25519.pub
```

The private key must be accessible only by me, otherwise someone could just copy it and impersonete me to log into the server.

The public key can be readable by others, the whole point is that it can be shared indiscriminately, to encrypt messages that only I can decrypt.

Neither should be writable by others, to prevent corruption.

## Setting up a firewall

#### 1. What command did you use to enable a port?
```
$ sudo ufw default deny
Default incoming policy changed to 'deny'

$ sudo ufw allow ssh
Rules updated
Rules updated (v6)
```

#### 2. Paste the output of sudo ufw status verbose. Make sure you can clearly see the changes you made in the steps above!
```
$ sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                  
22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

#### 3. Why is setting up a firewall important? What are some security concerns that might arise from exposing a port?

For security reasons, to reduce the attack surface as much as possible, only those services that need to be accesed by external systems should be exposed by the firewall.

This is why the default policy is to deny all connections.

One of the concerns is that any service endpoint that is allowed by the firewall can be exploited if it turns out that it has a vulnerability, which can eventually lead to the whole network being compromised. But it could also leak information about the system that can be used to narrow down what attacks to try on services that are rightly allowed by the firewall, facilitating the attack.

## Choose your won adventure

#### 1. What did you install on your VM?

Gitea

#### 2. Attach a screenshot of your service in action. (This could be a web console or a command output in the shell.)

![Gitea Screenshow](./gitea.png)

#### 3. Briefly describe the installation process. Were there any unexpected roadblocks you encountered?

First I tried to install CherryMusic, but ran into a 404 error when trying to install its python module. Moved on to a different app.

Gitea installation was very smooth, maybe because it is distributed as just one binary, and the manual configuration instructions went smoothly.

#### 4. 

##### a) What are some security implications from hosting this service? 

Just by hosting any service in the public internet you have already become a target. Your server will probably get listed by services like Shodan, and botnets will try to press it into their service, to be used towards nefarious ends, such as DoS attacks, hosting the unspeakable, proxying, etc.

This is a service that is quite niche, so it is unlikely to have attracted much attention from both researchers (and attackers). For this reason I would be very reluctant to use for anything serios, and go with a more mainstream alternative.

There is a number of [known vulnerabilities](https://www.cvedetails.com/vulnerability-list.php?vendor_id=19185&product_id=49829&version_id=0&page=1&hasexp=0&opdos=0&opec=0&opov=0&opcsrf=0&opgpriv=0&opsqli=0&opxss=0&opdirt=0&opmemc=0&ophttprs=0&opbyp=0&opfileinc=0&opginf=0&cvssscoremin=0&cvssscoremax=0&year=0&month=0&cweid=0&order=1&trc=1&sha=3a73efafeb155c1c85dcbed0e96ba39730cb04cf)

What is worrying is that none of them has been updated since 2019, and it isn't clear to me which are applicable to the current version (1.13).

##### b) How have you handled them (or are you not handling them?)

I have configured and enabled ufw to allow only ssh (port 22) and gitea (port 3000), and rebooted to ensure that the rules are being enforced.

```
$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
3000/tcp                   ALLOW       Anywhere                  
22/tcp (v6)                ALLOW       Anywhere (v6)             
3000/tcp (v6)              ALLOW       Anywhere (v6) 
```

I am running Gitea as root, which is a concern, and will review this in the coming labs.

I have also confirmed that my Ubuntu version is still maintained (EOL Apr 2023) and patched up-to-date.

```
apt update
apt list --upgradable
apt upgrade
```

