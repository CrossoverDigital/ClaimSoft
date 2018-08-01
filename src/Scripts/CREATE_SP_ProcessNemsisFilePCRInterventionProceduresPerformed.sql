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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRInterventionProceduresPerformed] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- Table                                                 - Column                                - Description
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--
	-- PCRInterventionProceduresPerformed                    - PerformedSuccessfullyDateTime         - NEMSIS V2 - E19_01 Element - Date/Time Procedure Performed Successfully 
	-- PCRInterventionProceduresPerformed                    - PerformedPriorToUnitsEMSCare          - NEMSIS V2 - E19_02 Element - Procedure Performed Prior to this Units EMS Care 
	-- PCRInterventionProceduresPerformed                    - Procedure                             - NEMSIS V2 - E19_03 Element - Procedure 
	-- PCRInterventionProceduresPerformed                    - EquipmentSize                         - NEMSIS V2 - E19_04 Element - Size of Procedure Equipment 
	-- PCRInterventionProceduresPerformed                    - NumberOfAttempts                      - NEMSIS V2 - E19_05 Element - Number of Procedure Attempts 
	-- PCRInterventionProceduresPerformed                    - ProcedureSuccessful                   - NEMSIS V2 - E19_06 Element - Procedure Successful 
	-- PCRInterventionProceduresPerformed                    - Response                              - NEMSIS V2 - E19_08 Element - Response to Procedure 
	-- PCRInterventionProceduresPerformed                    - CrewMembersId                         - NEMSIS V2 - E19_09 Element - Procedure Crew Members ID 
	-- PCRInterventionProceduresPerformed                    - Authorization                         - NEMSIS V2 - E19_10 Element - Procedure Authorization 
	-- PCRInterventionProceduresPerformed                    - AuthorizingPhysician                  - NEMSIS V2 - E19_11 Element - Procedure Authorizing Physician 
	-- PCRInterventionProceduresPerformedComplications       - PCRInterventionProceduresPerformedId  - NEMSIS V2 - E19 - Intervention Procedures Performed 
	-- PCRInterventionProceduresPerformedComplications       - ProcedureComplication                 - NEMSIS V2 - E19_07 Element - Procedure Complication 
	-- PCRInterventionProceduresPerformedSuccessfulIVSite    - SuccessfulIVSite                      - NEMSIS V2 - E19_12 Element - Successful IV Site 
	-- PCRInterventionProceduresPerformedTubeConfirmation    - TubeConfirmation                      - NEMSIS V2 - E19_13 Element - Tube Confirmation 
	-- PCRInterventionProceduresPerformedTubePlacement       - TubePlacement                         - NEMSIS V2 - E19_14 Element - Destination Confirmation of Tube Placement 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRInterventionProceduresPerformed]'
			, 'Beginning the PCR Intervention Procedures Performed import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);


		DECLARE @InterventionProceduresPerformed TABLE
		(
			[AgencyId] [int] NOT NULL,
			[PerformedSuccessfullyDateTime] [datetime] NULL,
			[PerformedPriorToUnitsEMSCare] [int] NULL,
			[Procedure] [varchar](255) NOT NULL,
			[EquipmentSize] [varchar](20) NULL,
			[NumberOfAttempts] [varchar](255) NOT NULL,
			[ProcedureSuccessful] [int] NOT NULL,
			[Response] [int] NULL,
			[CrewMembersId] [varchar](15) NULL,
			[Authorization] [int] NULL,
			[AuthorizingPhysician] [varchar](20) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @InterventionProceduresPerformedComplications TABLE
		(
			[AgencyId] [int] NOT NULL,
			[PerformedSuccessfullyDateTime] [datetime] NULL,
			[ProcedureComplication] [int] NOT NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @InterventionProceduresPerformedSuccessfulIVSite TABLE
		(
			[AgencyId] [int] NOT NULL,
			[SuccessfulIVSite] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @InterventionProceduresPerformedTubeConfirmation TABLE
		(
			[AgencyId] [int] NOT NULL,
			[TubeConfirmation] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)
		
				
		DECLARE @InterventionProceduresPerformedTubePlacement TABLE
		(
			[AgencyId] [int] NOT NULL,
			[TubePlacement] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

				
		INSERT INTO @InterventionProceduresPerformed 
		(
			  [AgencyId]
			, [PerformedSuccessfullyDateTime]
			, [PerformedPriorToUnitsEMSCare]
			, [Procedure]
			, [EquipmentSize]
			, [NumberOfAttempts]
			, [ProcedureSuccessful]
			, [Response]
			, [CrewMembersId]
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
			, [PerformedSuccessfullyDateTime]
			, [PerformedPriorToUnitsEMSCare]
			, [Procedure]
			, [EquipmentSize]
			, [NumberOfAttempts]
			, [ProcedureSuccessful]
			, [Response]
			, [CrewMembersId]
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
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH 
		(
			  [PerformedSuccessfullyDateTime] DATETIME 'n:E19_01_0/n:E19_01'
			, [PerformedPriorToUnitsEMSCare] INT 'n:E19_01_0/n:E19_02'
			, [Procedure] VARCHAR(127) 'n:E19_01_0/n:E19_03'
			, [EquipmentSize] VARCHAR(10) 'n:E19_01_0/n:E19_04'
			, [NumberOfAttempts] VARCHAR(127) 'n:E19_01_0/n:E19_05'
			, [ProcedureSuccessful] INT 'n:E19_01_0/n:E19_06'
			, [Response] INT 'n:E19_01_0/n:E19_08'
			, [CrewMembersId] VARCHAR(7) 'n:E19_01_0/n:E19_09'
			, [Authorization] INT 'n:E19_01_0/n:E19_10'
			, [AuthorizingPhysician] VARCHAR(10) 'n:E19_01_0/n:E19_11'
			, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
			, [AgencyState] INT '../../n:D01_03'
			, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
			, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
			, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04'
		);
		

		INSERT INTO @InterventionProceduresPerformedComplications 
		(
			  [AgencyId]
			, [PerformedSuccessfullyDateTime]
            , [ProcedureComplication]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [PerformedSuccessfullyDateTime]
			, [ProcedureComplication]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH (
					  [PerformedSuccessfullyDateTime] DATETIME 'n:E19_01_0/n:E19_01'
					, [ProcedureComplication] INT 'n:E19_01_0/n:E19_07'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @InterventionProceduresPerformedSuccessfulIVSite 
		(
			  [AgencyId]
            , [SuccessfulIVSite]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [SuccessfulIVSite]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH (
					  [SuccessfulIVSite] INT 'n:E19_12'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @InterventionProceduresPerformedTubeConfirmation 
		(
			  [AgencyId]
            , [TubeConfirmation]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [TubeConfirmation]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH (
					  [TubeConfirmation] INT 'n:E19_13'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
		

		INSERT INTO @InterventionProceduresPerformedTubePlacement 
		(
			  [AgencyId]
            , [TubePlacement]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  @AgencyId AS [AgencyId]
			, [TubePlacement]		
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH (
					  [TubePlacement] INT 'n:E19_14'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');

					
		INSERT INTO [dbo].[PCRInterventionProceduresPerformed]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [PerformedSuccessfullyDateTime]
			, [PerformedPriorToUnitsEMSCare]
			, [Procedure]
			, [EquipmentSize]
			, [NumberOfAttempts]
			, [ProcedureSuccessful]
			, [Response]
			, [CrewMembersId]
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
			, [IPP].[PerformedSuccessfullyDateTime]
			, [IPP].[PerformedPriorToUnitsEMSCare]
			, [IPP].[Procedure]
			, [IPP].[EquipmentSize]
			, [IPP].[NumberOfAttempts]
			, [IPP].[ProcedureSuccessful]
			, [IPP].[Response]
			, [IPP].[CrewMembersId]
			, [IPP].[Authorization]
			, [IPP].[AuthorizingPhysician]
			, [IPP].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionProceduresPerformed AS [IPP]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IPP].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IPP].[FileImportRecordId];
		
		
		INSERT INTO [dbo].[PCRInterventionProceduresPerformedComplications]
		(
			  [AgencyId]
			, [PCRInterventionProceduresPerformedId]
            , [ProcedureComplication]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  @AgencyId
			, [IPP].[Id]
            , [IPPC].[ProcedureComplication]
			, [IPPC].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionProceduresPerformedComplications AS [IPPC]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IPPC].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PCRInterventionProceduresPerformed] AS [IPP]
		ON
			    [IPP].[FileImportRecordId] = [IPPC].[FileImportRecordId]
			AND [IPP].[PerformedSuccessfullyDateTime] = [IPPC].[PerformedSuccessfullyDateTime];
		
		
		INSERT INTO [dbo].[PCRInterventionProceduresPerformedSuccessfulIVSite]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [SuccessfulIVSite]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [IPPS].[SuccessfulIVSite]
			, [IPPS].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionProceduresPerformedSuccessfulIVSite AS [IPPS]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IPPS].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IPPS].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRInterventionProceduresPerformedTubeConfirmation]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [TubeConfirmation]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [IPPTC].[TubeConfirmation]
			, [IPPTC].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionProceduresPerformedTubeConfirmation AS [IPPTC]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IPPTC].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IPPTC].[FileImportRecordId];
		

		INSERT INTO [dbo].[PCRInterventionProceduresPerformedTubePlacement]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [TubePlacement]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
            , @AgencyId
			, [IPPTP].[TubePlacement]
			, [IPPTP].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@InterventionProceduresPerformedTubePlacement AS [IPPTP]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [IPPTP].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [IPPTP].[FileImportRecordId];
				

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRInterventionProceduresPerformed]'
			, 'Completed the PCR Intervention Procedures Performed import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRInterventionProceduresPerformed] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO