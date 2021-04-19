# /bin/bash
OUTPUT_FILE=/vagrant/join.sh
rm -rf /vagrant/join.sh
rm -rf /vagrant/.kube
sudo kubeadm init --apiserver-advertise-address=172.28.128.100 --pod-network-cidr=10.244.0.0/16
sudo kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x $OUTPUT_FILE
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
cp -R $HOME/.kube /vagrant/.kube
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl completion bash >/etc/bash_completion.d/kubect
echo 'alias k=kubectl' >>~/.bashrc