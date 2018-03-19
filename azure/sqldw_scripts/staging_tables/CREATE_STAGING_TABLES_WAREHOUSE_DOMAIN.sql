SET ANSI_NULLS ON
GO

-- SECTION TO DROP  TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_ColdRoomTemperatures') )
    DROP  TABLE stg.Warehouse_ColdRoomTemperatures
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_Colors') )
    DROP  TABLE stg.Warehouse_Colors
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_PackageTypes') )
    DROP  TABLE stg.Warehouse_PackageTypes
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_StockGroups') )
    DROP  TABLE stg.Warehouse_StockGroups
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_StockItemHoldings') )
    DROP  TABLE stg.Warehouse_StockItemHoldings
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_StockItems') )
    DROP  TABLE stg.Warehouse_StockItems
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_StockItemStockGroups') )
    DROP  TABLE stg.Warehouse_StockItemStockGroups
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_StockItemTransactions') )
    DROP  TABLE stg.Warehouse_StockItemTransactions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Warehouse_VehicleTemperatures') )
    DROP  TABLE stg.Warehouse_VehicleTemperatures
GO

PRINT 'CREATING [Warehouse_ColdRoomTemperatures]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_ColdRoomTemperatures]
(
	[ColdRoomTemperatureID] [bigint]  NOT NULL,
	[ColdRoomSensorNumber] [int] NOT NULL,
	[RecordedWhen] [datetime2](7) NOT NULL,
	[Temperature] [decimal](10, 2) NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_ColdRoomTemperatures]'
GO

INSERT INTO  [stg].[Warehouse_ColdRoomTemperatures] 
SELECT

	[ColdRoomTemperatureID] ,
	[ColdRoomSensorNumber] ,
	[RecordedWhen] ,
	[Temperature] ,
	[ValidFrom] ,
	[ValidTo] 
FROM [ext].[Warehouse_ColdRoomTemperatures] 

PRINT 'CREATING [Warehouse_Colors]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_Colors]
(
	[ColorID] [int] NOT NULL,
	[ColorName] [nvarchar](20) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_Colors]'
GO

INSERT INTO  [stg].[Warehouse_Colors] 
SELECT
	[ColorID] ,
	[ColorName],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM [ext].[Warehouse_Colors] 


