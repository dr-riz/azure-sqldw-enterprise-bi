SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[SalesFact]') )
    DROP  TABLE [prd].[SalesFact]
GO

CREATE TABLE [prd].[SalesFact]
WITH
(
    DISTRIBUTION = HASH([WWI Invoice ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT 
       c.DeliveryCityID AS [WWI City ID],
       i.CustomerID AS [WWI Customer ID],
	   i.BillToCustomerID AS [WWI Bill To Customer ID],
	   il.StockItemID AS [WWI Stock Item ID],
	   CAST(i.InvoiceDate AS date) AS [Invoice Date Key],
       CAST(i.ConfirmedDeliveryTime AS date) AS [Delivery Date Key],
	   i.SalespersonPersonID AS [WWI Saleperson ID],
       i.InvoiceID AS [WWI Invoice ID],
       il.[Description],
       pt.PackageTypeName AS Package,
       il.Quantity,
       il.UnitPrice AS [Unit Price],
       il.TaxRate AS [Tax Rate],
       il.ExtendedPrice - il.TaxAmount AS [Total Excluding Tax],
       il.TaxAmount AS [Tax Amount],
       il.LineProfit AS Profit,
       il.ExtendedPrice AS [Total Including Tax],
       CASE WHEN si.IsChillerStock = 0 THEN il.Quantity ELSE 0 END AS [Total Dry Items],
       CASE WHEN si.IsChillerStock <> 0 THEN il.Quantity ELSE 0 END AS [Total Chiller Items]
       
FROM [stg].[Sales_Invoices] AS i
INNER JOIN [stg].[Sales_InvoiceLines] AS il
ON i.InvoiceID = il.InvoiceID
INNER JOIN [stg].[Warehouse_StockItems] AS si
ON il.StockItemID = si.StockItemID
INNER JOIN [stg].[Warehouse_PackageTypes] AS pt
ON il.PackageTypeID = pt.PackageTypeID
INNER JOIN [stg].[Sales_Customers] AS c
ON i.CustomerID = c.CustomerID
INNER JOIN [stg].[Sales_Customers] AS bt
ON i.BillToCustomerID = bt.CustomerID
OPTION (LABEL = 'CTAS : [SalesFact]')