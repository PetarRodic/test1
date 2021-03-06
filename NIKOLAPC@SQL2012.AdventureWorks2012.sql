/*=============================================================
SCRIPT HEADER

VERSION:   1.01.0001
DATE:      07-18-2014 17:57:54
SERVER:    NIKOLAPC\SQL2012

DATABASE:	AdventureWorks2012
	Tables:
		Address, AddressType


=============================================================*/
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET ARITHABORT ON
SET NOCOUNT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
GO
-- BEGINNING TRANSACTION STRUCTURE
PRINT 'Beginning transaction STRUCTURE'
BEGIN TRANSACTION _STRUCTURE_
GO
-- Create Table [Person].[AddressType]
Print 'Create Table [Person].[AddressType]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Person].[AddressType] (
		[AddressTypeID]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]              [dbo].[Name] NOT NULL,
		[rowguid]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]      [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Person].[AddressType]
	ADD
	CONSTRAINT [PK_AddressType_AddressTypeID]
	PRIMARY KEY
	CLUSTERED
	([AddressTypeID])
	ON [PRIMARY]
GO
ALTER TABLE [Person].[AddressType]
	ADD
	CONSTRAINT [DF_AddressType_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Person].[AddressType]
	ADD
	CONSTRAINT [DF_AddressType_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_Name]
	ON [Person].[AddressType] ([Name])
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_rowguid]
	ON [Person].[AddressType] ([rowguid])
	ON [PRIMARY]
GO
ALTER TABLE [Person].[AddressType] SET (LOCK_ESCALATION = TABLE)
GO

-- Create Table [Person].[Address]
Print 'Create Table [Person].[Address]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Person].[Address] (
		[AddressID]           [int] IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
		[AddressLine1]        [nvarchar](60) NOT NULL,
		[AddressLine2]        [nvarchar](60) NULL,
		[City]                [nvarchar](30) NOT NULL,
		[StateProvinceID]     [int] NOT NULL,
		[PostalCode]          [nvarchar](15) NOT NULL,
		[SpatialLocation]     [geography] NULL,
		[rowguid]             [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]        [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Person].[Address]
	ADD
	CONSTRAINT [PK_Address_AddressID]
	PRIMARY KEY
	CLUSTERED
	([AddressID])
	ON [PRIMARY]
GO
ALTER TABLE [Person].[Address]
	ADD
	CONSTRAINT [DF_Address_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Person].[Address]
	ADD
	CONSTRAINT [DF_Address_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Address_rowguid]
	ON [Person].[Address] ([rowguid])
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode]
	ON [Person].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvinceID], [PostalCode])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Address_StateProvinceID]
	ON [Person].[Address] ([StateProvinceID])
	ON [PRIMARY]
GO
ALTER TABLE [Person].[Address] SET (LOCK_ESCALATION = TABLE)
GO

-- Create Foreign Key FK_Address_StateProvince_StateProvinceID On Address
Print 'Create Foreign Key FK_Address_StateProvince_StateProvinceID On Address'
GO
ALTER TABLE [Person].[Address]
	WITH CHECK
	ADD CONSTRAINT [FK_Address_StateProvince_StateProvinceID]
	FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
ALTER TABLE [Person].[Address]
	CHECK CONSTRAINT [FK_Address_StateProvince_StateProvinceID]

GO

-- COMMITTING TRANSACTION STRUCTURE
PRINT 'Committing transaction STRUCTURE'
IF @@TRANCOUNT>0
	COMMIT TRANSACTION _STRUCTURE_
GO

SET NOEXEC OFF
GO
