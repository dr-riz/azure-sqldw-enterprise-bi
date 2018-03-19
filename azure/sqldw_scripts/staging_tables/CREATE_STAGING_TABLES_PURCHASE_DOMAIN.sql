SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Purchasing_PurchaseOrderLines') )
    DROP  TABLE stg.Purchasing_PurchaseOrderLines
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Purchasing_PurchaseOrders') )
    DROP  TABLE stg.Purchasing_PurchaseOrders
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Purchasing_SupplierCategories') )
    DROP  TABLE stg.Purchasing_SupplierCategories
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Purchasing_Suppliers') )
    DROP  TABLE stg.Purchasing_Suppliers
GO

--SupplierTransactions

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Purchasing_SupplierTransactions') )
    DROP  TABLE stg.Purchasing_SupplierTransactions
GO

PRINT 'CREATING [Purchasing_PurchaseOrderLines]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Purchasing_PurchaseOrderLines]
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
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_PurchaseOrderLines]'
GO

INSERT INTO  [stg].[Purchasing_PurchaseOrderLines] 
SELECT 
	[PurchaseOrderLineID],
	[PurchaseOrderID],
	[StockItemID] ,
	[OrderedOuters] ,
	[Description],
	[ReceivedOuters] ,
	[PackageTypeID],
	[ExpectedUnitPricePerOuter],
	[LastReceiptDate] ,
	[IsOrderLineFinalized],
	[LastEditedBy] ,
	[LastEditedWhen] 
FROM [ext].[Purchasing_PurchaseOrderLines]



PRINT 'CREATING [Purchasing_PurchaseOrders]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Purchasing_PurchaseOrders]
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
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_PurchaseOrders]'
GO

INSERT INTO  [stg].[Purchasing_PurchaseOrders] 
SELECT
	[PurchaseOrderID] ,
	[SupplierID] ,
	[OrderDate],
	[DeliveryMethodID],
	[ContactPersonID],
	[ExpectedDeliveryDate],
	[SupplierReference],
	[IsOrderFinalized] ,
	[Comments] ,
	[InternalComments] ,
	[LastEditedBy] ,
	[LastEditedWhen]
FROM [ext].[Purchasing_PurchaseOrders]


PRINT 'CREATING [Purchasing_SupplierCategories]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Purchasing_SupplierCategories]
(
	[SupplierCategoryID] [int] NOT NULL,
	[SupplierCategoryName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_SupplierCategories]'
GO

INSERT INTO  [stg].Purchasing_SupplierCategories 
SELECT

	[SupplierCategoryID],
	[SupplierCategoryName],
	[LastEditedBy] ,
	[ValidFrom],
	[ValidTo]
FROM ext.Purchasing_SupplierCategories


PRINT 'CREATING [Purchasing_Suppliers]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Purchasing_Suppliers]
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
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_Suppliers]'
GO

INSERT INTO  [stg].[Purchasing_Suppliers] 
SELECT

	[SupplierID] ,
	[SupplierName],
	[SupplierCategoryID],
	[PrimaryContactPersonID],
	[AlternateContactPersonID],
	[DeliveryMethodID],
	[DeliveryCityID],
	[PostalCityID],
	[SupplierReference],
	[BankAccountName],
	[BankAccountBranch] ,
	[BankAccountCode],
	[BankAccountNumber],
	[BankInternationalCode],
	[PaymentDays],
	[InternalComments],
	[PhoneNumber],
	[FaxNumber] ,
	[WebsiteURL],
	[DeliveryAddressLine1],
	[DeliveryAddressLine2],
	[DeliveryPostalCode],
	[DeliveryLocation] ,
	[PostalAddressLine1],
	[PostalAddressLine2],
	[PostalPostalCode],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo] 
FROM ext.[Purchasing_Suppliers]


PRINT 'CREATING [Purchasing_SupplierTransactions]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Purchasing_SupplierTransactions]
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
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_SupplierTransactions]'
GO

INSERT INTO  [stg].[Purchasing_SupplierTransactions] 
SELECT

	[SupplierTransactionID],
	[SupplierID] ,
	[TransactionTypeID],
	[PurchaseOrderID],
	[PaymentMethodID],
	[SupplierInvoiceNumber],
	[TransactionDate],
	[AmountExcludingTax],
	[TaxAmount],
	[TransactionAmount],
	[OutstandingBalance],
	[FinalizationDate],
	[IsFinalized],
	[LastEditedBy],
	[LastEditedWhen]

FROM ext.[Purchasing_SupplierTransactions]


PRINT 'ALL DONE'
--GO