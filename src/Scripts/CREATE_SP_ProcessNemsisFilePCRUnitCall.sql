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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRUnitCall] 
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
	-- PCRUnitCall                   - PatientCareReportId         - NEMSIS V2 - E01 - Patient Care Report 
	-- PCRUnitCall                   - DispatchComplaintReported   - NEMSIS V2 - E03_01 Element - Complaint Reported by Dispatch 
	-- PCRUnitCall                   - EMDPerformed                - NEMSIS V2 - E03_02 Element - EMD Performed 
	-- PCRUnitCall                   - EMDCardNumber               - NEMSIS V2 - E03_03 Element - EMD Card Number 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitCall]'
			, 'Beginning the PCR Unit Call import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId:' + CONVERT(VARCHAR, @FileImportId) + ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);
		

		DECLARE @UnitCall TABLE
		(
			[PatientCareReportNumber] [varchar](30) NOT NULL,
			[AgencyId] [int] NOT NULL,
			[DispatchComplaintReported] [int] NOT NULL,
			[EMDPerformed] [int] NOT NULL,
			[EMDCardNumber] [varchar](10) NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)


		INSERT INTO @UnitCall 
		(
			  [PatientCareReportNumber]
			, [AgencyId]
			, [DispatchComplaintReported]
			, [EMDPerformed]
			, [EMDCardNumber]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PatientCareReportNumber]
			, @AgencyId
			, [DispatchComplaintReported]
			, [EMDPerformed]
			, [EMDCardNumber]
			, CONCAT( [AgencyNumber]
					, [AgencyState]
					, [UnitCallSign]
					, [PatientCareReportNumber]
					, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E03', 2) WITH (
					  [DispatchComplaintReported] INT 'n:E03_01'
					, [EMDPerformed] INT 'n:E03_02'
					, [EMDCardNumber] VARCHAR(30) 'n:E03_03'
					, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
					, [AgencyState] INT '../../n:D01_03'
					, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');

				   
		INSERT INTO [dbo].[PCRUnitCall]
        (
			  [PatientCareReportId]
			, [AgencyId]
			, [DispatchComplaintReported]
			, [EMDPerformed]
			, [EMDCardNumber]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
     	SELECT 
			  [PCR].[Id]
			, @AgencyId
			, [PUC].[DispatchComplaintReported]
			, [PUC].[EMDPerformed]
			, [PUC].[EMDCardNumber]
			, [PUC].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@UnitCall AS [PUC]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId] = [PUC].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId] = @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUC].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUC].[PatientCareReportNumber]
		ORDER BY 
			[PUC].[FileImportRecordId];
			

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitCall]'
			, 'Completed the PCR Unit Call import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRUnitCall] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
