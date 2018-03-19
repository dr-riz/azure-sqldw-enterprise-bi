DECLARE @StartDate datetime2
DECLARE @EndDate datetime2

SELECT @StartDate = DATEFROMPARTS(DATEPART(year, MIN(a.MinDate)), 1, 1),
       @EndDate = DATEFROMPARTS(DATEPART(year, GETUTCDATE()), 12, 31)
FROM (
    SELECT MIN(OrderDate) AS MinDate FROM stg.Purchasing_PurchaseOrders
    UNION
    SELECT MIN(TransactionDate) AS MinDate FROM stg.Purchasing_SupplierTransactions
    UNION
    SELECT MIN(TransactionDate) AS MinDate FROM stg.Sales_CustomerTransactions
    UNION
    SELECT MIN(InvoiceDate) AS MinDate FROM stg.Sales_Invoices
    UNION
    SELECT MIN(OrderDate) AS MinDate FROM stg.Sales_Orders
    UNION
    SELECT MIN(TransactionOccurredWhen) AS MinDate FROM stg.Warehouse_StockItemTransactions
) a

SELECT [Date] AS [Date],                                                  -- 2013-01-01
       CONVERT(NVARCHAR(10),[Date],112) AS [DateKey],                     -- 20130101 (to 20131231)
       DATEPART(day, [Date]) AS [Day Number],                             -- 1 (to last day of month)
       DATENAME(day, [Date]) AS [Day],                                    -- 1 (to last day of month)
       DATENAME(dayofyear, [Date]) AS [Day of Year],                      -- 1 (to 365)
       DATEPART(dayofyear, [Date]) AS [Day of Year Number],               -- 1 (to 365)
       DATENAME(weekday, [Date]) AS [Day of Week],                        -- Tuesday
       DATEPART(weekday, [Date]) AS [Day of Week Number],                 -- 3
       DATENAME(week, [Date]) AS [Week of Year],                          -- 1
       DATENAME(month, [Date]) AS [Month],    
	   DATENAME(mm,[Date]),                                                -- Jan
       CONCAT('Q' , DATENAME(quarter, [Date])) AS [Quarter],                     -- Q1 (to Q4)
       CONCAT('H' , CAST([Year Half] AS nvarchar)) AS [Half of Year],            -- H1 (or H2)
       [Beginning of Month] AS [Beginning of Month],                      -- 2013-01-01
       [Beginning of Quarter] AS [Beginning of Quarter],                  -- 2013-01-01
       [Beginning of Half of Year] AS [Beginning of Half of Year],        -- 2013-01-01
       [Beginning of Year] AS [Beginning of Year],
	   CONCAT('Beginning of Month ',DATENAME(m,[Date]),'-',DATENAME(YYYY,[Date])) AS [Beginning of Month Label] ,
	   CONCAT('BOM  ',SUBSTRING(DATENAME(m,[Date]),1,3),'-',DATENAME(YYYY,[Date])) AS [Beginning of Month Label Short] ,
	   CONCAT('Beginning Of Quarter  ',DATENAME(YYYY,[Date]),'-', CONCAT('Q' , DATENAME(quarter, [Date]))) AS [Beginning of Quater Label ],                       -- 2013-01-01
	   CONCAT('BOQ  ',DATENAME(YYYY,[Date]),'-', CONCAT('Q' , DATENAME(quarter, [Date]))) AS [Beginning of Quater Short ],
	   CONCAT('Beginning of Half Year ',DATENAME(YYYY,[Date]),'-', CONCAT('H' , CAST([Year Half] AS nvarchar))) AS [Beginning of Half Year Label],                        -- 2013-01-01
	   CONCAT('BOH ',DATENAME(YYYY,[Date]),'-', CONCAT('H' , CAST([Year Half] AS nvarchar))) AS [Beginning of Half Year Label Short]  ,
       CONCAT('Beginning of Year ',DATENAME(YYYY,[Date])) AS [Beginning of Year Label],
	   CONCAT('BOY ',DATENAME(YYYY,[Date])) AS [Beginning of Year Label Short],
	   CONCAT( DATENAME(m,[Date]),' ',DATENAME(d,[Date]),', ',DATENAME(YYYY,[Date]))   AS [Calendar Day Label],
	   CONCAT( SUBSTRING(DATENAME(m,[Date]),1,3),' ',DATENAME(d,[Date]),', ',DATENAME(YYYY,[Date]))   AS [Calendar Day Label Short],
	   DATENAME(ww,[Date]) AS [Calendar Week Number],
	   CONCAT('CY',DATENAME(YYYY,[Date]),'-W',DATENAME(ww,[Date])) AS [Calendar Week Label],
	   MONTH([Date]) AS [Calendar Month Number],
	   CONCAT(SUBSTRING(DATENAME(mm,[Date]),1,3),'-',DATENAME(YYYY,[Date])) AS [Calendar Month Year Label],	
	   CONCAT('CY',DATENAME(YYYY,[Date]),'-',SUBSTRING(DATENAME(mm,[Date]),1,3)) AS [Calendar Month Label],	
	   DATENAME(quarter, [Date]) AS [Calendar Quarter Number],
	   CONCAT('CY',DATENAME(YYYY,[Date]),'-Q',DATENAME(quarter, [Date])) AS [Calendar Quater Label],		
	   CONCAT('Q',DATENAME(quarter, [Date]),'-',DATENAME(YYYY,[Date])) AS [Calendar Quater Year Label],	
       [Year Half] AS [Calendar Half of Year Number],                     -- 1 (to 2)
	   CONCAT('CY',DATENAME(YYYY,[Date]),'-H',CAST([Year Half] AS nvarchar)) AS [Calendar Half of Year Label],	
	   CONCAT('H',DATENAME(quarter, [Date]),'-',DATENAME(YYYY,[Date])) AS [Calendar Year Half of Year Label],	       
       DATEPART(year, [Date]) AS [Calendar Year],                       -- 2013
	   CONCAT('CY',DATENAME(YYYY,[Date])) AS [Calendar Year Label],
       DATEPART(month, [Fiscal Date]) AS [Fiscal Month Number]  ,         -- 7
	   CONCAT('FY',DATENAME(YYYY,[Fiscal Date]),'-', SUBSTRING(DATENAME(m,[Fiscal Date]),1,3)) AS [Fiscal Month Label]
       --FORMAT([Fiscal Date], N'"FY"yyyy-') + FORMAT([Date], N'MMM')
       --    AS [Fiscal Month Label],                                       -- FY2013-Jan
       --DATEPART(quarter, [Fiscal Date]) AS [Fiscal Quarter Number],       -- 2
       --FORMAT([Fiscal Date], N'"FY"yyyy-Q') +
       --    DATENAME(quarter, [Fiscal Date]) AS [Fiscal Quarter Label],    -- FY2013-Q2
       --[Fiscal Year Half] AS [Fiscal Half of Year Number],                -- 1 (to 2)
       --FORMAT([Fiscal Date], N'"FY"yyyy-\H') +
       --    CAST([Fiscal Year Half] AS nvarchar)
       --    AS [Fiscal Half of Year Label],                                -- FY2013-H2
       --DATEPART(year, [Fiscal Date]) AS [Fiscal Year],                    -- 2013
       --FORMAT([Fiscal Date], N'"FY"yyyy') AS [Fiscal Year Label],         -- FY2013
       --CAST(FORMAT([Date], N'yyyyMMdd') AS int) AS [Date Key],            -- 20130101 (to 20131231)
       --CAST(DATENAME(year, [Date]) +
       --    RIGHT(N'00' + DATENAME(week, [Date]), 2) AS int)
       --    AS [Year Week Key],                                            -- 201301 (to 201353)
       --CAST(FORMAT([Date], N'yyyyMM') AS int) AS [Year Month Key],        -- 201301 (to 201312)
       --CAST(DATENAME(year, [Date]) + DATENAME(quarter, [Date]) AS int)
       --    AS [Year Quarter Key],                                         -- 20131 (to 20134)
       --CAST(DATENAME(year, [Date]) + CAST([Year Half] AS nvarchar) AS int)
       --    AS [Year Half of Year Key],                                    -- 20131 (to 20132)
       --DATEPART(year, [Date]) AS [Year Key],                              -- 2013
       --CAST(FORMAT([Fiscal Date], N'yyyy') + FORMAT([Date], N'MM') AS int)
       --    AS [Fiscal Year Month Key],                                    -- 201301 (to 201312)
       --CAST(FORMAT([Beginning of Month], N'yyyyMMdd') AS int)
       --    AS [Beginning of Month Key],                                   -- 20130101
       --FORMAT([Beginning of Quarter], N'yyyyMMdd')
       --    AS [Beginning of Quarter Key],                                 -- 20130101
       --FORMAT([Beginning of Half of Year], N'yyyyMMdd')
       --    AS [Beginning of Half of Year Key],
       --CAST(FORMAT([Beginning of Year], N'yyyyMMdd') AS int)
       --    AS [Beginning of Year Key],                                    -- 20130101
       --CAST(FORMAT([Fiscal Date], N'yyyy') +
       --    DATENAME(quarter, [Fiscal Date]) AS int)
       --    AS [Fiscal Year Quarter Key],                                  -- 20131
       --CAST(FORMAT([Fiscal Date], N'yyyy') +
       --    CAST([Fiscal Year Half] AS nvarchar) AS int)
       --    AS [Fiscal Year Half of Year Key],                             -- 20131
       --DATEPART(ISO_WEEK, [Date]) AS [ISO Week Number]                    -- 1;
