#!/bin/bash

# Write a shell script mac.sh which processes the output of ip command and displays the MAC address of the network interface eth0 of your VM.
# - First figure out how to use ip command to get an output which contains the information we want
# - Then use head and tail command and pipes to tailor ip’s output to one line
# - Use cut command (Examples) to get the MAC address. Since we know that the MAC address has fixed length, feel free to count the indices.
# - The final shell script only has to have one line, although a answer with multiple lines are also acceptable.

ip address | head -8 | tail -1 | cut -d ' ' -f 6

