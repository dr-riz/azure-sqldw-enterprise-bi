SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_Cities') )
    DROP EXTERNAL TABLE ext.Application_Cities
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_Countries') )
    DROP EXTERNAL TABLE ext.Application_Countries
GO


IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_DeliveryMethods') )
    DROP EXTERNAL TABLE ext.Application_DeliveryMethods
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_PaymentMethods') )
    DROP EXTERNAL TABLE ext.Application_PaymentMethods
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_People') )
    DROP EXTERNAL TABLE ext.Application_People
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_StateProvinces') )
    DROP EXTERNAL TABLE ext.Application_StateProvinces
GO

IF EXISTS ( SELECT * FROM sys.external_tables WHERE object_id = OBJECT_ID('ext.Application_TransactionTypes') )
    DROP EXTERNAL TABLE ext.Application_TransactionTypes
GO


PRINT 'CREATING [Application_Cities]'
GO

--CREATE AND DROP SECTION
CREATE EXTERNAL TABLE [ext].[Application_Cities]
(
	[CityID] [int] NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[Location] BINARY(8000) NULL,
	[LatestRecordedPopulation] [bigint] NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_Cities/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO



PRINT 'CREATING [Application_Countries]'
GO

CREATE EXTERNAL TABLE [ext].[Application_Countries]
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
	[Border] BINARY(8000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL ,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_Countries/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


PRINT 'CREATING [Application_DeliveryMethods]'
GO

CREATE EXTERNAL TABLE [ext].[Application_DeliveryMethods]
(
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryMethodName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_DeliveryMethods/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO




PRINT 'CREATING [Application_PaymentMethods]'
GO

CREATE EXTERNAL TABLE [ext].[Application_PaymentMethods]
(
	[PaymentMethodID] [int] NOT NULL,
	[PaymentMethodName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_PaymentMethods/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO




--Application_People

PRINT 'CREATING [Application_People]'
GO

CREATE EXTERNAL TABLE [ext].[Application_People]
(
	[PersonID] [int] NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[PreferredName] [nvarchar](50) NOT NULL,
	[SearchName] [nvarchar](101) NOT NULL,
	[IsPermittedToLogon] [bit] NOT NULL,
	[LogonName] [nvarchar](50) NULL,
	[IsExternalLogonProvider] [bit] NOT NULL,
	[HashedPassword] [varbinary](8000) NULL,
	[IsSystemUser] [bit] NOT NULL,
	[IsEmployee] [bit] NOT NULL,
	[IsSalesperson] [bit] NOT NULL,
	[UserPreferences] [nvarchar](4000) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[FaxNumber] [nvarchar](20) NULL,
	[EmailAddress] [nvarchar](256) NULL,
	[Photo] [varbinary](8000) NULL,
	[CustomFields] [nvarchar](4000) NULL,
	[OtherLanguages] [nvarchar](4000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_People/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO



PRINT 'CREATING [Application_StateProvinces]'
GO
CREATE EXTERNAL TABLE [ext]. [Application_StateProvinces](
	[StateProvinceID] [int] NOT NULL,
	[StateProvinceCode] [nvarchar](5) NOT NULL,
	[StateProvinceName] [nvarchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
	[SalesTerritory] [nvarchar](50) NOT NULL,
	[Border] varbinary(8000) NULL,
	[LatestRecordedPopulation] [bigint] NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_StateProvinces/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

PRINT 'CREATING [Application_SystemParameters]'


CREATE EXTERNAL TABLE [ext].[Application_TransactionTypes](
	[TransactionTypeID] [int] NOT NULL,
	[TransactionTypeName] [nvarchar](50) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7)  NOT NULL,
	[ValidTo] [datetime2](7)
	)
WITH (DATA_SOURCE = [WAREHOUSEEXTERNALDATASOURCE],LOCATION = N'/WideWorldImporters_Application_TransactionTypes/',FILE_FORMAT = [UNCOMPRESSEDCSV],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


PRINT 'ALL DONE'
--GO
