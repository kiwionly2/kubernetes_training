# k8_training
k8s Training Assets


- This Hub contains the Scripts/JSON files to provision Kubernetes Cluster and Labs files needed for training

- This Scriplet/JSON files can be only used in MS Azure Cloud

- Scriplet available in this Hub will use Azure Resource Manager(ARM) Template to create Kubernetes Cluster.


- The only script you need to run is main.sh

- main.sh will call all the other scripts automatically

# Steps to be Performed on Azure Cloud Shell: 

1. Go Azure Shell - Bash
2. use git clone to clone this HUB
  
   ```sh 
   git clone https://github.com/stv707/kubernetes_training.git
   ```

3. Change Directory to hub directory  

   ```sh 
   cd kubernetes_training/
   ```

4. Make main* unix format 
   ```sh 
   dos2unix main* 
   ``` 

5. Execute main.sh with aks as argument 
   ```sh 
   bash main.sh aks
   ```
   **NOTE**
   - You need to pass aks as arguments
   - aks arg will create Azure Kubernetes Service

6. Wait until the deployment is done. Then, Execute this to reveal Vital Info of AKS: 
   ```sh 
   bash main.sh info 
   ```
   **NOTE**
   - Write down the vital info for future usage
   - Vital info will be recorded in file aks_info.txt as well, ``` cat $HOME/aks_info.txt ```

Thank You, Have Fun, Cheers<br>
Steven<br>

smahalin@redhat.com