SET ANSI_NULLS ON
GO

-- SECTION TO DROP STAGING TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.DateDimensions') )
    DROP  TABLE stg.DateDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.CityDimensions') )
    DROP  TABLE stg.CityDimensions
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.CustomerDimensions') )
    DROP  TABLE stg.CustomerDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.EmployeeDimensions') )
    DROP  TABLE stg.EmployeeDimensions
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.PaymentDimensions') )
    DROP  TABLE stg.PaymentDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.StockItemDimensions') )
    DROP  TABLE stg.StockItemDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.SupplierDimensions') )
    DROP  TABLE stg.SupplierDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.TransactionrDimensions') )
    DROP  TABLE stg.TransactionrDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.MovementsFact') )
    DROP  TABLE stg.MovementsFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.OrdersFact') )
    DROP  TABLE stg.OrdersFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.SalesFact') )
    DROP  TABLE stg.SalesFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.PurchasesFact') )
    DROP  TABLE stg.PurchasesFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.StockHoldingsFact') )
    DROP  TABLE stg.StockHoldingsFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.TransactionsFact') )
    DROP  TABLE stg.TransactionsFact
GO

-- SECTION TO DROP AND CREATE SCHEMA 
IF  EXISTS (SELECT 1 FROM sys.schemas where name = 'stg')
BEGIN
	DROP SCHEMA stg ;
END
GO 

CREATE SCHEMA stg
GO



--SECITON TO CREATE  TABLES 
CREATE  TABLE [stg].[DateDimensions]
(
    [Date] [datetime2](7) NOT NULL,
    [DateKey] [int] NOT NULL,
    [Day Number] [int] NOT NULL,
    [Day] [nvarchar](10) NOT NULL,
    [Day of Year] [nvarchar](5) NOT NULL,
    [Day of Year Number] [int] NOT NULL,
    [Day of Week] [nvarchar](20) NOT NULL,
    [Day of Week Number] [int] NOT NULL,
    [Week of Year] [nvarchar](5) NOT NULL,
    [Month] [nvarchar](10) NOT NULL,
    [Short Month] [nvarchar](3) NOT NULL,
    [Quarter] [nvarchar](2) NOT NULL,
    [Half of Year] [nvarchar](3) NOT NULL,
    [Beginning of Month] [date] NOT NULL,
    [Beginning of Quarter] [date] NOT NULL,
    [Beginning of Half Year] [date] NOT NULL,
    [Beginning of Year] [date] NOT NULL,
    [Beginning of Month Label] [nvarchar](40) NOT NULL,
    [Beginning of Month Label Short] [nvarchar](40) NOT NULL,
    [Beginning of Quarter Label] [nvarchar](40) NOT NULL,
    [Beginning of Quarter Label Short] [nvarchar](40) NOT NULL,
    [Beginning of Half Year Label] [nvarchar](40) NOT NULL,
    [Beginning of Half Year Label Short] [nvarchar](40) NOT NULL,
    [Beginning of Year Label] [nvarchar](40) NOT NULL,
    [Beginning of Year Label Short] [nvarchar](40) NOT NULL,
    [Calendar Day Label] [nvarchar](20) NOT NULL,
    [Calendar Day Label Short] [nvarchar](20) NOT NULL,
    [Calendar Week Number] [int] NOT NULL,
    [Calendar Week Label] [nvarchar](20) NOT NULL,
    [Calendar Month Number] [int] NOT NULL,
    [Calendar Month Label] [nvarchar](20) NOT NULL,
    [Calendar Month Year Label] [nvarchar](20) NOT NULL,
    [Calendar Quarter Number] [int] NOT NULL,
    [Calendar Quarter Label] [nvarchar](20) NOT NULL,
    [Calendar Quarter Year Label] [nvarchar](20) NOT NULL,
    [Calendar Half of Year Number] [int] NOT NULL,
    [Calendar Half of Year Label] [nvarchar](20) NOT NULL,
    [Calendar Year Half of Year Label] [nvarchar](20) NOT NULL,
    [Calendar Year] [int] NOT NULL,
    [Calendar Year Label] [nvarchar](10) NOT NULL,
    [Fiscal Month Number] [int] NOT NULL,
    [Fiscal Month Label] [nvarchar](20) NOT NULL,
    [Fiscal Quarter Number] [int] NOT NULL,
    [Fiscal Quarter Label] [nvarchar](20) NOT NULL,
    [Fiscal Half of Year Number] [int] NOT NULL,
    [Fiscal Half of Year Label] [nvarchar](20) NOT NULL,
    [Fiscal Year] [int] NOT NULL,
    [Fiscal Year Label] [nvarchar](10) NOT NULL,
    [Date Key] [int] NOT NULL,
    [Year Week Key] [int] NOT NULL,
    [Year Month Key] [int] NOT NULL,
    [Year Quarter Key] [int] NOT NULL,
    [Year Half of Year Key] [int] NOT NULL,
    [Year Key] [int] NOT NULL,
    [Beginning of Month Key] [int] NOT NULL,
    [Beginning of Quarter Key] [int] NOT NULL,
    [Beginning of Half Year Key] [int] NOT NULL,
    [Beginning of Year Key] [int] NOT NULL,
    [Fiscal Year Month Key] [int] NOT NULL,
    [Fiscal Year Quarter Key] [int] NOT NULL,
    [Fiscal Year Half of Year Key] [int] NOT NULL,
    [ISO Week Number] [int] NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[DateDimensions] SELECT * FROM [ext].[DateDimensions];
GO

CREATE  TABLE [stg].[CityDimensions]
(
	[WWI City ID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State Province] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](60) NOT NULL,
	[Continent] [nvarchar](30) NOT NULL,
	[Sales Territory] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](30) NOT NULL,
	[Subregion] [nvarchar](30) NOT NULL,
	[Location] [varbinary](4000) NULL,
	[Latest Recorded Population] [bigint] NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[CityDimensions] SELECT * FROM [ext].[CityDimensions];
