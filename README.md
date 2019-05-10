![](images/title.png)  
Update: May 9, 2019

## Introduction

This workshop will walk you through the process of deploying **Pivotal Cloud Foundry (PCF)** on **Microsoft Azure**. We will stand up **Concourse** using **Pivotal Control Plane** and deploy PCF using **Platform Automation**.

***To log issues***, click here to go to the [github](https://github.com/dfoleypivotal/azure-platform-automation-example/issues) repository issue submission form.

## Objectives

- [Install Pivotal Control Plane](#install)

## Required Artifacts

- The following lab requires a Microsoft Azure account.
- A registered domain name is required to deploy PCF.

<a id="install"></a>

## Install Pivotal Control Plane

### **STEP 1**: Clone Terraform template repository

- Open a terminal window and change to working directory. For documentation working directory location will be /Users/dfoley/development/Azure.

```bash
cd /Users/dfoley/development/Azure
```

- Clone terraforming-azure repository

```bash
git clone https://github.com/pivotal-cf/terraforming-azure.git
cd terraforming-azure
```

![](images/image1.png)

### **STEP 2**: Create an Automation Account

- First, find your account by running the following commands using the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

```bash
az login
az account list
```

![](images/image2.png)

**Note:** Copy **Id** an **Tenant Id** as these values will be used later in the lab.

- To create the automation account, you need **az-automation**. You can use brew or go to the [releases](https://github.com/genevieve/az-automation/releases) and get the necessary binary.

```bash
brew tap genevieve/tap
brew install az-automation
```

![](images/image3.png)

- Run the following command. Replace **some-account-id** with your **subscription id** and create a unique **identifier=uri**.

```bash
az-automation \
  --account some-account-id \
  --identifier-uri http://example.com \
  --display-name controlplane \
  --credential-output-file controlplane-credentials.tfvars
  ```

![](images/image4.png)

- If you want to verify that the service principal was create you can login to the Azure Console. Click **Azure Active Directory** then **App registrations** and you will see the new **controlplane** application was created.

    ![](images/image5.png)

### **STEP 3**: Pave IaaS using Terraform

- Next step

```bash
cd terraforming-control-plane/
vi terraform.tfvars
```

![](images/image6.png)

- Using the values from the file **controlplane-credentials.tfvars** populate the **terraform.tfvars** file with the content below.

```bash
subscription_id = "some-subscription-id"
tenant_id       = "some-tenant-id"
client_id       = "some-client-id"
client_secret   = "some-client-secret"

env_name              = "controlplane"
ops_manager_image_uri = "https://opsmanagerwestus.blob.core.windows.net/images/ops-manager-2.4-build.192.vhd"
location              = "WestUS2"
dns_suffix            = "domain.com"

dns_subdomain         = "pcfcontrolplane"
```

- Create Infrastructure 

```bash
terraform init
terraform apply
```

![](images/image7.png)

- Back on the Azure Console, you will see that a resource group named **controlplane** has been created and you can view all the resources that where created.

    ![](images/image8.png)

- Create an NS record on the parent DNS Zone with the records returned by the following. You can test 

```bash
terraform output env_dns_zone_name_servers
```

![](images/image9.png)

- Verify connectivity with the following command:

```bash
dig pcfcontrolplane.<your domain> NS +short
```

![](images/image10.png)

### **STEP 4**: Configure BOSH Director

- From any browser, access Ops Manger using URL defined by:

```bash
echo https://"$(terraform output ops_manager_dns)"
```

![](images/image11.png)

- Follow the Pivotal documentation [Configuring BOSH Director on Azure](https://docs.pivotal.io/pivotalcf/2-4/om/azure/config-manual.html)

**Note:** On the *Create Networks Page* only create one network, following the *infrastructure* network guide, and set the *Name* field to *control-plane-subnet*