PRINT 'CREATING [Warehouse_PackageTypes]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_PackageTypes]
(
	[PackageTypeID] [int] NOT NULL,
	[PackageTypeName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_PackageTypes]'
GO

INSERT INTO  [stg].[Warehouse_PackageTypes] 
SELECT
	[PackageTypeID],
	[PackageTypeName],
	[LastEditedBy] ,
	[ValidFrom] ,
	[ValidTo]
FROM [ext].[Warehouse_PackageTypes]

PRINT 'CREATING [Warehouse_StockGroups]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_StockGroups]
(
	[StockGroupID] [int] NOT NULL,
	[StockGroupName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_StockGroups]'
GO

INSERT INTO  [stg].[Warehouse_StockGroups] 
SELECT
	[StockGroupID],
	[StockGroupName] ,
	[LastEditedBy],
	[ValidFrom] ,
	[ValidTo] 
FROM [ext].[Warehouse_StockGroups]

PRINT 'CREATING [Warehouse_StockItemHoldings]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_StockItemHoldings]
(
	[StockItemID] [int] NOT NULL,
	[QuantityOnHand] [int] NOT NULL,
	[BinLocation] [nvarchar](20) NOT NULL,
	[LastStocktakeQuantity] [int] NOT NULL,
	[LastCostPrice] [decimal](18, 2) NOT NULL,
	[ReorderLevel] [int] NOT NULL,
	[TargetStockLevel] [int] NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_StockItemHoldings]'
GO

INSERT INTO  [stg].[Warehouse_StockItemHoldings] 
SELECT
	[StockItemID] ,
	[QuantityOnHand],
	[BinLocation] ,
	[LastStocktakeQuantity] ,
	[LastCostPrice] ,
	[ReorderLevel] ,
	[TargetStockLevel] ,
	[LastEditedBy] ,
	[LastEditedWhen] 
FROM [ext].[Warehouse_StockItemHoldings]


PRINT 'CREATING [Warehouse_StockItems]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_StockItems]
(
	[StockItemID] [int] NOT NULL,
	[StockItemName] [nvarchar](100) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ColorID] [int] NULL,
	[UnitPackageID] [int] NOT NULL,
	[OuterPackageID] [int] NOT NULL,
	[Brand] [nvarchar](50) NULL,
	[Size] [nvarchar](20) NULL,
	[LeadTimeDays] [int] NOT NULL,
	[QuantityPerOuter] [int] NOT NULL,
	[IsChillerStock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL,
	[TypicalWeightPerUnit] [decimal](18, 3) NOT NULL,
	[MarketingComments] [nvarchar](4000) NULL,
	[InternalComments] [nvarchar](4000) NULL,
	[Photo] [varbinary](8000) NULL,
	[CustomFields] [nvarchar](4000) NULL,
	[Tags] [nvarchar](4000) NULL,
	[SearchDetails] [nvarchar](4000) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_StockItems]'
GO

INSERT INTO  [stg].[Warehouse_StockItems] 
SELECT
	[StockItemID],
	[StockItemName] ,
	[SupplierID],
	[ColorID],
	[UnitPackageID],
	[OuterPackageID] ,
	[Brand],
	[Size] ,
	[LeadTimeDays] ,
	[QuantityPerOuter] ,
	[IsChillerStock],
	[Barcode] ,
	[TaxRate] ,
	[UnitPrice],
	[RecommendedRetailPrice] ,
	[TypicalWeightPerUnit],
	[MarketingComments],
	[InternalComments] ,
	[Photo] ,
	[CustomFields] ,
	[Tags] ,
	[SearchDetails],
	[LastEditedBy],
	[ValidFrom] ,
	[ValidTo] 
FROM [ext].[Warehouse_StockItems]

PRINT 'CREATING [Warehouse_StockItemStockGroups]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_StockItemStockGroups]
(
	[StockItemStockGroupID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[StockGroupID] [int] NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_StockItemStockGroups]'
GO

INSERT INTO  [stg].[Warehouse_StockItemStockGroups] 
SELECT
	[StockItemStockGroupID] ,
	[StockItemID] ,
	[StockGroupID],
	[LastEditedBy],
	[LastEditedWhen]
FROM [ext].[Warehouse_StockItemStockGroups]



PRINT 'CREATING [Warehouse_StockItemTransactions]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_StockItemTransactions]
(
	[StockItemTransactionID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[TransactionTypeID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[InvoiceID] [int] NULL,
	[SupplierID] [int] NULL,
	[PurchaseOrderID] [int] NULL,
	[TransactionOccurredWhen] [datetime2](7) NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_StockItemTransactions]'
GO

INSERT INTO  [stg].[Warehouse_StockItemTransactions] 
SELECT
	[StockItemTransactionID] ,
	[StockItemID],
	[TransactionTypeID],
	[CustomerID],
	[InvoiceID] ,
	[SupplierID],
	[PurchaseOrderID] ,
	[TransactionOccurredWhen] ,
	[Quantity],
	[LastEditedBy] ,
	[LastEditedWhen]
FROM [ext].[Warehouse_StockItemTransactions]

PRINT 'CREATING [Warehouse_VehicleTemperatures]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Warehouse_VehicleTemperatures]
(
	[VehicleTemperatureID] [bigint]  NOT NULL,
	[VehicleRegistration] [nvarchar](20)  NOT NULL,
	[ChillerSensorNumber] [int] NOT NULL,
	[RecordedWhen] [datetime2](7) NOT NULL,
	[Temperature] [decimal](10, 2) NOT NULL,
	[FullSensorData] [nvarchar](1000)  NULL,
	[IsCompressed] [bit] NOT NULL,
	[CompressedSensorData] [varbinary](8000) NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Warehouse_VehicleTemperatures]'
GO

INSERT INTO  [stg].[Warehouse_VehicleTemperatures] 
SELECT
	[VehicleTemperatureID],
	[VehicleRegistration] ,
	[ChillerSensorNumber] ,
	[RecordedWhen] ,
	[Temperature] ,
	[FullSensorData] ,
	[IsCompressed],
	[CompressedSensorData] 
FROM [ext].[Warehouse_VehicleTemperatures]
--SELECT COUNT(*) FROM[stg].[Warehouse_ColdRoomTemperatures]
--SELECT COUNT(*) FROM [ext].[Warehouse_Colors]
--SELECT COUNT(*) FROM [ext].[Warehouse_PackageTypes]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockGroups]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemHoldings]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItems]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemStockGroups]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemTransactions]
--SELECT COUNT(*) FROM [ext].[Warehouse_VehicleTemperatures]
