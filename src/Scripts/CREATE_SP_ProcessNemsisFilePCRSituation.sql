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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRSituation] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table                                 - Column                                  - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRSituationPriorAid                  - PriorAid                                - NEMSIS V2 - E09_01 Element - Prior Aid 
	-- PCRSituationPriorAidPerformedBy       - PriorAidPerformedBy                     - NEMSIS V2 - E09_02 Element - Prior Aid Performed By 
	-- PCRSituation                          - PriorAidOutcome                         - NEMSIS V2 - E09_03 Element - Outcome of the Prior Aid 
	-- PCRSituation                          - PossibleInjury                          - NEMSIS V2 - E09_04 Element - Possible Injury 
	-- PCRSituation                          - ChiefComplaint                          - NEMSIS V2 - E09_05 Element - Chief Complaint 
	-- PCRSituation                          - DurationChiefComplaint                  - NEMSIS V2 - E09_06 Element - Duration of Chief Complaint 
	-- PCRSituation                          - TimeChiefComplaintUnitsDuration         - NEMSIS V2 - E09_07 Element - Time Units of Duration of Chief Complaint 
	-- PCRSituation                          - SecondaryComplaintNarrative             - NEMSIS V2 - E09_08 Element - Secondary Complaint Narrative 
	-- PCRSituation                          - DurationSecondaryComplaint              - NEMSIS V2 - E09_09 Element - Duration of Secondary Complaint 
	-- PCRSituation                          - TimeUnitsDurationSecondaryComplaint     - NEMSIS V2 - E09_10 Element - Time Units of Duration of Secondary Complaint 
	-- PCRSituation                          - ChiefComplaintAnatomicLocation          - NEMSIS V2 - E09_11 Element - Chief Complaint Anatomic Location 
	-- PCRSituation                          - ChiefComplaintOrganSystem               - NEMSIS V2 - E09_12 Element - Chief Complaint Organ System 
	-- PCRSituation                          - PrimarySymptom                          - NEMSIS V2 - E09_13 Element - Primary Symptom 
	-- PCRSituationOtherSymptoms             - OtherAssociatedSymptom                  - NEMSIS V2 - E09_14 Element - Other Associated Symptoms 
	-- PCRSituation                          - ProvidersPrimaryImpression              - NEMSIS V2 - E09_15 Element - Provider's Primary Impression 
	-- PCRSituation                          - ProvidersSecondaryImpression            - NEMSIS V2 - E09_16 Element - Provider’s Secondary Impression 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRSituation]'
			, 'Beginning the PCR Situation import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @Situation TABLE
		(
			  [AgencyId] [int] NOT NULL
			, [PriorAidOutcome] [INT] NOT NULL
			, [PossibleInjury] [INT] NOT NULL
			, [ChiefComplaint] [VARCHAR](25) NULL
			, [DurationChiefComplaint] [INT] NULL
			, [TimeChiefComplaintUnitsDuration] [INT] NULL
			, [SecondaryComplaintNarrative] [VARCHAR](25) NULL
			, [DurationSecondaryComplaint] [INT] NULL
			, [TimeUnitsDurationSecondaryComplaint] [INT] NULL
			, [ChiefComplaintAnatomicLocation] [INT] NOT NULL
			, [ChiefComplaintOrganSystem] [INT] NOT NULL
			, [PrimarySymptom] [INT] NOT NULL
			, [ProvidersPrimaryImpression] [INT] NOT NULL
			, [ProvidersSecondaryImpression] [INT] NOT NULL
			, [FileImportRecordId] [nvarchar](50) NOT NULL
			, [CreateBy] [nvarchar](128) NOT NULL
			, [CreateDate] [datetime] NOT NULL
			, [LastModifyBy] [nvarchar](128) NOT NULL
			, [LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @SituationPriorAid TABLE
		(
			  [AgencyId] [int] NOT NULL
			, [PriorAid] [VARCHAR](15) NOT NULL
			, [FileImportRecordId] [nvarchar](50) NOT NULL
			, [CreateBy] [nvarchar](128) NOT NULL
			, [CreateDate] [datetime] NOT NULL
			, [LastModifyBy] [nvarchar](128) NOT NULL
			, [LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @SituationPriorAidPerformedBy TABLE
		(
			  [AgencyId] [int] NOT NULL
			, [PriorAidPerformedBy] [INT] NOT NULL
			, [FileImportRecordId] [nvarchar](50) NOT NULL
			, [CreateBy] [nvarchar](128) NOT NULL
			, [CreateDate] [datetime] NOT NULL
			, [LastModifyBy] [nvarchar](128) NOT NULL
			, [LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @SituationOtherSymptoms TABLE
		(
			  [AgencyId] [int] NOT NULL
			, [OtherAssociatedSymptom] [INT] NOT NULL
			, [FileImportRecordId] [nvarchar](50) NOT NULL
			, [CreateBy] [nvarchar](128) NOT NULL
			, [CreateDate] [datetime] NOT NULL
			, [LastModifyBy] [nvarchar](128) NOT NULL
			, [LastModifyDate] [datetime] NOT NULL
		)


		INSERT INTO @Situation
        (
			  [AgencyId]
			, [PriorAidOutcome]
			, [PossibleInjury]
			, [ChiefComplaint]
			, [DurationChiefComplaint]
			, [TimeChiefComplaintUnitsDuration]
			, [SecondaryComplaintNarrative]
			, [DurationSecondaryComplaint]
			, [TimeUnitsDurationSecondaryComplaint]
			, [ChiefComplaintAnatomicLocation]
			, [ChiefComplaintOrganSystem]
			, [PrimarySymptom]
			, [ProvidersPrimaryImpression]
			, [ProvidersSecondaryImpression]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PriorAidOutcome]
			, [PossibleInjury]
			, [ChiefComplaint]
			, [DurationChiefComplaint]
			, [TimeChiefComplaintUnitsDuration]
			, [SecondaryComplaintNarrative]
			, [DurationSecondaryComplaint]
			, [TimeUnitsDurationSecondaryComplaint]
			, [ChiefComplaintAnatomicLocation]
			, [ChiefComplaintOrganSystem]
			, [PrimarySymptom]
			, [ProvidersPrimaryImpression]
			, [ProvidersSecondaryImpression]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E09', 2) WITH 
		(
		      [PriorAidOutcome] INT 'n:E09_03'
			, [PossibleInjury] INT 'n:E09_04'
			, [ChiefComplaint] VARCHAR(25) 'n:E09_05'
			, [DurationChiefComplaint] INT 'n:E09_06'
			, [TimeChiefComplaintUnitsDuration] INT 'n:E09_07'
			, [SecondaryComplaintNarrative] VARCHAR(25) 'n:E09_08'
			, [DurationSecondaryComplaint] INT 'n:E09_09'
			, [TimeUnitsDurationSecondaryComplaint] INT 'n:E09_10'
			, [ChiefComplaintAnatomicLocation] INT 'n:E09_11'
			, [ChiefComplaintOrganSystem] INT 'n:E09_12'
			, [PrimarySymptom] INT 'n:E09_13'
			, [ProvidersPrimaryImpression] INT 'n:E09_15'
			, [ProvidersSecondaryImpression] INT 'n:E09_16'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		

		INSERT INTO @SituationPriorAid 
		(
			  [AgencyId]
			, [PriorAid]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PriorAid]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E09', 2) WITH (
					  [PriorAid] VARCHAR(15) 'n:E09_01'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
			

		INSERT INTO @SituationPriorAidPerformedBy 
		(
			  [AgencyId]
			, [PriorAidPerformedBy]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PriorAidPerformedBy]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E09', 2) WITH (
					  [PriorAidPerformedBy] INT 'n:E09_02'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @SituationOtherSymptoms 
		(
			  [AgencyId]
			, [OtherAssociatedSymptom]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [OtherAssociatedSymptom]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E09', 2) WITH (
					  [OtherAssociatedSymptom] INT 'n:E09_14'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO [dbo].[PCRSituation]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [PriorAidOutcome]
			, [PossibleInjury]
			, [ChiefComplaint]
			, [DurationChiefComplaint]
			, [TimeChiefComplaintUnitsDuration]
			, [SecondaryComplaintNarrative]
			, [DurationSecondaryComplaint]
			, [TimeUnitsDurationSecondaryComplaint]
			, [ChiefComplaintAnatomicLocation]
			, [ChiefComplaintOrganSystem]
			, [PrimarySymptom]
			, [ProvidersPrimaryImpression]
			, [ProvidersSecondaryImpression]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [S].[PriorAidOutcome]
			, [S].[PossibleInjury]
			, [S].[ChiefComplaint]
			, [S].[DurationChiefComplaint]
			, [S].[TimeChiefComplaintUnitsDuration]
			, [S].[SecondaryComplaintNarrative]
			, [S].[DurationSecondaryComplaint]
			, [S].[TimeUnitsDurationSecondaryComplaint]
			, [S].[ChiefComplaintAnatomicLocation]
			, [S].[ChiefComplaintOrganSystem]
			, [S].[PrimarySymptom]
			, [S].[ProvidersPrimaryImpression]
			, [S].[ProvidersSecondaryImpression]
			, [S].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Situation AS [S]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [S].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [S].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRSituationPriorAid]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [PriorAid]
            , [FileImportRecordId]
            , [CreateBy]
            , [CreateDate]
            , [LastModifyBy]
            , [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [SPA].[PriorAid]
			, [SPA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@SituationPriorAid AS [SPA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [SPA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [SPA].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRSituationPriorAidPerformedBy]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [PriorAidPerformedBy]
            , [FileImportRecordId]
            , [CreateBy]
            , [CreateDate]
            , [LastModifyBy]
            , [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [SPA].[PriorAidPerformedBy]
			, [SPA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@SituationPriorAidPerformedBy AS [SPA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [SPA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [SPA].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRSituationOtherSymptoms]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [OtherAssociatedSymptom]
            , [FileImportRecordId]
            , [CreateBy]
            , [CreateDate]
            , [LastModifyBy]
            , [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [SOS].[OtherAssociatedSymptom]
			, [SOS].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@SituationOtherSymptoms AS [SOS]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [SOS].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [SOS].[FileImportRecordId];
				

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRSituation]'
			, 'Completed the PCR Situation import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRSituation] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
