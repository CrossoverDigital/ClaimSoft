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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRTimes] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table             - Column                              - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRTimes          - IncidentDateTime                    - NEMSIS V2 - E05_01 Element - Incident or Onset Date/Time 
	-- PCRTimes          - PSAPCallDateTime                    - NEMSIS V2 - E05_02 Element - PSAP Call Date/Time 
	-- PCRTimes          - DispatchNotifiedDateTime            - NEMSIS V2 - E05_03 Element - Dispatch Notified Date/Time 
	-- PCRTimes          - UnitNotifiedByDispatchDateTime      - NEMSIS V2 - E05_04 Element - Unit Notified by Dispatch Date/Time 
	-- PCRTimes          - UnitEnRouteDateTime                 - NEMSIS V2 - E05_05 Element - Unit En Route Date/Time 
	-- PCRTimes          - UnitArrivedSceneDateTime            - NEMSIS V2 - E05_06 Element - Unit Arrived on Scene Date/Time 
	-- PCRTimes          - ArrivedAtPatientDateTime            - NEMSIS V2 - E05_07 Element - Arrived at Patient Date/Time 
	-- PCRTimes          - TransferPatientCareDateTime         - NEMSIS V2 - E05_08 Element - Transfer of Patient Care Date/Time 
	-- PCRTimes          - UnitLeftSceneDateTime               - NEMSIS V2 - E05_09 Element - Unit Left Scene Date/Time 
	-- PCRTimes          - PatientArrivedDestinationDateTime   - NEMSIS V2 - E05_10 Element - Patient Arrived at Destination Date/Time 
	-- PCRTimes          - UnitBackInServiceDateTime           - NEMSIS V2 - E05_11 Element - Unit Back in Service Date/Time 
	-- PCRTimes          - UnitCancelledDateTime               - NEMSIS V2 - E05_12 Element - Unit Cancelled Date/Time 
	-- PCRTimes          - UnitBackHomeLocationDateTime        - NEMSIS V2 - E05_13 Element - Unit Back at Home Location Date/Time 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRTimes]'
			, 'Beginning the PCR Times import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @Times TABLE
		(
			[AgencyId] [int] NOT NULL,
			[IncidentDateTime] [datetime] NULL,
			[PSAPCallDateTime] [datetime] NULL,
			[DispatchNotifiedDateTime] [datetime] NULL,
			[UnitNotifiedByDispatchDateTime] [datetime] NOT NULL,
			[UnitEnRouteDateTime] [datetime] NULL,
			[UnitArrivedSceneDateTime] [datetime] NULL,
			[ArrivedAtPatientDateTime] [datetime] NULL,
			[TransferPatientCareDateTime] [datetime] NULL,
			[UnitLeftSceneDateTime] [datetime] NULL,
			[PatientArrivedDestinationDateTime] [datetime] NULL,
			[UnitBackInServiceDateTime] [datetime] NOT NULL,
			[UnitCancelledDateTime] [datetime] NULL,
			[UnitBackHomeLocationDateTime] [datetime] NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		INSERT INTO @Times 
		(
			  [AgencyId]
			, [IncidentDateTime]
			, [PSAPCallDateTime]
			, [DispatchNotifiedDateTime]
			, [UnitNotifiedByDispatchDateTime]
			, [UnitEnRouteDateTime]
			, [UnitArrivedSceneDateTime]
			, [ArrivedAtPatientDateTime]
			, [TransferPatientCareDateTime]
			, [UnitLeftSceneDateTime]
			, [PatientArrivedDestinationDateTime]
			, [UnitBackInServiceDateTime]
			, [UnitCancelledDateTime]
			, [UnitBackHomeLocationDateTime]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [IncidentDateTime]
			, [PSAPCallDateTime]
			, [DispatchNotifiedDateTime]
			, [UnitNotifiedByDispatchDateTime]
			, [UnitEnRouteDateTime]
			, [UnitArrivedSceneDateTime]
			, [ArrivedAtPatientDateTime]
			, [TransferPatientCareDateTime]
			, [UnitLeftSceneDateTime]
			, [PatientArrivedDestinationDateTime]
			, [UnitBackInServiceDateTime]
			, [UnitCancelledDateTime]
			, [UnitBackHomeLocationDateTime]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E05', 2) WITH (
				  [IncidentDateTime] DATETIME 'n:E05_01'
				, [PSAPCallDateTime] DATETIME 'n:E05_02'
				, [DispatchNotifiedDateTime] DATETIME 'n:E05_03'
				, [UnitNotifiedByDispatchDateTime] DATETIME 'n:E05_04'
				, [UnitEnRouteDateTime] DATETIME 'n:E05_05'
				, [UnitArrivedSceneDateTime] DATETIME 'n:E05_06'
				, [ArrivedAtPatientDateTime] DATETIME 'n:E05_07'
				, [TransferPatientCareDateTime] DATETIME 'n:E05_08'
				, [UnitLeftSceneDateTime] DATETIME 'n:E05_09'
				, [PatientArrivedDestinationDateTime] DATETIME 'n:E05_10'
				, [UnitBackInServiceDateTime] DATETIME 'n:E05_11'
				, [UnitCancelledDateTime] DATETIME 'n:E05_12'
				, [UnitBackHomeLocationDateTime] DATETIME 'n:E05_13'
				, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
				, [AgencyState] INT '../../n:D01_03'
				, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
				, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01');


		INSERT INTO [dbo].[PCRTimes]
		(	 
			  [PatientCareReportId]
			, [AgencyId]
			, [IncidentDateTime]
			, [PSAPCallDateTime]
			, [DispatchNotifiedDateTime]
			, [UnitNotifiedByDispatchDateTime]
			, [UnitEnRouteDateTime]
			, [UnitArrivedSceneDateTime]
			, [ArrivedAtPatientDateTime]
			, [TransferPatientCareDateTime]
			, [UnitLeftSceneDateTime]
			, [PatientArrivedDestinationDateTime]
			, [UnitBackInServiceDateTime]
			, [UnitCancelledDateTime]
			, [UnitBackHomeLocationDateTime]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
			, @AgencyId
			, [T].[IncidentDateTime]
			, [T].[PSAPCallDateTime]
			, [T].[DispatchNotifiedDateTime]
			, [T].[UnitNotifiedByDispatchDateTime]
			, [T].[UnitEnRouteDateTime]
			, [T].[UnitArrivedSceneDateTime]
			, [T].[ArrivedAtPatientDateTime]
			, [T].[TransferPatientCareDateTime]
			, [T].[UnitLeftSceneDateTime]
			, [T].[PatientArrivedDestinationDateTime]
			, [T].[UnitBackInServiceDateTime]
			, [T].[UnitCancelledDateTime]
			, [T].[UnitBackHomeLocationDateTime]
			, [T].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Times AS [T]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [T].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [T].[FileImportRecordId];
			

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRTimes]'
			, 'Completed the PCR Times import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRTimes] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
