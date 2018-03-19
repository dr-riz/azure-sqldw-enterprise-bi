SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[CityDimensions]') )
    DROP  TABLE [prd].[CityDimensions]
GO

CREATE TABLE [prd].[CityDimensions]
WITH
(
    DISTRIBUTION = REPLICATE
,   CLUSTERED COLUMNSTORE INDEX
)
AS SELECT c.CityID AS [WWI City ID],
       c.CityName AS [City],
       sp.StateProvinceName AS [State Province],
       co.CountryName AS [Country],
	   co.Continent as [Continent],
       sp.SalesTerritory AS [Sales Territory],
	   co.Region AS [Region],
	   co.Subregion AS [Subregion],
	   COALESCE(c.LatestRecordedPopulation, 0) AS [Latest Recorded Population],
	   c.ValidFrom AS [Valid From],
	   c.ValidTo AS [Valid To]
FROM  [stg].[Application_Cities] AS c
INNER JOIN [stg].[Application_StateProvinces] AS sp
ON c.StateProvinceID = sp.StateProvinceID
INNER JOIN [stg].[Application_Countries] AS co
ON sp.CountryID = co.CountryID
OPTION (LABEL = 'CTAS : [CityDimensions]')

