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
      "userName": ".\\username",
      "password": "password"
    }
    ```

3. Run `azbb` as shown below to deploy the on-premises server.

    ```bash
    azbb -s <subscription_id> -g <resource_group_name> -l <region> -p onprem.parameters.json --deploy
    ```

    Specify a region that supports SQL Data Warehouse and Azure Analysis Services. See [Azure Products by Region](https://azure.microsoft.com/global-infrastructure/services/)

4. The deployment may take 20 to 30 minutes to complete, which includes running the [DSC](/powershell/dsc/overview) script to install the tools and restore the database. Verify the deployment in the Azure portal by reviewing the resources in the resource group. You should see the `sql-vm1` virtual machine and its associated resources.

### Deploy the Azure resources

This step provisions SQL Data Warehouse and Azure Analysis Services, along with a Storage account. If you want, you can run this step in parallel with the previous step.

1. Navigate to the `data\enterprise_bi_sqldw\azure\templates` folder of the repository.

2. Run the following Azure CLI command to create a resource group. You can deploy to a different resource group than the previous step, but choose the same region. 

    ```bash
    az group create --name <resource_group_name> --location <region>  
    ```

3. Run the following Azure CLI command to deploy the Azure resources. Replace the parameter values shown in angle brackets. 

    ```bash
    az group deployment create --resource-group <resource_group_name> \
     --template-file azure-resources-deploy.json \
     --parameters "dwServerName"="<server_name>" \
     "dwAdminLogin"="<admin_username>" "dwAdminPassword"="<password>" \ 
     "storageAccountName"="<storage_account_name>" \
     "analysisServerName"="<analysis_server_name>" \
     "analysisServerAdmin"="user@contoso.com"
    ```

    - The `storageAccountName` parameter must follow the [naming rules](https://docs.microsoft.com/azure/architecture/best-practices/naming-conventions#naming-rules-and-restrictions) for Storage accounts.
    - For the `analysisServerAdmin` parameter, use your Azure Active Directory user principal name (UPN).

4. Verify the deployment in the Azure portal by reviewing the resources in the resource group. You should see a storage account, Azure SQL Data Warehouse instance, and Analysis Services instance.

5. Use the Azure portal to get the access key for the storage account. Select the storage account to open it. Under **Settings**, select **Access keys**. Copy the primary key value. You will use it in the next step.

### Export the source data to Azure Blob storage 

In this step, you will run a PowerShell script that uses bcp to export the SQL database to flat files on the VM, and then uses AzCopy to copy those files into Azure Blob Storage.

1. Use Remote Desktop to connect to the simulated on-premises VM.

2. While logged into the VM, run the following commands from a PowerShell window.  

    ```powershell
    cd 'C:\SampleDataFiles\reference-architectures\data\enterprise_bi_sqldw\onprem'

    .\Load_SourceData_To_Blob.ps1 -File .\sql_scripts\db_objects.txt -Destination 'https://<storage_account_name>.blob.core.windows.net/wwi' -StorageAccountKey '<storage_account_key>'
    ```

    For the `Destination` parameter, replace `<storage_account_name>` with the name the Storage account that you created previously. For the `StorageAccountKey` parameter, use the access key for that Storage account.

3. In the Azure portal, verify that the source data was copied to Blob storage by navigating to the storage account, selecting the Blob service, and opening the `wwi` container. You should see a list of tables prefaced with `WorldWideImporters_Application_*`.

### Run the data warehouse scripts

1. From your Remote Desktop session, launch SQL Server Management Studio (SSMS). 

2. Connect to SQL Data Warehouse

    - Server type: Database Engine
    
    - Server name: `<dwServerName>.database.windows.net`, where `<dwServerName>` is the name that you specified when you deployed the Azure resources. You can get this name from the Azure portal.
    
    - Authentication: SQL Server Authentication. Use the credentials that you specified when you deployed the Azure resources, in the `dwAdminLogin` and `dwAdminPassword` parameters.

2. Navigate to the `C:\SampleDataFiles\reference-architectures\data\enterprise_bi_sqldw\azure\sqldw_scripts` folder on the VM. You will execute the scripts in this folder in numerical order, `STEP_1` through `STEP_7`.

3. Select the `master` database in SSMS and open the `STEP_1` script. Change the value of the password in the following line, then execute the script.

    ```sql
    CREATE LOGIN LoaderRC20 WITH PASSWORD = '<change this value>';
    ```

4. Select the `wwi` database in SSMS. Open the `STEP_2` script and execute the script. If you get an error, make sure you are running the script against the `wwi` database and not `master`.

5. Open a new connection to SQL Data Warehouse, using the `LoaderRC20` user and the password indicated in the `STEP_1` script.

6. Using this connection, open the `STEP_3` script. Set the following values in the script:

    - SECRET: Use the access key for your storage account.
    - LOCATION: Use the name of the storage account as follows: `wasbs://wwi@<storage_account_name>.blob.core.windows.net`.

