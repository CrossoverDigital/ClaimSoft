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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRMedicalDeviceData] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                   - Column                                  - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRMedicalDeviceData    - EventDateTime                           - NEMSIS V2 - E21_01 Element - Event Date/Time 
	-- PCRMedicalDeviceData    - MedicalDeviceEventName                  - NEMSIS V2 - E21_02 Element - Medical Device Event Name 
	-- PCRMedicalDeviceData    - WaveformGraphicType                     - NEMSIS V2 - E21_03 Element - Waveform Graphic Type 
	-- PCRMedicalDeviceData    - WaveformGraphic                         - NEMSIS V2 - E21_04 Element - Waveform Graphic 
	-- PCRMedicalDeviceData    - AEDPacingCO2Mode                        - NEMSIS V2 - E21_05 Element - AED, Pacing, or CO2 Mode 
	-- PCRMedicalDeviceData    - ECGLead                                 - NEMSIS V2 - E21_06 Element - ECG Lead 
	-- PCRMedicalDeviceData    - ECGInterpretation                       - NEMSIS V2 - E21_07 Element - ECG Interpretation 
	-- PCRMedicalDeviceData    - ShockType                               - NEMSIS V2 - E21_08 Element - Type of Shock 
	-- PCRMedicalDeviceData    - ShockPacingEnergy                       - NEMSIS V2 - E21_09 Element - Shock or Pacing Energy 
	-- PCRMedicalDeviceData    - TotalNumberShocksDelivered              - NEMSIS V2 - E21_10 Element - Total Number of Shocks Delivered 
	-- PCRMedicalDeviceData    - PacingRate                              - NEMSIS V2 - E21_11 Element - Pacing Rate 
	-- PCRMedicalDeviceData    - HeartRate                               - NEMSIS V2 - E21_12 Element - Device Heart Rate 
	-- PCRMedicalDeviceData    - PulseRate                               - NEMSIS V2 - E21_13 Element - Device Pulse Rate 
	-- PCRMedicalDeviceData    - SystolicBloodPressure                   - NEMSIS V2 - E21_14 Element - Device Systolic Blood Pressure 
	-- PCRMedicalDeviceData    - DiastolicBloodPressure                  - NEMSIS V2 - E21_15 Element - Device Diastolic Blood Pressure 
	-- PCRMedicalDeviceData    - RespiratoryRate                         - NEMSIS V2 - E21_16 Element - Device Respiratory Rate 
	-- PCRMedicalDeviceData    - PulseOximetry                           - NEMSIS V2 - E21_17 Element - Device Pulse Oximetry 
	-- PCRMedicalDeviceData    - CO2etCO2                                - NEMSIS V2 - E21_18 Element - Device CO2 or etCO2 
	-- PCRMedicalDeviceData    - CO2etCO2InvasivePressureMonitorUnits    - NEMSIS V2 - E21_19 Element - Device CO2, etCO2, or Invasive Pressure Monitor Units 
	-- PCRMedicalDeviceData    - InvasivePressureMean                    - NEMSIS V2 - E21_20 Element - Device Invasive Pressure Mean 
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMedicalDeviceData]'
			, 'Beginning the PCR Medical Device Data import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
		

		DECLARE @MedicalDeviceData TABLE
		(
			[AgencyId] [int] NOT NULL,
			[EventDateTime] [datetime] NULL,
			[MedicalDeviceEventName] [int] NULL,
			[WaveformGraphicType] [int] NULL,
			[WaveformGraphic] [image] NULL,
			[AEDPacingCO2Mode] [int] NULL,
			[ECGLead] [int] NULL,
			[ECGInterpretation] [varchar](2000) NULL,
			[ShockType] [int] NULL,
			[ShockPacingEnergy] [decimal](5, 1) NULL,
			[TotalNumberShocksDelivered] [int] NULL,
			[PacingRate] [int] NULL,
			[HeartRate] [int] NULL,
			[PulseRate] [int] NULL,
			[SystolicBloodPressure] [int] NULL,
			[DiastolicBloodPressure] [int] NULL,
			[RespiratoryRate] [int] NULL,
			[PulseOximetry] [int] NULL,
			[CO2etCO2] [int] NULL,
			[CO2etCO2InvasivePressureMonitorUnits] [int] NULL,
			[InvasivePressureMean] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		INSERT INTO @MedicalDeviceData 
		(
			  [AgencyId]
			, [EventDateTime]
			, [MedicalDeviceEventName]
			, [WaveformGraphicType]
			, [WaveformGraphic]
			, [AEDPacingCO2Mode]
			, [ECGLead]
			, [ECGInterpretation]
			, [ShockType]
			, [ShockPacingEnergy]
			, [TotalNumberShocksDelivered]
			, [PacingRate]
			, [HeartRate]
			, [PulseRate]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [RespiratoryRate]
			, [PulseOximetry]
			, [CO2etCO2]
			, [CO2etCO2InvasivePressureMonitorUnits]
			, [InvasivePressureMean]
		    , [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [EventDateTime]
			, [MedicalDeviceEventName]
			, [WaveformGraphicType]
			, [WaveformGraphic]
			, [AEDPacingCO2Mode]
			, [ECGLead]
			, [ECGInterpretation]
			, [ShockType]
			, [ShockPacingEnergy]
			, [TotalNumberShocksDelivered]
			, [PacingRate]
			, [HeartRate]
			, [PulseRate]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [RespiratoryRate]
			, [PulseOximetry]
			, [CO2etCO2]
			, [CO2etCO2InvasivePressureMonitorUnits]
			, [InvasivePressureMean]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E21', 2) WITH 
		(
			  [EventDateTime] DATETIME 'n:E21_01'
			, [MedicalDeviceEventName] INT 'n:E21_02'
			, [WaveformGraphicType] INT 'n:E21_03_0/n:E21_03'
			, [WaveformGraphic] IMAGE 'n:E21_03_0/n:E21_04'
			, [AEDPacingCO2Mode] INT 'n:E21_05'
			, [ECGLead] INT 'n:E21_06'
			, [ECGInterpretation] VARCHAR(1000) 'n:E21_07'
			, [ShockType] INT 'n:E21_08'
			, [ShockPacingEnergy] DECIMAL 'n:E21_09'
			, [TotalNumberShocksDelivered] INT 'n:E21_10'
			, [PacingRate] INT 'n:E21_11'
			, [HeartRate] INT 'n:E21_12'
			, [PulseRate] INT 'n:E21_13'
			, [SystolicBloodPressure] INT 'n:E21_14'
			, [DiastolicBloodPressure] INT 'n:E21_15'
			, [RespiratoryRate] INT 'n:E21_16'
			, [PulseOximetry] INT 'n:E21_17'
			, [CO2etCO2] INT 'n:E21_18_0/n:E21_18'
			, [CO2etCO2InvasivePressureMonitorUnits] INT 'n:E21_18_0/n:E21_19'
			, [InvasivePressureMean] INT 'n:E21_20'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		
					
		INSERT INTO [dbo].[PCRMedicalDeviceData]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [EventDateTime]
			, [MedicalDeviceEventName]
			, [WaveformGraphicType]
			, [WaveformGraphic]
			, [AEDPacingCO2Mode]
			, [ECGLead]
			, [ECGInterpretation]
			, [ShockType]
			, [ShockPacingEnergy]
			, [TotalNumberShocksDelivered]
			, [PacingRate]
			, [HeartRate]
			, [PulseRate]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [RespiratoryRate]
			, [PulseOximetry]
			, [CO2etCO2]
			, [CO2etCO2InvasivePressureMonitorUnits]
			, [InvasivePressureMean]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [MDD].[EventDateTime]
			, [MDD].[MedicalDeviceEventName]
			, [MDD].[WaveformGraphicType]
			, [MDD].[WaveformGraphic]
			, [MDD].[AEDPacingCO2Mode]
			, [MDD].[ECGLead]
			, [MDD].[ECGInterpretation]
			, [MDD].[ShockType]
			, [MDD].[ShockPacingEnergy]
			, [MDD].[TotalNumberShocksDelivered]
			, [MDD].[PacingRate]
			, [MDD].[HeartRate]
			, [MDD].[PulseRate]
			, [MDD].[SystolicBloodPressure]
			, [MDD].[DiastolicBloodPressure]
			, [MDD].[RespiratoryRate]
			, [MDD].[PulseOximetry]
			, [MDD].[CO2etCO2]
			, [MDD].[CO2etCO2InvasivePressureMonitorUnits]
			, [MDD].[InvasivePressureMean]
			, [MDD].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@MedicalDeviceData AS [MDD]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [MDD].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [MDD].[FileImportRecordId];
		

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRMedicalDeviceData]'
			, 'Completed the PCR Medical Device Data import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRMedicalDeviceData] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
