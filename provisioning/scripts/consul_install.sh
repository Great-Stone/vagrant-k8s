# /bin/bash
cd /root/consul

# create pv
for pv in pv01 pv02 pv03
do
    sudo mkdir -p /vagrant/k8s-pv/$pv
done
kubectl apply -f /tmp/pv.yaml

# license
kubectl create secret generic license --from-file=/tmp/consul.hclic --from-file=/tmp/vault.hclic

# helm consul install
kubectl create namespace consul
kubectl create secret generic consul-gossip-encryption-key --from-literal=key=xYgXIlHbF1/6dh0g45AfMh/eP442Ab+fI7wkTcA+Q6w=
helm install consul hashicorp/consul --namespace consul -f /tmp/consul.yaml --debug

