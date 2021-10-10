#  Explore Kubernetes Cluster 


Verify your System for Kubernetes
# Step 1 

Access Azure Cloud Shell and Connect to AKS

- Initiate Azure Cloud Shell ( you may be asked to create storage account when you run Azure Cloud Shell for First time, accept the default)

- Select Bash if prompted 

![picture 1](../../images/1ccba30eda4a59d6473e7ccd94e63f0901c6aed775e74445fcc3910aa23f7955.png)  


```sh
master#>ping node1.example.local 
master#>ping node2.example.local 
```

# Step 2 

Make sure /etc/hosts on all 3 nodes have hostname information 
```sh
master#> cat /etc/hosts 
node1#> cat /etc/hosts 
node2#> cat /etc/hosts 
```

# Step 3 

Make sure docker is installed on all 3 system 
```sh
master#> docker -v 
node1#> docker -v 
node2#> docker -v 
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
 kubectl get po -n kube-system
 kubectl get node -o wide 
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