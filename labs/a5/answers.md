# [Advanced Lab 5 - Processes and Services](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/a5)

## Using systemd

### What services are running right now?

#### Question 1: What is the name of a systemd service running on your system? What does it do?

```
$ systemctl --type=service
...
ssh.service                          loaded active running OpenBSD Secure Shell server  
...
```

### Controlling Services

#### Question 2: What is the difference between systemctl reload yourservice and systemctl restart yourservice?

Reload doesn't need to stop the service at all.

### Creating a service