GO
	

CREATE  TABLE [stg].[CustomerDimensions]
(
	[WWI Customer ID] [int] NOT NULL,
	[Customer] [nvarchar](100) NOT NULL,
	[Bill To Customer] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Buying Group] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[CustomerDimensions] SELECT * FROM [ext].[CustomerDimensions];
GO

CREATE  TABLE [stg].[EmployeeDimensions]
(
	[WWI Employee ID] [int] NOT NULL,
	[Employee] [nvarchar](50) NOT NULL,
	[Preferred Name] [nvarchar](50) NOT NULL,
	[Is Salesperson] [bit] NOT NULL,
	[Photo] [varbinary](4000) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[EmployeeDimensions] SELECT * FROM [ext].[EmployeeDimensions];
GO

CREATE  TABLE [stg].[PaymentDimensions]
(
	[WWI Payment Method ID] int,
	[Payment Method] nvarchar(50),
	[Valid From] datetime2(7),
	[Valid To] datetime2(7)
)
WITH (HEAP);
GO

INSERT INTO [stg].[PaymentDimensions] SELECT * FROM [ext].[PaymentDimensions];
GO

CREATE  TABLE [stg].[StockItemDimensions]
(
    [WWI Stock Item ID] [int] NOT NULL,
    [Stock Item] [nvarchar](100) NOT NULL,
    [Color] [nvarchar](20) NOT NULL,
    [Selling Package] [nvarchar](50) NOT NULL,
    [Buying Package] [nvarchar](50) NOT NULL,
    [Brand] [nvarchar](50) NOT NULL,
    [Size] [nvarchar](20) NOT NULL,
    [Lead Time Days] [int] NOT NULL,
    [Quantity Per Outer] [int] NOT NULL,
    [Is Chiller Stock] [bit] NOT NULL,
    [Barcode] [nvarchar](50) NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Recommended Retail Price] [decimal](18, 2) NULL,
    [Typical Weight Per Unit] [decimal](18, 3) NOT NULL,
    [Photo] [varbinary](4000) NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL

)
WITH (HEAP);
GO

INSERT INTO [stg].[StockItemDimensions] SELECT * FROM [ext].[StockItemDimensions];
GO



