SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[PaymentMethodDimension]') )
    DROP  TABLE [prd].[PaymentMethodDimension]
GO

CREATE TABLE [prd].[PaymentMethodDimension]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT p.PaymentMethodID,
	   p.PaymentMethodName,
	   p.ValidFrom,
	   p.ValidTo
FROM [stg].[Application_PaymentMethods] AS p
OPTION (LABEL = 'CTAS : [PaymentMethodDimension]')