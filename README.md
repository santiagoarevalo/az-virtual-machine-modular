# Azure Virtual Machine in Module
### Santiago Arévalo Valencia 👨🏽‍💻

## Description
This is a Azure Virtual Machine created with Terraform. The purpose of this exercise is to understand through practice what resources are required to create a virtual machine in Azure, how the configuration should be set up so that it is accessible through a public ip and use modules serve to have reusable building blocks that encapsulate infrastructure resources and configurations.
### Key Technologies:
  * Azure
  * Terraform

## Prerequisites
  * OS with Terraform installed ([Installation guide on Windows](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
  * Azure CLI installed, with a logged in session to access the Azure portal ([Azure CLI installation guide](https://learn.microsoft.com/es-es/cli/azure/install-azure-cli-linux?pivots=apt))
  * File ````terraform.tfvars```` with the values for the variables defined in the file ````variables.tf````.

## Step by step

* We create a file ````main.tf```` in which we will code the general infrastructure provisioning required to create a virtual machine. This is:
    * Resource Group
    * Virtual Network
    * Subnet
* After this, we create a variables file ````name.tf```` in which we will declare the general variables that we want to use for the names of the general infrastructure resources.
* Once the necessary variables have been declared, we create a file ````name.tfvars```` to initialize or assign a value to these variables.
* We must make sure that the calls to the variables in the resources are done in a correct way.
* Now, we create first the folder of modules, and into this folder we create the folder for the VMs. The path look like this: ````./modules/vm````
* Inside the vm folder, we create the files ````main.tf````, ````variables.tf```` and ````name.tfvars````. The main file must contains the resources pending:
    * IP public
    * Network Interface
    * Network Security Group
    * Association between security group and network interface
    * Virtual Machine
* The files ````variables.tf```` and ````name.tfvars```` must contain the corresponding variables indicated in ````main.tf````

## Commands

Now, let's see the commands used to initialize and mount our Infrastructure as Code:
1. Prepare working directory for Terraform:

```
terraform init
```

2. Validate terraform configuration:

```
terraform validate
```

3. Validate and show the changes required for this configuration:

```
terraform plan
```

4. Create the infrastructure:

```
terraform apply
```

---

Now, let's see the evidence of how the infrastructure is displayed in our Azure portal.

* Resource Group created
  
  ![image](https://github.com/santiagoarevalo/az-virtual-machine-modular/assets/71450411/ad5ada9c-94e0-4943-9482-560fb54fcb2f)


* Resources created
  
  ![image](https://github.com/santiagoarevalo/az-virtual-machine-modular/assets/71450411/bba0a1e9-6b36-4f32-be56-d7705d56ab8f)


* IP Public created and accesible VM
  
![image](https://github.com/santiagoarevalo/az-virtual-machine-modular/assets/71450411/ccd62867-0022-4ab8-aefd-bb90eb95b497)




