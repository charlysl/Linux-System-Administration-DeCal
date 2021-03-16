# [Lab 4 - Linux Post-Install](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/a4)

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
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/Dc4hE/soHfuv75Wg2Sle/4qn+O9SoXJDBX7jQMNgi charly@pandemia
```

#### 2. What are the permissions on your public key and private key? Why do you think they are the way they are?

```
$ ls -l ~/.ssh
total 16
-rw------- 1 charly charly 411 Mar 15 14:35 id_ed25519
-rw-r--r-- 1 charly charly  97 Mar 15 14:35 id_ed25519.pub
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

One of the concerns is that any service endpoint that is allowed by the firewall can be exploited if it turns out that it has a vulnerability, which can eventually lead to the whole network being compromised. But it could also leak information about the system that can be used to narrow down what attacks to try on services that are correctly rightly allowed by the firewall, facilitating the attack.
