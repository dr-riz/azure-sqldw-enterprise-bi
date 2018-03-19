SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[PurchasesFact]') )
    DROP  TABLE [prd].[PurchasesFact]
GO

CREATE TABLE [prd].[PurchasesFact]
WITH
(
    DISTRIBUTION = HASH([WWI Purchase Order ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT CAST(po.OrderDate AS date) AS [Date Key],
           po.SupplierID AS [WWI Supplier ID],
		   pol.StockItemID AS [WWI Stock Item ID],
           po.PurchaseOrderID AS [WWI Purchase Order ID],
           pol.OrderedOuters AS [Ordered Outers],
           pol.OrderedOuters * si.QuantityPerOuter AS [Ordered Quantity],
           pol.ReceivedOuters AS [Received Outers],
           pt.PackageTypeName AS Package,
           pol.IsOrderLineFinalized AS [Is Order Finalized]
    FROM [stg].[Purchasing_PurchaseOrders] AS po
    INNER JOIN [stg].[Purchasing_PurchaseOrderLines] AS pol
    ON po.PurchaseOrderID = pol.PurchaseOrderID
    INNER JOIN [stg].[Warehouse_StockItems] AS si
    ON pol.StockItemID = si.StockItemID
    INNER JOIN [stg].[Warehouse_PackageTypes] AS pt
    ON pol.PackageTypeID = pt.PackageTypeID
OPTION (LABEL = 'CTAS : [PurchasesFact]')