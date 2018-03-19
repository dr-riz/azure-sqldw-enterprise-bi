SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[StockItemHoldingFacts]') )
    DROP  TABLE [prd].[StockItemHoldingFacts]
GO

CREATE TABLE [prd].[StockItemHoldingFacts]
WITH
(
    DISTRIBUTION = HASH([WWI Stock Item ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT 
       sih.StockItemID AS [WWI Stock Item ID],
	   sih.QuantityOnHand AS [Quantity On Hand],
       sih.BinLocation AS [Bin Location],
       sih.LastStocktakeQuantity AS [Last Stocktake Quantity],
       sih.LastCostPrice AS [Last Cost Price],
       sih.ReorderLevel AS [Reorder Level],
       sih.TargetStockLevel AS [Target Stock Level]
FROM [stg].[Warehouse_StockItemHoldings] AS sih
OPTION (LABEL = 'CTAS : [StockItemHoldingFacts]')