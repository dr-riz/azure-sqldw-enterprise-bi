SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Purchasing_PurchaseOrderLines') )
    DROP EXTERNAL TABLE ext.Purchasing_PurchaseOrderLines
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Purchasing_PurchaseOrders') )
    DROP EXTERNAL TABLE ext.Purchasing_PurchaseOrders
GO


IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Purchasing_SupplierCategories') )
    DROP EXTERNAL TABLE ext.Purchasing_SupplierCategories
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Purchasing_Suppliers') )
    DROP EXTERNAL TABLE ext.Purchasing_Suppliers
GO

--SupplierTransactions

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Purchasing_SupplierTransactions') )
    DROP EXTERNAL TABLE ext.Purchasing_SupplierTransactions
GO

PRINT 'CREATING [Purchasing_PurchaseOrderLines]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Purchasing_PurchaseOrderLines]
(
	[PurchaseOrderLineID] [int] NOT NULL,
	[PurchaseOrderID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[OrderedOuters] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[ReceivedOuters] [int] NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[ExpectedUnitPricePerOuter] [decimal](18, 2) NULL,
	[LastReceiptDate] [date] NULL,
	[IsOrderLineFinalized] [bit] NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Purchasing_PurchaseOrderLines/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


PRINT 'CREATING [Purchasing_PurchaseOrders]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Purchasing_PurchaseOrders]
(
	[PurchaseOrderID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[ContactPersonID] [int] NOT NULL,
	[ExpectedDeliveryDate] [date] NULL,
	[SupplierReference] [nvarchar](20) NULL,
	[IsOrderFinalized] [bit] NOT NULL,
	[Comments] [nvarchar](4000) NULL,
	[InternalComments] [nvarchar](4000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Purchasing_PurchaseOrders/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Purchasing_SupplierCategories]'
GO


--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Purchasing_SupplierCategories]
(
	[SupplierCategoryID] [int] NOT NULL,
	[SupplierCategoryName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Purchasing_SupplierCategories/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Purchasing_Suppliers]'
GO


--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Purchasing_Suppliers]
(
	[SupplierID] [int] NOT NULL,
	[SupplierName] [nvarchar](100) NOT NULL,
	[SupplierCategoryID] [int] NOT NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NOT NULL,
	[DeliveryMethodID] [int] NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[SupplierReference] [nvarchar](20) NULL,
	[BankAccountName] [nvarchar](50) NULL,
	[BankAccountBranch] [nvarchar](50) NULL,
	[BankAccountCode] [nvarchar](20) NULL,
	[BankAccountNumber] [nvarchar](20)  NULL,
	[BankInternationalCode] [nvarchar](20) NULL,
	[PaymentDays] [int] NOT NULL,
	[InternalComments] [nvarchar](4000) NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[FaxNumber] [nvarchar](20) NOT NULL,
	[WebsiteURL] [nvarchar](256) NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) NULL,
	[DeliveryPostalCode] [nvarchar](10) NOT NULL,
	[DeliveryLocation] [varbinary](8000) NULL,
	[PostalAddressLine1] [nvarchar](60) NOT NULL,
	[PostalAddressLine2] [nvarchar](60) NULL,
	[PostalPostalCode] [nvarchar](10) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Purchasing_Suppliers/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


PRINT 'CREATING [Purchasing_SupplierTransactions]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Purchasing_SupplierTransactions]
(
	[SupplierTransactionID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[TransactionTypeID] [int] NOT NULL,
	[PurchaseOrderID] [int] NULL,
	[PaymentMethodID] [int] NULL,
	[SupplierInvoiceNumber] [nvarchar](20) NULL,
	[TransactionDate] [date] NOT NULL,
	[AmountExcludingTax] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
	[OutstandingBalance] [decimal](18, 2) NOT NULL,
	[FinalizationDate] [date] NULL,
	[IsFinalized] bit,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Purchasing_SupplierTransactions/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'ALL DONE'
--GO