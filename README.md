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

4. Make main.sh executable 
   ```sh 
   chmod +x main.sh 
   ``` 

5. Execute main.sh with aks as argument 
   ```sh 
   ./main.sh aks
   ```
   **NOTE**
   - You need to pass aks as arguments
   - aks arg will create Azure Kubernetes Service
   - there is a hidden argument called init - WARNING - this will delete resources 


Thank You, Have Fun, Cheers<br>
Steven<br>

smahalin@redhat.com  | stv707@gmail.com