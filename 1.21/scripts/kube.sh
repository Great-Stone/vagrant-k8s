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

sudo apt-get install -y docker-ce=$docker_ver docker-ce-cli=$docker_ver containerd.io
sudo systemctl enable docker
sudo systemctl start docker

# First Permission
sudo mkdir /etc/docker
# sudo chown $USER:docker /etc/docker

# Setup daemon.
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d

sudo systemctl daemon-reload
sudo systemctl restart docker
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

sudo apt-get install -y kubelet=$k8s_ver kubeadm=$k8s_ver kubectl=$k8s_ver
sudo apt-mark hold kubelet kubeadm kubectl