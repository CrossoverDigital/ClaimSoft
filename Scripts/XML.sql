









---- PCRUnitPersonnel
--SELECT *
--FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E04', 2) WITH (
--		[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--		,[CrewMemberId] VARCHAR(7) 'n:E04_01'
--		,[CrewMemberRole] INT 'n:E04_02'
--		,[CrewMemberLevel] INT 'n:E04_03'
--		);

---- PCRTimes
--SELECT *
--FROM OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E05', 2) WITH (
--		[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--		,[IncidentDateTime] DATETIME 'n:E05_01'
--		,[PSAPCallDateTime] DATETIME 'n:E05_02'
--		,[DispatchNotifiedDateTime] DATETIME 'n:E05_03'
--		,[UnitNotifiedByDispatchDateTime] DATETIME 'n:E05_04'
--		,[UnitEnRouteDateTime] DATETIME 'n:E05_05'
--		,[UnitArrivedSceneDateTime] DATETIME 'n:E05_06'
--		,[ArrivedAtPatientDateTime] DATETIME 'n:E05_07'
--		,[TransferPatientCareDateTime] DATETIME 'n:E05_08'
--		,[UnitLeftSceneDateTime] DATETIME 'n:E05_09'
--		,[PatientArrivedDestinationDateTime] DATETIME 'n:E05_10'
--		,[UnitBackInServiceDateTime] DATETIME 'n:E05_11'
--		,[UnitCancelledDateTime] DATETIME 'n:E05_12'
--		,[UnitBackHomeLocationDateTime] DATETIME 'n:E05_13'
--		);

-- PCRPatient
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E06', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[LastName] VARCHAR(10) 'n:E06_01_0/n:E06_01'
--	,[FirstName] VARCHAR(10) 'n:E06_01_0/n:E06_02'
--	,[MiddleName] VARCHAR(10) 'n:E06_01_0/n:E06_03'
--	,[HomeAddress] VARCHAR(15) 'n:E06_04_0/n:E06_04'
--	,[HomeCity] VARCHAR(15) 'n:E06_04_0/n:E06_05'
--	,[HomeCounty] VARCHAR(2) 'n:E06_06'
--	,[HomeState] VARCHAR(1) 'n:E06_04_0/n:E06_07'
--	,[HomeZipCode] VARCHAR(5) 'n:E06_04_0/n:E06_08'
--	,[HomeCountry] VARCHAR(10) 'n:E06_09'
--	,[SocialSecurityNumber] VARCHAR(5) 'n:E06_10'
--	,[Gender] INT 'n:E06_11'
--	,[Race] INT 'n:E06_12'
--	,[Ethnicity] INT 'n:E06_13'
--	,[Age] INT 'n:E06_14_0/n:E06_14'
--	,[AgeUnits] INT 'n:E06_14_0/n:E06_15'
--	,[DateOfBirth] DATETIME 'n:E06_16'
--	,[PrimaryorHomeTelephoneNumber] VARCHAR(5) 'n:E06_17'
--	,[StateIssuingDriverLicense] VARCHAR(1) 'n:E06_19_0/n:E06_18'
--	,[DriverLicenseNumber] VARCHAR(15) 'n:E06_19_0/n:E06_19'
--	);

