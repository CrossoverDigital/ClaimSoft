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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRAssessmentExam] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                          - Column                      - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRAssessmentExam              - EstimatedBodyWeight         - NEMSIS V2 - E16_01 Element - Estimated Body Weight 
	-- PCRAssessmentExam              - BroselowLutenColor          - NEMSIS V2 - E16_02 Element - Broselow/Luten Color 
	-- PCRAssessmentExamsDifferent    - AssessmentDateTime          - NEMSIS V2 - E16_03 Element - Date/Time of Assessment 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRScene]'
			, 'Beginning the PCR Scene import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @Scene TABLE
		(
			[AgencyId] [int] NOT NULL,
			[EstimatedDateTimeInitialResponderArrived] [int] NULL,
			[DateTimeInitialResponderArrived] [datetime] NULL,
			[NumberPatientsScene] [int] NOT NULL,
			[MassCasualtyIncident] [int] NOT NULL,
			[IncidentLocationType] [int] NOT NULL,
			[IncidentFacilityCode] [varchar](30) NULL,
			[SceneZoneNumber] [varchar](30) NULL,
			[SceneGPSLocationLatitude] [decimal](4, 2) NULL,
			[SceneGPSLocationLongitude] [decimal](5, 2) NULL,
			[IncidentAddress] [varchar](30) NULL,
			[IncidentCity] [varchar](30) NULL,
			[IncidentCounty] [varchar](5) NULL,
			[IncidentState] [varchar](3) NULL,
			[IncidentZipCode] [varchar](10) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @SceneOtherEMSAgencies TABLE
		(
			[AgencyId] [int] NOT NULL,
			[OtherEMSAgencies] [varchar](30) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		
		DECLARE @SceneOtherServices TABLE
		(
			[AgencyId] [int] NOT NULL,
			[OtherService] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		INSERT INTO @Scene 
		(
			  [AgencyId]
			, [EstimatedDateTimeInitialResponderArrived]
			, [DateTimeInitialResponderArrived]
			, [NumberPatientsScene]
			, [MassCasualtyIncident]
			, [IncidentLocationType]
			, [IncidentFacilityCode]
			, [SceneZoneNumber]
			--, [SceneGPSLocationLatitude]
			--, [SceneGPSLocationLongitude]
			, [IncidentAddress]
			, [IncidentCity]
			, [IncidentCounty]
			, [IncidentState]
			, [IncidentZipCode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [EstimatedDateTimeInitialResponderArrived]
			, [DateTimeInitialResponderArrived]
			, [NumberPatientsScene]
			, [MassCasualtyIncident]
			, [IncidentLocationType]
			, [IncidentFacilityCode]
			, [SceneZoneNumber]
			--, [SceneGPSLocationLatitude]
			--, [SceneGPSLocationLongitude]
			, [IncidentAddress]
			, [IncidentCity]
			, [IncidentCounty]
			, [IncidentState]
			, [IncidentZipCode]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E08', 2) WITH 
		(
			  [EstimatedDateTimeInitialResponderArrived] INT 'n:E08_03'
			, [DateTimeInitialResponderArrived] [datetime]  'n:E08_04'
			, [NumberPatientsScene] [int]  'n:E08_05'
			, [MassCasualtyIncident] [int]  'n:E08_06'
			, [IncidentLocationType] [int]  'n:E08_07'
			, [IncidentFacilityCode] [varchar](30)  'n:E08_08'
			, [SceneZoneNumber] [varchar](30)  'n:E08_09'
			--, [SceneGPSLocationLatitude] [decimal](4, 2) 'n:E08_10'
			--, [SceneGPSLocationLongitude] [decimal](5, 2) 'n:E08_10'
			, [IncidentAddress] [varchar](30) 'n:E08_11_0/n:E08_11'
			, [IncidentCity] [varchar](30) 'n:E08_11_0/n:E08_12'
			, [IncidentCounty] [varchar](5) 'n:E08_13'
			, [IncidentState] [varchar](3) 'n:E08_11_0/n:E08_14'
			, [IncidentZipCode] [varchar](10) 'n:E08_11_0/n:E08_15'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		

		INSERT INTO @SceneOtherEMSAgencies 
		(
			  [AgencyId]
			, [OtherEMSAgencies]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [OtherEMSAgencies]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E08', 2) WITH (
					  [OtherEMSAgencies] [varchar](30) 'n:E08_01'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
			

		INSERT INTO @SceneOtherServices 
		(
			  [AgencyId]
			, [OtherService]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [OtherService]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E08', 2) WITH (
					  [OtherService] [varchar](30) 'n:E08_02'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO [dbo].[PCRScene]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [EstimatedDateTimeInitialResponderArrived]
			, [DateTimeInitialResponderArrived]
			, [NumberPatientsScene]
			, [MassCasualtyIncident]
			, [IncidentLocationType]
			, [IncidentFacilityCode]
			, [SceneZoneNumber]
			--, [SceneGPSLocationLatitude]
			--, [SceneGPSLocationLongitude]
			, [IncidentAddress]
			, [IncidentCity]
			, [IncidentCounty]
			, [IncidentState]
			, [IncidentZipCode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [S].[EstimatedDateTimeInitialResponderArrived]
			, [S].[DateTimeInitialResponderArrived]
			, [S].[NumberPatientsScene]
			, [S].[MassCasualtyIncident]
			, [S].[IncidentLocationType]
			, [S].[IncidentFacilityCode]
			, [S].[SceneZoneNumber]
			--, [S].[SceneGPSLocationLatitude]
			--, [S].[SceneGPSLocationLongitude]
			, [S].[IncidentAddress]
			, [S].[IncidentCity]
			, [S].[IncidentCounty]
			, [S].[IncidentState]
			, [S].[IncidentZipCode]
			, [S].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Scene AS [S]
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
			

		INSERT INTO [dbo].[PCRSceneOtherEMSAgencies]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [OtherEMSAgencies]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [SOEA].[OtherEMSAgencies]
			, [SOEA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@SceneOtherEMSAgencies AS [SOEA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [SOEA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [SOEA].[FileImportRecordId];
				
				
		INSERT INTO [dbo].[PCRSceneOtherServices]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [OtherService]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [SOS].[OtherService]
			, [SOS].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@SceneOtherServices AS [SOS]
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRScene]'
			, 'Completed the PCR Scene import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRScene] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
