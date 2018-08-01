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

ALTER PROCEDURE [dbo].[ProcessNemsisFilePCRUnitPersonnel] 
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
    -- PCRUnitPersonnel              - CrewMemberId                - NEMSIS V2 - E04_01 Element - Crew Member ID 
    -- PCRUnitPersonnel              - CrewMemberRole              - NEMSIS V2 - E04_02 Element - Crew Member Role 
    -- PCRUnitPersonnel              - CrewMemberLevel             - NEMSIS V2 - E04_03 Element - Crew Member Level 
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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitPersonnel]'
			, 'Beginning the PCR Unit Personnel import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
			, GETDATE()
			, @UserId
		);

		
		DECLARE @UnitPersonnel TABLE
		(
			[PatientCareReportNumber] [varchar](30) NOT NULL,
			[AgencyId] [int] NOT NULL,
			[CrewMemberId] [varchar](15) NULL,
			[CrewMemberRole] [int] NULL,
			[CrewMemberLevel] [int] NULL,
			[FileImportRecordId] [nvarchar](50) NOT NULL,
			[CreateBy] [nvarchar](128) NOT NULL,
			[CreateDate] [datetime] NOT NULL,
			[LastModifyBy] [nvarchar](128) NOT NULL,
			[LastModifyDate] [datetime] NOT NULL
		)

		INSERT INTO @UnitPersonnel 
		(
			  [PatientCareReportNumber]
			, [AgencyId]
			, [CrewMemberId]
			, [CrewMemberRole]
			, [CrewMemberLevel]
			, [FileImportRecordId]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate]
		)
		SELECT 
			  [PatientCareReportNumber]
			, @AgencyId AS [AgencyId]
			, [CrewMemberId]
			, [CrewMemberRole]
			, [CrewMemberLevel]
			, CONCAT( [AgencyNumber]
				, [AgencyState]
				, [UnitCallSign]
				, [PatientCareReportNumber]
				, [UnitNotifiedByDispatchDateTime]) AS [FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E04', 2) WITH (
					[CrewMemberId] VARCHAR(30) 'n:E04_01'
				, [CrewMemberRole] INT 'n:E04_02'
				, [CrewMemberLevel] INT 'n:E04_03'
				, [AgencyNumber] VARCHAR(30) '../n:E02/n:E02_01'
				, [AgencyState] INT '../../n:D01_03'
				, [UnitCallSign] VARCHAR(30) '../n:E02/n:E02_12'
				, [PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
				, [UnitNotifiedByDispatchDateTime] VARCHAR(30) '../n:E05/n:E05_04');

				   
		INSERT INTO [dbo].[PCRUnitPersonnel]
           ([AgencyId]
           ,[PatientCareReportId]
           ,[CrewMemberId]
           ,[CrewMemberRole]
           ,[CrewMemberLevel]
           ,[FileImportRecordId]
           ,[CreateBy]
           ,[CreateDate]
           ,[LastModifyBy]
           ,[LastModifyDate])
     	SELECT 
			  @AgencyId
			, [PCR].[Id]
			, [PUP].[CrewMemberId]
			, [PUP].[CrewMemberRole]
			, [PUP].[CrewMemberLevel]
			, [PUP].[FileImportRecordId]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM 
			@UnitPersonnel AS [PUP]
		INNER JOIN
			[dbo].[FileImportRecords] AS [FIR]
		ON
				[FIR].[FileImportRecordId]= [PUP].[FileImportRecordId]
			AND [FIR].[AgencyId] = @AgencyId
			AND [FIR].[FileImportId]= @FileImportId
		INNER JOIN
			[dbo].[PatientCareReport] AS [PCR]
		ON
			    [PCR].[FileImportRecordId] = [PUP].[FileImportRecordId]
			AND [PCR].[PatientCareReportNumber] = [PUP].[PatientCareReportNumber];
			

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
			, 'NemsisImport - [dbo].[ProcessNemsisFilePCRUnitPersonnel]'
			, 'Completed the PCR Unit Personnel import.'
			, GETDATE()
			, @UserId
		);
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the [dbo].[ProcessNemsisFilePCRUnitPersonnel] import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Messsage: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
