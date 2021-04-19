# /bin/bash
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
sudo apt-get update
sleep 1

sudo apt-get install -y ca-certificates apt-transport-https curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sleep 1

sudo apt-get install -y docker-ce=5:19.03.15~3-0~ubuntu-bionic docker-ce-cli=5:19.03.15~3-0~ubuntu-bionic containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sleep 1

sudo apt-get install -y kubelet=1.19.10-00 kubeadm=1.19.10-00 kubectl=1.19.10-00
sudo apt-mark hold kubelet kubeadm kubectl