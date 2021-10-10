#!/bin/bash
#main.sh Script to create resources and Build VM in Azure
#Using Local SYS via git clone
#Function LIB
source  ./mainlib.sh
source  ./mainsub.sh
source  ./mainsub2.sh

# Variables
VMNAME=$1
LOC=

##main program
if [ $# -ne 1 ]
  then 
  my_usage #This will print USAGE
  exit
  else
  setloc #This will set RG Location 
  addssh #This will create local Private/Public Key for VM
  subid  #This will catch your Azure Subscription ID
  case ${VMNAME} in
  'vm001') non ;; #createrg_vm001 && config_vm001 ;;
  'k8s'  ) non ;;#createrg_k8s  && config_k8s ;;
  'cloud') non ;;#createrg_cloud ;;
  'aks'  ) createrg_cloud_aks ;;
  'init' ) reinit   ;;
        *) my_usage ;;
  esac
fi