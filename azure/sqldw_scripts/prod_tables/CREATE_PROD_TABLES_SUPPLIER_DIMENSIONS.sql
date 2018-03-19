SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[SupplierDimensions]') )
    DROP  TABLE [prd].[SupplierDimensions]
GO

CREATE TABLE [prd].[SupplierDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT s.SupplierID AS [WWI Supplier ID],
       s.SupplierName AS Supplier,
	   sc.SupplierCategoryName AS Category,
	   p.FullName AS [Primary Contact],
	   s.SupplierReference AS [Supplier Reference],
       s.PaymentDays AS [Payment Days],
	   s.DeliveryPostalCode AS [Postal Code],
	   s.ValidFrom AS [Valid From],
	   s.ValidTo AS [Valid To]
FROM [stg].[Purchasing_Suppliers] AS s
INNER JOIN [stg].[Purchasing_SupplierCategories] AS sc
ON s.SupplierCategoryID = sc.SupplierCategoryID
INNER JOIN [stg].[Application_People] AS p
ON s.PrimaryContactPersonID = p.PersonID
OPTION (LABEL = 'CTAS : [SupplierDimensions]')