# vagrant-k8s

> Tested on mac(catalina/big sur)

## Pre-installed solutions
- Virtualbox : https://www.virtualbox.org
- Vagrant : https://www.vagrantup.com


## Add Virtualbox Network for Vagrant

Menu > Host Network Manager > Create

- IPv4 Address : 192.168.60.1
- IPv4 Network Mask : 255.255.255.0

![image-20210419215511702](https://github.com/Great-Stone/images/raw/master/uPic/Gs36kl.png)

## vagrantfile variables

```hcl
IMAGE_NAME = "bento/ubuntu-20.04"

K8S_MINOR_VERSION = "21"
NETWORK_SUB = "192.168.60."
START_IP = 130
POD_CIDR = "10.#{K8S_MINOR_VERSION}.0.0/16"

cluster = {
  "master" => { :cpus => 2, :mem => 2048 },
  "node" => { :cpus => 1, :mem => 1024 }
}

NODE_COUNT = 1

VM_GROUP_NAME = "k8s-1.#{K8S_MINOR_VERSION}"
DOCKER_VER = "5:20.10.12~3-0~ubuntu-focal"
KUBE_VER = "1.#{K8S_MINOR_VERSION}.8-00"

Vagrant.configure("2") do |config|
  config.vm.box = IMAGE_NAME
  ...
```

|Variable name|value|
|-|-|
|IMAGE_NAME|base image name from vagrant cloud|
|K8S_MINOR_VERSION|kubernetes minor version number|
|NETWORK_SUB|Virtual box network ip|
|START_IP|divided each k8s cluster by start ip number|
|POD_CIDR|using in kubeadm init; --pod-network-cidr|
|cluster={}|cluster resource define|
|NODE_COUNT|worker node count|
|VM_GROUP_NAME|Virtual box vm group name|
|DOCKER_VER|docker version define|
|KUBE_VER|kube* package version|


## RUN example
```bash
~/vagrant-k8s/1.23> vagrant up
```

## Check kubeconfig

```bash
~/vagrant-k8s/1.23> kubectl --kubeconfig=./.kube/config get nodes
NAME     STATUS   ROLES                  AGE   VERSION
master   Ready    control-plane,master   68m   v1.23.1
node-1   Ready    <none>                 63m   v1.23.1
node-2   Ready    <none>                 59m   v1.23.1
node-3   Ready    <none>                 54m   v1.23.1
```

## Ubuntu check package versions

```bash
#apt-cache policy <packagename>
apt-cache policy kubelet | grep 1.2
  Candidate: 1.23.1-00
     1.23.1-00 500
     1.23.0-00 500
     1.22.5-00 500
     1.22.4-00 500
     1.22.3-00 500
     1.22.2-00 500
     1.22.1-00 500
     1.22.0-00 500
     1.21.8-00 500
     1.21.7-00 500
     ...
```
