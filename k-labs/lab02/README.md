#  Lab02 - Pods 

# Step 1 
Create and Verify Single Container Pod 

```sh
 kubectl create -f kubia-pod.yaml
 
 kubectl get po kubia-pod -o yaml
 
 kubectl get po kubia-pod -o json
 
 kubectl get pods

 kubectl get pods -o wide

 kubectl create -f box1.yaml

 kubectl create -f box2.yaml

 kubectl get pods -o wide
```

# Step 2 
Create and Verify Multi Container Pod ( init container )

```sh
kubectl create -f kubia-pod-init-multi.yaml

kubectl get pod kubia-pod-init -w
**As per kubia-pod-init-multi.yaml manifest, init container runs sleep command for 90 second, after 90 Second, the main container will start
```

# Step 3 
Create and Verify Multi Container Pod ( sidecar container )

```sh
kubectl create -f kubia-pod-sidecar-multi.yaml

kubectl get pod
** Note from output there is 2/2 in READY state for sidecar-container-demo

kubectl get pod -o wide
** NOTE the IP address of sidecar-container-demo 

kubectl exec -it box1 -- sh 
# curl IP_sidecar-container-demo 
# exit 

kubectl delete -f kubia-pod-sidecar-multi.yaml
```

# Step 4 
Labels can also be added to and modified on existing pods. 
```sh
kubectl label po kubia-manual creation_method=manual
kubectl label po kubia-manual-v2 env=debug --overwrite
kubectl get po -L creation_method,env
kubectl get po -l creation_method=manual
kubectl get po -l env
kubectl get po -l '!env'
```

# Step 5
Labels can be attached to any Kubernetes object, including nodes
```sh
kubectl label node node1.example.local gpu=true
kubectl get nodes -l gpu=true

```

# Step 6

To ask the scheduler to only choose among the nodes that provide a GPU, you’ll
add a node selector to the pod’s YAML
```sh
kubectl create -f kubia-gpu.yaml
```

# Step 7
list all namespaces in your cluster:
```sh
kubectl get ns
kubectl get po --namespace kube-system
```

# Step 8 
A namespace is a Kubernetes resource like any other, so you can create it by posting a
YAML file to the Kubernetes API server

```sh
 kubectl create -f custom-namespace.yaml
```
or
```sh
kubectl create namespace custom-namespace
kubectl create -f kubia-manual.yaml -n custom-namespace
```

# Step 9 
You’re going to stop all of of the pods now, because you don’t need them anymore
```sh
kubectl delete po kubia-gpu
kubectl delete po -l creation_method=manual
kubectl delete ns custom-namespace
kubectl delete po --all
```

# Step 10 

Delete everthing ....opss 

```sh
kubectl delete all --all
kubectl get pods --all-namespaces
```

END