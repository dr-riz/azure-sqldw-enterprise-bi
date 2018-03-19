SET ANSI_NULLS ON
GO

-- SECTION TO DROP  TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_BuyingGroups') )
    DROP  TABLE stg.Sales_BuyingGroups
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_CustomerCategories') )
    DROP  TABLE stg.Sales_CustomerCategories
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_Customers') )
    DROP  TABLE stg.Sales_Customers
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_CustomerTransactions') )
    DROP  TABLE stg.Sales_CustomerTransactions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_InvoiceLines') )
    DROP  TABLE stg.Sales_InvoiceLines
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_Invoices') )
    DROP  TABLE stg.Sales_Invoices
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_OrderLines') )
    DROP  TABLE stg.Sales_OrderLines
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_Orders') )
    DROP  TABLE stg.Sales_Orders
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Sales_SpecialDeals') )
    DROP  TABLE stg.Sales_SpecialDeals
GO


PRINT 'CREATING [Sales_BuyingGroups]'
GO

CREATE  TABLE [stg].[Sales_BuyingGroups]
(
	[BuyingGroupID] [int] NOT NULL,
	[BuyingGroupName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Purchasing_PurchaseOrderLines]'
GO

INSERT INTO  [stg].[Sales_BuyingGroups] 
SELECT
	[BuyingGroupID] ,
	[BuyingGroupName],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM  [ext].[Sales_BuyingGroups] 



PRINT 'CREATING [Sales_CustomerCategories]'
GO

CREATE  TABLE [stg].[Sales_CustomerCategories]
(
	[CustomerCategoryID] [int] NOT NULL,
	[CustomerCategoryName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_CustomerCategories]'
GO

INSERT INTO  [stg].[Sales_CustomerCategories] 
SELECT
	[CustomerCategoryID],
	[CustomerCategoryName],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM [ext].[Sales_CustomerCategories] 



PRINT 'CREATING [Sales_Customers]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_Customers]
(
	[CustomerID] [int] NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[CustomerCategoryID] [int] NOT NULL,
	[BuyingGroupID] [int] NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[CreditLimit] [decimal](18, 2) NULL,
	[AccountOpenedDate] [date] NOT NULL,
	[StandardDiscountPercentage] [decimal](18, 3) NOT NULL,
	[IsStatementSent] [bit] NOT NULL,
	[IsOnCreditHold] [bit] NOT NULL,
	[PaymentDays] [int] NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[FaxNumber] [nvarchar](20) NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[WebsiteURL] [nvarchar](256) NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) NULL,
	[DeliveryPostalCode] [nvarchar](10) NOT NULL,
	[DeliveryLocation] varbinary(8000) NULL,
	[PostalAddressLine1] [nvarchar](60) NOT NULL,
	[PostalAddressLine2] [nvarchar](60) NULL,
	[PostalPostalCode] [nvarchar](10) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_Customers]'
GO

INSERT INTO  [stg].[Sales_Customers] 
SELECT
	[CustomerID],
	[CustomerName] ,
	[BillToCustomerID],
	[CustomerCategoryID],
	[BuyingGroupID],
	[PrimaryContactPersonID],
	[AlternateContactPersonID],
	[DeliveryMethodID],
	[DeliveryCityID],
	[PostalCityID],
	[CreditLimit],
	[AccountOpenedDate],
	[StandardDiscountPercentage],
	[IsStatementSent] ,
	[IsOnCreditHold] ,
	[PaymentDays] ,
	[PhoneNumber],
	[FaxNumber],
	[DeliveryRun],
	[RunPosition],
	[WebsiteURL] ,
	[DeliveryAddressLine1],
	[DeliveryAddressLine2],
	[DeliveryPostalCode] ,
	[DeliveryLocation],
	[PostalAddressLine1],
	[PostalAddressLine2],
	[PostalPostalCode],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM  [ext].[Sales_Customers] 


PRINT 'CREATING [Sales_CustomerTransactions]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_CustomerTransactions]
(
	[CustomerTransactionID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[TransactionTypeID] [int] NOT NULL,
	[InvoiceID] [int] NULL,
	[PaymentMethodID] [int] NULL,
	[TransactionDate] [date] NOT NULL,
	[AmountExcludingTax] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
	[OutstandingBalance] [decimal](18, 2) NOT NULL,
	[FinalizationDate] [date] NULL,
	[IsFinalized]  bit,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_CustomerTransactions]'
GO

INSERT INTO  [stg].[Sales_CustomerTransactions] 
SELECT
	[CustomerTransactionID] ,
	[CustomerID],
	[TransactionTypeID],
	[InvoiceID],
	[PaymentMethodID],
	[TransactionDate],
	[AmountExcludingTax],
	[TaxAmount],
	[TransactionAmount],
	[OutstandingBalance],
	[FinalizationDate],
	[IsFinalized],
	[LastEditedBy],
	[LastEditedWhen]
FROM  [stg].[Sales_CustomerTransactions] 

PRINT 'CREATING [Sales_InvoiceLines]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_InvoiceLines]
(
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_InvoiceLines]'
GO

INSERT INTO  [stg].[Sales_InvoiceLines] 
SELECT
	[InvoiceLineID] ,
	[InvoiceID],
	[StockItemID],
	[Description],
	[PackageTypeID],
	[Quantity] ,
	[UnitPrice],
	[TaxRate] ,
	[TaxAmount],
	[LineProfit],
	[ExtendedPrice],
	[LastEditedBy],
	[LastEditedWhen]
FROM  [ext].[Sales_InvoiceLines] 

PRINT 'CREATING [Sales_InvoiceLines]'
GO
--Sales_Invoices

PRINT 'CREATING [Sales_Invoices]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_Invoices]
(
	[InvoiceID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[OrderID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[ContactPersonID] [int] NOT NULL,
	[AccountsPersonID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PackedByPersonID] [int] NOT NULL,
	[InvoiceDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsCreditNote] [bit] NOT NULL,
	[CreditNoteReason] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL,
	[DeliveryInstructions] [nvarchar](4000) NULL,
	[InternalComments] [nvarchar](4000) NULL,
	[TotalDryItems] [int] NOT NULL,
	[TotalChillerItems] [int] NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[ReturnedDeliveryData] [nvarchar](4000) NULL,
	[ConfirmedDeliveryTime] [datetime2](7)  NULL,
	[ConfirmedReceivedBy]  [nvarchar](4000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_Invoices]'
GO

INSERT INTO  [stg].[Sales_Invoices] 
SELECT
	[InvoiceID] ,
	[CustomerID],
	[BillToCustomerID],
	[OrderID] ,
	[DeliveryMethodID],
	[ContactPersonID] ,
	[AccountsPersonID],
	[SalespersonPersonID] ,
	[PackedByPersonID] ,
	[InvoiceDate],
	[CustomerPurchaseOrderNumber] ,
	[IsCreditNote] ,
	[CreditNoteReason] ,
	[Comments],
	[DeliveryInstructions] ,
	[InternalComments] ,
	[TotalDryItems],
	[TotalChillerItems] ,
	[DeliveryRun] ,
	[RunPosition] ,
	[ReturnedDeliveryData] ,
	[ConfirmedDeliveryTime],
	[ConfirmedReceivedBy] ,
	[LastEditedBy] ,
	[LastEditedWhen]
FROM [ext].[Sales_Invoices]



PRINT 'CREATING [Sales_OrderLines]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_OrderLines]
(
	[OrderLineID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[PickedQuantity] [int] NOT NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_OrderLines]'
GO

INSERT INTO  [stg].[Sales_OrderLines]
SELECT
	[OrderLineID],
	[OrderID] ,
	[StockItemID] ,
	[Description] ,
	[PackageTypeID],
	[Quantity] ,
	[UnitPrice],
	[TaxRate],
	[PickedQuantity] ,
	[PickingCompletedWhen],
	[LastEditedBy],
	[LastEditedWhen]
FROM [ext].[Sales_OrderLines]

PRINT 'CREATING [Sales_Orders]'
GO

--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Sales_Orders]
(
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PickedByPersonID] [int] NULL,
	[ContactPersonID] [int] NOT NULL,
	[BackorderOrderID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ExpectedDeliveryDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsUndersupplyBackordered] [bit] NOT NULL,
	[Comments] [nvarchar](4000) NULL,
	[DeliveryInstructions] [nvarchar](4000) NULL,
	[InternalComments] [nvarchar](4000) NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_Orders]'
GO

INSERT INTO  [stg].[Sales_Orders]
SELECT
	[OrderID] ,
	[CustomerID],
	[SalespersonPersonID] ,
	[PickedByPersonID],
	[ContactPersonID] ,
	[BackorderOrderID],
	[OrderDate],
	[ExpectedDeliveryDate],
	[CustomerPurchaseOrderNumber],
	[IsUndersupplyBackordered],
	[Comments] ,
	[DeliveryInstructions],
	[InternalComments],
	[PickingCompletedWhen] ,
	[LastEditedBy],
	[LastEditedWhen] 
FROM [ext].[Sales_Orders]


PRINT 'CREATING [Sales_SpecialDeals]'
GO
CREATE  TABLE [stg].[Sales_SpecialDeals]
(
	[SpecialDealID] [int] NOT NULL,
	[StockItemID] [int] NULL,
	[CustomerID] [int] NULL,
	[BuyingGroupID] [int] NULL,
	[CustomerCategoryID] [int] NULL,
	[StockGroupID] [int] NULL,
	[DealDescription] [nvarchar](30) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 3) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Sales_SpecialDeals]'
GO

INSERT INTO  [stg].[Sales_SpecialDeals]
SELECT
	[SpecialDealID] ,
	[StockItemID] ,
	[CustomerID] ,
	[BuyingGroupID],
	[CustomerCategoryID] ,
	[StockGroupID] ,
	[DealDescription] ,
	[StartDate],
	[EndDate] ,
	[DiscountAmount] ,
	[DiscountPercentage] ,
	[UnitPrice] ,
	[LastEditedBy] ,
	[LastEditedWhen]
FROM [ext].[Sales_SpecialDeals]