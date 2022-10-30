#!/bin/bash -e

# install kvm packages
sudo apt update
sudo apt install -y cpu-checker
kvm-ok
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
sudo systemctl is-active libvirtd
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
echo "================================"
echo "If you need, "
echo "newgrp libvirt"
echo "newgrp kvm"
echo "================================"

# copy your image here
sudo cp ../sonic-build/sonic-buildimage/target/sonic-vs.img.gz /var/lib/libvirt/images/
sudo gunzip -k /var/lib/libvirt/images/sonic-vs.img.gz

## create qemu
# reference xml
# wget https://raw.githubusercontent.com/sonic-net/sonic-buildimage/master/platform/vs/sonic.xml
sudo virsh create sonic.xml

## check qmemu list
sudo virsh list --all

## login
echo "================================"
echo "SONiC login:"
echo "admin/pass"
echo "telnet localhost 7000"
echo "================================"

## terminate VM
# sudo virsh destroy sonic
