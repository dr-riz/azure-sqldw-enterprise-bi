SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[OrdersFact]') )
    DROP  TABLE [prd].[OrdersFact]
GO

CREATE TABLE [prd].[OrdersFact]
WITH
(
    DISTRIBUTION = HASH([WWI Order ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT 
	c.DeliveryCityID AS [WWI City ID],
	c.CustomerID AS [WWI Customer ID],
	ol.StockItemID AS [WWI Stock Item ID],
	CAST(o.OrderDate AS date) AS [Order Date Key],
	CAST(ol.PickingCompletedWhen AS date) AS [Picked Date Key],
	o.SalespersonPersonID AS [WWI Salesperson ID],
	o.PickedByPersonID AS [WWI Picker ID],
	o.OrderID AS [WWI Order ID],
	o.BackorderOrderID AS [WWI Backorder ID],
	ol.[Description],
	pt.PackageTypeName AS Package,
	ol.Quantity AS Quantity,
	ol.UnitPrice AS [Unit Price],
	ol.TaxRate AS [Tax Rate],
	ROUND(ol.Quantity * ol.UnitPrice, 2) AS [Total Excluding Tax],
	ROUND(ol.Quantity * ol.UnitPrice * ol.TaxRate / 100.0, 2) AS [Tax Amount],
	ROUND(ol.Quantity * ol.UnitPrice, 2) + ROUND(ol.Quantity * ol.UnitPrice * ol.TaxRate / 100.0, 2) AS [Total Including Tax]
FROM [stg].[Sales_Orders] AS o
INNER JOIN [stg].[Sales_OrderLines] AS ol
ON o.OrderID = ol.OrderID
INNER JOIN [stg].[Warehouse_PackageTypes] AS pt
ON ol.PackageTypeID = pt.PackageTypeID
INNER JOIN [stg].[Sales_Customers] AS c
ON c.CustomerID = o.CustomerID
OPTION (LABEL = 'CTAS : [OrdersFact]')