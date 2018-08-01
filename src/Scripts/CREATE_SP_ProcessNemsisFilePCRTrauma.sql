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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRTrauma] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                              - Column                       - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRTrauma                          - InjuryCause                  - NEMSIS V2 - E10_01 Element - Cause of Injury 
	-- PCRTrauma                          - InjuryIntent                 - NEMSIS V2 - E10_02 Element - Intent of the Injury 
	-- PCRTraumaInjuryMechanism           - InjuryMechanism              - NEMSIS V2 - E10_03 Element - Mechanism of Injury 
	-- PCRTraumaRiskFactorPredictors      - VehicularInjuryIndicator     - NEMSIS V2 - E10_04 Element - Vehicular Injury Indicators 
	-- PCRTraumaVehicleImpactLocation     - AreaVehicleImpacted          - NEMSIS V2 - E10_05 Element - Area of the Vehicle impacted by the collision 
	-- PCRTrauma                          - SeatRowLocation              - NEMSIS V2 - E10_06 Element - Seat Row Location of Patient in Vehicle 
	-- PCRTrauma                          - PatientSeatPosition          - NEMSIS V2 - E10_07 Element - Position of Patient in the Seat of the Vehicle 
	-- PCRTraumaOccupantSafetyEquipment   - OccupantSafetyEquipment      - NEMSIS V2 - E10_08 Element - Use of Occupant Safety Equipment 
	-- PCRTraumaAirbagDeployment          - AirbagDeployment             - NEMSIS V2 - E10_09 Element - Airbag Deployment 
	-- PCRTrauma                          - FallHeight                   - NEMSIS V2 - E10_10 Element - Height of Fall 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRTrauma]'
			, 'Beginning the PCR trauma import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

	
		DECLARE @Trauma TABLE
		(
			  [AgencyId] [int] NOT NULL
			, [InjuryCause] [int] NOT NULL
			, [InjuryIntent] [int] NULL
			, [SeatRowLocation] [int] NULL
			, [PatientSeatPosition] [int] NULL
			, [FallHeight] [int] NULL
			, [FileImportRecordId] [nvarchar](50) NOT NULL
			, [CreateBy] [nvarchar](128) NOT NULL
			, [CreateDate] [datetime] NOT NULL
			, [LastModifyBy] [nvarchar](128) NOT NULL
			, [LastModifyDate] [datetime] NOT NULL
		)
		
						
		DECLARE @TraumaAirbagDeployment TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AirbagDeployment] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @TraumaInjuryMechanism TABLE
		(
			[AgencyId] [int] NOT NULL,
			[InjuryMechanism] [varchar](255) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @TraumaOccupantSafetyEquipment TABLE
		(
			[AgencyId] [int] NOT NULL,
			[OccupantSafetyEquipment] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		DECLARE @TraumaRiskFactorPredictors TABLE
		(
			[AgencyId] [int] NOT NULL,
			[VehicularInjuryIndicator] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		DECLARE @TraumaVehicleImpactLocation TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AreaVehicleImpacted] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
			 

		INSERT INTO @Trauma
        (
			  [AgencyId]
            , [InjuryCause]
            , [InjuryIntent]
            , [SeatRowLocation]
            , [PatientSeatPosition]
            , [FallHeight]
            , [FileImportRecordId]
            , [CreateBy]
            , [CreateDate]
            , [LastModifyBy]
            , [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [InjuryCause]
            , [InjuryIntent]
            , [SeatRowLocation]
            , [PatientSeatPosition]
            , [FallHeight]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH 
		(
			  [InjuryCause] [int] 'n:E10_01'
			, [InjuryIntent] [int] 'n:E10_02'
			, [SeatRowLocation] [int] 'n:E10_06_0/n:E10_06'
			, [PatientSeatPosition] [int] 'n:E10_06_0/n:E10_07'
			, [FallHeight] [int] 'n:E10_10'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		
	
		INSERT INTO @TraumaInjuryMechanism
		(
			  [AgencyId]
			, [InjuryMechanism]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [InjuryMechanism]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
					  [InjuryMechanism] [varchar](255) 'n:E10_03'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @TraumaRiskFactorPredictors 
		(
			  [AgencyId]
			, [VehicularInjuryIndicator]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [VehicularInjuryIndicator]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
					  [VehicularInjuryIndicator] [varchar](30) 'n:E10_04'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @TraumaVehicleImpactLocation 
		(
			  [AgencyId]
			, [AreaVehicleImpacted]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AreaVehicleImpacted]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
					  [AreaVehicleImpacted] INT 'n:E10_05'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @TraumaOccupantSafetyEquipment
		(
			  [AgencyId]
			, [OccupantSafetyEquipment]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [OccupantSafetyEquipment]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
					  [OccupantSafetyEquipment] INT 'n:E10_08'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
	

		INSERT INTO @TraumaAirbagDeployment
		(
			  [AgencyId]
			, [AirbagDeployment]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AirbagDeployment]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
					  [AirbagDeployment] INT 'n:E10_09'	
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');


		INSERT INTO [dbo].[PCRTrauma]
		(
			  [PatientCareReportId]
			, [AgencyId]
			, [InjuryCause]
			, [InjuryIntent]
			, [SeatRowLocation]
			, [PatientSeatPosition]
			, [FallHeight]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [T].[InjuryCause]
			, [T].[InjuryIntent]
			, [T].[SeatRowLocation]
			, [T].[PatientSeatPosition]
			, [T].[FallHeight]
			, [T].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@Trauma AS [T]
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
			

		INSERT INTO [dbo].[PCRTraumaAirbagDeployment]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [AirbagDeployment]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [TAD].[AirbagDeployment]
			, [TAD].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@TraumaAirbagDeployment AS [TAD]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [TAD].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [TAD].[FileImportRecordId];
				
				
		INSERT INTO [dbo].[PCRTraumaInjuryMechanism]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [InjuryMechanism]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [TIM].[InjuryMechanism]
			, [TIM].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@TraumaInjuryMechanism AS [TIM]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [TIM].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [TIM].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRTraumaOccupantSafetyEquipment]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [OccupantSafetyEquipment]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [TOSE].[OccupantSafetyEquipment]
			, [TOSE].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@TraumaOccupantSafetyEquipment AS [TOSE]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [TOSE].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [TOSE].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRTraumaRiskFactorPredictors]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [VehicularInjuryIndicator]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [TRFP].[VehicularInjuryIndicator]
			, [TRFP].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@TraumaRiskFactorPredictors AS [TRFP]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [TRFP].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [TRFP].[FileImportRecordId];
		
		
		INSERT INTO [dbo].[PCRTraumaVehicleImpactLocation]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [AreaVehicleImpacted]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [TVIL].[AreaVehicleImpacted]
			, [TVIL].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@TraumaVehicleImpactLocation AS [TVIL]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [TVIL].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [TVIL].[FileImportRecordId];


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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRTrauma]'
			, 'Completed the PCR trauma import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRTrauma] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
