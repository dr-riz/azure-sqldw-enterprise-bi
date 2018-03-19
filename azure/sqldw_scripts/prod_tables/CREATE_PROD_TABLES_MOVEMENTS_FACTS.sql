

SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[MovementsFact]') )
    DROP  TABLE [prd].[MovementsFact]
GO

CREATE TABLE [prd].[MovementsFact]
WITH
(
    DISTRIBUTION = HASH([WWI Stock Item Transaction ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT CAST(sit.TransactionOccurredWhen AS date) AS [Date Key],
       sit.StockItemTransactionID AS [WWI Stock Item Transaction ID],
       sit.InvoiceID AS [WWI Invoice ID],
       sit.PurchaseOrderID AS [WWI Purchase Order ID],
       CAST(sit.Quantity AS int) AS Quantity,
       sit.StockItemID AS [WWI Stock Item ID],
       sit.CustomerID AS [WWI Customer ID],
       sit.SupplierID AS [WWI Supplier ID],
       sit.TransactionTypeID AS [WWI Transaction Type ID]
FROM [stg].[Warehouse_StockItemTransactions] AS sit
OPTION (LABEL = 'CTAS : [MovementsFact]')