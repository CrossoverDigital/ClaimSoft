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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePatientCareReport] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- TABLE: [PatientCareReport]
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- AgencyId                = NEMSIS V2 - D01    Element - Agency General Information
	-- PatientCareReportNumber = NEMSIS V2 - E01_01 Element - Patient Care Report Number
	-- SoftwareCreator         = NEMSIS V2 - E01_02 Element - Software Creator
	-- SoftwareName            = NEMSIS V2 - E01_03 Element - Software Name
	-- SoftwareVersion         = NEMSIS V2 - E01_04 Element - Software Version
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
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
           , 'NemsisImport - [dbo].[ProcessNemsisFilePatientCareReport]'
           , 'Beginning the PatientCareReport import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
           , GETDATE()
		   , @UserId
		);
		
		
		INSERT INTO [dbo].[PatientCareReport] ( 
			  [AgencyId]
			, [PatientCareReportNumber]
			, [SoftwareCreator]
			, [SoftwareName]
			, [SoftwareVersion]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate] 
		)
		SELECT
			  @AgencyId
			, [PatientCareReportNumber]
			, [SoftwareCreator]
			, [SoftwareName]
			, [SoftwareVersion]
			, CONCAT( [AgencyNumber]
					, [AgencyState]
					, [UnitCallSign]
					, [PatientCareReportNumber]
					, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM
			OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E01', 2) WITH (
				  [PatientCareReportNumber] VARCHAR(30) 'n:E01_01'
				, [SoftwareCreator] VARCHAR(30) 'n:E01_02'
				, [SoftwareName] VARCHAR(30) 'n:E01_03'
				, [SoftwareVersion] VARCHAR(30) 'n:E01_04'
			    , [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
				, [AgencyState] INT '../../n:D01_03'
				, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
				, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');
				

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePatientCareReport]'
			, 'Completed the PatientCareReport import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePatientCareReport] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
