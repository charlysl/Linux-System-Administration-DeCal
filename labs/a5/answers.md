# [Lab 5 - Introduction to Networking](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/b5)

## Short Answer Questions

### 1. Does HTTP use TCP or UDP and why? How about Discord and Skype, why?

HTTP uses TCP, because it requires reliable connectivity, otherwise the data displayed on the browser might be corruptied or missing.

Discord and Skype use UDP, just like any other voice or video service, because its worse to delay a stream than it is to miss a few frames.

### 2. Who manufactured the NIC with mac address 52:54:00:d7:ce:cc?

Given that in ```52:54:00``` the b1 byte is 1, it is "locally administered", which means it is very likely an unregistered virtual device.

### 3. How many distinct hosts can 127.0.0.0/8 contain?

2 ** (32 - 8) = 16,777,216

### 4. What types of records do you get when you perform a DNS lookup of facebook.com?

```
nslookup www.facebook.com
Server:		192.168.122.1
Address:	192.168.122.1#53

Non-authoritative answer:
www.facebook.com	canonical name = star-mini.c10r.facebook.com.
Name:	star-mini.c10r.facebook.com
Address: 69.171.250.35
Name:	star-mini.c10r.facebook.com
Address: 2a03:2880:f1ff:83:face:b00c:0:25de
```
These are ```A``` records, (non-DNS server and IP address name-value pairs).

The IP address output by ```dnslookup www.facebook.com``` matches the one output by ```host www.facebook.com```, as expected if the above is true.

```
$ host www.facebook.com
www.facebook.com is an alias for star-mini.c10r.facebook.com.
star-mini.c10r.facebook.com has address 69.171.250.35
star-mini.c10r.facebook.com has IPv6 address 2a03:2880:f1ff:83:face:b00c:0:25de
```
