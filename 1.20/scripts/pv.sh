# create pv
for pv in pv01 pv02 pv03
do
    sudo mkdir -p /vagrant/k8s-pv/$pv
done
kubectl apply -f /tmp/pv.yaml