7. Using the same connection, execute scripts `STEP_4` through `STEP_7` sequentially. Verify that each script completes successfully before running the next.

In SMSS, you should see a set of `prd.*` tables in the `wwi` database. To verify that the data was generated, run the following query: 

```sql
SELECT TOP 10 * FROM prd.CityDimensions
```

## Build the Analysis Services model

In this step, you will create a tabular model that imports data from the data warehouse. Then you will deploy the model to Azure Analysis Services.

1. From your Remote Desktop session, launch SQL Server Data Tools 2015.

2. Select **File** > **New** > **Project**.

3. In the **New Project** dialog, under **Templates**, select  **Business Intelligence** > **Analysis Services** > **Analysis Services Tabular Project**. 

4. Name the project and click **OK**.

5. In the **Tabular model designer** dialog, select **Integrated workspace**  and set **Compatibility level** to `SQL Server 2017 / Azure Analysis Services (1400)`. Click **OK**.

6. In the **Tabular Model Explorer** window, right-click the project and select **Import from Data Source**.

7. Select **Azure SQL Data Warehouse** and click **Connect**.

8. For **Server**, enter the fully qualified name of your Azure SQL Data Warehouse server. For **Database**, enter `wwi`. Click **OK**.

9. In the next dialog, choose **Database** authentication and enter your Azure SQL Data Warehouse user name and password, and click **OK**.

10. In the **Navigator** dialog, select the checkboxes for **prd.CityDimensions**, **prd.DateDimensions**, and **prd.SalesFact**. 

    ![](./_images/analysis-services-import.png)

11. Click **Load**. When processing is complete, click **Close**. You should now see a tabular view of the data.

12. In the **Tabular Model Explorer** window, right-click the project and select **Model View** > **Diagram View**.

13. Drag the **[prd.SalesFact].[WWI City ID]** field to the **[prd.CityDimensions].[WWI City ID]** field to create a relationship.  

14. Drag the **[prd.SalesFact].[Invoice Date Key]** field to the **[prd.DateDimensions].[Date]** field.  
    ![](./_images/analysis-services-relations.png)

15. From the **File** menu, choose **Save All**.  

16. In **Solution Explorer**, right-click the project and select **Properties**. 

17. Under **Server**, enter the URL of your Azure Analysis Services instance. You can get this value from the Azure Portal. In the portal, select the Analysis Services resource, click the Overview pane, and look for the **Server Name** property. It will be similar to `asazure://westus.asazure.windows.net/contoso`. Click **OK**.

    ![](./_images/analysis-services-properties.png)

18. In **Solution Explorer**, right-click the project and select **Deploy**. Sign into Azure if prompted. When processing is complete, click **Close**.

19. In the Azure portal, view the details for your Azure Analysis Services instance. Verify that your model appears in the list of models.

    ![](./_images/analysis-services-models.png)

## Analyze the data in Power BI Desktop

In this step, you will use Power BI to create a report from the data in Analysis Services.

1. From your Remote Desktop session, launch Power BI Desktop.

2. In the Welcome Scren, click **Get Data**.

3. Select **Azure** > **Azure Analysis Services database**. Click **Connect**

    ![](./_images/power-bi-get-data.png)

4. Enter the URL of your Analysis Services instance, then click **OK**. Sign into Azure if prompted.

5. In the **Navigator** dialog, expand the tabular project that you deployed, select the model that you created, and click **OK**.

2. In the **Visualizations** pane, select the **Stacked Bar Chart** icon. In the Report view, resize the visualization to make it larger.

6. In the **Fields** pane, expand **prd.CityDimensions**.

7. Drag **prd.CityDimensions** > **WWI City ID** to the **Axis** well.

8. Drag **prd.CityDimensions** > **City** to the **Legend** well.

9. In the **Fields** pane, expand **prd.SalesFact**.

10. Drag **prd.SalesFact** > **Total Excluding Tax** to the **Value** well.

    ![](./_images/power-bi-visualization.png)

11. Under **Visual Level Filters**, select **WWI City ID**.

12. Set the **Filter Type** to `Top N`, and set **Show Items** to `Top 10`.

13. Drag **prd.SalesFact** > **Total Excluding Tax** to the **By Value** well

    ![](./_images/power-bi-visualization2.png)

14. Click **Apply Filter**. The visualization shows the top 10 total sales by city.

    ![](./_images/power-bi-report.png)

To learn more about Power BI Desktop, see [Getting started with Power BI Desktop](https://docs.microsoft.com/power-bi/desktop-getting-started).