-- PCRBilling
-- PCRBillingInsurance
-- PCRBillingConditionCodes
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E07', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[PrimaryPaymentMethod] INT 'n:E07_01'
--	,[CertificateMedicalNecessity] INT 'n:E07_02'
--	,[InsuranceCompanyId] VARCHAR(15) 'n:E07_03_0/n:E07_03'
--	,[InsuranceCompanyBillingPriority] INT 'n:E07_03_0/n:E07_04'
--	,[InsuranceCompanyAddress] VARCHAR(15) 'n:E07_03_0/n:E07_05_0/n:E07_05'
--	,[InsuranceCompanyCity] VARCHAR(15) 'n:E07_03_0/n:E07_05_0/n:E07_06'
--	,[InsuranceCompanyState] VARCHAR(1) 'n:E07_03_0/n:E07_05_0/n:E07_07'
--	,[InsuranceCompanyZipCode] VARCHAR(5) 'n:E07_03_0/n:E07_05_0/n:E07_08'
--	,[InsuranceGroupId] VARCHAR(15) 'n:E07_03_0/n:E07_09'
--	,[InsurancePolicyIdNumber] VARCHAR(15) 'n:E07_03_0/n:E07_10'
--	,[InsuredLastName] VARCHAR(10) 'n:E07_03_0/n:E07_11_0/n:E07_11'
--	,[InsuredFirstName] VARCHAR(10) 'n:E07_03_0/n:E07_11_0/n:E07_12'
--	,[InsuredMiddleName] VARCHAR(10) 'n:E07_03_0/n:E07_11_0/n:E07_13'
--	,[RelationshipToInsured] INT 'n:E07_03_0/n:E07_14'
--	,[WorkRelated] INT 'n:E07_15'
--	,[PatientOccupationalIndustry] INT 'n:E07_16'
--	,[PatientOccupation] INT 'n:E07_17'
--	,[GuardianLastName] VARCHAR(10) 'n:E07_18_0/n:E07_18_01/n:E07_18'
--	,[GuardianFirstName] VARCHAR(10) 'n:E07_18_0/n:E07_18_01/n:E07_19'
--	,[GuardianMiddleName] VARCHAR(10) 'n:E07_18_0/n:E07_18_01/n:E07_20'
--	,[GuardianAddress] VARCHAR(15) 'n:E07_18_0/n:E07_21_0/n:E07_21'
--	,[GuardianCity] VARCHAR(15) 'n:E07_18_0/n:E07_21_0/n:E07_22'
--	,[GuardianState] VARCHAR(3) 'n:E07_18_0/n:E07_21_0/n:E07_23'
--	,[GuardianZipCode] VARCHAR(5) 'n:E07_18_0/n:E07_21_0/n:E07_24'
--	,[GuardianPhoneNumber] VARCHAR(5) 'n:E07_18_0/n:E07_25'
--	,[GuardianRelationship] INT 'n:E07_18_0/n:E07_26'
--	,[PatientEmployer] VARCHAR(15) 'n:E07_27_0/n:E07_27'
--	,[PatientEmployerAddress] VARCHAR(15) 'n:E07_27_0/n:E07_28_0/n:E07_28'
--	,[PatientEmployerCity] VARCHAR(15) 'n:E07_27_0/n:E07_28_0/n:E07_29'
--	,[PatientEmployerState] VARCHAR(3) 'n:E07_27_0/n:E07_28_0/n:E07_30'
--	,[PatientEmployerZipCode] VARCHAR(5) 'n:E07_27_0/n:E07_28_0/n:E07_31'
--	,[PatientWorkTelephoneNumber] VARCHAR(5) 'n:E07_32'
--	,[ResponseUrgency] INT 'n:E07_33'
--	,[CMSServiceLevel] INT 'n:E07_34'
--	,[CodeNumber] VARCHAR(15) 'n:E07_35_0/n:E07_35'
--	,[ICD9Code] VARCHAR(15) 'n:E07_35_0/n:E07_36'
--	,[CodeModifier] INT 'n:E07_37'
--	);

