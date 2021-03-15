# [Lab 4 - Linux Post-Install](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/a4)

## Generating and using SSH keys

Executing ```ssh-keygen -t rsa -b 4096``` (and any attempt at generating rsa keys for that matter) would hang (```strace``` shows repeated a loop repeatedly calling ```getpid```).

However generating ec25519 keys worked just fine.

### 1. Paste the contents of ~/.ssh/authorized_keys from your student VM.

In my case, I generated the keys inside the Ubuntu server host, and copied the arch VM I installed in Lab 3.

```
$ cat ~/.ssh/authorized_keys 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/Dc4hE/soHfuv75Wg2Sle/4qn+O9SoXJDBX7jQMNgi charly@pandemia
```

### 2. What are the permissions on your public key and private key? Why do you think they are the way they are?

```
$ ls -l ~/.ssh
total 16
-rw------- 1 charly charly 411 Mar 15 14:35 id_ed25519
-rw-r--r-- 1 charly charly  97 Mar 15 14:35 id_ed25519.pub
```

The private key must be accessible only by me, otherwise someone could just copy it and impersonete me to log into the server.

The public key can be readable by others, the whole point is that it can be shared indiscriminately, to encrypt messages that only I can decrypt.

Neither should be writable by others, to prevent corruption.

