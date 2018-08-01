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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRMiscellaneous] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table                                                    - Column                                     - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRMiscellaneous                                         - ReviewRequested                            - NEMSIS V2 - E23_01 Element - Review Requested 
	-- PCRMiscellaneousPatientIndicationCriteriaRegistry        - PotentialRegistryCandidate                 - NEMSIS V2 - E23_02 Element - Potential Registry Candidate 
	-- PCRMiscellaneousProtectiveEquipmentUsed                  - PersonalProtectiveEquipmentUsed            - NEMSIS V2 - E23_03 Element - Personal Protective Equipment Used 
	-- PCRMiscellaneousSuspicionMultiCasualtyDomesticTerrorism  - SuspectedIntentionalUnintentionalDisaster  - NEMSIS V2 - E23_04 Element - Suspected Intentional, or Unintentional Disaster 
	-- PCRMiscellaneous											- SuspectedContactBodyFluidsEMSInjuryDeath   - NEMSIS V2 - E23_05 Element - Suspected Contact with Blood/Body Fluids of EMS Injury or Death 
	-- PCRMiscellaneousTypeExposureBodilyFluids                 - TypeSuspectedFluidExposure                 - NEMSIS V2 - E23_06 Element - Type of Suspected Blood/Body Fluid Exposure, Injury, or Death 
	-- PCRMiscellaneousPersonnelExposedFluids                   - PersonnelExposed                           - NEMSIS V2 - E23_07 Element - Personnel Exposed 
	-- PCRMiscellaneous											- RequiredReportableCondition                - NEMSIS V2 - E23_08 Element - Required Reportable Conditions 
	-- PCRMiscellaneousLocalAgencyResearchField                 - ResearchSurveyField                        - NEMSIS V2 - E23_09 Element - Research Survey Field 
	-- PCRMiscellaneous											- ReportGeneratedBy                          - NEMSIS V2 - E23_10 Element - Who Generated this Report? 
	-- PCRMiscellaneousLocalAgencyResearchField                 - ResearchSurveyFieldTitle                   - NEMSIS V2 - E23_11 Element - Research Survey Field Title 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMiscellaneous]'
			, 'Beginning the PCR Miscellaneous import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
	

		DECLARE @Miscellaneous TABLE
		(
			[AgencyId] INT NOT NULL,
			[ReviewRequested] INT NULL,
			[SuspectedContactBodyFluidsEMSInjuryDeath] INT NULL,
			[RequiredReportableCondition] INT NULL,
			[ReportGeneratedBy] VARCHAR (15) NULL,
			[FileImportRecordId] NVARCHAR (50) NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousLocalAgencyResearchField TABLE
		(
			[AgencyId] INT NOT NULL,
			[ResearchSurveyField] VARCHAR (50) NOT NULL,
			[ResearchSurveyFieldTitle] VARCHAR (30) NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NOT NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousPatientIndicationCriteriaRegistry TABLE
		(
			[AgencyId] INT NOT NULL,
			[PotentialRegistryCandidate] INT NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NOT NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousPersonnelExposedFluids TABLE
		(
			[AgencyId] INT NOT NULL,
			[PersonnelExposed] INT NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NOT NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousProtectiveEquipmentUsed TABLE
		(
			[AgencyId] INT NOT NULL,
			[PersonalProtectiveEquipmentUsed] INT NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousSuspicionMultiCasualtyDomesticTerrorism TABLE
		(
			[AgencyId] INT NOT NULL,
			[SuspectedIntentionalUnintentionalDisaster] INT NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)


		DECLARE @MiscellaneousTypeExposureBodilyFluids TABLE
		(
			[AgencyId] INT NOT NULL,
			[TypeSuspectedFluidExposure] INT NOT NULL,
			[FileImportRecordId] NVARCHAR (50) NOT NULL,
			[CreateBy] NVARCHAR (128) NOT NULL,
			[CreateDate] DATETIME NOT NULL,
			[LastModifyBy] NVARCHAR (128) NOT NULL,
			[LastModifyDate] DATETIME NOT NULL
		)
		
           
		INSERT INTO @Miscellaneous
        (
			  [AgencyId]
			, [ReviewRequested]
			, [SuspectedContactBodyFluidsEMSInjuryDeath]
			, [RequiredReportableCondition]
			, [ReportGeneratedBy]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [ReviewRequested]
			, [SuspectedContactBodyFluidsEMSInjuryDeath]
			, [RequiredReportableCondition]
			, [ReportGeneratedBy]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [ReviewRequested] INT 'n:E23_01'
			, [SuspectedContactBodyFluidsEMSInjuryDeath] INT 'n:E23_05'
			, [TypeSuspectedFluidExposure] INT 'n:E23_06'
			, [RequiredReportableCondition] INT 'n:E23_08'
			, [ReportGeneratedBy] VARCHAR(15) 'n:E23_10'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);

		
		INSERT INTO @MiscellaneousLocalAgencyResearchField
        (
			  [AgencyId]
			, [ResearchSurveyField]
			, [ResearchSurveyFieldTitle]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [ResearchSurveyField]
			, [ResearchSurveyFieldTitle]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [ResearchSurveyField] VARCHAR(25) 'n:E23_09_0/n:E23_09'
			, [ResearchSurveyFieldTitle] VARCHAR(15) 'n:E23_09_0/n:E23_11'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		)
		WHERE [ResearchSurveyField] IS NOT NULL;
				

		INSERT INTO @MiscellaneousPatientIndicationCriteriaRegistry
        (
			  [AgencyId]
			, [PotentialRegistryCandidate]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PotentialRegistryCandidate]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [PotentialRegistryCandidate] INT 'n:E23_02'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
						

		INSERT INTO @MiscellaneousPersonnelExposedFluids
        (
			  [AgencyId]
			, [PersonnelExposed]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PersonnelExposed]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [PersonnelExposed] INT 'n:E23_07'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
								

		INSERT INTO @MiscellaneousProtectiveEquipmentUsed
        (
			  [AgencyId]
			, [PersonalProtectiveEquipmentUsed]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PersonalProtectiveEquipmentUsed]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [PersonalProtectiveEquipmentUsed] INT 'n:E23_03'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
						

		INSERT INTO @MiscellaneousSuspicionMultiCasualtyDomesticTerrorism
        (
			  [AgencyId]
			, [SuspectedIntentionalUnintentionalDisaster]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [SuspectedIntentionalUnintentionalDisaster]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [SuspectedIntentionalUnintentionalDisaster] INT 'n:E23_04'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
										

		INSERT INTO @MiscellaneousTypeExposureBodilyFluids
        (
			  [AgencyId]
			, [TypeSuspectedFluidExposure]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [TypeSuspectedFluidExposure]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH 
		(
			  [TypeSuspectedFluidExposure] INT 'n:E23_06'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);

		
		INSERT INTO [dbo].[PCRMiscellaneous]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [ReviewRequested]
			, [SuspectedContactBodyFluidsEMSInjuryDeath]
			, [RequiredReportableCondition]
			, [ReportGeneratedBy]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [M].[ReviewRequested]
			, [M].[SuspectedContactBodyFluidsEMSInjuryDeath]
			, [M].[RequiredReportableCondition]
			, [M].[ReportGeneratedBy]
			, [M].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Miscellaneous AS [M]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [M].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [M].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousLocalAgencyResearchField]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [ResearchSurveyField]
            , [ResearchSurveyFieldTitle]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MARF].[ResearchSurveyField]
            , [MARF].[ResearchSurveyFieldTitle]
			, [MARF].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousLocalAgencyResearchField AS [MARF]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MARF].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MARF].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousPatientIndicationCriteriaRegistry]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [PotentialRegistryCandidate]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MPICR].[PotentialRegistryCandidate]
			, [MPICR].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousPatientIndicationCriteriaRegistry AS [MPICR]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MPICR].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MPICR].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousPersonnelExposedFluids]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [PersonnelExposed]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MPEF].[PersonnelExposed]
			, [MPEF].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousPersonnelExposedFluids AS [MPEF]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MPEF].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MPEF].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousProtectiveEquipmentUsed]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [PersonalProtectiveEquipmentUsed]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MPEU].[PersonalProtectiveEquipmentUsed]
			, [MPEU].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousProtectiveEquipmentUsed AS [MPEU]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MPEU].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MPEU].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousSuspicionMultiCasualtyDomesticTerrorism]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [SuspectedIntentionalUnintentionalDisaster]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MSMCDT].[SuspectedIntentionalUnintentionalDisaster]
			, [MSMCDT].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousSuspicionMultiCasualtyDomesticTerrorism AS [MSMCDT]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MSMCDT].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MSMCDT].[FileImportRecordId];


		INSERT INTO [dbo].[PCRMiscellaneousTypeExposureBodilyFluids]
        (
			  [PatientCareReportId]
			, [AgencyId]
            , [TypeSuspectedFluidExposure]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
            , [MTEBF].[TypeSuspectedFluidExposure]
			, [MTEBF].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MiscellaneousTypeExposureBodilyFluids AS [MTEBF]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MTEBF].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MTEBF].[FileImportRecordId];


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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMiscellaneous]'
			, 'Completed the PCR Miscellaneous import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRMiscellaneous] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