--PCRSceneOtherEMSAgencies
--PCRSceneOtherServices
--PCRScene
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E08', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[OtherEMSAgencies] VARCHAR(15) 'n:E08_01'
--	,[OtherService] INT 'n:E08_02'
--	,[EstimatedDateTimeInitialResponderArrived] INT 'n:E08_03'
--	,[DateTimeInitialResponderArrived] DATETIME 'n:E08_04'
--	,[NumberPatientsScene] INT 'n:E08_05'
--	,[MassCasualtyIncident] INT 'n:E08_06'
--	,[IncidentLocationType] INT 'n:E08_07'
--	,[IncidentFacilityCode] VARCHAR(15) 'n:E08_08'
--	,[SceneZoneNumber] VARCHAR(15) 'n:E08_09'
--	,[SceneGPSLocationLatitude] DECIMAL 'n:E08_10'
--	,[SceneGPSLocationLongitude] DECIMAL 'n:E08_10'
--	,[IncidentAddress] VARCHAR(15) 'n:E08_11_0/n:E08_11'
--	,[IncidentCity] VARCHAR(15) 'n:E08_11_0/n:E08_12'
--	,[IncidentCounty] VARCHAR(2) 'n:E08_13'
--	,[IncidentState] VARCHAR(1) 'n:E08_11_0/n:E08_14'
--	,[IncidentZipCode] VARCHAR(5) 'n:E08_11_0/n:E08_15'
--	);

----PCRSituationOtherSymptoms
----PCRSituation
----PCRSituationPriorAidPerformedBy
----PCRSituationPriorAid
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E09', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[PriorAid] VARCHAR(15) 'n:E09_01'
--	,[PriorAidPerformedBy] INT 'n:E09_02'
--	,[PriorAidOutcome] INT 'n:E09_03'
--	,[PossibleInjury] INT 'n:E09_04'
--	,[ChiefComplaint] VARCHAR(25) 'n:E09_05'
--	,[DurationChiefComplaint] INT 'n:E09_06_0/n:E09_06'
--	,[TimeChiefComplaintUnitsDuration] INT 'n:E09_06_0/n:E09_07'
--	,[SecondaryComplaintNarrative] VARCHAR(25) 'n:E09_08'
--	,[DurationSecondaryComplaint] INT 'n:E09_09_0/n:E09_09'
--	,[TimeUnitsDurationSecondaryComplaint] INT 'n:E09_09_0/n:E09_10'
--	,[ChiefComplaintAnatomicLocation] INT 'n:E09_11'
--	,[ChiefComplaintOrganSystem] INT 'n:E09_12'
--	,[PrimarySymptom] INT 'n:E09_13'
--	,[OtherAssociatedSymptom] INT 'n:E09_14'
--	,[ProvidersPrimaryImpression] INT 'n:E09_15'
--	,[ProvidersSecondaryImpression] INT 'n:E09_16'
--	);

----PCRTrauma
----PCRTraumaInjuryMechanism
----PCRTraumaRiskFactorPredictors
----PCRTraumaVehicleImpactLocation
----PCRTraumaOccupantSafetyEquipment
----PCRTraumaAirbagDeployment
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E10', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[InjuryCause] INT 'n:E10_01'
--	,[InjuryIntent] INT 'n:E10_02'
--	,[InjuryMechanism] VARCHAR(127) 'n:E10_03'
--	,[VehicularInjuryIndicator] INT 'n:E10_04'
--	,[AreaVehicleImpacted] INT 'n:E10_05'
--	,[SeatRowLocation] INT 'n:E10_06_0/n:E10_06'
--	,[PatientSeatPosition] INT 'n:E10_06_0/n:E10_07'
--	,[OccupantSafetyEquipment] INT 'n:E10_08'
--	,[AirbagDeployment] INT 'n:E10_09'
--	,[FallHeight] INT 'n:E10_10'
--	);

----PCRCPR
----PCRCPRIndicationAttemptResuscitate
----PCRCPRCardiacRhythmDelivery
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E11', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[CardiacArrest] INT 'n:E11_01'
--	,[CardiacArrestEtiology] INT 'n:E11_02'
--	,[ResuscitationAttempted] VARCHAR(127) 'n:E11_03'
--	,[ArrestWitnessedBy] INT 'n:E11_04'
--	,[FirstMonitoredRhythm] INT 'n:E11_05'
--	,[AnyReturnSpontaneousCirculation] INT 'n:E11_06'
--	,[NeurologicalOutcome] INT 'n:E11_07'
--	,[EstimatedTimeArrestPriorEMSArrival] INT 'n:E11_08'
--	,[DateTimeResuscitationDiscontinued] DATETIME 'n:E11_09'
--	,[ReasonCPRDiscontinued] INT 'n:E11_10'
--	,[CardiacRhythmDestination] VARCHAR(127) 'n:E11_11'
--	);

