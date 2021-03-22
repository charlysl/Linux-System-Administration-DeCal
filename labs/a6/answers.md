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

It creates the loopback ```lo``` interface for IPv4; if deleted then ```127\24``` addresses wouldn't work as expected.

#### Question 1c: Write a few stanzas that configure an interface called ```test``` that is brought up on boot and given the following address: ```192.168.13.37/16```.

```
auto test
iface test inet static
	address 192.168.13.37/16
```



