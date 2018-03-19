SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[EmployeeDimensions]') )
    DROP  TABLE [prd].[EmployeeDimensions]
GO

CREATE TABLE [prd].[EmployeeDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS SELECT p.PersonID AS [WWI Employee ID],
       p.FullName AS [Employee],
	   p.PreferredName AS [Preferred Name],
	   p.IsSalesperson AS [Is Salesperson],
       p.ValidFrom AS [Valid From],
	   p.ValidTo AS [Valid To]
FROM [stg].[Application_People] AS p
WHERE p.IsEmployee <> 0
OPTION (LABEL = 'CTAS : [EmployeeDimensions]')