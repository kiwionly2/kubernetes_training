# Lab12A
# Step 
Limiting resources available to a pods/containers
```sh

**Request Resource 

cat requests-pod.yaml

kubectl apply -f requests-pod.yaml 

kubectl exec -it requests-pod -- sh 
> top 
> exit

kubectl get pod -o wide requests-pod
 * identify the node the pod is running on

kubectl describe nodes <request_pod_running_node>

kubectl run requests-pod-2 --image=busybox --restart Never --requests='cpu=800m,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-3 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-4 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-5 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 



kubectl describe po requests-pod-5

kubectl get pods 
kubectl delete po requests-pod-4 --force
kubectl get pods 

kubectl delete pod requests-pod-2 requests-pod-3 requests-pod-5 requests-pod  --force 

**Explore limits
kubectl create -f limited-pod.yaml

kubectl get pods -o wide

kubectl describe nodes (node where the pod is running)

kubectl delete  -f  limited-pod.yaml --force

**Some memory test 

kubectl apply -f memoryhog.yaml
kubectl get pods --watch 

**Check the detail on what happen? 
kubectl describe pod memoryhog 

kubectl delete -f memoryhog.yaml --force 

**Explore limitsranges

kubectl create ns dev

kubectl apply -f limits.yaml

kubectl get limitranges -n dev 

kubectl describe limitranges example -n dev 

kubectl apply -f kubia-manual.yaml
kubectl get pod

kubectl describe pod kubia-manual

```
# Lab12B
# Step 1
 * Configure vm001 VM to access Kubernetes Cluster ( install az cli & kubectl )
 * Perform this on Azure Cloud shell ( private key to access vm001 only available on Azure Cloud Shell )
```sh 

# @Azure:~$  VMIP=$(az vm show -d -g vm001_rg -n vm001 --query "publicIps" -o tsv)

# @Azure:~$  ssh droot@${VMIP}

# droot@vm001:~$ sudo apt install azure-cli -y 

# droot@vm001:~$ sudo apt-get update

# droot@vm001:~$ sudo apt-get install -y apt-transport-https ca-certificates curl git

# droot@vm001:~$ sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# droot@vm001:~$ echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# droot@vm001:~$ sudo apt-get update

# droot@vm001:~$ apt-get install -y kubectl

# droot@vm001:~$ kubectl version

# droot@vm001:~$ az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXXX to authenticate.

 * open the link on the browser where you have Azure logged in to Authenticate vm001 to access Azure Access and insert the code 

# droot@vm001:~$  az account set --subscription $(az account list | grep id | awk '{print $2}'  | sed 's/"//g' | sed 's/,//g')

# droot@vm001:~$  az aks get-credentials --resource-group aks_rg --name aks_lab

# droot@vm001:~$ kubectl cluster-info 
* You should receive Cluster Info Output

# droot@vm001:~$ sudo useradd jedi 

# droot@vm001:~$ sudo useradd sith 

# droot@vm001:~$ tail -n2 /etc/passwd

```

# Step 2
 * Create namespace for user Jedi and Sith and Apply Resource Quota 

```sh

** Clone Github
# droot@vm001:~$ git clone https://github.com/stv707/kubernetes_training.git

# droot@vm001:~$ cd kubernetes_training/k-labs/lab12/

** Create Namespace 
# droot@vm001:~/kubernetes_training/k-labs/lab12$ kubectl create namespace jedi

# droot@vm001:~/kubernetes_training/k-labs/lab12$ kubectl create namespace sith




* run create_user_namespace.sh to generate kubeconfig 

bash create_user_namespace.sh jedi
bash create_user_namespace.sh sith


* create hard pod limit 
kubectl apply -f quota-pod_jedi.yaml --namespace=jedi 

kubectl apply -f quota-pod_sith.yaml --namespace=sith


* create linux user 
useradd jedi1 
useradd sith1

* copy the config file to home dir of each 
cp jedi_kubeconfig   ~jedi1 

cp sith_kubeconfig   ~sith1 


* copy quota_test_jedi.yaml to jedi1 user $HOME
cp quota_test_jedi.yaml  ~jedi1

* copy quota_test_sith.yaml to sith1 user $HOME
cp quota_test_sith.yaml  ~sith1


* set .bashrc to call the kubeconfig file on each home dir 
echo "export KUBECONFIG=/home/jedi1/jedi_kubeconfig"  >> ~jedi1/.bashrc 
echo "export KUBECONFIG=/home/sith1/sith_kubeconfig"  >> ~sith1/.bashrc 

* update Access

chown -R jedi1:jedi1  ~jedi1/* 

chown -R sith1:sith1  ~sith1/*

su - jedi1 
kubectl apply -f quota_test_jedi.yaml
*check the pods / deployments 

*on another Terminal 
su - sith1 
kubectl apply -f quota_test_sith.yaml
*check the pods / deployments 
```

END