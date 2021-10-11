#  Explore Kubernetes Cluster 


Explore and Verify Kubernetes ( AKS )
# Step 1 

Access Azure Cloud Shell and Connect to AKS

- Initiate Azure Cloud Shell ( you may be asked to create storage account when you run Azure Cloud Shell for First time, accept the default)

- Select Bash if prompted 

![picture 1](../../images/1ccba30eda4a59d6473e7ccd94e63f0901c6aed775e74445fcc3910aa23f7955.png)  


```sh
User@Azure#> az account set --subscription $(az account list | grep id | awk '{print $2}'  | sed 's/"//g' | sed 's/,//g')

User@Azure#> az aks get-credentials --resource-group aks_rg --name aks_lab

User@Azure#> kubectl get nodes 

User@Azure#> kubectl get nodes -o wide

User@Azure#> kubectl describe node <node_name>

```

# Step 2 

Open a SSH connection to worker node
 - replace node_name with your first worker node name 
```sh
User@Azure#> kubectl get nodes 

User@Azure#> kubectl debug node/<node_name> -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11

root@aks-agentpool-25073747-0:/# chroot /host

# crictl ps

# crictl images ls 

# systemctl status kubelet

# systemctl status containerd

# crictl ps | grep kube-proxy

# cat /etc/*rel*

# uname -a

# lscpu 

# free -h 

# exit

root@aks-agentpool-25073747-0:/# exit

User@Azure#> kubectl get pods --field-selector status.phase!=Running 
NAME                                           READY   STATUS      RESTARTS   AGE
node-debugger-XXX                              0/1     Completed   0          13m

User@Azure#> kubectl pod delete node-debugger-XXX


```

# Step 3 

Explore all running Containers/Pods and Configurations
```sh

User@Azure#>  kubectl get ns 

User@Azure#>  kubectl get po -n kube-system

User@Azure#>  kubectl get service 

User@Azure#>  kubectl get deployments

User@Azure#>  kubectl get daemonsets

User@Azure#>  kubectl get replicasets 

User@Azure#>  kubectl get statefulsets 

User@Azure#>  kubectl get configmap 

User@Azure#>  kubectl get secret 

User@Azure#>  kubectl get storageclass 

User@Azure#>  kubectl get pv

User@Azure#>  kubectl get pvc

```

# Step 4 

Open SSH session from master to node1 and node2 in terminal 
```sh
master#> ssh node1.example.local 
master#> ssh node2.example.local 
```

# Step 5
# Init Kubernetes <br>
Perform kubeadm init on master <br>

```sh
master#> kubeadm init 
```

# Step 6
Copy the kubeadm join output and run it in node1 and node2 


# Step 7
Enable kubectl command  
```sh

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

# Step 8 
Verify with kubectl command in master.example.local 
```sh

```

# Step 9 
Deploy the Weave Net cni in master.example.local
 
```sh
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

# Step 10 
Verify with kubectl command in master.example.local 
```sh
 kubectl get po -n kube-system
 kubectl get node
```

# Enable kubectl autocompletion 
```sh
echo 'source <(kubectl completion bash)' >>~/.bashrc

kubectl completion bash >/etc/bash_completion.d/kubectl

echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
```
Restart (logoff/logon) shell session for kubectl autocompletion activation 

END