---- PCRMedicalHistoryPatientBarriers
---- PCRMedicalHistory
---- PCRMedicalHistoryLivingWill
---- PCRMedicalHistoryMedicationAllergies
---- PCRMedicalHistoryAllergies
---- MedicalHistoryPreexistingMedicalSurgery
---- PCRMedicalHistoryImmunizationDetails
---- PCRMedicalHistoryCurrentMedication
---- PCRMedicalHistoryAlcoholDrugIndicators
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E12', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[BarriersPatientCare] INT 'n:E12_01'
--	,[SendingFacilityMRNumber] VARCHAR(15) 'n:E12_02'
--	,[DestinationMRNumber] VARCHAR(15) 'n:E12_03'
--	,[PrimaryPractitionerFirstName] VARCHAR(10) 'n:E12_4_0/n:E12_04'
--	,[PrimaryPractitionerMiddleName] VARCHAR(10) 'n:E12_4_0/n:E12_05'
--	,[PrimaryPractitionerLastName] VARCHAR(10) 'n:E12_4_0/n:E12_06'
--	,[AdvancedDirective] INT 'n:E12_07'
--	,[MedicationAllergy] VARCHAR(15) 'n:E12_08'
--	,[EnvironmentalFoodAllergy] INT 'n:E12_09'
--	,[MedicalSurgicalHistory] VARCHAR(15) 'n:E12_10'
--	,[MedicalHistoryObtainedFrom] INT 'n:E12_11'
--	,[ImmunizationHistory] INT 'n:E12_12_0/n:E12_12'
--	,[ImmunizationDate] INT 'n:E12_12_0/n:E12_13'
--	,[CurrentMedication] VARCHAR(15) 'n:E12_14_0/n:E12_14'
--	,[CurrentMedicationDose] DECIMAL 'n:E12_14_0/n:E12_15_0/n:E12_15'
--	,[CurrentMedicationDosageUnit] INT 'n:E12_14_0/n:E12_15_0/n:E12_16'
--	,[CurrentMedicationAdministrationRoute] INT 'n:E12_14_0/n:E12_17'
--	,[PresenceEmergencyInformationForm] INT 'n:E12_18'
--	,[AlcoholDrugUseIndicator] INT 'n:E12_19'
--	,[Pregnancy] INT 'n:E12_20'
--	);

---- PCRNarrative
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E13', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[RunReportNarrative] VARCHAR(2000) 'n:E13_01'
--	);

---- PCRVitalSignsAssessment
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E14', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[DateTimeVitalSignsTaken] DATETIME 'n:E14_01'
--	,[ObtainedPriorUnitsEMSCare] INT 'n:E14_02'
--	,[CardiacRhythm] VARCHAR(127) 'n:E14_03'
--	,[SystolicBloodPressure] INT 'n:E14_04_0/n:E14_04'
--	,[DiastolicBloodPressure] INT 'n:E14_04_0/n:E14_05'
--	,[MethodBloodPressureMeasurement] INT 'n:E14_04_0/n:E14_06'
--	,[PulseRate] INT 'n:E14_07'
--	,[ElectronicMonitorRate] INT 'n:E14_08'
--	,[PulseOximetry] INT 'n:E14_09'
--	,[PulseRhythm] INT 'n:E14_10'
--	,[RespiratoryRate] INT 'n:E14_11'
--	,[RespiratoryEffort] INT 'n:E14_12'
--	,[CarbonDioxide] INT 'n:E14_13'
--	,[BloodGlucoseLevel] INT 'n:E14_14'
--	,[GlasgowComaScoreEye] INT 'n:E14_15_0/n:E14_15'
--	,[GlasgowComaScoreVerbal] INT 'n:E14_15_0/n:E14_16'
--	,[GlasgowComaScoreMotor] INT 'n:E14_15_0/n:E14_17'
--	,[GlasgowComaScoreQualifier] INT 'n:E14_15_0/n:E14_18'
--	,[TotalGlasgowComaScore] INT 'n:E14_19'
--	,[Temperature] FLOAT 'n:E14_20_0/n:E14_20'
--	,[TemperatureMethod] INT 'n:E14_20_0/n:E14_21'
--	,[LevelOfResponsiveness] INT 'n:E14_22'
--	,[PainScale] INT 'n:E14_23'
--	,[StrokeScale] INT 'n:E14_24'
--	,[ThrombolyticScreen] INT 'n:E14_25'
--	,[APGAR] INT 'n:E14_26'
--	,[RevisedTraumaScore] INT 'n:E14_27'
--	,[PediatricTraumaScore] INT 'n:E14_28'
--	);

