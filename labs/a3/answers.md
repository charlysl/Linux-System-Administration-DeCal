# [Advanced Lab 3 - Pre-install Setup and Installation](https://decal.ocf.berkeley.edu/archives/2020-fall/labs/a3)

## Setup

### Acquire installation media

#### Who is the developer that created this signature, and what is their key’s fingerprint?

Installation media signed by:
```
Pierre Schmitz <pierre@archlinux.de>   Primary key fingerprint: 4AA4 767B BC9C 4B1D 18AE  28B7 7F2D 434B 9741 E8AC
```

### Create VM

Installing arch in my desktop using VMWare and Ubuntu 18.04 desktop failed early (no network called default)
Installing in Digital Ocean in a Ubuntu 18.04 server droplet failed as well (boots into the UEFI Shell, no way out)
But installing it my laptop using VMWare and Ubunti 18.04 server, updated and upgraded, did get as far as login!

#### Use the hostname command to get the current hostname. What is it?

Hostname: archiso

#### Then, use ip addr to find the current IP address (look at the inet line under ens2, it’s the stuff at the beginning of the line, not including the /24). What is your IP address?

```
inet 192.168.122.90
```

#### In another terminal, try to ping this IP address from your student VM, and then also from tsunami (ssh.ocf.berkeley.edu). Can either of them reach it?

##### From Ubuntu VM:

```
ping 192.168.122.90
PING 192.168.122.90 (192.168.122.90): 56 data bytes
Request timeout for icmp_seq 0
Request timeout for icmp_seq 1
Request timeout for icmp_seq 2
Request timeout for icmp_seq 3
Request timeout for icmp_seq 4
Request timeout for icmp_seq 5
Request timeout for icmp_seq 6
Request timeout for icmp_seq 7
Request timeout for icmp_seq 8
Request timeout for icmp_seq 9
Request timeout for icmp_seq 10
Request timeout for icmp_seq 11
--- 192.168.122.90 ping statistics ---
13 packets transmitted, 0 packets received, 100.0% packet loss
```

##### From laptop:
```
ping 192.168.122.90
PING 192.168.122.90 (192.168.122.90): 56 data bytes
Request timeout for icmp_seq 0
Request timeout for icmp_seq 1
Request timeout for icmp_seq 2
Request timeout for icmp_seq 3
Request timeout for icmp_seq 4
Request timeout for icmp_seq 5
Request timeout for icmp_seq 6
Request timeout for icmp_seq 7
Request timeout for icmp_seq 8
Request timeout for icmp_seq 9
Request timeout for icmp_seq 10
Request timeout for icmp_seq 11

--- 192.168.122.90 ping statistics ---
13 packets transmitted, 0 packets received, 100.0% packet loss
```

## Partitioning time

#### The purpose of having:

##### (1) the EFI system partition 

It is recommended that for compability this boot partition fs should be FAT32 (to support dual booting with Windows); however, the recommended fs for modern Linux is ext4, so the boot fs and the root fs should be installed on different partitions.

##### (2) the swap partition

Swap permanent storage doesn't use a filesystem at all; one option is to store assign it its own partition; another is to just use a regular file in a regular partition, like the root partition.


### Create partitions

#### What would be the name of the device file corresponding to the fourth partition on the second discovered storage device?

sdb4

#### To see your final results, run fdisk -l /dev/sda
```
root@archiso ~ # fdisk -l /dev/sda
Disk /dev/sda: 5 GiB, 5368709120 bytes, 10485760 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 990E07C6-2D50-884D-9922-8F66841E037E

Device       Start      End Sectors  Size Type
/dev/sda1     2048  1050623 1048576  512M EFI System
/dev/sda2  1050624  9437183 8386560    4G Linux filesystem
/dev/sda3  9437184 10485726 1048543  512M Linux swap
```

### Create filesystems 

#### Root Partition. Run lsblk to see the hierarchy of these partitions. 
```
NAME          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
loop0           7:0    0 602.6M  1 loop  /run/archiso/sfs/airootfs
sda             8:0    0     5G  0 disk  
├─sda1          8:1    0   512M  0 part  
├─sda2          8:2    0     4G  0 part  
│ └─cryptroot 253:0    0     4G  0 crypt 
└─sda3          8:3    0   512M  0 part  
sr0            11:0    1 734.3M  0 rom   /run/archiso/bootmnt
```

#### Creating the actual filesystem. What previous command we ran is similar to this command (mkfs.ext4), and what’s the difference? (Bonus: why?)

mkfs.fat, which created a FAT32 fs, as opposed to ext4

### Mount the new filesystems

#### You can see every single filesystem that’s currently mounted by running the mount command.
```
/dev/mapper/cryptroot on /mnt type ext4 (rw,relatime)
/dev/sda1 on /mnt/boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro)
```

#### Hypothetically, if we had made a separate /home partition and filesystem in the previous steps, what command(s) would we need to run to mount it? Assume the /home partition is /dev/sda3

mount /dev/sda3 /home

## Installation

Takes a bit over 15m

#### To show off your newly installed Arch system, run the following commands

```
[root@pandemia ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 52:54:00:11:ce:bb brd ff:ff:ff:ff:ff:ff
    altname enp0s2

[root@pandemia ~]# mount
...
/dev/sda1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro)
...
/dev/mapper/cryptroot on / type ext4 (rw,relatime) (rw,nosuid,nodev,noexec,relatime)


[root@pandemia ~]# lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda             8:0    0    5G  0 disk  
├─sda1          8:1    0  512M  0 part  /boot
├─sda2          8:2    0    4G  0 part  
│ └─cryptroot 254:0    0    4G  0 crypt /
└─sda3          8:3    0  512M  0 part  [SWAP]
sr0            11:0    1 1024M  0 rom   


[root@pandemia ~]# uname -a
Linux pandemia 5.11.5-arch1-1 #1 SMP PREEMPT Tue, 09 Mar 2021 18:56:28 +0000 x86_64 GNU/Linux
```
