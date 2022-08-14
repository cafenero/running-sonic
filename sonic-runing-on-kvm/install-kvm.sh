#!/bin/bash -xe

# install kvm packages
sudo apt update
sudo apt install -y cpu-checker
kvm-ok
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
sudo systemctl is-active libvirtd
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
newgrp libvirt
newgrp kvm


# copy your image here
cp ../sonic-build/sonic-buildimage/target/sonic-vs.img.gz .
gunzip -k sonic-vs-no-pass.img.gz

# reference xml
# wget https://raw.githubusercontent.com/sonic-net/sonic-buildimage/master/platform/vs/sonic.xml

## create qemu
sudo virsh create sonic.xml

## check qmemu list
sudo virsh list --all

## login
telnet localhost 7000
