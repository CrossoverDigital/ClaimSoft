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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRInterventionMedications] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                                     - Column                         - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRInterventionMedications                - AdministeredDateTime           - NEMSIS V2 - E18_01 Element - Date/Time Medication Administered 
	-- PCRInterventionMedications                - AdministeredPriorUnitsEMSCare  - NEMSIS V2 - E18_02 Element - Medication Administered Prior to this Units EMS Care 
	-- PCRInterventionMedications                - MedicationGiven                - NEMSIS V2 - E18_03 Element - Medication Given 
	-- PCRInterventionMedications                - AdministeredRoute              - NEMSIS V2 - E18_04 Element - Medication Administered Route 
	-- PCRInterventionMedications                - Dosage                         - NEMSIS V2 - E18_05 Element - Medication Dosage 
	-- PCRInterventionMedications                - DosageUnits                    - NEMSIS V2 - E18_06 Element - Medication Dosage Units 
	-- PCRInterventionMedications                - Response                       - NEMSIS V2 - E18_07 Element - Response to Medication 
	-- PCRInterventionMedicationComplications    - MedicationComplication         - NEMSIS V2 - E18_08 Element - Medication Complication 
	-- PCRInterventionMedications                - CrewMemberId                   - NEMSIS V2 - E18_09 Element - Medication Crew Member ID 
	-- PCRInterventionMedications                - Authorization                  - NEMSIS V2 - E18_10 Element - Medication Authorization 
	-- PCRInterventionMedications                - AuthorizingPhysician           - NEMSIS V2 - E18_11 Element - Medication Authorizing Physician  
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--

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
			, 'NemsisImport - [dbo].[PCRInterventionMedications]'
			, 'Beginning the PCR Intervention Medications import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);


		DECLARE @InterventionMedications TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AdministeredDateTime] [datetime] NULL,
			[AdministeredPriorUnitsEMSCare] [int] NULL,
			[MedicationGiven] [varchar](30) NOT NULL,
			[AdministeredRoute] [int] NULL,
			[Dosage] [decimal](8, 2) NULL,
			[DosageUnits] [int] NULL,
			[Response] [int] NULL,
			[CrewMemberId] [varchar](15) NULL,
			[Authorization] [int] NULL,
			[AuthorizingPhysician] [varchar](20) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @InterventionMedicationComplications TABLE
		(
			[AgencyId] [int] NOT NULL,
			[AdministeredDateTime] [datetime] NULL,
			[MedicationComplication] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		
		INSERT INTO @InterventionMedications 
		(
			  [AgencyId]
			, [AdministeredDateTime]
			, [AdministeredPriorUnitsEMSCare]
			, [MedicationGiven]
			, [AdministeredRoute]
			, [Dosage]
			, [DosageUnits]
			, [Response]
			, [CrewMemberId]
			, [Authorization]
			, [AuthorizingPhysician]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AdministeredDateTime]
			, [AdministeredPriorUnitsEMSCare]
			, [MedicationGiven]
			, [AdministeredRoute]
			, [Dosage]
			, [DosageUnits]
			, [Response]
			, [CrewMemberId]
			, [Authorization]
			, [AuthorizingPhysician]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E18', 2) WITH 
		(
			  [AdministeredDateTime] DATETIME 'n:E18_01'
			, [AdministeredPriorUnitsEMSCare] INT 'n:E18_02'
			, [MedicationGiven] VARCHAR(15) 'n:E18_03'
			, [AdministeredRoute] INT 'n:E18_04'
			, [Dosage] DECIMAL 'n:E18_05_0/n:E18_05'
			, [DosageUnits] INT 'n:E18_05_0/n:E18_06'
			, [Response] INT 'n:E18_07'
			, [CrewMemberId] VARCHAR(7) 'n:E18_09'
			, [Authorization] INT 'n:E18_10'
			, [AuthorizingPhysician] VARCHAR(10) 'n:E18_11'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		

		INSERT INTO @InterventionMedicationComplications 
		(
			  [AgencyId]
			, [AdministeredDateTime]
			, [MedicationComplication]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [AdministeredDateTime]
			, [MedicationComplication]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E18', 2) WITH (
					  [AdministeredDateTime] DATETIME 'n:E18_01'
					, [MedicationComplication] INT 'n:E18_08'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
			

		INSERT INTO [dbo].[PCRInterventionMedications]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [AdministeredDateTime]
			, [AdministeredPriorUnitsEMSCare]
			, [MedicationGiven]
			, [AdministeredRoute]
			, [Dosage]
			, [DosageUnits]
			, [Response]
			, [CrewMemberId]
			, [Authorization]
			, [AuthorizingPhysician]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [IM].[AdministeredDateTime]
			, [IM].[AdministeredPriorUnitsEMSCare]
			, [IM].[MedicationGiven]
			, [IM].[AdministeredRoute]
			, [IM].[Dosage]
			, [IM].[DosageUnits]
			, [IM].[Response]
			, [IM].[CrewMemberId]
			, [IM].[Authorization]
			, [IM].[AuthorizingPhysician]
			, [IM].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionMedications AS [IM]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IM].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IM].[FileImportRecordId];
			

		INSERT INTO [dbo].[PCRInterventionMedicationComplications]
		(
			  [AgencyId]
			, [PCRInterventionMedicationId]
            , [MedicationComplication]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [IM].[Id]
            , [IMC].[MedicationComplication]
			, [IMC].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionMedicationComplications AS [IMC]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IMC].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PCRInterventionMedications] AS [IM]
		ON
			    [IM].[FileImportRecordId] = [IMC].[FileImportRecordId]
			AND [IM].[AdministeredDateTime] = [IMC].[AdministeredDateTime];
				

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
			, 'NemsisImport - [dbo].[PCRInterventionMedications]'
			, 'Completed the PCR Intervention Medications import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[PCRInterventionMedications] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