----PCRAssessmentExam
----PCRAssessmentExamsDifferent
-- Mappings:
--E16_01	Estimated Body Weight
--E16_02	Broselow/Luten Color
--E16_03	Date/Time of Assessment
--E16_04	Skin Assessment
--E16_05	Head/Face Assessment
--E16_06	Neck Assessment
--E16_07	Chest/Lungs Assessment
--E16_08	Heart Assessment
--E16_09	Abdomen Left Upper Assessment
--E16_10	Abdomen Left Lower Assessment
--E16_11	Abdomen Right Upper Assessment
--E16_12	Abdomen Right Lower Assessment
--E16_13	GU Assessment
--E16_14	Back Cervical Assessment
--E16_15	Back Thoracic Assessment
--E16_16	Back Lumbar/Sacral Assessment
--E16_17	Extremities-Right Upper Assessment
--E16_18	Extremities-Right Lower Assessment
--E16_19	Extremities-Left Upper Assessment
--E16_20	Extremities-Left Lower Assessment
--E16_21	Eyes-Left Assessment
--E16_22	Eyes-Right Assessment
--E16_23	Mental Status Assessment
--E16_24	Neurological Assessment

--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E16', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[EstimatedBodyWeight] DECIMAL 'n:E16_01'
--	,[BroselowLutenColor] INT 'n:E16_02'
--	,[AssessmentDateTime] DATETIME 'n:E16_00_0/n:E16_03'
--	,[SkinAssessment] INT 'n:E16_00_0/n:E16_04'
--	,[HeadFaceAssessment] INT 'n:E16_00_0/n:E16_05'
--	,[NeckAssessment] INT 'n:E16_00_0/n:E16_06'
--	,[ChestLungsAssessment] INT 'n:E16_00_0/n:E16_07'
--	,[HeartAssessment] INT 'n:E16_00_0/n:E16_08'
--	,[AbdomenLeftUpperAssessment] INT 'n:E16_00_0/n:E16_09'
--	,[AbdomenLeftLowerAssessment] INT 'n:E16_00_0/n:E16_10'
--	,[AbdomenRightUpperAssessment] INT 'n:E16_00_0/n:E16_11'
--	,[AbdomenRightLowerAssessment] INT 'n:E16_00_0/n:E16_12'
--	,[GUAssessment] INT 'n:E16_00_0/n:E16_13'
--	,[BackCervicalAssessment] INT 'n:E16_00_0/n:E16_14'
--	,[BackThoracicAssessment] INT 'n:E16_00_0/n:E16_15'
--	,[BackLumbarSacralAssessment] INT 'n:E16_00_0/n:E16_16'
--	,[ExtremitiesRightUpperAssessment] INT 'n:E16_00_0/n:E16_17'
--	,[ExtremitiesRightLowerAssessment] INT 'n:E16_00_0/n:E16_18'
--	,[ExtremitiesLeftUpperAssessment] INT 'n:E16_00_0/n:E16_19'
--	,[ExtremitiesLeftLowerAssessment] INT 'n:E16_00_0/n:E16_20'
--	,[EyesLeftAssessment] INT 'n:E16_00_0/n:E16_23'
--	,[EyesRightAssessment] INT 'n:E16_00_0/n:E16_23'
--	,[MentalStatusAssessment] INT 'n:E16_00_0/n:E16_23'
--	,[NeurologicalAssessment] INT 'n:E16_00_0/n:E16_24'
--	);

