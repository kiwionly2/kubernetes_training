#  Lab07A  
* Introducing liveness probes 

# Step 
* You’ll create a new pod that includes an HTTP GET liveness probe and another pod with initial delay.

```sh
 kubectl create -f kubia-liveness-probe.yaml

 kubectl get po kubia-liveness

 kubectl describe po kubia-liveness

 kubectl create -f kubia-liveness-probe-initial-delay.yaml
```

# Lab07B  
# Step 
* Manage ReplicationController

```sh
kubectl create -f kubia-rc.yaml

kubectl get pods

kubectl delete pod kubiarc-xxxx

kubectl get pods

kubectl get rc

kubectl describe rc kubiarc
```

# Lab07C
# Step 
```sh 
kubectl get pods -L app

kubectl label pod kubiarc-xxxx app=foo --overwrite

kubectl get pods -L app

kubectl edit rc kubiarc
*change image to stv707/kubia:latest

kubectl describe pod kubiarc-xxx
```

# Lab07D 
# Step 
* Scaling Replication Controller
```sh 

kubectl scale rc kubiarc --replicas=5

kubectl get pods

kubectl describe pod kubiarc-xxx(new_pod)
* Verify the image is now stv707/kubia:latest

kubectl scale rc kubiarc --replicas=3

kubectl get pods 

kubectl delete rc kubiarc

*verify all kubiarc pods are deleted
*Due to label differences, one kubiarc pod may still be alive, leave it there

```
# Lab07E
# Step 
Manage ReplicaSets

```sh
kubectl create -f  kubia-replicaset.yaml 

kubectl get rs kubiars

kubectl describe rs kubiars

kubectl delete rs kubiars

kubectl create -f kubia-replicaset-matchexpressions.yaml

kubectl delete rs kubia

```
# Lab03D
# Step 
Manage DaemonSets

```sh
kubectl get node
kubectl label node node2 disk=ssd
kubectl create -f ssd-monitor-daemonset.yaml
kubectl get ds
kubectl get po
kubectl label node node2 disk=hdd --overwrite
kubectl get po
```
# Lab03E

# Step 
Manage Jobs Resources 

```sh
kubectl get jobs
kubectl create -f batch-job.yaml
kubectl get po
kubectl logs batch-job-xxxxx
kubectl get job
kubectl create -f multi-completion-batch-job.yaml
kubectl create -f multi-completion-parallel-batch-job.yaml
kubectl get po
kubectl scale job multi-completion-batch-job --replicas 3
```

# Lab03F

# Step 

```sh
kubectl get cronjobs
kubectl create -f  cronjob.yaml
kubectl get po 
kubectl get cronjobs
```
END