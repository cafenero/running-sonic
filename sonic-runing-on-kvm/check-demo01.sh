#!/bin/bash -x

sudo ip netns exec ns1 bash -c "ping -c 5 192.168.1.102" &
sudo ip netns exec ns2 bash -c "tcpdump -l -nnn -i veth2"
