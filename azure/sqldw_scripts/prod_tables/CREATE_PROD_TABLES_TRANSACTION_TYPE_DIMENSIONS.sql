SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[TransactionTypeDimensions]') )
    DROP  TABLE [prd].[TransactionTypeDimensions]
GO

CREATE TABLE [prd].[TransactionTypeDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT p.TransactionTypeID AS [WWI Transaction Type ID],
       p.TransactionTypeName AS [Transaction Type],
	   p.ValidFrom AS [Valid From],
	   p.ValidTo AS [Valid To]
FROM [stg].[Application_TransactionTypes] AS p
OPTION (LABEL = 'CTAS : [TransactionTypeDimensions]')