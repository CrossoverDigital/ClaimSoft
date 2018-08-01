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

CREATE PROCEDURE [dbo].[ProcessNemsisFilePCRHeader] 
	  @XmlDocumentHandle INT
	, @FileImportId INT
	, @AgencyId INT
	, @UserId NVARCHAR(128)
	, @LoadDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- TABLE: [PCRHeader]
	--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=--=
	-- AgencyId           = NEMSIS V2 - D01    Element - Agency General Information
	-- AgencyNumber       = NEMSIS V2 - D01_01 Element - The state-assigned provider number of the agency
	-- State              = NEMSIS V2 - D01_03 Element - The agency state
	-- County             = NEMSIS V2 - D01_04 Element - The agency county
	-- LevelOfService     = NEMSIS V2 - D01_07 Element - The agency level of service
	-- OrganizationType   = NEMSIS V2 - D01_08 Element - The agency organization type
	-- OrganizationStatus = NEMSIS V2 - D01_09 Element - The agency organization status
	-- NationalProviderId = NEMSIS V2 - D01_21 Element - The agency national provider ID
	-- ZipCode            = NEMSIS V2 - D02_07 Element - Zip Code
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
            , 'NemsisImport - [dbo].[ProcessNemsisFilePCRHeader]'
            , 'Beginning the PCRHeader import. AgencyId: ' + CAST(@AgencyId AS VARCHAR) + ' FileImportId: ' + CONVERT(VARCHAR, @FileImportId) +  ' UserId: ' + @UserId + ' LoadDate: ' + CONVERT(VARCHAR, @LoadDate)
            , GETDATE()
		    , @Userid
		)
		
		INSERT INTO [dbo].[PCRHeader] 
		( 
			  [AgencyId]
			, [FileImportId]
			, [AgencyNumber]
			, [State]
			, [County]
			, [LevelOfService]
			, [OrganizationType]
			, [OrganizationStatus]
			, [NationalProviderId]
			, [ZipCode]
			, [CreateBy]
			, [CreateDate]
			, [LastModifyBy]
			, [LastModifyDate] 
		)
		SELECT
			  @AgencyId
			, @FileImportId
		    , [AgencyNumber]
			, [State]
			, [County]
			, [LevelOfService]
			, [OrganizationType]
			, [OrganizationStatus]
			, [NationalProviderId]
			, [ZipCode]
			, @UserId
			, @LoadDate
			, @UserId
			, @LoadDate
		FROM
			OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header', 2) WITH (
				[AgencyNumber] varchar(15) 'n:D01_01', -- Agency Number
				[State] int 'n:D01_03', -- Agency State
				[County] varchar(5) 'n:D01_04', -- Agency County
				[LevelOfService] varchar(30) 'n:D01_07', -- Level Of Service
				[OrganizationType] int 'n:D01_08', -- Organization Type
				[OrganizationStatus] int 'n:D01_09', -- Organization Status
				[NationalProviderId] varchar(10) 'n:D01_21', -- National Provider ID
				[ZipCode] varchar(10) 'n:D02_07' -- Zip Code
			);


		INSERT INTO [dbo].[ApplicationLog] (
			  [AgencyId]
			, [Severity]
			, [Logger]
			, [Message]
			, [LogDate]
			, [UserId]
		) VALUES (
		     @AgencyId
		   , 'INFO'
           , 'NemsisImport - [dbo].[ProcessNemsisFilePCRHeader]'
           , 'Completed the PCRHeader import.'
           , GETDATE()
		   , @UserId
		)
	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(2048)

		SET @message = 'Error processing the PCRHeader import. Error Line: ' + CAST(ERROR_LINE() AS VARCHAR) + ' Error Message: ' + ERROR_MESSAGE();

		THROW 58000, @message, 1
	END CATCH;
END;
GO
