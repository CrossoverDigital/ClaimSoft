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

ALTER PROCEDURE [dbo].[ProcessNemsisFile]
    @FileName NVARCHAR(255),
    @UserId   NVARCHAR(128),
    @AgencyId INT
AS
    BEGIN
        SET NOCOUNT ON;
        SET XACT_ABORT ON;

        DECLARE
            @XmlDocument       AS XML,
            @XmlDocumentHandle AS INT,
            @LoadDate          AS DATETIME = GETDATE();    

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
			, 'NemsisImport - [dbo].[ProcessNemsisFile]'
			, 'Beginning the NEMSIS import. File: '+@FileName+' User Id: '+@UserId
			, GETDATE()
			, @UserId
        );

        BEGIN TRY
            BEGIN TRANSACTION;

            SELECT 
				@XmlDocument = CONVERT(XML, [file_stream])
            FROM
				[cdTestDB].[dbo].[_AgencyImport]
            WHERE 
				[name] = @FileName;

            EXEC [sp_xml_preparedocument]
                  @XmlDocumentHandle OUTPUT
				, @XmlDocument
				, '<root xmlns:n="http://www.nemsis.org" />';


            INSERT INTO [dbo].[FileImport]
			(
                  [AgencyId]
				, [Success]
				, [CreateBy]
				, [CreateDate]
				, [LastModifyBy]
				, [LastModifyDate]
			)
            VALUES
            (
				  @AgencyId
				, 0
				, @UserId
				, @LoadDate
				, @UserId
				, @LoadDate
            );

            DECLARE @FileImportId AS INT = SCOPE_IDENTITY();
			
			INSERT INTO [dbo].[FileImportRecords]
			( 
				  [AgencyId]
				, [FileImportId]
				, [FileImportRecordId]
				, [CreateBy]
				, [CreateDate]
				, [LastModifyBy]
				, [LastModifyDate]
			)
    		SELECT
				  @AgencyId
				, @FileImportId
				, CONCAT([AgencyNumber]
						, [AgencyState]
						, [UnitCallSign]
						, [PatientCareReportNumber]
						, [UnitNotifiedByDispatchDateTime])
				, @UserId
				, @LoadDate
				, @UserId
				, @LoadDate
			FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record', 2) WITH (
					  [AgencyNumber] VARCHAR(30) 'n:E02/n:E02_01'
					, [AgencyState] INT '../n:D01_03'
					, [UnitCallSign] VARCHAR(30) 'n:E02/n:E02_12'
					, [PatientCareReportNumber] VARCHAR(30) 'n:E01/n:E01_01'
					, [UnitNotifiedByDispatchDateTime] VARCHAR(30) 'n:E05/n:E05_04');
					

			-- D01 - Process the Header
            EXEC [dbo].[ProcessNemsisFilePCRHeader] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate;

			-- E01 - Process all the Patient Care Report records
            EXEC [dbo].[ProcessNemsisFilePatientCareReport] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate;

			-- E02 - Process all the PCR Unit Agency records
			EXEC [ProcessNemsisFilePCRUnitAgency] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E03 - Process all the PCR Unit Call records
			EXEC [ProcessNemsisFilePCRUnitCall] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E04 - Process all the PCR Unit Personnel records
			EXEC [ProcessNemsisFilePCRUnitPersonnel] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E05 - Process all the PCR Times records
			EXEC [ProcessNemsisFilePCRTimes] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E06 - Process all the PCR Patient records
			EXEC [ProcessNemsisFilePCRPatient] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E07 - Process all the PCR Billing records
			EXEC [ProcessNemsisFilePCRBilling] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E08 - Process all the PCR Scene records
			EXEC [ProcessNemsisFilePCRScene] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E09 - Process all the PCR Situation records
			EXEC [ProcessNemsisFilePCRSituation] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E10 - Process all the PCR Trauma records
			EXEC [ProcessNemsisFilePCRTrauma] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E11 - Process all the PCR CPR records
			EXEC [ProcessNemsisFilePCRCPR] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E12 - Process all the PCR Medical History records
			EXEC [ProcessNemsisFilePCRMedicalHistory] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E13 - Process all the PCR Narrative records
			EXEC [ProcessNemsisFilePCRNarrative] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E14 - Process all the PCR Vital Signs Assessment records
			EXEC [ProcessNemsisFilePCRVitalSignsAssessment] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E15
			-- E16 - PCRAssessmentExam

			-- E17 - Process all the PCR Intervention records
			EXEC [ProcessNemsisFilePCRIntervention] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E18 - Process all the PCR Intervention Medications records
			EXEC [ProcessNemsisFilePCRInterventionMedications] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E19 - Process all the PCR Intervention Procedures Performed records
			EXEC [ProcessNemsisFilePCRInterventionProceduresPerformed] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E20 - Process all the PCR Disposition records
			EXEC [ProcessNemsisFilePCRDisposition] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E21 - Process all the PCR Medical Device Data records
			EXEC [ProcessNemsisFilePCRMedicalDeviceData] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E22 - Process all the PCR Outcome Linkage records
			EXEC [ProcessNemsisFilePCROutcomeLinkage] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			-- E23 - Process all the PCR Miscellaneous records
			EXEC [ProcessNemsisFilePCRMiscellaneous] @XmlDocumentHandle, @FileImportId, @AgencyId, @UserId, @LoadDate

			EXEC [sp_xml_removedocument] @XmlDocumentHandle;


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
				, 'NemsisImport - [dbo].[ProcessNemsisFile]'
				, 'Completed the NEMSIS import. File: '+@FileName+' User Id: '+@UserId
				, GETDATE()
				, @UserId
			);

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;

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
				, 'ERROR'
				, 'NemsisImport - [dbo].[ProcessNemsisFile]'
				, 'Error processing the NEMSIS import. File: '+@FileName+' User Id: '+@UserId+' Error Line: '+CAST(ERROR_LINE() AS VARCHAR)+' Error Message: '+ERROR_MESSAGE()
				, GETDATE()
				, @UserId
            );
        END CATCH;
    END;
GO