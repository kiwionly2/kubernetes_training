# k8_training
k8s Training Assets


This Hub contains the Scripts/JSON files to provision VM(s) needed for Docker/k8s and Labs files needed for training

This Scriplet/JSON files can be only used in MS Azure Cloud

VM creation:

Docker/Container
- VM001 - Centos78/Docker - for Docker training

Kubernetes Standalone
- VM002(master.example.local) - Centos78/K8s - k8 Master Node
- VM003(node1.example.local)  - Centos78/K8s - k8 worker Node
- VM004(node2.example.local)  - Centos78/K8s - k8 worker Node


Cloud based Container/Kubernetes Service
- Azure Kubernetes Service Setup ( AKS )

The only script you need to run is main.sh

main.sh will call all the other scripts automatically

# Steps: 

1. Go Azure CLI - Bash
2. use git clone to clone this HUB
3. How to use this script? 

- cd into the hub clone 
- chmod +x main.sh 
- ./main.sh  [ vm001 | k8s | aks ]
- You need to pass vm001 or k8s or cloud or aks as arguments
- vm001 arg will create single VM with docker capabilities 
- k8s arg will create 3 VM  (vm002[master], vm003[node1] and vm004[node2]) 
- aks arg will create Azure Kubernetes Service
- there is a hidden argument called init - WARNING - this will delete resources 


Thank You, Have Fun, Cheers<br>
Steven<br>

steven@cognitoz.com | steven@outlook.my | smahalin@redhat.com 