# https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

kubectl create deployment hostnames --image=k8s.gcr.io/serve_hostname
# kubectl scale deployment hostnames --replicas=3


kubectl get pods -l app=hostnames

kubectl expose deployment hostnames --port=80 --target-port=9376