FROM (
    SELECT [Date],
           DATEADD(month, 6, [Date]) AS [Fiscal Date],
           CAST(DATEADD(month, DATEDIFF(month, 0, [Date]), 0) AS date)
               AS [Beginning of Month],
           DATEFROMPARTS(DATEPART(year, [Date]), 1, 1) AS [Beginning of Year],
           DATEFROMPARTS(DATEPART(year, [Date]), ((DATEPART(quarter, [Date]) - 1) * 3) + 1, 1)
               AS [Beginning of Quarter],
           DATEFROMPARTS(DATEPART(year, [Date]), ((DATEPART(month, [Date]) / 7) * 6) + 1, 1)
               AS [Beginning of Half of Year],
           (DATEPART(month, [Date]) / 7) + 1 AS [Year Half],
           (DATEPART(month, DATEADD(month, 6, [Date])) / 7) + 1 AS [Fiscal Year Half]
    FROM (
        SELECT TOP (DATEDIFF(day, @StartDate, @EndDate) + 1)
               DATEADD(day, ROW_NUMBER() OVER (ORDER BY s1.[object_id]) - 1, @StartDate) AS [Date]
        FROM sys.all_objects AS s1
        CROSS JOIN sys.all_objects AS s2
        ORDER BY s1.[object_id]
    ) AS gen_date
) AS gen_dates

GO