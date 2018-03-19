SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_ColdRoomTemperatures') )
    DROP EXTERNAL TABLE ext.Warehouse_ColdRoomTemperatures
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_Colors') )
    DROP EXTERNAL TABLE ext.Warehouse_Colors
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_PackageTypes') )
    DROP EXTERNAL TABLE ext.Warehouse_PackageTypes
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_StockGroups') )
    DROP EXTERNAL TABLE ext.Warehouse_StockGroups
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_StockItemHoldings') )
    DROP EXTERNAL TABLE ext.Warehouse_StockItemHoldings
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_StockItems') )
    DROP EXTERNAL TABLE ext.Warehouse_StockItems
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_StockItemStockGroups') )
    DROP EXTERNAL TABLE ext.Warehouse_StockItemStockGroups
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_StockItemTransactions') )
    DROP EXTERNAL TABLE ext.Warehouse_StockItemTransactions
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Warehouse_VehicleTemperatures') )
    DROP EXTERNAL TABLE ext.Warehouse_VehicleTemperatures
GO

PRINT 'CREATING [Warehouse_ColdRoomTemperatures]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_ColdRoomTemperatures]
(
	[ColdRoomTemperatureID] [bigint]  NOT NULL,
	[ColdRoomSensorNumber] [int] NOT NULL,
	[RecordedWhen] [datetime2](7) NOT NULL,
	[Temperature] [decimal](10, 2) NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_ColdRoomTemperatures/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Warehouse_Colors]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_Colors]
(
	[ColorID] [int] NOT NULL,
	[ColorName] [nvarchar](20) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_Colors/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Warehouse_PackageTypes]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_PackageTypes]
(
	[PackageTypeID] [int] NOT NULL,
	[PackageTypeName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_PackageTypes/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Warehouse_StockGroups]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_StockGroups]
(
	[StockGroupID] [int] NOT NULL,
	[StockGroupName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_StockGroups/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Warehouse_StockItemHoldings]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_StockItemHoldings]
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
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_StockItemHoldings/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO



PRINT 'CREATING [Warehouse_StockItems]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_StockItems]
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
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_StockItems/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


PRINT 'CREATING [Warehouse_StockItemStockGroups]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_StockItemStockGroups]
(
	[StockItemStockGroupID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[StockGroupID] [int] NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_StockItemStockGroups/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO



PRINT 'CREATING [Warehouse_StockItemTransactions]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_StockItemTransactions]
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
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_StockItemTransactions/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Warehouse_VehicleTemperatures]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Warehouse_VehicleTemperatures]
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
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Warehouse_VehicleTemperatures/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

--SELECT COUNT(*) FROM [ext].[Warehouse_ColdRoomTemperatures]
--SELECT COUNT(*) FROM [ext].[Warehouse_Colors]
--SELECT COUNT(*) FROM [ext].[Warehouse_PackageTypes]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockGroups]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemHoldings]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItems]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemStockGroups]
--SELECT COUNT(*) FROM [ext].[Warehouse_StockItemTransactions]
--SELECT COUNT(*) FROM [ext].[Warehouse_VehicleTemperatures]
