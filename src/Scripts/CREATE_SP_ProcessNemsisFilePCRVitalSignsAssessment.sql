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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRVitalSignsAssessment] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- Table                                            - Column                                     - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- PCRVitalSignsAssessment                          - DateTimeVitalSignsTaken               - NEMSIS V2 - E14_01 Element - Date/Time Vital Signs Taken 
	-- PCRVitalSignsAssessment                          - ObtainedPriorUnitsEMSCare             - NEMSIS V2 - E14_02 Element - Obtained Prior to this Units EMS Care 
	-- PCRVitalSignsAssessmentInitialCardiacRhythm      - CardiacRhythm							- NEMSIS V2 - E14_03 Element - Cardiac Rhythm 
	-- PCRVitalSignsAssessment                          - SystolicBloodPressure                 - NEMSIS V2 - E14_04 Element - SBP (Systolic Blood Pressure) 
	-- PCRVitalSignsAssessment                          - DiastolicBloodPressure                - NEMSIS V2 - E14_05 Element - DBP (Diastolic Blood Pressure) 
	-- PCRVitalSignsAssessment                          - MethodBloodPressureMeasurement        - NEMSIS V2 - E14_06 Element - Method of Blood Pressure Measurement 
	-- PCRVitalSignsAssessment                          - PulseRate								- NEMSIS V2 - E14_07 Element - Pulse Rate 
	-- PCRVitalSignsAssessment                          - ElectronicMonitorRate                 - NEMSIS V2 - E14_08 Element - Electronic Monitor Rate 
	-- PCRVitalSignsAssessment                          - PulseOximetry							- NEMSIS V2 - E14_09 Element - Pulse Oximetry 
	-- PCRVitalSignsAssessment                          - PulseRhythm							- NEMSIS V2 - E14_10 Element - Pulse Rhythm 
	-- PCRVitalSignsAssessment                          - RespiratoryRate						- NEMSIS V2 - E14_11 Element - Respiratory Rate 
	-- PCRVitalSignsAssessment                          - RespiratoryEffort						- NEMSIS V2 - E14_12 Element - Respiratory Effort 
	-- PCRVitalSignsAssessment                          - CarbonDioxide							- NEMSIS V2 - E14_13 Element - Carbon Dioxide 
	-- PCRVitalSignsAssessment                          - BloodGlucoseLevel						- NEMSIS V2 - E14_14 Element - Blood Glucose Level 
	-- PCRVitalSignsAssessment                          - GlasgowComaScoreEye                   - NEMSIS V2 - E14_15 Element - Glasgow Coma Score-Eye 
	-- PCRVitalSignsAssessment                          - GlasgowComaScoreVerbal                - NEMSIS V2 - E14_16 Element - Glasgow Coma Score-Verbal 
	-- PCRVitalSignsAssessment                          - GlasgowComaScoreMotor                 - NEMSIS V2 - E14_17 Element - Glasgow Coma Score-Motor 
	-- PCRVitalSignsAssessment                          - GlasgowComaScoreQualifier             - NEMSIS V2 - E14_18 Element - Glasgow Coma Score-Qualifier 
	-- PCRVitalSignsAssessment                          - TotalGlasgowComaScore                 - NEMSIS V2 - E14_19 Element - Total Glasgow Coma Score 
	-- PCRVitalSignsAssessment                          - Temperature							- NEMSIS V2 - E14_20 Element - Temperature 
	-- PCRVitalSignsAssessment                          - TemperatureMethod						- NEMSIS V2 - E14_21 Element - Temperature Method 
	-- PCRVitalSignsAssessment                          - LevelOfResponsiveness                 - NEMSIS V2 - E14_22 Element - Level of Responsiveness 
	-- PCRVitalSignsAssessment                          - PainScale								- NEMSIS V2 - E14_23 Element - Pain Scale 
	-- PCRVitalSignsAssessment                          - StrokeScale							- NEMSIS V2 - E14_24 Element - Stroke Scale 
	-- PCRVitalSignsAssessment                          - ThrombolyticScreen                    - NEMSIS V2 - E14_25 Element - Thrombolytic Screen 
	-- PCRVitalSignsAssessment                          - APGAR									- NEMSIS V2 - E14_26 Element - APGAR 
	-- PCRVitalSignsAssessment                          - RevisedTraumaScore                    - NEMSIS V2 - E14_27 Element - Revised Trauma Score 
	-- PCRVitalSignsAssessment                          - PediatricTraumaScore                  - NEMSIS V2 - E14_28 Element - Pediatric Trauma Score 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRVitalSignsAssessment]'
			, 'Beginning the PCR Vital Signs Assessment import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @VitalSignsAssessment TABLE
		(
			[AgencyId] [int] NOT NULL,
			[DateTimeVitalSignsTaken] [datetime] NULL,
			[ObtainedPriorUnitsEMSCare] [int] NULL,
			[SystolicBloodPressure] [int] NULL,
			[DiastolicBloodPressure] [int] NULL,
			[MethodBloodPressureMeasurement] [int] NULL,
			[PulseRate] [int] NULL,
			[ElectronicMonitorRate] [int] NULL,
			[PulseOximetry] [int] NULL,
			[PulseRhythm] [int] NULL,
			[RespiratoryRate] [int] NULL,
			[RespiratoryEffort] [int] NULL,
			[CarbonDioxide] [int] NULL,
			[BloodGlucoseLevel] [int] NULL,
			[GlasgowComaScoreEye] [int] NULL,
			[GlasgowComaScoreVerbal] [int] NULL,
			[GlasgowComaScoreMotor] [int] NULL,
			[GlasgowComaScoreQualifier] [int] NULL,
			[TotalGlasgowComaScore] [int] NULL,
			[Temperature] [decimal](4, 2) NULL,
			[TemperatureMethod] [int] NULL,
			[LevelOfResponsiveness] [int] NULL,
			[PainScale] [int] NULL,
			[StrokeScale] [int] NULL,
			[ThrombolyticScreen] [int] NULL,
			[APGAR] [int] NULL,
			[RevisedTraumaScore] [int] NULL,
			[PediatricTraumaScore] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		DECLARE @VitalSignsAssessmentInitialCardiacRhythm TABLE
		(
			[AgencyId] [int] NOT NULL,
			[CardiacRhythm] [varchar](255) NOT NULL,
			[FileImportRecordId] [nvarchar](50) NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		

		INSERT INTO @VitalSignsAssessment 
		(
			  [AgencyId]
			, [DateTimeVitalSignsTaken]
			, [ObtainedPriorUnitsEMSCare]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [MethodBloodPressureMeasurement]
			, [PulseRate]
			, [ElectronicMonitorRate]
			, [PulseOximetry]
			, [PulseRhythm]
			, [RespiratoryRate]
			, [RespiratoryEffort]
			, [CarbonDioxide]
			, [BloodGlucoseLevel]
			, [GlasgowComaScoreEye]
			, [GlasgowComaScoreVerbal]
			, [GlasgowComaScoreMotor]
			, [GlasgowComaScoreQualifier]
			, [TotalGlasgowComaScore]
			, [Temperature]
			, [TemperatureMethod]
			, [LevelOfResponsiveness]
			, [PainScale]
			, [StrokeScale]
			, [ThrombolyticScreen]
			, [APGAR]
			, [RevisedTraumaScore]
			, [PediatricTraumaScore]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [DateTimeVitalSignsTaken]
			, [ObtainedPriorUnitsEMSCare]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [MethodBloodPressureMeasurement]
			, [PulseRate]
			, [ElectronicMonitorRate]
			, [PulseOximetry]
			, [PulseRhythm]
			, [RespiratoryRate]
			, [RespiratoryEffort]
			, [CarbonDioxide]
			, [BloodGlucoseLevel]
			, [GlasgowComaScoreEye]
			, [GlasgowComaScoreVerbal]
			, [GlasgowComaScoreMotor]
			, [GlasgowComaScoreQualifier]
			, [TotalGlasgowComaScore]
			, [Temperature]
			, [TemperatureMethod]
			, [LevelOfResponsiveness]
			, [PainScale]
			, [StrokeScale]
			, [ThrombolyticScreen]
			, [APGAR]
			, [RevisedTraumaScore]
			, [PediatricTraumaScore]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E14', 2) WITH 
		(
			  [DateTimeVitalSignsTaken] DATETIME 'n:E14_01'
			, [ObtainedPriorUnitsEMSCare] INT 'n:E14_02'
			, [SystolicBloodPressure] INT 'n:E14_04_0/n:E14_04'
			, [DiastolicBloodPressure] INT 'n:E14_04_0/n:E14_05'
			, [MethodBloodPressureMeasurement] INT 'n:E14_04_0/n:E14_06'
			, [PulseRate] INT 'n:E14_07'
			, [ElectronicMonitorRate] INT 'n:E14_08'
			, [PulseOximetry] INT 'n:E14_09'
			, [PulseRhythm] INT 'n:E14_10'
			, [RespiratoryRate] INT 'n:E14_11'
			, [RespiratoryEffort] INT 'n:E14_12'
			, [CarbonDioxide] INT 'n:E14_13'
			, [BloodGlucoseLevel] INT 'n:E14_14'
			, [GlasgowComaScoreEye] INT 'n:E14_15_0/n:E14_15'
			, [GlasgowComaScoreVerbal] INT 'n:E14_15_0/n:E14_16'
			, [GlasgowComaScoreMotor] INT 'n:E14_15_0/n:E14_17'
			, [GlasgowComaScoreQualifier] INT 'n:E14_15_0/n:E14_18'
			, [TotalGlasgowComaScore] INT 'n:E14_19'
			, [Temperature] FLOAT 'n:E14_20_0/n:E14_20'
			, [TemperatureMethod] INT 'n:E14_20_0/n:E14_21'
			, [LevelOfResponsiveness] INT 'n:E14_22'
			, [PainScale] INT 'n:E14_23'
			, [StrokeScale] INT 'n:E14_24'
			, [ThrombolyticScreen] INT 'n:E14_25'
			, [APGAR] INT 'n:E14_26'
			, [RevisedTraumaScore] INT 'n:E14_27'
			, [PediatricTraumaScore] INT 'n:E14_28'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		

		INSERT INTO @VitalSignsAssessmentInitialCardiacRhythm 
		(
			  [AgencyId]
			, [CardiacRhythm]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [CardiacRhythm]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E14', 2) WITH (
					  [CardiacRhythm] VARCHAR(127) 'n:E14_03'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
			

		INSERT INTO [dbo].[PCRVitalSignsAssessment]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [DateTimeVitalSignsTaken]
			, [ObtainedPriorUnitsEMSCare]
			, [SystolicBloodPressure]
			, [DiastolicBloodPressure]
			, [MethodBloodPressureMeasurement]
			, [PulseRate]
			, [ElectronicMonitorRate]
			, [PulseOximetry]
			, [PulseRhythm]
			, [RespiratoryRate]
			, [RespiratoryEffort]
			, [CarbonDioxide]
			, [BloodGlucoseLevel]
			, [GlasgowComaScoreEye]
			, [GlasgowComaScoreVerbal]
			, [GlasgowComaScoreMotor]
			, [GlasgowComaScoreQualifier]
			, [TotalGlasgowComaScore]
			, [Temperature]
			, [TemperatureMethod]
			, [LevelOfResponsiveness]
			, [PainScale]
			, [StrokeScale]
			, [ThrombolyticScreen]
			, [APGAR]
			, [RevisedTraumaScore]
			, [PediatricTraumaScore]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [VSA].[DateTimeVitalSignsTaken]
			, [VSA].[ObtainedPriorUnitsEMSCare]
			, [VSA].[SystolicBloodPressure]
			, [VSA].[DiastolicBloodPressure]
			, [VSA].[MethodBloodPressureMeasurement]
			, [VSA].[PulseRate]
			, [VSA].[ElectronicMonitorRate]
			, [VSA].[PulseOximetry]
			, [VSA].[PulseRhythm]
			, [VSA].[RespiratoryRate]
			, [VSA].[RespiratoryEffort]
			, [VSA].[CarbonDioxide]
			, [VSA].[BloodGlucoseLevel]
			, [VSA].[GlasgowComaScoreEye]
			, [VSA].[GlasgowComaScoreVerbal]
			, [VSA].[GlasgowComaScoreMotor]
			, [VSA].[GlasgowComaScoreQualifier]
			, [VSA].[TotalGlasgowComaScore]
			, [VSA].[Temperature]
			, [VSA].[TemperatureMethod]
			, [VSA].[LevelOfResponsiveness]
			, [VSA].[PainScale]
			, [VSA].[StrokeScale]
			, [VSA].[ThrombolyticScreen]
			, [VSA].[APGAR]
			, [VSA].[RevisedTraumaScore]
			, [VSA].[PediatricTraumaScore]
			, [VSA].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@VitalSignsAssessment AS [VSA]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [VSA].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [VSA].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRVitalSignsAssessmentInitialCardiacRhythm]
		(
			  [AgencyId]
			, [PatientCareReportId]
			, [CardiacRhythm]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
            , [VSAICR].[CardiacRhythm]
			, [VSAICR].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@VitalSignsAssessmentInitialCardiacRhythm AS [VSAICR]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [VSAICR].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [VSAICR].[FileImportRecordId];
				

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRVitalSignsAssessment]'
			, 'Completed the PCR Vital Signs Assessment import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRVitalSignsAssessment] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
