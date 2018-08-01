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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRBilling] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table                               - Column                             - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRBilling                          - PrimaryPaymentMethod               - NEMSIS V2 - E07_01 Element - Primary Method of Payment 
	-- PCRBilling                          - CertificateMedicalNecessity        - NEMSIS V2 - E07_02 Element - Certificate of Medical Necessity 
	-- PCRBillingInsurance                 - InsuranceCompanyId                 - NEMSIS V2 - E07_03 Element - Insurance Company ID/Name 
	-- PCRBillingInsurance                 - InsuranceCompanyBillingPriority    - NEMSIS V2 - E07_04 Element - Insurance Company Billing Priority 
	-- PCRBillingInsurance                 - InsuranceCompanyAddress            - NEMSIS V2 - E07_05 Element - Insurance Company Address 
	-- PCRBillingInsurance                 - InsuranceCompanyCity               - NEMSIS V2 - E07_06 Element - Insurance Company City 
	-- PCRBillingInsurance                 - InsuranceCompanyState              - NEMSIS V2 - E07_07 Element - Insurance Company State 
	-- PCRBillingInsurance                 - InsuranceCompanyZipCode            - NEMSIS V2 - E07_08 Element - Insurance Company Zip Code 
	-- PCRBillingInsurance                 - InsuranceGroupId                   - NEMSIS V2 - E07_09 Element - Insurance Group ID/Name 
	-- PCRBillingInsurance                 - InsurancePolicyIdNumber            - NEMSIS V2 - E07_10 Element - Insurance Policy ID Number 
	-- PCRBillingInsurance                 - InsuredLastName                    - NEMSIS V2 - E07_11 Element - Last Name of the Insured 
	-- PCRBillingInsurance                 - InsuredFirstName                   - NEMSIS V2 - E07_12 Element - First Name of the Insured 
	-- PCRBillingInsurance                 - InsuredMiddleName                  - NEMSIS V2 - E07_13 Element - Middle Initial/Name of the Insured 
	-- PCRBillingInsurance                 - RelationshipToInsured              - NEMSIS V2 - E07_14 Element - Relationship to the Insured 
	-- PCRBilling                          - WorkRelated                        - NEMSIS V2 - E07_15 Element - Work-Related 
	-- PCRBilling                          - PatientOccupationalIndustry        - NEMSIS V2 - E07_16 Element - Patient’s Occupational Industry 
	-- PCRBilling                          - PatientOccupation                  - NEMSIS V2 - E07_17 Element - Patient’s Occupation 
	-- PCRBillingInsurance                 - GuardianLastName                   - NEMSIS V2 - E07_18 Element - Closest Relative/Guardian Last Name 
	-- PCRBillingInsurance                 - GuardianFirstName                  - NEMSIS V2 - E07_19 Element - First Name of the Closest Relative/Guardian 
	-- PCRBillingInsurance                 - GuardianMiddleName                 - NEMSIS V2 - E07_20 Element - Middle Initial/Name of the Closest Relative/Guardian 
	-- PCRBillingInsurance                 - GuardianAddress                    - NEMSIS V2 - E07_21 Element - Closest Relative/Guardian Street Address 
	-- PCRBillingInsurance                 - GuardianCity                       - NEMSIS V2 - E07_22 Element - Closest Relative/Guardian City 
	-- PCRBillingInsurance                 - GuardianState                      - NEMSIS V2 - E07_23 Element - Closest Relative/Guardian State 
	-- PCRBillingInsurance                 - GuardianZipCode                    - NEMSIS V2 - E07_24 Element - Closest Relative/Guardian Zip Code 
	-- PCRBillingInsurance                 - GuardianPhoneNumber                - NEMSIS V2 - E07_25 Element - Closest Relative/Guardian Phone Number 
	-- PCRBillingInsurance                 - GuardianRelationship               - NEMSIS V2 - E07_26 Element - Closest Relative/Guardian Relationship 
	-- PCRBillingInsurance                 - PatientEmployer                    - NEMSIS V2 - E07_27 Element - Patient's Employer 
	-- PCRBillingInsurance                 - PatientEmployerAddress             - NEMSIS V2 - E07_28 Element - Patient's Employer's Address 
	-- PCRBillingInsurance                 - PatientEmployerCity                - NEMSIS V2 - E07_29 Element - Patient’s Employer’s City 
	-- PCRBillingInsurance                 - PatientEmployerState               - NEMSIS V2 - E07_30 Element - Patient’s Employer’s State 
	-- PCRBillingInsurance                 - PatientEmployerZipCode             - NEMSIS V2 - E07_31 Element - Patient’s Employer’s Zip Code 
	-- PCRBilling                          - PatientWorkTelephoneNumber         - NEMSIS V2 - E07_32 Element - Patient's Work Telephone Number 
	-- PCRBilling                          - ResponseUrgency                    - NEMSIS V2 - E07_33 Element - Response Urgency 
	-- PCRBilling                          - CMSServiceLevel                    - NEMSIS V2 - E07_34 Element - CMS Service Level 
	-- PCRBillingConditionCodes            - CodeNumber                         - NEMSIS V2 - E07_35 Element - Condition Code Number 
	-- PCRBillingConditionCodes            - ICD9Code                           - NEMSIS V2 - E07_36 Element - ICD-9 Code for the Condition Code Number 
	-- PCRBillingConditionCodesModifier    - CodeModifier                       - NEMSIS V2 - E07_37 Element - Condition Code Modifier 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRBilling]'
			, 'Beginning the PCR Billing import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @Billing TABLE
		(
			[AgencyId] [int] NOT NULL,
			[PrimaryPaymentMethod] [int] NOT NULL,
			[CertificateMedicalNecessity] [int] NULL,
			[WorkRelated] [int] NULL,
			[PatientOccupationalIndustry] [int] NULL,
			[PatientOccupation] [int] NULL,
			[PatientWorkTelephoneNumber] [varchar](10) NULL,
			[ResponseUrgency] [int] NULL,
			[CMSServiceLevel] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @BillingInsurance TABLE
		(
			[AgencyId] [int] NOT NULL,
			[InsuranceCompanyId] [varchar](30) NULL,
			[InsuranceCompanyBillingPriority] [int] NULL,
			[InsuranceCompanyAddress] [varchar](30) NULL,
			[InsuranceCompanyCity] [varchar](30) NULL,
			[InsuranceCompanyState] [varchar](3) NULL,
			[InsuranceCompanyZipCode] [varchar](10) NULL,
			[InsuranceGroupId] [varchar](30) NULL,
			[InsurancePolicyIdNumber] [varchar](30) NULL,
			[InsuredLastName] [varchar](20) NULL,
			[InsuredFirstName] [varchar](20) NULL,
			[InsuredMiddleName] [varchar](20) NULL,
			[RelationshipToInsured] [int] NULL,
			[GuardianLastName] [varchar](20) NULL,
			[GuardianFirstName] [varchar](20) NULL,
			[GuardianMiddleName] [varchar](20) NULL,
			[GuardianAddress] [varchar](30) NULL,
			[GuardianCity] [varchar](30) NULL,
			[GuardianState] [varchar](3) NULL,
			[GuardianZipCode] [varchar](10) NULL,
			[GuardianPhoneNumber] [varchar](10) NULL,
			[GuardianRelationship] [int] NULL,
			[PatientEmployer] [varchar](30) NULL,
			[PatientEmployerAddress] [varchar](30) NULL,
			[PatientEmployerCity] [varchar](30) NULL,
			[PatientEmployerState] [varchar](3) NULL,
			[PatientEmployerZipCode] [varchar](10) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @BillingConditionCodes TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CodeNumber] [varchar](30) NOT NULL,
			[ICD9Code] [varchar](30) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @BillingConditionCodesModifier TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CodeModifier] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		INSERT INTO @Billing 
		(
			  [AgencyId]
			, [PrimaryPaymentMethod]
			, [CertificateMedicalNecessity]
			, [WorkRelated]
			, [PatientOccupationalIndustry]
			, [PatientOccupation]
			, [PatientWorkTelephoneNumber]
			, [ResponseUrgency]
			, [CMSServiceLevel]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PrimaryPaymentMethod]
			, [CertificateMedicalNecessity]
			, [WorkRelated]
			, [PatientOccupationalIndustry]
			, [PatientOccupation]
			, [PatientWorkTelephoneNumber]
			, [ResponseUrgency]
			, [CMSServiceLevel]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E07', 2) WITH (
					  [PrimaryPaymentMethod] VARCHAR(30) 'n:E07_01'
					, [CertificateMedicalNecessity] VARCHAR(30) 'n:E07_02'
					, [WorkRelated] VARCHAR(30) 'n:E07_15'
					, [PatientOccupationalIndustry] VARCHAR(30) 'n:E07_16'
					, [PatientOccupation] VARCHAR(30) 'n:E07_17'
					, [PatientWorkTelephoneNumber] VARCHAR(30) 'n:E07_32'
					, [ResponseUrgency] VARCHAR(30) 'n:E07_33'
					, [CMSServiceLevel] VARCHAR(30) 'n:E07_34'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @BillingInsurance 
		(
			  [AgencyId]
			, [InsuranceCompanyId]
			, [InsuranceCompanyBillingPriority]
			, [InsuranceCompanyAddress]
			, [InsuranceCompanyCity]
			, [InsuranceCompanyState]
			, [InsuranceCompanyZipCode]
			, [InsuranceGroupId]
			, [InsurancePolicyIdNumber]
			, [InsuredLastName]
			, [InsuredFirstName]
			, [InsuredMiddleName]
			, [RelationshipToInsured]
			, [GuardianLastName]
			, [GuardianFirstName]
			, [GuardianMiddleName]
			, [GuardianAddress]
			, [GuardianCity]
			, [GuardianState]
			, [GuardianZipCode]
			, [GuardianPhoneNumber]
			, [GuardianRelationship]
			, [PatientEmployer]
			, [PatientEmployerAddress]
			, [PatientEmployerCity]
			, [PatientEmployerState]
			, [PatientEmployerZipCode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [InsuranceCompanyId]
			, [InsuranceCompanyBillingPriority]
			, [InsuranceCompanyAddress]
			, [InsuranceCompanyCity]
			, [InsuranceCompanyState]
			, [InsuranceCompanyZipCode]
			, [InsuranceGroupId]
			, [InsurancePolicyIdNumber]
			, [InsuredLastName]
			, [InsuredFirstName]
			, [InsuredMiddleName]
			, [RelationshipToInsured]
			, [GuardianLastName]
			, [GuardianFirstName]
			, [GuardianMiddleName]
			, [GuardianAddress]
			, [GuardianCity]
			, [GuardianState]
			, [GuardianZipCode]
			, [GuardianPhoneNumber]
			, [GuardianRelationship]
			, [PatientEmployer]
			, [PatientEmployerAddress]
			, [PatientEmployerCity]
			, [PatientEmployerState]
			, [PatientEmployerZipCode]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E07', 2) WITH (
					  [InsuranceCompanyId] VARCHAR(30) 'n:E07_03_0/n:E07_03'
					, [InsuranceCompanyBillingPriority] VARCHAR(30) 'n:E07_03_0/n:E07_04'
					, [InsuranceCompanyAddress] VARCHAR(30) 'n:E07_03_0/n:E07_05_0/n:E07_05'
					, [InsuranceCompanyCity] VARCHAR(30) 'n:E07_03_0/n:E07_05_0/n:E07_06'
					, [InsuranceCompanyState] VARCHAR(30) 'n:E07_03_0/n:E07_05_0/n:E07_07'
					, [InsuranceCompanyZipCode] VARCHAR(30) 'n:E07_03_0/n:E07_05_0/n:E07_08'
					, [InsuranceGroupId] VARCHAR(30) 'n:E07_03_0/n:E07_09'
					, [InsurancePolicyIdNumber] VARCHAR(30) 'n:E07_03_0/n:E07_10'
					, [InsuredLastName] VARCHAR(30) 'n:E07_03_0/n:E07_11_0/n:E07_11'
					, [InsuredFirstName] VARCHAR(30) 'n:E07_03_0/n:E07_11_0/n:E07_12'
					, [InsuredMiddleName] VARCHAR(30) 'n:E07_03_0/n:E07_11_0/n:E07_13'
					, [RelationshipToInsured] VARCHAR(30) 'n:E07_03_0/n:E07_14'
					, [GuardianLastName] VARCHAR(30) 'n:E07_18_0/n:E07_18_01/n:E07_18'
					, [GuardianFirstName] VARCHAR(30) 'n:E07_18_0/n:E07_18_01/n:E07_19'
					, [GuardianMiddleName] VARCHAR(30) 'n:E07_18_0/n:E07_18_01/n:E07_20'
					, [GuardianAddress] VARCHAR(30) 'n:E07_18_0/n:E07_21_0/n:E07_21'
					, [GuardianCity] VARCHAR(30) 'n:E07_18_0/n:E07_21_0/n:E07_22'
					, [GuardianState] VARCHAR(30) 'n:E07_18_0/n:E07_21_0/n:E07_23'
					, [GuardianZipCode] VARCHAR(30) 'n:E07_18_0/n:E07_21_0/n:E07_24'
					, [GuardianPhoneNumber] VARCHAR(30) 'n:E07_18_0/n:E07_25'
					, [GuardianRelationship] VARCHAR(30) 'n:E07_18_0/n:E07_26'
					, [PatientEmployer] VARCHAR(30) 'n:E07_27_0/n:E07_27'
					, [PatientEmployerAddress] VARCHAR(30) 'n:E07_27_0/n:E07_28_0/n:E07_28'
					, [PatientEmployerCity] VARCHAR(30) 'n:E07_27_0/n:E07_28_0/n:E07_29'
					, [PatientEmployerState] VARCHAR(30) 'n:E07_27_0/n:E07_28_0/n:E07_30'
					, [PatientEmployerZipCode] VARCHAR(30) 'n:E07_27_0/n:E07_28_0/n:E07_31'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
					
	
		INSERT INTO @BillingConditionCodes 
		(
			  [AgencyId]
			, [CodeNumber]
			, [ICD9Code]			
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CodeNumber]
			, [ICD9Code]			
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E07', 2) WITH (
					  [CodeNumber] [varchar](30) 'n:E07_35_0/n:E07_35'
					, [ICD9Code] [varchar](30) 'n:E07_35_0/n:E07_36'		
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
					
	
		INSERT INTO @BillingConditionCodesModifier 
		(
			  [AgencyId]
			, [CodeModifier]		
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CodeModifier]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E07', 2) WITH (
					  [CodeModifier] [varchar](30) 'n:E07_37'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO [dbo].[PCRBilling]
		(
			  [PatientCareReportId]
			, [AgencyId]
			, [PrimaryPaymentMethod]
			, [CertificateMedicalNecessity]
			, [WorkRelated]
			, [PatientOccupationalIndustry]
			, [PatientOccupation]
			, [PatientWorkTelephoneNumber]
			, [ResponseUrgency]
			, [CMSServiceLevel]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate])
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [B].[PrimaryPaymentMethod]
			, [B].[CertificateMedicalNecessity]
			, [B].[WorkRelated]
			, [B].[PatientOccupationalIndustry]
			, [B].[PatientOccupation]
			, [B].[PatientWorkTelephoneNumber]
			, [B].[ResponseUrgency]
			, [B].[CMSServiceLevel]
			, [B].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Billing AS [B]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [B].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [B].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRBillingInsurance]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [InsuranceCompanyId]
			, [InsuranceCompanyBillingPriority]
			, [InsuranceCompanyAddress]
			, [InsuranceCompanyCity]
			, [InsuranceCompanyState]
			, [InsuranceCompanyZipCode]
			, [InsuranceGroupId]
			, [InsurancePolicyIdNumber]
			, [InsuredLastName]
			, [InsuredFirstName]
			, [InsuredMiddleName]
			, [RelationshipToInsured]
			, [GuardianLastName]
			, [GuardianFirstName]
			, [GuardianMiddleName]
			, [GuardianAddress]
			, [GuardianCity]
			, [GuardianState]
			, [GuardianZipCode]
			, [GuardianPhoneNumber]
			, [GuardianRelationship]
			, [PatientEmployer]
			, [PatientEmployerAddress]
			, [PatientEmployerCity]
			, [PatientEmployerState]
			, [PatientEmployerZipCode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [BI].[InsuranceCompanyId]
			, [BI].[InsuranceCompanyBillingPriority]
			, [BI].[InsuranceCompanyAddress]
			, [BI].[InsuranceCompanyCity]
			, [BI].[InsuranceCompanyState]
			, [BI].[InsuranceCompanyZipCode]
			, [BI].[InsuranceGroupId]
			, [BI].[InsurancePolicyIdNumber]
			, [BI].[InsuredLastName]
			, [BI].[InsuredFirstName]
			, [BI].[InsuredMiddleName]
			, [BI].[RelationshipToInsured]
			, [BI].[GuardianLastName]
			, [BI].[GuardianFirstName]
			, [BI].[GuardianMiddleName]
			, [BI].[GuardianAddress]
			, [BI].[GuardianCity]
			, [BI].[GuardianState]
			, [BI].[GuardianZipCode]
			, [BI].[GuardianPhoneNumber]
			, [BI].[GuardianRelationship]
			, [BI].[PatientEmployer]
			, [BI].[PatientEmployerAddress]
			, [BI].[PatientEmployerCity]
			, [BI].[PatientEmployerState]
			, [BI].[PatientEmployerZipCode]
			, [BI].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@BillingInsurance AS [BI]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [BI].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [BI].[FileImportRecordId];


		INSERT INTO [dbo].[PCRBillingConditionCodes]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [CodeNumber]
			, [ICD9Code]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [BCC].[CodeNumber]
			, [BCC].[ICD9Code]	
			, [BCC].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@BillingConditionCodes AS [BCC]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [BCC].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [BCC].[FileImportRecordId];


	INSERT INTO [dbo].[PCRBillingConditionCodesModifier]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [CodeModifier]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [BCCM].[CodeModifier]
			, [BCCM].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@BillingConditionCodesModifier AS [BCCM]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [BCCM].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [BCCM].[FileImportRecordId];
				

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRBilling]'
			, 'Completed the PCR Billing import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRBilling] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
