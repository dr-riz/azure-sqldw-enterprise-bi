SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_Cities') )
    DROP  TABLE stg.Application_Cities
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_Countries') )
    DROP  TABLE stg.Application_Countries
GO


IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_DeliveryMethods') )
    DROP  TABLE stg.Application_DeliveryMethods
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_PaymentMethods') )
    DROP  TABLE stg.Application_PaymentMethods
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_People') )
    DROP  TABLE stg.Application_People
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_StateProvinces') )
    DROP  TABLE stg.Application_StateProvinces
GO

IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('stg.Application_TransactionTypes') )
    DROP  TABLE stg.Application_TransactionTypes
GO


PRINT 'CREATING [Application_Cities]'
GO


--CREATE AND DROP SECTION
CREATE  TABLE [stg].[Application_Cities]
(
	[CityID] [int] NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[LatestRecordedPopulation] [bigint] NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_Cities]'
GO

INSERT INTO [stg].[Application_Cities]
SELECT  
	[CityID] ,
	[CityName] ,
	[StateProvinceID],
	[LatestRecordedPopulation],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo] 
FROM [ext].[Application_Cities];
GO

PRINT 'CREATING [Application_Countries]'
GO

CREATE  TABLE [stg].[Application_Countries]
(
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](60) NOT NULL,
	[FormalName] [nvarchar](60) NOT NULL,
	[IsoAlpha3Code] [nvarchar](3) NULL,
	[IsoNumericCode] [int] NULL,
	[CountryType] [nvarchar](20) NULL,
	[LatestRecordedPopulation] [bigint] NULL,
	[Continent] [nvarchar](30) NOT NULL,
	[Region] [nvarchar](30) NOT NULL,
	[Subregion] [nvarchar](30) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL ,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_Countries]'
GO

INSERT INTO [stg].[Application_Countries]

SELECT
	[CountryID], 
	[CountryName] ,
	[FormalName],
	[IsoAlpha3Code],
	[IsoNumericCode],
	[CountryType],
	[LatestRecordedPopulation],
	[Continent],
	[Region],
	[Subregion],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM [ext].[Application_Countries];

PRINT 'CREATING [Application_DeliveryMethods]'
GO

CREATE TABLE stg.Application_DeliveryMethods
(
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryMethodName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO


PRINT 'INSERTING [Application_DeliveryMethods]'
GO
INSERT INTO stg.Application_DeliveryMethods
SELECT 
	[DeliveryMethodID] ,
	[DeliveryMethodName],
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM ext.Application_DeliveryMethods


PRINT 'CREATING [Application_PaymentMethods]'
GO

CREATE TABLE stg.Application_PaymentMethods
(
	[PaymentMethodID] [int] NOT NULL,
	[PaymentMethodName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_PaymentMethods]'
GO
INSERT INTO stg.Application_PaymentMethods
SELECT
	[PaymentMethodID] ,
	[PaymentMethodName] ,
	[LastEditedBy] ,
	[ValidFrom] ,
	[ValidTo]
FROM ext.Application_PaymentMethods


PRINT 'CREATING [Application_People]'
GO

CREATE TABLE stg.Application_People
(
	[PersonID] [int] NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[PreferredName] [nvarchar](50) NOT NULL,
	[SearchName] [nvarchar](101) NOT NULL,
	[IsPermittedToLogon] [bit] NOT NULL,
	[LogonName] [nvarchar](50) NULL,
	[IsExternalLogonProvider] [bit] NOT NULL,
	[IsSystemUser] [bit] NOT NULL,
	[IsEmployee] [bit] NOT NULL,
	[IsSalesperson] [bit] NOT NULL,
	[UserPreferences] [nvarchar](4000) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[FaxNumber] [nvarchar](20) NULL,
	[EmailAddress] [nvarchar](256) NULL,
	[CustomFields] [nvarchar](4000) NULL,
	[OtherLanguages] [nvarchar](4000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_People]'
GO
INSERT INTO stg.Application_People
SELECT
	[PersonID],
	[FullName],
	[PreferredName],
	[SearchName],
	[IsPermittedToLogon],
	[LogonName],
	[IsExternalLogonProvider],
	[IsSystemUser],
	[IsEmployee],
	[IsSalesperson],
	[UserPreferences],
	[PhoneNumber],
	[FaxNumber],
	[EmailAddress] ,
	[CustomFields],
	[OtherLanguages] ,
	[LastEditedBy],
	[ValidFrom],
	[ValidTo]
FROM ext.Application_People


PRINT 'CREATING [Application_StateProvinces]'
GO
CREATE  TABLE stg.Application_StateProvinces(
	[StateProvinceID] [int] NOT NULL,
	[StateProvinceCode] [nvarchar](5) NOT NULL,
	[StateProvinceName] [nvarchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
	[SalesTerritory] [nvarchar](50) NOT NULL,
	[LatestRecordedPopulation] [bigint] NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_StateProvinces]'
GO
INSERT INTO stg.Application_StateProvinces

SELECT
	[StateProvinceID] ,
	[StateProvinceCode],
	[StateProvinceName] ,
	[CountryID] ,
	[SalesTerritory] ,
	[LatestRecordedPopulation],
	[LastEditedBy] ,
	[ValidFrom],
	[ValidTo]
FROM ext.Application_StateProvinces

PRINT 'CREATING [Application_TransactionTypes]'
GO


CREATE  TABLE [stg].[Application_TransactionTypes](
	[TransactionTypeID] [int] NOT NULL,
	[TransactionTypeName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)
	)
WITH (HEAP);
GO

PRINT 'INSERTING [Application_SystemParameters]'
GO
INSERT INTO stg.[Application_TransactionTypes]

SELECT
	[TransactionTypeID] ,
	[TransactionTypeName] ,
	[LastEditedBy],
	[ValidFrom] ,
	[ValidTo] 
FROM ext.[Application_TransactionTypes]

