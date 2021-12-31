# /bin/bash
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
sudo apt-get update
sudo apt-get install -y ca-certificates apt-transport-https curl gnupg-agent software-properties-common
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubectl=1.20
sudo apt-mark hold kubectl
mkdir -p /home/consul
sudo cp -R /vagrant/.kube /home/consul/.kube