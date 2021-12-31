# vagrant-k8s

> Tested on mac(catalina/big sur)

## Need solutions
- Virtualbox : https://www.virtualbox.org
- Vagrant : https://www.vagrantup.com


## Add Virtualbox Network for Vagrant

Menu > Host Network Manager > Create

- IPv4 Address : 192.168.60.1
- IPv4 Network Mask : 255.255.255.0

![image-20210419215511702](https://github.com/Great-Stone/images/raw/master/uPic/Gs36kl.png)

## RUN
```bash
$ vagrant up
```

## Ubuntu check package versions

```bash
#apt-cache policy <packagename>
apt-cache policy kubelet | grep 1.19
     1.19.16-00 500
     1.19.15-00 500
     ...
```

## Check kubeconfig

```bash
$ kubectl --kubeconfig=.kube/config get node
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   68m   v1.19.10
node-1   Ready    <none>   63m   v1.19.10
node-2   Ready    <none>   59m   v1.19.10
node-3   Ready    <none>   54m   v1.19.10
```
