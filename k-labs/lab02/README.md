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
Inter-Pod Networking  

```sh

kubectl get pod -o wide 

** Note the IP address of kubia-pod 
** Open another terminal(Azure Cloud Shell) to perform next step 

kubectl exec -it box1 -- sh 
# curl http://IP_kubia_pod:8080
# exit 

kubectl exec -it box2 -- sh 
# curl http://IP_kubia_pod:8080
# exit 

```

# Step 5
Create multi label for Pod/Deployment and Filter using Label

```sh
kubectl create -f kubia-label.yaml

kubectl get pod

kubectl get 

kubectl get pod -l app=ui,rel=stable

kubectl get pod -l app=pc,rel=stable

kubectl get pod -l app=os,rel=stable

kubectl get pod -l 'app in (ui,os,pc)',rel=stable

kubectl get pod -l 'app in (ui,os,pc)',rel=beta

```

# Step 6
Labels can be attached to any Kubernetes object, including nodes

```sh
kubectl get nodes

kubectl label node <node-name-1> ssd=true

kubectl get nodes --show-labels | grep ssd

kubectl get nodes -l ssd=true

kubectl create -f kubia-ssd.yaml

kubectl get pod kubia-ssd -o wide 

** Verify the pod only runs on node that has label ssd=true

```

# Step 7
Create namespace to split pods to specific namespace 

```sh
kubectl create namespace prod-ns

kubectl create namespace dev-ns

kubectl get namespaces

kubectl describe sa default | grep Namespace

kubectl config set-context --current --namespace=prod-ns

kubectl describe sa default | grep Namespace

kubectl get pods

kubectl create -f kubia-ns.yaml

kubectl get namespaces

kubectl config set-context --current --namespace=default

kubectl get pods 

```


# Step 8
Deploy pods on different namespaces

```sh
kubectl create -f kubia-namespace-full.yaml

kubectl get pod --namespace prod-ns

kubectl get pod --namespace dev-ns

kubectl get pod -A

kubectl get pod  -l rel=beta -A

kubectl get pod  -l rel=stable -A

```

# Step 9
Delete/Remove pods

```sh
kubectl delete pod kubia-ssd 

kubectl delete pod -l rel=beta

kubectl delete ns prod-ns

kubectl config set-context --current --namespace=default

kubectl delete  -f kubia-namespace-full.yaml

kubectl delete  -f kubia-label.yaml

kubectl delete ns dev-ns

kubectl delete ns kubia-app-ns

```

# Step 10 
Remove node label 

```sh 

kubectl get nodes -L ssd

kubectl get nodes --show-labels  | grep ssd

kubectl label node <NODE_NAME> ssd-

kubectl get nodes -L ssd

```

END