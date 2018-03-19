SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[StockItemDimensions]') )
    DROP  TABLE [prd].[StockItemDimensions]
GO

CREATE TABLE [prd].[StockItemDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT si.StockItemID AS [WWI Stock Item ID],
       si.StockItemName AS [Stock Item],
	   ISNULL(c.ColorName, N'N/A') AS Color,
	   spt.PackageTypeName AS [Selling Package],
       bpt.PackageTypeName AS [Buying Package],
	   ISNULL(si.Brand, N'N/A') AS Brand,
	   ISNULL(si.Size, N'N/A') AS Size,
	   si.LeadTimeDays AS [Lead Time Days],
	   si.QuantityPerOuter AS [Quantity Per Outer],
       si.IsChillerStock AS [Is Chiller Stock],
	   ISNULL(si.Barcode, N'N/A') AS Barcode,
	   si.TaxRate AS [Tax Rate],
	   si.UnitPrice AS [Unit Price],
	   si.RecommendedRetailPrice AS [Recommended Retail Price],
       si.TypicalWeightPerUnit AS [Typical Weight Per Unit],
	   si.Photo AS Photo,
	   si.ValidFrom AS [Valid From],
	   si.ValidTo AS [Valid To]
FROM [stg].[Warehouse_StockItems] si
INNER JOIN [stg].[Warehouse_PackageTypes] AS spt
ON si.UnitPackageID = spt.PackageTypeID
INNER JOIN [stg].[Warehouse_PackageTypes] AS bpt
ON si.OuterPackageID = bpt.PackageTypeID
LEFT OUTER JOIN [stg].[Warehouse_Colors] AS c
ON si.ColorID = c.ColorID
OPTION (LABEL = 'CTAS : [StockItemDimensions]')