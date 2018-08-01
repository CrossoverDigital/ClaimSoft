USE [cdTestDB]
GO
/****** Object:  StoredProcedure [dbo].[ProcessNemsisFilePCRMedicalHistory]    Script Date: 7/4/2018 1:27:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================================
-- Author:	 Charles J. Duncan
-- Create date: March 29, 2018
-- Description: Parses the Nemsis file and inserts the parts into the appropriate tables.
-- ==========================================================================================

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRMedicalHistory] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                                       - Column                                 - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRMedicalHistoryPatientBarriers            - BarriersPatientCare                    - NEMSIS V2 - E12_01 Element - Barriers to Patient Care 
	-- PCRMedicalHistory                           - SendingFacilityMRNumber                - NEMSIS V2 - E12_02 Element - Sending Facility Medical Record Number 
	-- PCRMedicalHistory                           - DestinationMRNumber                    - NEMSIS V2 - E12_03 Element - Destination Medical Record Number 
	-- PCRMedicalHistory                           - PrimaryPractitionerFirstName           - NEMSIS V2 - E12_04 Element - First Name of Patient's Primary Practitioner 
	-- PCRMedicalHistory                           - PrimaryPractitionerMiddleName          - NEMSIS V2 - E12_05 Element - Middle Name of Patient's Primary Practitioner 
	-- PCRMedicalHistory                           - PrimaryPractitionerLastName            - NEMSIS V2 - E12_06 Element - Last Name of Patient's Primary Practitioner 
	-- PCRMedicalHistoryLivingWill                 - AdvancedDirective                      - NEMSIS V2 - E12_07 Element - Advanced Directives 
	-- PCRMedicalHistoryMedicationAllergies        - MedicationAllergy                      - NEMSIS V2 - E12_08 Element - Medication Allergies 
	-- PCRMedicalHistoryAllergies                  - EnvironmentalFoodAllergy               - NEMSIS V2 - E12_09 Element - Environmental/Food Allergies 
	-- PCRMedicalHistoryPreexistingMedicalSurgery  - MedicalSurgicalHistory                 - NEMSIS V2 - E12_10 Element - Medical/Surgical History 
	-- PCRMedicalHistory                           - MedicalHistoryObtainedFrom             - NEMSIS V2 - E12_11 Element - Medical History Obtained From 
	-- PCRMedicalHistoryImmunizationDetails        - ImmunizationHistory                    - NEMSIS V2 - E12_12 Element - Immunization History 
	-- PCRMedicalHistoryImmunizationDetails        - ImmunizationDate                       - NEMSIS V2 - E12_13 Element - Immunization Date 
	-- PCRMedicalHistoryCurrentMedication          - CurrentMedication                      - NEMSIS V2 - E12_14 Element - Current Medications 
	-- PCRMedicalHistoryCurrentMedication          - CurrentMedicationDose                  - NEMSIS V2 - E12_15 Element - Current Medication Dose 
	-- PCRMedicalHistoryCurrentMedication          - CurrentMedicationDosageUnit            - NEMSIS V2 - E12_16 Element - Current Medication Dosage Unit 
	-- PCRMedicalHistoryCurrentMedication          - CurrentMedicationAdministrationRoute   - NEMSIS V2 - E12_17 Element - Current Medication Administration Route 
	-- PCRMedicalHistory                           - PresenceEmergencyInformationForm       - NEMSIS V2 - E12_18 Element - Presence of Emergency Information Form 
	-- PCRMedicalHistoryAlcoholDrugIndicators      - AlcoholDrugUseIndicator                - NEMSIS V2 - E12_19 Element - Alcohol/Drug Use Indicators 
	-- PCRMedicalHistory                           - Pregnancy                              - NEMSIS V2 - E12_20 Element - Pregnancy 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMedicalHistory]'
			, 'Beginning the PCR Medical History import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
		

		DECLARE @MedicalHistory TABLE
		(
			[AgencyId] [int] NOT NULL,
			[SendingFacilityMRNumber] [varchar](30) NULL,
			[DestinationMRNumber] [varchar](30) NULL,
			[PrimaryPractitionerFirstName] [varchar](20) NULL,
			[PrimaryPractitionerMiddleName] [varchar](20) NULL,
			[PrimaryPractitionerLastName] [varchar](20) NULL,
			[MedicalHistoryObtainedFrom] [int] NULL,
			[PresenceEmergencyInformationForm] [int] NULL,
			[Pregnancy] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		DECLARE @MedicalHistoryAlcoholDrugIndicators TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AlcoholDrugUseIndicator] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryAllergies TABLE
		(
			[AgencyId] [int] NOT NULL,
			[EnvironmentalFoodAllergy] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryCurrentMedication TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CurrentMedication] [varchar](30) NOT NULL,
			[CurrentMedicationDose] [decimal](8, 2) NULL,
			[CurrentMedicationDosageUnit] [int] NULL,
			[CurrentMedicationAdministrationRoute] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryImmunizationDetails TABLE
		(
			[AgencyId] [int] NOT NULL,
			[ImmunizationHistory] [int] NOT NULL,
			[ImmunizationDate] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryLivingWill TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AdvancedDirective] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryMedicationAllergies TABLE
		(
			[AgencyId] [int] NOT NULL,
			[MedicationAllergy] [varchar](30) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryPatientBarriers TABLE
		(
			[AgencyId] [int] NOT NULL,
			[BarriersPatientCare] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @MedicalHistoryPreexistingMedicalSurgery TABLE
		(
			[AgencyId] [int] NOT NULL,
			[MedicalSurgicalHistory] [varchar](30) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		INSERT INTO @MedicalHistory
        (
			  [AgencyId]
			, [SendingFacilityMRNumber]
			, [DestinationMRNumber]
			, [PrimaryPractitionerFirstName]
			, [PrimaryPractitionerMiddleName]
			, [PrimaryPractitionerLastName]
			, [MedicalHistoryObtainedFrom]
			, [PresenceEmergencyInformationForm]
			, [Pregnancy]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [SendingFacilityMRNumber]
			, [DestinationMRNumber]
			, [PrimaryPractitionerFirstName]
			, [PrimaryPractitionerMiddleName]
			, [PrimaryPractitionerLastName]
			, [MedicalHistoryObtainedFrom]
			, [PresenceEmergencyInformationForm]
			, [Pregnancy]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH 
		(
			  [SendingFacilityMRNumber] VARCHAR(15) 'n:E12_02'
			, [DestinationMRNumber] VARCHAR(15) 'n:E12_03'
			, [PrimaryPractitionerFirstName] VARCHAR(10) 'n:E12_4_0/n:E12_04'
			, [PrimaryPractitionerMiddleName] VARCHAR(10) 'n:E12_4_0/n:E12_05'
			, [PrimaryPractitionerLastName] VARCHAR(10) 'n:E12_4_0/n:E12_06'
			, [MedicalHistoryObtainedFrom] INT 'n:E12_11'
			, [PresenceEmergencyInformationForm] INT 'n:E12_18'
			, [Pregnancy] INT 'n:E12_20'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
			

		INSERT INTO @MedicalHistoryAlcoholDrugIndicators
		(
			  [AgencyId]
			, [AlcoholDrugUseIndicator]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AlcoholDrugUseIndicator]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [AlcoholDrugUseIndicator] INT 'n:E12_19'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @MedicalHistoryAllergies 
		(
			  [AgencyId]
			, [EnvironmentalFoodAllergy]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [EnvironmentalFoodAllergy]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [EnvironmentalFoodAllergy] INT 'n:E12_09'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @MedicalHistoryCurrentMedication 
		(
			  [AgencyId]
			, [CurrentMedication]
			, [CurrentMedicationDose]
			, [CurrentMedicationDosageUnit]
			, [CurrentMedicationAdministrationRoute]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CurrentMedication]
			, [CurrentMedicationDose]
			, [CurrentMedicationDosageUnit]
			, [CurrentMedicationAdministrationRoute]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [CurrentMedication] VARCHAR(15) 'n:E12_14_0/n:E12_14'
					, [CurrentMedicationDose] DECIMAL 'n:E12_14_0/n:E12_15_0/n:E12_15'
					, [CurrentMedicationDosageUnit] INT 'n:E12_14_0/n:E12_15_0/n:E12_16'
					, [CurrentMedicationAdministrationRoute] INT 'n:E12_14_0/n:E12_17'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04')
		WHERE [CurrentMedication] IS NOT NULL;
	

		INSERT INTO @MedicalHistoryImmunizationDetails 
		(
			  [AgencyId]
			, [ImmunizationHistory]
			, [ImmunizationDate]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [ImmunizationHistory]
			, [ImmunizationDate]	
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [ImmunizationHistory] INT 'n:E12_12_0/n:E12_12'
					, [ImmunizationDate] INT 'n:E12_12_0/n:E12_13'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04')
		WHERE [ImmunizationHistory] IS NOT NULL;


		INSERT INTO @MedicalHistoryLivingWill 
		(
			  [AgencyId]
			, [AdvancedDirective]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AdvancedDirective]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [AdvancedDirective] INT 'n:E12_07'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @MedicalHistoryMedicationAllergies 
		(
			  [AgencyId]
			, [MedicationAllergy]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [MedicationAllergy]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [MedicationAllergy] VARCHAR(15) 'n:E12_08'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');


		INSERT INTO @MedicalHistoryPatientBarriers 
		(
			  [AgencyId]
			, [BarriersPatientCare]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [BarriersPatientCare]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [BarriersPatientCare] INT 'n:E12_01'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');


		INSERT INTO @MedicalHistoryPreexistingMedicalSurgery 
		(
			  [AgencyId]
			, [MedicalSurgicalHistory]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [MedicalSurgicalHistory]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
					  [MedicalSurgicalHistory] VARCHAR(15) 'n:E12_10'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');			
					

		INSERT INTO [dbo].[PCRMedicalHistory]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [SendingFacilityMRNumber]
			, [DestinationMRNumber]
			, [PrimaryPractitionerFirstName]
			, [PrimaryPractitionerMiddleName]
			, [PrimaryPractitionerLastName]
			, [MedicalHistoryObtainedFrom]
			, [PresenceEmergencyInformationForm]
			, [Pregnancy]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MH].[SendingFacilityMRNumber]
			, [MH].[DestinationMRNumber]
			, [MH].[PrimaryPractitionerFirstName]
			, [MH].[PrimaryPractitionerMiddleName]
			, [MH].[PrimaryPractitionerLastName]
			, [MH].[MedicalHistoryObtainedFrom]
			, [MH].[PresenceEmergencyInformationForm]
			, [MH].[Pregnancy]
			, [MH].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistory AS [MH]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MH].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MH].[FileImportRecordId];
				

		INSERT INTO [dbo].[PCRMedicalHistoryAlcoholDrugIndicators]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [AlcoholDrugUseIndicator]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHADI].[AlcoholDrugUseIndicator]
			, [MHADI].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryAlcoholDrugIndicators AS [MHADI]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHADI].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHADI].[FileImportRecordId];
		
		
		INSERT INTO [dbo].[PCRMedicalHistoryAllergies]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [EnvironmentalFoodAllergy]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHA].[EnvironmentalFoodAllergy]
			, [MHA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryAllergies AS [MHA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHA].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRMedicalHistoryCurrentMedication]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [CurrentMedication]
			, [CurrentMedicationDose]
			, [CurrentMedicationDosageUnit]
			, [CurrentMedicationAdministrationRoute]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHCM].[CurrentMedication]
			, [MHCM].[CurrentMedicationDose]
			, [MHCM].[CurrentMedicationDosageUnit]
			, [MHCM].[CurrentMedicationAdministrationRoute]
			, [MHCM].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryCurrentMedication AS [MHCM]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHCM].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHCM].[FileImportRecordId];
				

		INSERT INTO [dbo].[PCRMedicalHistoryImmunizationDetails]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [ImmunizationHistory]
            , [ImmunizationDate]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHID].[ImmunizationHistory]
			, [MHID].[ImmunizationDate]
			, [MHID].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryImmunizationDetails AS [MHID]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHID].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHID].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRMedicalHistoryLivingWill]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [AdvancedDirective]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHLW].[AdvancedDirective]
			, [MHLW].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryLivingWill AS [MHLW]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHLW].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHLW].[FileImportRecordId];
				

		INSERT INTO [dbo].[PCRMedicalHistoryMedicationAllergies]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [MedicationAllergy]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHMA].[MedicationAllergy]
			, [MHMA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryMedicationAllergies AS [MHMA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHMA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHMA].[FileImportRecordId];
				

		INSERT INTO [dbo].[PCRMedicalHistoryPatientBarriers]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [BarriersPatientCare]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHPB].[BarriersPatientCare]
			, [MHPB].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryPatientBarriers AS [MHPB]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHPB].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHPB].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMedicalHistoryPreexistingMedicalSurgery]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [MedicalSurgicalHistory]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MHPMS].[MedicalSurgicalHistory]
			, [MHPMS].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalHistoryPreexistingMedicalSurgery AS [MHPMS]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MHPMS].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MHPMS].[FileImportRecordId];


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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMedicalHistory]'
			, 'Completed the PCR Medical History import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRMedicalHistory] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
