SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[stg].[DateDimensions]') )
    DROP  TABLE [stg].[DateDimensions]
GO

PRINT 'CREATING [stg].[DateDimensions]'
GO

CREATE  TABLE [stg].[DateDimensions]
(	
	[Date] [datetime2](7) NOT NULL,
	[DateKey] int NOT NULL,
	[Day Number] int NOT NULL,
	[Day] int NOT NULL,
	[Day of Year] int NOT NULL,
	[Day of Year Number] int NOT NULL,
	[Day of Week] [nvarchar](10) NOT NULL,
	[Day of Week Number] int NOT NULL,
	[Week of Year] int NOT NULL,
	[Month] [nvarchar](10) NOT NULL,
	[Short Month] [nvarchar](10) NOT NULL,
	[Quarter] [nvarchar](10) NOT NULL,
	[Half of Year] [nvarchar](10) NOT NULL,
	[Beginning of Month] [nvarchar](10) NOT NULL,
	[Beginning of Quarter] [nvarchar](10) NOT NULL,
	[Beginning of Half of Year] [nvarchar](10) NOT NULL,
	[Beginning of Year] [nvarchar](10) NOT NULL,
	[Beginning of Month Label] [nvarchar](40) NOT NULL,
	[Beginning of Month Label Short] [nvarchar](40) NOT NULL,
	[Beginning of Quarter Label] [nvarchar](40) NOT NULL,
	[Beginning of Quarter Label Short] [nvarchar](40) NOT NULL,
	[Beginning of Half Year Label] [nvarchar](40) NOT NULL,	
	[Beginning of Half Year Label Short] [nvarchar](40) NOT NULL,
	[Beginning of Year Label] [nvarchar](40) NOT NULL,
	[Beginning of Year Label Short] [nvarchar](40) NOT NULL,
	[Calendar Day Label] [nvarchar](40) NOT NULL,
	[Calendar Day Label Short] [nvarchar](40) NOT NULL,
	[Calendar Week Number] int NOT NULL,
	[Calendar Week Label] [nvarchar](40) NOT NULL,
	[Calendar Month Number] int NOT NULL,
	[Calendar Month Label] [nvarchar](40) NOT NULL,
	[Calendar Month Year Label] [nvarchar](40) NOT NULL,
	[Calendar Quarter Number] int NOT NULL,
	[Calendar Quarter Label] [nvarchar](40) NOT NULL,
	[Calendar Quarter Year Label] [nvarchar](40) NOT NULL,
	[Calendar Half of Year Number] int NOT NULL,
	[Calendar Half of Year Label] [nvarchar](40) NOT NULL,
	[Calendar Year Half of Year Label] [nvarchar](40) NOT NULL,
	[Calendar Year] int,
	[Calendar Year Label] [nvarchar](40) NOT NULL, 
	[Fiscal Month Number] int NOT NULL,
	[Fiscal Month Label] [nvarchar](40) NOT NULL,
	[Fiscal Quarter Number] int NOT NULL,
	[Fiscal Quarter Label] [nvarchar](40) NOT NULL,
	[Fiscal Half of Year Number] int NOT NULL,
	[Fiscal Half of Year Label] [nvarchar](40) NOT NULL,
	[Fiscal Year] int,
	[Fiscal Year Label] [nvarchar](40) NOT NULL,
	[Date Key] int,
	[Year Week Key] int,
	[Year Month Key] int,
	[Year Quarter Key] int,
	[Year Half of Year Key] int,
	[Year Key] int,
	[Fiscal Year Month Key] int,
	[Beginning of Month Key] int,
	[Beginning of Quarter Key] int,
	[Beginning of Half of Year Key] int,
	[Beginning of Year Key] int,
	[Fiscal Year Quarter Key] int,
	[Fiscal Year Half of Year Key] int,
	[ISO Week Number] int NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [stg].[DateDimensions]'
GO

INSERT INTO [stg].[DateDimensions] 
SELECT * FROM [ext].[DateDimensions]
GO