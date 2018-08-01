USE [cdTestDB];

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- ==========================================================================================
-- Author:	 Charles J. Duncan
-- Create date: March 29, 2018
-- Description: Parses the Nemsis file and inserts the parts into the appropriate tables.
-- ==========================================================================================

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRPatient] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table        - Column                        - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRPatient   - LastName                      - NEMSIS V2 - E06_01_0/E06_01 Element - Last Name 
	-- PCRPatient   - FirstName                     - NEMSIS V2 - E06_01_0/E06_02 Element - First Name 
	-- PCRPatient   - MiddleName                    - NEMSIS V2 - E06_01_0/E06_03 Element - Middle Initial/Name 
	-- PCRPatient   - HomeAddress                   - NEMSIS V2 - E06_04_0/E06_04 Element - Patient's Home Address 
	-- PCRPatient   - HomeCity                      - NEMSIS V2 - E06_04_0/E06_05 Element - Patient's Home City 
	-- PCRPatient   - HomeCounty                    - NEMSIS V2 - E06_04_0/E06_06 Element - Patient's Home County 
	-- PCRPatient   - HomeState                     - NEMSIS V2 - E06_04_0/E06_07 Element - Patient's Home State 
	-- PCRPatient   - HomeZipCode                   - NEMSIS V2 - E06_04_0/E06_08 Element - Patient's Home Zip Code 
	-- PCRPatient   - HomeCountry                   - NEMSIS V2 - E06_09 Element - Patient’s Home Country 
	-- PCRPatient   - SocialSecurityNumber          - NEMSIS V2 - E06_10 Element - Social Security Number 
	-- PCRPatient   - Gender						- NEMSIS V2 - E06_11 Element - Gender 
	-- PCRPatient   - Race							- NEMSIS V2 - E06_12 Element - Race 
	-- PCRPatient   - Ethnicity						- NEMSIS V2 - E06_13 Element - Ethnicity 
	-- PCRPatient   - Age							- NEMSIS V2 - E06_14_0/E06_14 Element - Age 
	-- PCRPatient   - AgeUnits						- NEMSIS V2 - E06_14_0/E06_15 Element - Age Units 
	-- PCRPatient   - DateOfBirth                   - NEMSIS V2 - E06_16 Element - Date of Birth 
	-- PCRPatient   - PrimaryorHomeTelephoneNumber  - NEMSIS V2 - E06_17 Element - Primary or Home Telephone Number 
	-- PCRPatient   - StateIssuingDriverLicense     - NEMSIS V2 - E06_19_0/E06_18 Element - State Issuing Driver's License 
	-- PCRPatient   - DriverLicenseNumber           - NEMSIS V2 - E06_19_0/E06_19 Element - Driver's License Number 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=

	BEGIN TRY
		INSERT INTO [dbo].[ApplicationLog]
        (
			  [AgencyId]
			, [Severity]
			, [Logger]
			, [Message]
			, [LogDate]
			, [UserId]
		) VALUES (
			  @AgencyId
			, 'INFO'
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRPatient]'
			, 'Beginning the PCR Patient import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @Patient TABLE
		(
			[PatientCareReportNumber] [varchar](30) NOT NULL,
			[AgencyId] [int] NOT NULL,
			[LastName] [varchar](20) NULL,
			[FirstName] [varchar](20) NULL,
			[MiddleName] [varchar](20) NULL,
			[HomeAddress] [varchar](30) NULL,
			[HomeCity] [varchar](30) NULL,
			[HomeCounty] [varchar](5) NULL,
			[HomeState] [varchar](3) NULL,
			[HomeZipCode] [varchar](10) NOT NULL,
			[HomeCountry] [varchar](20) NULL,
			[SocialSecurityNumber] [varchar](11) NULL,
			[Gender] [int] NOT NULL,
			[Race] [int] NOT NULL,
			[Ethnicity] [int] NOT NULL,
			[Age] [int] NULL,
			[AgeUnits] [int] NOT NULL,
			[DateOfBirth] [datetime] NULL,
			[PrimaryorHomeTelephoneNumber] [varchar](10) NULL,
			[StateIssuingDriverLicense] [varchar](3) NULL,
			[DriverLicenseNumber] [varchar](30) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		INSERT INTO @Patient 
		(
			  [PatientCareReportNumber]
			, [AgencyId]
			, [LastName]
			, [FirstName]
			, [MiddleName]
			, [HomeAddress]
			, [HomeCity]
			, [HomeCounty]
			, [HomeState]
			, [HomeZipCode]
			, [HomeCountry]
			, [SocialSecurityNumber]
			, [Gender]
			, [Race]
			, [Ethnicity]
			, [Age]
			, [AgeUnits]
			, [DateOfBirth]
			, [PrimaryorHomeTelephoneNumber]
			, [StateIssuingDriverLicense]
			, [DriverLicenseNumber]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PatientCareReportNumber]
			, @AgencyId AS [AgencyId]
			, [LastName]
			, [FirstName]
			, [MiddleName]
			, [HomeAddress]
			, [HomeCity]
			, [HomeCounty]
			, [HomeState]
			, [HomeZipCode]
			, [HomeCountry]
			, [SocialSecurityNumber]
			, [Gender]
			, [Race]
			, [Ethnicity]
			, [Age]
			, [AgeUnits]
			, [DateOfBirth]
			, [PrimaryorHomeTelephoneNumber]
			, [StateIssuingDriverLicense]
			, [DriverLicenseNumber]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E06', 2) WITH (
						  [LastName] VARCHAR(30) 'n:E06_01_0/n:E06_01'
						, [FirstName] VARCHAR(30) 'n:E06_01_0/n:E06_02'
						, [MiddleName] VARCHAR(30) 'n:E06_01_0/n:E06_03'
						, [HomeAddress] VARCHAR(30) 'n:E06_04_0/n:E06_04'
						, [HomeCity] VARCHAR(30) 'n:E06_04_0/n:E06_05'
						, [HomeCounty] VARCHAR(30) 'n:E06_04_0/n:E06_06'
						, [HomeState] VARCHAR(30) 'n:E06_04_0/n:E06_07'
						, [HomeZipCode] VARCHAR(30) 'n:E06_04_0/n:E06_08'
						, [HomeCountry] VARCHAR(30) 'n:E06_09'
						, [SocialSecurityNumber] VARCHAR(30) 'n:E06_10'
						, [Gender] VARCHAR(30) 'n:E06_11'
						, [Race] VARCHAR(30) 'n:E06_12'
						, [Ethnicity] VARCHAR(30) 'n:E06_13'
						, [Age] VARCHAR(30) 'n:E06_14_0/n:E06_14'
						, [AgeUnits] VARCHAR(30) 'n:E06_14_0/n:E06_15'
						, [DateOfBirth] VARCHAR(30) 'n:E06_16'
						, [PrimaryorHomeTelephoneNumber] VARCHAR(30) 'n:E06_17'
						, [StateIssuingDriverLicense] VARCHAR(30) 'n:E06_19_0/n:E06_18'
						, [DriverLicenseNumber] VARCHAR(30) 'n:E06_19_0/n:E06_19'
						, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
						, [AgencyState] INT '../../n:D01_03'
						, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
						, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
						, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');

				   
		INSERT INTO [dbo].[PCRPatient]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [LastName]
			, [FirstName]
			, [MiddleName]
			, [HomeAddress]
			, [HomeCity]
			, [HomeCounty]
			, [HomeState]
			, [HomeZipCode]
			, [HomeCountry]
			, [SocialSecurityNumber]
			, [Gender]
			, [Race]
			, [Ethnicity]
			, [Age]
			, [AgeUnits]
			, [DateOfBirth]
			, [PrimaryorHomeTelephoneNumber]
			, [StateIssuingDriverLicense]
			, [DriverLicenseNumber]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [P].[LastName]
			, [P].[FirstName]
			, [P].[MiddleName]
			, [P].[HomeAddress]
			, [P].[HomeCity]
			, [P].[HomeCounty]
			, [P].[HomeState]
			, [P].[HomeZipCode]
			, [P].[HomeCountry]
			, [P].[SocialSecurityNumber]
			, [P].[Gender]
			, [P].[Race]
			, [P].[Ethnicity]
			, [P].[Age]
			, [P].[AgeUnits]
			, [P].[DateOfBirth]
			, [P].[PrimaryorHomeTelephoneNumber]
			, [P].[StateIssuingDriverLicense]
			, [P].[DriverLicenseNumber]
			, [P].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Patient AS [P]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [P].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [P].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [P].[PatientCareReportNumber];
			

		INSERT INTO [dbo].[ApplicationLog]
		(
			  [AgencyId]
			, [Severity]
			, [Logger]
			, [Message]
			, [LogDate]
			, [UserId]
		) VALUES (
			  @AgencyId
			, 'INFO'
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRPatient]'
			, 'Completed the PCR Patient import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRPatient] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
