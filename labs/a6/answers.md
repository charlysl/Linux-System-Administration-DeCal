# (Lab 6 - Networking 102)[https://decal.ocf.berkeley.edu/archives/2020-fall/labs/a6]

## Network Interfaces

#### Question 1a: Is the result of running ping enough to determine whether or not you can reach a server? Why or why not?

No, because the destination host's firewell might have been configured to ignore connection requests from you.

#### Question 1b: Here’s a quick check for your understanding – below is a very common default configuration for /etc/network/interfaces

```
auto lo
iface lo inet loopback
```

#### In your own words, explain what this configuration does. What would happen if you deleted these lines and rebooted?

It creates the loopback ```lo``` interface for IPv4; if deleted then ```127.0.0.0/8``` addresses wouldn't work as expected.

#### Question 1c: Write a few stanzas that configure an interface called ```test``` that is brought up on boot and given the following address: ```192.168.13.37/16```.

```
auto test
iface test inet static
	address 192.168.13.37/16
```

#### Question 2a: Describe the ```tcp_syncookies``` ```sysctl``` option. How can we toggle this value on, and when would we want this on?

See ```man 7 tcp```

It is accessible at ```/proc/sys/net/ipv4/tcp_syncookies```, and is a boolean. It is used to deal with *SYN flooding* DoS attacks (which can cause the SYN backlog to overflow), to issue syncookies. Should be used as a last resort, if at all.

It can be toogled on by ```sysctl net/ipv4/tcp_syncookies=1```