---- PCRIntervention
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E17', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[ProtocolUsed] VARCHAR(50) 'n:E17_01'
--	);

---- PCRInterventionMedications
---- PCRInterventionMedicationComplications
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E18', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[AdministeredDateTime] DATETIME 'n:E18_01'
--	,[AdministeredPriorUnitsEMSCare] INT 'n:E18_02'
--	,[MedicationGiven] VARCHAR(15) 'n:E18_03'
--	,[AdministeredRoute] INT 'n:E18_04'
--	,[Dosage] DECIMAL 'n:E18_05_0/n:E18_05'
--	,[DosageUnits] INT 'n:E18_05_0/n:E18_06'
--	,[Response] INT 'n:E18_07'
--	,[MedicationComplication] INT 'n:E18_08'
--	,[CrewMemberId] VARCHAR(7) 'n:E18_09'
--	,[Authorization] INT 'n:E18_10'
--	,[AuthorizingPhysician] VARCHAR(10) 'n:E18_11'
--	);

---- PCRInterventionProceduresPerformed
---- PCRInterventionProceduresPerformedComplications
---- PCRInterventionProceduresPerformedSuccessfulIVSite
---- PCRInterventionProceduresPerformedTubeConfirmation
---- PCRInterventionProceduresPerformedTubePlacement
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E19', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[PerformedSuccessfullyDateTime] DATETIME 'n:E19_01_0/n:E19_01'
--	,[PerformedPriorToUnitsEMSCare] INT 'n:E19_01_0/n:E19_02'
--	,[Procedure] VARCHAR(127) 'n:E19_01_0/n:E19_03'
--	,[EquipmentSize] VARCHAR(10) 'n:E19_01_0/n:E19_04'
--	,[NumberOfAttempts] VARCHAR(127) 'n:E19_01_0/n:E19_05'
--	,[ProcedureSuccessful] INT 'n:E19_01_0/n:E19_06'
--	,[ProcedureComplication] INT 'n:E19_01_0/n:E19_07'
--	,[Response] INT 'n:E19_01_0/n:E19_08'
--	,[CrewMembersId] VARCHAR(7) 'n:E19_01_0/n:E19_09'
--	,[Authorization] INT 'n:E19_01_0/n:E19_10'
--	,[AuthorizingPhysician] VARCHAR(10) 'n:E19_01_0/n:E19_11'
--	,[SuccessfulIVSite] INT 'n:E19_12'
--	,[TubeConfirmation] INT 'n:E19_13'
--	,[TubePlacement] INT 'n:E19_14'
--	);

---- PCRDisposition
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E20', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[DestinationTransferredToName] VARCHAR(25) 'n:E20_01'
--	,[DestinationTransferredToCode] VARCHAR(25) 'n:E20_02'
--	,[DestinationStreetAddress] VARCHAR(15) 'n:E20_03_0/n:E20_03'
--	,[DestinationCity] VARCHAR(15) 'n:E20_03_0/n:E20_04'
--	,[DestinationState] VARCHAR(1) 'n:E20_03_0/n:E20_05'
--	,[DestinationCounty] VARCHAR(2) 'n:E20_06'
--	,[DestinationZipCode] VARCHAR(5) 'n:E20_03_0/n:E20_07'
--	,[DestinationGPSLocationLatitude] DECIMAL 'n:E20_08'
--	,[DestinationGPSLocationLongitude] DECIMAL 'n:E20_08'
--	,[DestinationZoneNumber] VARCHAR(15) 'n:E20_09'
--	,[IncidentPatientDisposition] INT 'n:E20_10'
--	,[HowPatientMovedToAmbulance] INT 'n:E20_11'
--	,[PatientPositionDuringTransport] INT 'n:E20_12'
--	,[HowPatientTransportedFromAmbulance] INT 'n:E20_13'
--	,[TransportMode] INT 'n:E20_14'
--	,[DestinationPatientCondition] INT 'n:E20_15'
--	,[DestinationReason] INT 'n:E20_16'
--	,[DestinationType] INT 'n:E20_17'
--	);

