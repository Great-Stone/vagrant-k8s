# vagrant-k8s

> Tested on mac(catalina)



## Need solutions
- Virtualbox : https://www.virtualbox.org
- Vagrant : https://www.vagrantup.com



## Add Virtualbox Network for Vagrant

Menu > Host Network Manager > Create

- IPv4 Address : 172.28.128.1
- IPv4 MNetwork Mask : 255.255.255.0

![image-20210419215511702](https://raw.githubusercontent.com/Great-Stone/images/master/uPic/image-20210419215511702.png)



## RUN
```bash
$ vagrant up
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

