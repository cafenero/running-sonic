# SONiC running on KVM

read: https://github.com/ebiken/nsdevnotes/blob/main/sonic/running-sonic-kvm.md


## install qemu/kvm related packages

```
./install-kvm.sh
```


## get self-build SONiC image
```
cp ../sonic-build/sonic-buildimage-success-202205-vs-kvm/target/sonic-vs.img.gz .
gunzip -k sonic-vs.img.gz
```


## get pre-build SONiC image if you need
see URLs
- https://sonic-build.azurewebsites.net/ui/sonic/pipelines/142/builds/133812/artifacts/252963?branchName=202205&artifactName=sonic-buildimage.vs
- https://sonic-build.azurewebsites.net/ui/sonic/pipelines/142/builds/133812/artifacts?branchName=202205
- https://sonic-build.azurewebsites.net/ui/sonic/pipelines/142/builds?branchName=202205
- https://sonic-build.azurewebsites.net/ui/sonic/pipelines
```
wget https://sonic-build.azurewebsites.net/api/sonic/artifacts?branchName=202205&platform=vs&target=target%2Fsonic-vs.img.gz
gunzip -k sonic-vs.img.gz
```


## run SONiC VM
```
sudo virsh create sonic.xml
sudo virsh list all
sudo virsh destroy sonic
```

## login to the VM
user/password -> admin/pass
```
telnet localhost 7000
admin@sonic:~$ ip -br a show dev eth0
eth0             UP             192.168.122.***/24 fe80::ecee:eeff:fe00:1/64
```

you can also ssh to the VM
```
ssh admin@192.168.122.***
```

## run demo 01
use script: https://github.com/ebiken/nsdevnotes/blob/main/sonic/examples/nssetup-demo01-bridge.sh
```
./nssetup-demo01-bridge.sh -c
sudo virsh create sonic-demo1-bridge.xml
```

## run demo 02
use scritp: https://github.com/ebiken/nsdevnotes/blob/main/sonic/examples/nssetup-demo02-network.sh
```
./nssetup-demo02-network.sh -c
sudo virsh create sonic-demo2-network.xml
```

## validate demos
ping checker
```
./check-demo01.sh
```
