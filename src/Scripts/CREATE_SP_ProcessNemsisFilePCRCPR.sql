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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRCPR] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                               - Column                              - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRCPR                              - CardiacArrest                       - NEMSIS V2 - E11_01 Element - Cardiac Arrest 
	-- PCRCPR                              - CardiacArrestEtiology               - NEMSIS V2 - E11_02 Element - Cardiac Arrest Etiology 
	-- PCRCPRIndicationAttemptResuscitate  - ResuscitationAttempted              - NEMSIS V2 - E11_03 Element - Resuscitation Attempted 
	-- PCRCPR                              - ArrestWitnessedBy                   - NEMSIS V2 - E11_04 Element - Arrest Witnessed by 
	-- PCRCPR                              - FirstMonitoredRhythm                - NEMSIS V2 - E11_05 Element - First Monitored Rhythm of the  Patient 
	-- PCRCPR                              - AnyReturnSpontaneousCirculation     - NEMSIS V2 - E11_06 Element - Any Return of Spontaneous Circulation 
	-- PCRCPR                              - NeurologicalOutcome                 - NEMSIS V2 - E11_07 Element - Neurological Outcome at Hospital Discharge 
	-- PCRCPR                              - EstimatedTimeArrestPriorEMSArrival  - NEMSIS V2 - E11_08 Element - Estimated Time of  Arrest Prior to EMS Arrival 
	-- PCRCPR                              - DateTimeResuscitationDiscontinued   - NEMSIS V2 - E11_09 Element - Date/Time Resuscitation Discontinued 
	-- PCRCPR                              - ReasonCPRDiscontinued               - NEMSIS V2 - E11_10 Element - Reason CPR Discontinued 
	-- PCRCPRCardiacRhythmDelivery         - CardiacRhythmDestination            - NEMSIS V2 - E11_11 Element - Cardiac Rhythm on Arrival at Destination  
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRCPR]'
			, 'Beginning the PCR CPR import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
		

		DECLARE @Cpr TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CardiacArrest] [int] NOT NULL,
			[CardiacArrestEtiology] [int] NOT NULL,
			[ArrestWitnessedBy] [int] NULL,
			[FirstMonitoredRhythm] [int] NULL,
			[AnyReturnSpontaneousCirculation] [int] NULL,
			[NeurologicalOutcome] [int] NULL,
			[EstimatedTimeArrestPriorEMSArrival] [int] NULL,
			[DateTimeResuscitationDiscontinued] [datetime] NULL,
			[ReasonCPRDiscontinued] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		DECLARE @CPRCardiacRhythmDelivery TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CardiacRhythmDestination] [varchar](255) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @CPRIndicationAttemptResuscitate TABLE
		(
			[AgencyId] [int] NOT NULL,
			[ResuscitationAttempted] [varchar](255) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
		
		INSERT INTO @Cpr
        (
			  [AgencyId]
			, [CardiacArrest]
			, [CardiacArrestEtiology]
			, [ArrestWitnessedBy]
			, [FirstMonitoredRhythm]
			, [AnyReturnSpontaneousCirculation]
			, [NeurologicalOutcome]
			, [EstimatedTimeArrestPriorEMSArrival]
			, [DateTimeResuscitationDiscontinued]
			, [ReasonCPRDiscontinued]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CardiacArrest]
			, [CardiacArrestEtiology]
			, [ArrestWitnessedBy]
			, [FirstMonitoredRhythm]
			, [AnyReturnSpontaneousCirculation]
			, [NeurologicalOutcome]
			, [EstimatedTimeArrestPriorEMSArrival]
			, [DateTimeResuscitationDiscontinued]
			, [ReasonCPRDiscontinued]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E11', 2) WITH 
		(
			  [CardiacArrest] INT 'n:E11_01'
			, [CardiacArrestEtiology] INT 'n:E11_02'
			, [ArrestWitnessedBy] INT 'n:E11_04'
			, [FirstMonitoredRhythm] INT 'n:E11_05'
			, [AnyReturnSpontaneousCirculation] INT 'n:E11_06'
			, [NeurologicalOutcome] INT 'n:E11_07'
			, [EstimatedTimeArrestPriorEMSArrival] INT 'n:E11_08'
			, [DateTimeResuscitationDiscontinued] DATETIME 'n:E11_09'
			, [ReasonCPRDiscontinued] INT 'n:E11_10'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		
	
		INSERT INTO @CPRCardiacRhythmDelivery
		(
			  [AgencyId]
			, [CardiacRhythmDestination]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CardiacRhythmDestination]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E11', 2) WITH (
					  [CardiacRhythmDestination] VARCHAR(127) 'n:E11_11'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @CPRIndicationAttemptResuscitate 
		(
			  [AgencyId]
			, [ResuscitationAttempted]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [ResuscitationAttempted]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E11', 2) WITH (
					  [ResuscitationAttempted] VARCHAR(127) 'n:E11_03'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO [dbo].[PCRCPR]
        (
			  [PatientCareReportId]
            , [AgencyId]
			, [CardiacArrest]
			, [CardiacArrestEtiology]
			, [ArrestWitnessedBy]
			, [FirstMonitoredRhythm]
			, [AnyReturnSpontaneousCirculation]
			, [NeurologicalOutcome]
			, [EstimatedTimeArrestPriorEMSArrival]
			, [DateTimeResuscitationDiscontinued]
			, [ReasonCPRDiscontinued]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)     
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [CPR].[CardiacArrest]
			, [CPR].[CardiacArrestEtiology]
			, [CPR].[ArrestWitnessedBy]
			, [CPR].[FirstMonitoredRhythm]
			, [CPR].[AnyReturnSpontaneousCirculation]
			, [CPR].[NeurologicalOutcome]
			, [CPR].[EstimatedTimeArrestPriorEMSArrival]
			, [CPR].[DateTimeResuscitationDiscontinued]
			, [CPR].[ReasonCPRDiscontinued]
			, [CPR].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Cpr AS [CPR]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [CPR].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [CPR].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRCPRCardiacRhythmDelivery]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [CardiacRhythmDestination]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [CRD].[CardiacRhythmDestination]
			, [CRD].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@CPRCardiacRhythmDelivery AS [CRD]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [CRD].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [CRD].[FileImportRecordId];
				
				
		INSERT INTO [dbo].[PCRCPRIndicationAttemptResuscitate]
        (
			[AgencyId]
           ,[PatientCareReportId]
           ,[ResuscitationAttempted]
           ,[FileImportRecordId]
           ,[CreateBy]
           ,[CreateDate]
           ,[LastModifyBy]
           ,[LastModifyDate])
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [IAR].[ResuscitationAttempted]
			, [IAR].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@CPRIndicationAttemptResuscitate AS [IAR]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IAR].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IAR].[FileImportRecordId];
			

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRCPR]'
			, 'Completed the PCR CPR import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRCPR] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