---- PCRMedicalDeviceData
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E21', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[EventDateTime] DATETIME 'n:E21_01'
--	,[MedicalDeviceEventName] INT 'n:E21_02'
--	,[WaveformGraphicType] INT 'n:E21_03_0/n:E21_03'
--	,[WaveformGraphic] IMAGE 'n:E21_03_0/n:E21_04'
--	,[AEDPacingCO2Mode] INT 'n:E21_05'
--	,[ECGLead] INT 'n:E21_06'
--	,[ECGInterpretation] VARCHAR(1000) 'n:E21_07'
--	,[ShockType] INT 'n:E21_08'
--	,[ShockPacingEnergy] DECIMAL 'n:E21_09'
--	,[TotalNumberShocksDelivered] INT 'n:E21_10'
--	,[PacingRate] INT 'n:E21_11'
--	,[HeartRate] INT 'n:E21_12'
--	,[PulseRate] INT 'n:E21_13'
--	,[SystolicBloodPressure] INT 'n:E21_14'
--	,[DiastolicBloodPressure] INT 'n:E21_15'
--	,[RespiratoryRate] INT 'n:E21_16'
--	,[PulseOximetry] INT 'n:E21_17'
--	,[CO2etCO2] INT 'n:E21_18_0/n:E21_18'
--	,[CO2etCO2InvasivePressureMonitorUnits] INT 'n:E21_18_0/n:E21_19'
--	,[InvasivePressureMean] INT 'n:E21_20'
--	);

---- PCROutcomeLinkage
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E22', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[EmergencyDepartmentDisposition] INT 'n:E22_01'
--	,[HospitalDisposition] INT 'n:E22_02'
--	,[LawEnforcementReportNumber] VARCHAR(10) 'n:E22_03'
--	,[TraumaRegistryId] VARCHAR(10) 'n:E22_04'
--	,[FireIncidentReportNumber] VARCHAR(10) 'n:E22_05'
--	,[PatientIdBandTagNumber] VARCHAR(10) 'n:E22_06'
--	);

---- PCRMiscellaneous
---- PCRMiscellaneousPatientIndicationCriteriaRegistry
---- PCRMiscellaneousProtectiveEquipmentUsed
---- PCRMiscellaneousSuspicionMultiCasualtyDomesticTerrorism
---- PCRMiscellaneousTypeExposureBodilyFluids
---- PCRMiscellaneousPersonnelExposedFluids
---- PCRMiscellaneousLocalAgencyResearchField
--SELECT
--	*
--FROM
--	OPENXML(@XmlDocumentHandle, 'n:EMSDataSet/n:Header/n:Record/n:E23', 2) WITH (
--	[PatientCareReportNumber] VARCHAR(30) '../n:E01/n:E01_01'
--	,[ReviewRequested] INT 'n:E23_01'
--	,[SuspectedContactBodyFluidsEMSInjuryDeath] INT 'n:E23_05'
--	,[TypeSuspectedFluidExposure] INT 'n:E23_06'
--	,[RequiredReportableCondition] INT 'n:E23_08'
--	,[ResearchSurveyField] VARCHAR(25) 'n:E23_09_0/n:E23_09'
--	,[ReportGeneratedBy] VARCHAR(15) 'n:E23_10'
--	,[ResearchSurveyFieldTitle] VARCHAR(15) 'n:E23_09_0/n:E23_11'
--	);

