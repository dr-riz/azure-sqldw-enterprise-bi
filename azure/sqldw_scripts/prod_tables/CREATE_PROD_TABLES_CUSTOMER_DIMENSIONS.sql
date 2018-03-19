SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[CustomerDimensions]') )
    DROP  TABLE [prd].[CustomerDimensions]
GO

CREATE TABLE [prd].[CustomerDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS SELECT c.CustomerID AS [WWI Customer ID],
       c.CustomerName AS [Customer],
	   bt.CustomerName AS [Bill To Customer],
	   cc.CustomerCategoryName AS [Category],
       bg.BuyingGroupName AS [Buying Group],
	   p.FullName AS [Primary Contact],
	   c.DeliveryPostalCode AS [Postal Code],
       c.ValidFrom AS [Valid From],
	   c.ValidTo AS [Valid To]
FROM [stg].[Sales_Customers] AS c
INNER JOIN [stg].[Sales_BuyingGroups] AS bg
ON c.BuyingGroupID = bg.BuyingGroupID
INNER JOIN [stg].[Sales_CustomerCategories] AS cc
ON c.CustomerCategoryID = cc.CustomerCategoryID
INNER JOIN [stg].[Sales_Customers] AS bt
ON c.BillToCustomerID = bt.CustomerID
INNER JOIN [stg].[Application_People] AS p
ON c.PrimaryContactPersonID = p.PersonID
OPTION (LABEL = 'CTAS : [CustomerDimensions]')