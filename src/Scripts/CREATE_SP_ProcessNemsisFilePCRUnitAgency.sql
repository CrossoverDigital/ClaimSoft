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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRUnitAgency] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table                         - Column                      - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRUnitAgency	             - AgencyNumber                - NEMSIS V2 - E02_01 Element - EMS Agency Number
	-- PCRUnitAgency	             - IncidentNumber              - NEMSIS V2 - E02_02 Element - Incident Number
	-- PCRUnitAgency	             - UnitResponseNumber          - NEMSIS V2 - E02_03 Element - EMS Unit (Vehicle) Response Number
	-- PCRUnitAgency	             - ServiceTypeRequested        - NEMSIS V2 - E02_04 Element - Type of Service Requested
	-- PCRUnitAgency	             - PrimaryUnitRole             - NEMSIS V2 - E02_05 Element - Primary Role of the Unit
	-- PCRUnitAgencyDispatchDelays	 - DispatchDelayType           - NEMSIS V2 - E02_06 Element - Type of Dispatch Delay
	-- PCRUnitAgencyResponseDelays	 - ResponseDelayType           - NEMSIS V2 - E02_07 Element - Type of Response Delay
	-- PCRUnitAgencySceneDelays	     - SceneDelayType              - NEMSIS V2 - E02_08 Element - Type of Scene Delay
	-- PCRUnitAgencyTransportDelays	 - TransportDelayType          - NEMSIS V2 - E02_09 Element - Type of Transport Delay
	-- PCRUnitAgencyTurnAroundDelays - TurnAroundDelayType         - NEMSIS V2 - E02_10 Element - Type of Turn-Around Delay
	-- PCRUnitAgency	             - UnitVehicleNumber           - NEMSIS V2 - E02_11 Element - EMS Unit/Vehicle Number
	-- PCRUnitAgency	             - UnitCallSign                - NEMSIS V2 - E02_12 Element - EMS Unit Call Sign (Radio Number)
	-- PCRUnitAgency	             - VehicleDispatchLocation     - NEMSIS V2 - E02_13 Element - Vehicle Dispatch Location
	-- PCRUnitAgency	             - VehicleDispatchZone         - NEMSIS V2 - E02_14 Element - Vehicle Dispatch Zone
	-- PCRUnitAgency	             - VehicleDispatchGPSLatitude  - NEMSIS V2 - E02_15 Element - Vehicle Dispatch GPS Location
	-- PCRUnitAgency	             - VehicleDispatchGPSLongitude - NEMSIS V2 - E02_15 Element - Vehicle Dispatch GPS Location
	-- PCRUnitAgency	             - BeginningOdometer           - NEMSIS V2 - E02_16 Element - Beginning Odometer Reading of Responding Vehicle
	-- PCRUnitAgency	             - OnSceneOdometer             - NEMSIS V2 - E02_17 Element - On-Scene Odometer Reading of Responding Vehicle
	-- PCRUnitAgency	             - PatientDestinationOdometer  - NEMSIS V2 - E02_18 Element - Patient Destination Odometer Reading of Responding Vehicle
	-- PCRUnitAgency	             - EndingOdometer              - NEMSIS V2 - E02_19 Element - Ending Odometer Reading of Responding Vehicle
	-- PCRUnitAgency	             - SceneResponseMode           - NEMSIS V2 - E02_20 Element - Response Mode to Scene
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitAgency]'
			, 'Beginning the PCRUnitAgency import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
		

		DECLARE @UnitAgency TABLE
		(
			[PatientCareReportNumber] [varchar](30) NOT NULL,
			[AgencyId] [int] NOT NULL,
			[AgencyNumber] [varchar](15) NOT NULL,
			[IncidentNumber] [varchar](15) NULL,
			[UnitResponseNumber] [varchar](15) NULL,
			[ServiceTypeRequested] [int] NOT NULL,
			[PrimaryUnitRole] [int] NOT NULL,
			[DispatchDelayType] [int] NULL,
			[ResponseDelayType] [int] NULL,
			[SceneDelayType] [int] NULL,
			[TransportDelayType] [int] NULL,
			[TurnAroundDelayType] [int] NULL,
			[UnitVehicleNumber] [varchar](30) NULL,
			[UnitCallSign] [varchar](15) NOT NULL,
			[VehicleDispatchLocation] [varchar](30) NULL,
			[VehicleDispatchZone] [varchar](30) NULL,
			[VehicleDispatchGPSLatitude] [decimal](4, 2) NULL,
			[VehicleDispatchGPSLongitude] [decimal](5, 2) NULL,
			[BeginningOdometer] [decimal](6, 1) NULL,
			[OnSceneOdometer] [decimal](6, 1) NULL,
			[PatientDestinationOdometer] [decimal](6, 1) NULL,
			[EndingOdometer] [decimal](6, 1) NULL,
			[SceneResponseMode] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		INSERT INTO @UnitAgency 
		(
			  [PatientCareReportNumber]
			, [AgencyId]
			, [AgencyNumber]
			, [IncidentNumber]
			, [UnitResponseNumber]
			, [ServiceTypeRequested]
			, [PrimaryUnitRole]
			, [DispatchDelayType]
			, [ResponseDelayType]
			, [SceneDelayType]
			, [TransportDelayType]
			, [TurnAroundDelayType]
			, [UnitVehicleNumber]
			, [UnitCallSign]
			, [VehicleDispatchLocation]
			, [VehicleDispatchZone]
			--, [VehicleDispatchGPSLatitude]
			, [BeginningOdometer]
			, [OnSceneOdometer]
			, [PatientDestinationOdometer]
			, [EndingOdometer]
			, [SceneResponseMode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PatientCareReportNumber]
			, @AgencyId AS [AgencyId]
			, [AgencyNumber]
			, [IncidentNumber]
			, [UnitResponseNumber]
			, [ServiceTypeRequested]
			, [PrimaryUnitRole]
			, [DispatchDelayType]
			, [ResponseDelayType]
			, [SceneDelayType]
			, [TransportDelayType]
			, [TurnAroundDelayType]
			, [UnitVehicleNumber]
			, [UnitCallSign]
			, [VehicleDispatchLocation]
			, [VehicleDispatchZone]
			--, [VehicleDispatchGPSLatitude]
			, [BeginningOdometer]
			, [OnSceneOdometer]
			, [PatientDestinationOdometer]
			, [EndingOdometer]
			, [SceneResponseMode]
			, CONCAT( [AgencyNumber]
					, [AgencyState]
					, [UnitCallSign]
					, [PatientCareReportNumber]
					, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId AS [CreateBy]
			, @LoadDate AS [CreateDate]
			, @UserId AS [LastModifyBy]
			, @LoadDate AS [LastModifyDate]
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E02', 2) WITH (
				      [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
					, [AgencyNumber] VARCHAR(15) 'n:E02_01'
					, [IncidentNumber] VARCHAR(15) 'n:E02_02'
					, [UnitResponseNumber] VARCHAR(15) 'n:E02_03'
					, [ServiceTypeRequested] INT 'n:E02_04'
					, [PrimaryUnitRole] INT 'n:E02_05'
					, [DispatchDelayType] INT 'n:E02_06'
					, [ResponseDelayType] INT 'n:E02_07'
					, [SceneDelayType] INT 'n:E02_08'
					, [TransportDelayType] INT 'n:E02_09'
					, [TurnAroundDelayType] INT 'n:E02_10'
					, [UnitVehicleNumber] VARCHAR(30) 'n:E02_11'
					, [UnitCallSign] VARCHAR(15) 'n:E02_12'
					, [VehicleDispatchLocation] VARCHAR(30) 'n:E02_13'
					, [VehicleDispatchZone] VARCHAR(30) 'n:E02_14'
					--,[VehicleDispatchGPSLatitude] VARCHAR(30) 'n:E02_15'
					, [BeginningOdometer] DECIMAL(6, 1) 'n:E02_16'
					, [OnSceneOdometer] DECIMAL(6, 1) 'n:E02_17'
					, [PatientDestinationOdometer] DECIMAL(6, 1) 'n:E02_18'
					, [EndingOdometer] DECIMAL(6, 1) 'n:E02_19'
					, [SceneResponseMode] INT 'n:E02_20');

     
		INSERT INTO [dbo].[PCRUnitAgency]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [AgencyNumber]
			, [IncidentNumber]
			, [UnitResponseNumber]
			, [ServiceTypeRequested]
			, [PrimaryUnitRole]
			, [UnitVehicleNumber]
			, [UnitCallSign]
			, [VehicleDispatchLocation]
			, [VehicleDispatchZone]
			--,[VehicleDispatchGPSLatitude]
			--,[VehicleDispatchGPSLongitude]
			, [BeginningOdometer]
			, [OnSceneOdometer]
			, [PatientDestinationOdometer]
			, [EndingOdometer]
			, [SceneResponseMode]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PCR].[Id]
			, [PUA].[AgencyId]
			, [PUA].[AgencyNumber]
			, [PUA].[IncidentNumber]
			, [PUA].[UnitResponseNumber]
			, [PUA].[ServiceTypeRequested]
			, [PUA].[PrimaryUnitRole]
			, [PUA].[UnitVehicleNumber]
			, [PUA].[UnitCallSign]
			, [PUA].[VehicleDispatchLocation]
			, [PUA].[VehicleDispatchZone]
			--, [VehicleDispatchGPSLatitude]
			, [PUA].[BeginningOdometer]
			, [PUA].[OnSceneOdometer]
			, [PUA].[PatientDestinationOdometer]
			, [PUA].[EndingOdometer]
			, [PUA].[SceneResponseMode]
			, [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];
			

		INSERT INTO [dbo].[PCRUnitAgencyDispatchDelays]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [DispatchDelayType]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PUA].[AgencyId]
			, [PCR].[Id]
			, [PUA].[DispatchDelayType]
		    , [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];
			

		INSERT INTO [dbo].[PCRUnitAgencyResponseDelays]
        ( 
			  [AgencyId]
			, [PatientCareReportId]
			, [ResponseDelayType]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PUA].[AgencyId]
			, [PCR].[Id]
			, [PUA].[ResponseDelayType]
			, [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];

			
		INSERT INTO [dbo].[PCRUnitAgencySceneDelays]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [SceneDelayType]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PUA].[AgencyId]
			, [PCR].[Id]
			, [PUA].[SceneDelayType]	
			, [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];
			

		INSERT INTO [dbo].[PCRUnitAgencyTransportDelays]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [TransportDelayType]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PUA].[AgencyId]
			, [PCR].[Id]
			, [PUA].[TransportDelayType]	
			, [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];

			
		INSERT INTO [dbo].[PCRUnitAgencyTurnAroundDelays]
        (
			  [AgencyId]
			, [PatientCareReportId]
			, [TurnAroundDelayType]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PUA].[AgencyId]
			, [PCR].[Id]
			, [PUA].[TurnAroundDelayType]		
			, [PUA].[FileImportRecordId]
			, [PUA].[CreateBy]
			, [PUA].[CreateDate]
			, [PUA].[LastModifyBy]
			, [PUA].[LastModifyDate]
		FROM 
			@UnitAgency AS [PUA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUA].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUA].[PatientCareReportNumber];


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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitAgency]'
			, 'Completed the PCRUnitAgency import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRUnitAgency] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
