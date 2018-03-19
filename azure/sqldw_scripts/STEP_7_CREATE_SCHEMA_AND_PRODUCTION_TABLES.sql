SET ANSI_NULLS ON
GO

-- SECTION TO DROP PROD TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.DateDimensions') )
    DROP  TABLE prd.DateDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.CityDimensions') )
    DROP  TABLE prd.CityDimensions
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.CustomerDimensions') )
    DROP  TABLE prd.CustomerDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.EmployeeDimensions') )
    DROP  TABLE prd.EmployeeDimensions
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.PaymentDimensions') )
    DROP  TABLE prd.PaymentDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.StockItemDimensions') )
    DROP  TABLE prd.StockItemDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.SupplierDimensions') )
    DROP  TABLE prd.SupplierDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.TransactionrDimensions') )
    DROP  TABLE prd.TransactionrDimensions
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.MovementsFact') )
    DROP  TABLE prd.MovementsFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.OrdersFact') )
    DROP  TABLE prd.OrdersFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.SalesFact') )
    DROP  TABLE prd.SalesFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.PurchasesFact') )
    DROP  TABLE prd.PurchasesFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.StockHoldingsFact') )
    DROP  TABLE prd.StockHoldingsFact
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('prd.TransactionsFact') )
    DROP  TABLE prd.TransactionsFact
GO
-- SECTION TO DROP AND CREATE SCHEMA 
IF  EXISTS (SELECT 1 FROM sys.schemas where name = 'prd')
BEGIN
	DROP SCHEMA prd ;
END
GO 

CREATE SCHEMA prd
GO



--SECITON TO CREATE  TABLES 
CREATE  TABLE [prd].[DateDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[DateDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[DateDimensions]')
;
GO


CREATE  TABLE [prd].[CityDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[CityDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[CityDimensions]')
;
GO

	

CREATE  TABLE [prd].[CustomerDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[CustomerDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[CustomerDimensions]')
;
GO


CREATE  TABLE [prd].[EmployeeDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[EmployeeDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[EmployeeDimensions]')
;
GO

CREATE  TABLE [prd].[PaymentDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[PaymentDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[PaymentDimensions]')
;
GO


CREATE  TABLE [prd].[StockItemDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[StockItemDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[StockItemDimensions]')
;
GO




CREATE  TABLE [prd].[SupplierDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[SupplierDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[SupplierDimensions]')
;
GO

CREATE  TABLE [prd].[TransactionrDimensions]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[TransactionrDimensions]
OPTION (LABEL = 'CTAS : Load [prd].[TransactionrDimensions]')
;
GO


CREATE  TABLE [prd].[MovementsFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[MovementsFact]
OPTION (LABEL = 'CTAS : Load [prd].[MovementsFact]')
;
GO


CREATE  TABLE [prd].[OrdersFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[OrdersFact]
OPTION (LABEL = 'CTAS : Load [prd].[OrdersFact]')
;
GO


CREATE  TABLE [prd].[PurchasesFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[PurchasesFact]
OPTION (LABEL = 'CTAS : Load [prd].[PurchasesFact]')
;
GO


CREATE  TABLE [prd].[SalesFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[SalesFact]
OPTION (LABEL = 'CTAS : Load [prd].[SalesFact]')
;
GO


CREATE  TABLE [prd].[StockHoldingsFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[StockHoldingsFact]
OPTION (LABEL = 'CTAS : Load [prd].[StockHoldingsFact]')
;
GO

CREATE  TABLE [prd].[TransactionsFact]
WITH
( 
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[TransactionsFact]
OPTION (LABEL = 'CTAS : Load [prd].[TransactionsFact]')
;
GO

