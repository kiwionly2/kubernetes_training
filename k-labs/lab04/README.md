# Lab04A
# Step 
Using an emptyDir volume<br>
The yaml file will create 1 pod with 2 containers<br>
The html-generator container will run a script and generate index.html on /var/htdocs <br>
The web-server container will serve index.html from /usr/share/nginx/html/ <br>
Pod: fortune <br>
Container: html-generator mounts html <br>
Container: web-server mount html<br>
the volume html is a emptyDir type <br> 
see fortune-pod.yaml for settings <br>

```sh
cat fortune-pod.yaml

kubectl create -f fortune-pod.yaml

kubectl get po fortune -o=custom-columns=NAME:.metadata.name,CONTAINERS:.spec.containers[*].name

kubectl describe pod fortune 

kubectl exec -i -t fortune --container html-generator  -- /bin/sh
# cat /var/htdocs/index.html
# mount | grep /var/htdocs
# exit

kubectl exec -i -t fortune --container web-server  -- /bin/sh
# cat  /usr/share/nginx/html/index.html
# mount | grep /usr/share/nginx/html
# exit
```

# Lab04B
# Step 
Using an hostPath volume <br>
The yaml file will create 2 pods (mongo-xxx), which will run on both worker node<br>
hostPath volume will mount local worker node path <br>
Data will persists on both worker node as separate data not shared <br>

```sh
cat mongodb-rc-pod-hostpath.yaml
kubectl create -f mongodb-rc-pod-hostpath.yaml

kubectl get pods -o wide | grep mongo 

kubectl get nodes 

kubectl debug node/<node_name_1> -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11
# chroot /host
# ls /tmp/mongodb
# exit
# exit

kubectl debug node/<node_name_2> -it --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11
# chroot /host
# ls /tmp/mongodb
# exit
# exit

kubectl get pod | grep mongo

kubectl exec -it mongo-<pod1> -- mongo
> use mystore
> db.foo.insert({name:'foo Pan Pan'})
> db.foo.find()
> exit

kubectl exec -it mongo-<pod2> -- mongo
> use mystore
> db.bar.insert({name:'bar Pan Pan'})
> db.bar.find()
> exit

kubectl get pods | grep mongo 
kubectl delete pods mongo-<pod1>
kubectl delete pods mongo-<pod1>

kubectl get pods | grep mongo 
kubectl exec -it mongo-<new_pod1> -- mongo
> use mystore
> db.foo.find()
> exit

kubectl exec -it mongo-<new_pod2> -- mongo
> use mystore
> db.bar.find()
> exit

kubectl describe rc mongo
```

Cleanup 
```sh
kubectl get pods
kubectl get rc
kubectl delete rc mongo

kubectl get pods
kubectl get rc
```

# Lab04C
# Step 1
Using an NFS volume <br>
You will be using a NFS server running on vm001 to act as a NFS server <br>
A rc that will bring 2 pods up <br>
Both pods will mount the NFS volume in vm001 /export dir <br>
Data on both pod will be stored on NFS volume in vm001 /export <br>

## Step 2 
 * Find the IP address of NFS Server ( vm001 )

```sh 
 az vm show -d -g vm001_rg -n vm001 --query "publicIps" -o tsv
 *This is vm001 public ip address

 az vm show -d -g vm001_rg -n vm001 --query "privateIps" -o tsv
 *This is vm001 private address
```


# Step 3 
* edit the alpine-rc-pod-nfs.yaml to include the private ip address 
```sh

vim alpine-rc-pod-nfs.yaml

kubectl create -f alpine-rc-pod-nfs.yaml
kubectl get pods | grep alpine 
*Wait until pod is running 

kubectl describe pod alpine-xxxx 
*Look for Mounts section and Volume Sections 

ssh droot@vm001_public_ip_address 

droot@vm001:~$ ls -l /export/

droot@vm001:~$ ls -l /export/dates.txt

droot@vm001:~$ tail -f  /export/dates.txt
*Verify both alpine pod are writing to this NFS Share

droot@vm001:~$ exit
```

# Step 4 
 * Remove alpine pods 
```sh 
kubectl get pods | grep alpine

kubectl delete -f alpine-rc-pod-nfs.yaml

kubectl get pods | grep alpine
```

# Step 5
 * Verify data still retained on vm001 NFS server  
```sh 
ssh droot@vm001_public_ip_address 

droot@vm001:~$ ls -l /export/

droot@vm001:~$ ls -l /export/dates.txt

droot@vm001:~$ tail -f  /export/dates.txt
*Verify data is not updating, as we already deleted alpine pods 

droot@vm001:~$ exit
```

# Lab04D
# Step
Using PersistentVolumes and PersistentVolumeClaims <br>
You will create PersistentVolumes and PersistentVolumeClaims <br>
Bring up a pod that uses claim (mongodb-pod-pvc-1.yaml) <br>

```sh
kubectl get pv
kubectl create -f mongodb-pv-nfs-1.yaml
kubectl get pv
kubectl create -f mongodb-pv-nfs-2.yaml
kubectl get pv


kubectl get pvc
kubectl create -f mongodb-pvc-1.yaml
kubectl get pvc

kubectl create -f mongodb-pod-pvc-1.yaml

ls /nfsdata/dat2

kubectl exec -it mongodb1 -- mongo
> use mystore
> db.foo.insert({name:'foo Pan Pan'})
> db.foo.find()
exit

kubectl get pods
kubectl delete pods mongodb1
ls /nfsdata/dat1

kubectl get pv
kubectl get pvc
```

Cleanup 
```sh

kubectl delete -f mongodb-pvc-1.yaml

kubectl delete  -f mongodb-pv-nfs-1.yaml

```

# Lab05E
# Step
Using Dynamic provisioning of PersistentVolumes<br>
In order to use Dynamic provisioning, you need to use a provisioner <br>
Cloud based Kubernetes provides this, in bare metal (private) Kubernetes,you need to create provisioner <br>
Here you will deploy a NFS Provisioner and Storageclass <br>

```sh
 kubectl create -f nfs-provisioning/rbac.yaml
 kubectl create -f nfs-provisioning/deployment.yaml

 kubectl create -f nfs-provisioning/class.yaml
 kubectl get storageclass

 kubectl get pv
 kubectl get pvc
 ls /nfsdata/dat3/
 
 **This will create PersistentVolumeClaims ( we do need to create PersistentVolume )

 kubectl create -f nfs-provisioning/pvc-nfs.yaml
 kubectl get pv
 kubectl get pvc

 kubectl create -f    nfs-provisioning/busybox-pv-nfs.yaml
 kubectl get pods 
 ls /nfsdata/dat3/

 **Create another pod to take the claim 

 kubectl create -f nfs-provisioning/pvc-nfs2.yaml
 kubectl create -f    nfs-provisioning/busybox-pv-nfs2.yaml
 ls /nfsdata/dat3/

```

Cleanup
```sh
kubectl get pods
kubectl delete pods busybox
kubectl delete pods busybox2

kubectl delete pvc --all

 kubectl delete -f nfs-provisioning/class.yaml
 
```
END