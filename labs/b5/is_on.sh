#!/bin/bash

#Write a shell script is_on.sh so that is_on.sh host shows whether host is online. If it is, show “OK”. If it’s not, show “Host is not reachable”. Don’t show anything else. Some clarifications:
# - A host is online here means the ping to the host is successful
# - Just ping the server once (we assume the internet connection is reliable and the packet will not be dropped)
# - You can use man ping to see how to make the ping only ping the server once, and what the return value of ping command means. Use if to decide what to print.

ping -c 1 $1 >/dev/null 2>&1

if [ $? -eq 0 ]; then
	echo OK
else
	echo Host is not reachable
fi

