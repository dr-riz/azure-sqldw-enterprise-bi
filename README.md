# Enterprise BI with SQL Data Warehouse

This reference architecture implements an [ELT](https://docs.microsoft.com/azure/architecture/data-guide/relational-data/etl#extract-load-and-transform-elt) (extract-load-transform) pipeline that moves data from an on-premises SQL Server database into SQL Data Warehouse and transforms the data for analysis.

![](https://docs.microsoft.com/azure/architecture/reference-architectures/data/images/enterprise-bi-sqldw.png)

For more information about this reference architectures and guidance about best practices, see the article [Enterprise BI with SQL Data Warehouse](https://docs.microsoft.com/azure/architecture/reference-architectures/data/enterprise-bi-sqldw) on the Azure Architecture Center.

The deployment uses [Azure Building Blocks](https://github.com/mspnp/template-building-blocks/wiki) (azbb), a command line tool that simplifies deployment of Azure resources.

## Deploy the solution 

### Prerequisites

1. Clone, fork, or download the zip file for this repository.

2. Install [Azure CLI 2.0](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest).

3. Install the [Azure building blocks](https://github.com/mspnp/template-building-blocks/wiki/Install-Azure-Building-Blocks) npm package.

   ```bash
   npm install -g @mspnp/azure-building-blocks
   ```

4. From a command prompt, bash prompt, or PowerShell prompt, sign into your Azure account as follows:

   ```bash
   az login
   ```

### Deploy the simulated on-premises server

First you'll deploy a VM as a simulated on-premises server, which includes SQL Server 2017 and related tools. This step also loads the [Wide World Importers OLTP database](https://docs.microsoft.com/sql/sample/world-wide-importers/wide-world-importers-oltp-database) into SQL Server.

1. Navigate to the `data\enterprise_bi_sqldw\onprem\templates` folder of the repository.

2. In the `onprem.parameters.json` file, replace the values for `adminUsername` and `adminPassword`. Also change the values in the `SqlUserCredentials` section to match the user name and password. Note the `.\\` prefix in the userName property.
    
    ```bash
    "SqlUserCredentials": {
      "userName": "username",
      "password": "password"
    }
    ```

3. Run `azbb` as shown below to deploy the on-premises server.

    ```bash
    azbb -s <subscription_id> -g <resource_group_name> -l <region> -p onprem.parameters.json --deploy
    ```

    Specify a region that supports SQL Data Warehouse and Azure Analysis Services. See [Azure Products by Region](https://azure.microsoft.com/global-infrastructure/services/)

4. I got an error "Error executing az status: null - vm list-skus --resource-type virtualMachines --zone false --subscription". To proceed further, I had to define [maxBuffer](https://github.com/mspnp/template-building-blocks/issues/418)
	```bash
	spawnOptions = spawnOptions || {
		stdio: 'pipe',
        shell: true,
        maxBuffer : 1024*1024*20
    };
    ```


5. The deployment may take 20 to 30 minutes to complete, which includes running the [DSC](/powershell/dsc/overview) script to install the tools and restore the database. Verify the deployment in the Azure portal by reviewing the resources in the resource group. You should see the `sql-vm1` virtual machine and its associated resources.


6. I got errors in my Mac shell. Specifically, it reported the "Deployment failed." Meanwhile, the status of deployment in the Portal's Activity view was successful. I decided to connect with the SQL Server to confirm. By default, the SSH, RDO, SQL Server ports are not open to internet. That is, 22, 3389 and 1433 are closed. [Open the firewall] (How to open ports to a virtual machine with the Azure portal)

<pre>
"VM has reported a failure when processing extension 'SetupServer'. Error message: \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"DSC Configuration 'Provision_OnPrem' completed with error(s). Following are the first few: Unable to find package source 'PSGallery'. Use Get-PackageSource to see all available package sources. PowerShell Gallery is currently unavailable.  Please try again later. No match was found for the specified search criteria for the provider 'NuGet'. The package provider requires 'PackageManagement' and 'Provider' tags. Please check if the specified package has the tags.\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
</pre>

7. Upgrading az cli, installing and configuring PowerShell did not help. Unable to find 'PSGallery' or 'PowerShell Gallery'. I searched if I can find this package manually in some repo. I park this project for now and deleted the resource groups to avoid incurring costs.