CREATE  TABLE [stg].[SupplierDimensions]
(
    [WWI Supplier ID] [int] NOT NULL,
    [Supplier] [nvarchar](100) NOT NULL,
    [Category] [nvarchar](50) NOT NULL,
    [Primary Contact] [nvarchar](50) NOT NULL,
    [Supplier Reference] [nvarchar](20) NULL,
    [Payment Days] [int] NOT NULL,
    [Postal Code] [nvarchar](10) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO


INSERT INTO [stg].[SupplierDimensions] SELECT * FROM [ext].[SupplierDimensions];
GO

CREATE  TABLE [stg].[TransactionrDimensions]
(
    [WWI Transaction Type ID] [int] NOT NULL,
    [Transaction Type] [nvarchar](50) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[TransactionrDimensions] SELECT * FROM [ext].[TransactionrDimensions];
GO

CREATE  TABLE [stg].[MovementsFact]
(
    [Date Key] [date] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Customer Key] [int] NULL,
    [Supplier Key] [int] NULL,
    [Transaction Type Key] [int] NOT NULL,
    [WWI Stock Item Transaction ID] [int] NOT NULL,
    [WWI Invoice ID] [int] NULL,
    [WWI Purchase Order ID] [int] NULL,
    [Quantity] [int] NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[MovementsFact] SELECT * FROM [ext].[MovementsFact];
GO


CREATE  TABLE [stg].[OrdersFact]
(
    [City Key] [int] NOT NULL,
    [Customer Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Order Date Key] [date] NOT NULL,
    [Picked Date Key] [date] NULL,
    [Salesperson Key] [int] NOT NULL,
    [Picker Key] [int] NULL,
    [WWI Order ID] [int] NOT NULL,
    [WWI Backorder ID] [int] NULL,
    [Description] [nvarchar](100) NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Quantity] [int] NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Total Excluding Tax] [decimal](18, 2) NOT NULL,
    [Tax Amount] [decimal](18, 2) NOT NULL,
    [Total Including Tax] [decimal](18, 2) NOT NULL
)
WITH (HEAP);
GO


INSERT INTO [stg].[OrdersFact] SELECT * FROM [ext].[OrdersFact];
GO

CREATE  TABLE [stg].[PurchasesFact]
(
    [Date Key] [date] NOT NULL,
    [Supplier Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [WWI Purchase Order ID] [int] NULL,
    [Ordered Outers] [int] NOT NULL,
    [Ordered Quantity] [int] NOT NULL,
    [Received Outers] [int] NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Is Order Finalized] [bit] NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[PurchasesFact] SELECT * FROM [ext].[PurchasesFact];
GO

CREATE  TABLE [stg].[SalesFact]
(
    [City Key] [int] NOT NULL,
    [Customer Key] [int] NOT NULL,
    [Bill To Customer Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Invoice Date Key] [date] NOT NULL,
    [Delivery Date Key] [date] NULL,
    [Salesperson Key] [int] NOT NULL,
    [WWI Invoice ID] [int] NOT NULL,
    [Description] [nvarchar](100) NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Quantity] [int] NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Total Excluding Tax] [decimal](18, 2) NOT NULL,
    [Tax Amount] [decimal](18, 2) NOT NULL,
    [Profit] [decimal](18, 2) NOT NULL,
    [Total Including Tax] [decimal](18, 2) NOT NULL,
    [Total Dry Items] [int] NOT NULL,
    [Total Chiller Items] [int] NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[SalesFact] SELECT * FROM [ext].[SalesFact];
GO

CREATE  TABLE [stg].[StockHoldingsFact]
(
    [Stock Item Key] [int] NOT NULL,
    [Quantity On Hand] [int] NOT NULL,
    [Bin Location] [nvarchar](20) NOT NULL,
    [Last Stocktake Quantity] [int] NOT NULL,
    [Last Cost Price] [decimal](18, 2) NOT NULL,
    [Reorder Level] [int] NOT NULL,
    [Target Stock Level] [int] NOT NULL 
)
WITH (HEAP);
GO

INSERT INTO [stg].[StockHoldingsFact] SELECT * FROM [ext].[StockHoldingsFact];
GO

CREATE  TABLE [stg].[TransactionsFact]
(
	[Date Key] [date] NOT NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NOT NULL,
	[Payment Method Key] [int] NULL,
	[WWI Customer Transaction ID] [int] NULL,
	[WWI Supplier Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Supplier Invoice Number] [nvarchar](20) NULL,
	[Total Excluding Tax] [decimal](18, 2) NOT NULL,
	[Tax Amount] [decimal](18, 2) NOT NULL,
	[Total Including Tax] [decimal](18, 2) NOT NULL,
	[Outstanding Balance] [decimal](18, 2) NOT NULL,
	[Is Finalized] [bit] NOT NULL
)
WITH (HEAP);
GO

INSERT INTO [stg].[TransactionsFact] SELECT * FROM [ext].[TransactionsFact];
GO
