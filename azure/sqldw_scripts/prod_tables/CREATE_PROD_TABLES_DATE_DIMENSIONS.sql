SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[DateDimensions]') )
    DROP  TABLE [prd].[DateDimensions]
GO

CREATE TABLE [prd].[DateDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS SELECT * FROM [stg].[DateDimensions]
OPTION (LABEL = 'CTAS : [DateDimensions]')
