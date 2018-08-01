using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CD.ClaimSoft.Database.Model.Claim
{
    public class PatientCareReport
    {
        ///<summary>
        /// Id (Primary key)
        ///</summary>
        public int Id { get; set; }

        ///<summary>
        /// NEMSIS V2 - D01 - Agency General Information
        ///</summary>
        public int AgencyId { get; set; }

        ///<summary>
        /// NEMSIS V2 - E01_01 Element - Patient Care Report Number (length: 30)
        ///</summary>
        public string PatientCareReportNumber { get; set; }

        ///<summary>
        /// NEMSIS V2 - E01_02 Element - Software Creator (length: 30)
        ///</summary>
        public string SoftwareCreator { get; set; }

        ///<summary>
        /// NEMSIS V2 - E01_03 Element - Software Name (length: 30)
        ///</summary>
        public string SoftwareName { get; set; }

        ///<summary>
        /// NEMSIS V2 - E01_04 Element - Software Version (length: 30)
        ///</summary>
        public string SoftwareVersion { get; set; }

        ///<summary>
        /// Import Record Id (length: 50)
        ///</summary>
        public string FileImportRecordId { get; set; }

        ///<summary>
        /// Create By (length: 128)
        ///</summary>
        public string CreateBy { get; set; }

        public DateTime CreateDate { get; set; }

        ///<summary>
        /// Last Modify By (length: 128)
        ///</summary>
		public string LastModifyBy { get; set; }

        public DateTime LastModifyDate { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRAssessmentExam].[PatientCareReportId] (FK_PCRAssessmentExam_PatientCareReport)
        /// </summary>
        public PcrAssessmentExam PcrAssessmentExam { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRBilling].[PatientCareReportId] (FK_PCRBilling_PatientCareReport)
        /// </summary>
        public PcrBilling PcrBilling { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRCPR].[PatientCareReportId] (FK_PCRCPR_PatientCareReport)
        /// </summary>
        public PcrCpr Pcrcpr { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRDisposition].[PatientCareReportId] (FK_PCRDisposition_PatientCareReport)
        /// </summary>
        public PcrDisposition PcrDisposition { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRMedicalHistory].[PatientCareReportId] (FK_PCRMedicalHistory_PatientCareReport)
        /// </summary>
        public PcrMedicalHistory PcrMedicalHistory { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRMiscellaneous].[PatientCareReportId] (FK_PCRMiscellaneous_PatientCareReport)
        /// </summary>
        public PcrMiscellaneous PcrMiscellaneous { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRNarrative].[PatientCareReportId] (FK_PCRNarrative_PatientCareReport)
        /// </summary>
        public PcrNarrative PcrNarrative { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCROutcomeLinkage].[PatientCareReportId] (FK_PCROutcomeLinkage_PatientCareReport)
        /// </summary>
        public PcrOutcomeLinkage PcrOutcomeLinkage { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRPatient].[PatientCareReportId] (FK_PCRPatient_PatientCareReport)
        /// </summary>
        public PcrPatient PcrPatient { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRScene].[PatientCareReportId] (FK_PCRScene_PatientCareReport)
        /// </summary>
        public PcrScene PcrScene { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRSituation].[PatientCareReportId] (FK_PCRSituation_PatientCareReport)
        /// </summary>
        public PcrSituation PcrSituation { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRTimes].[PatientCareReportId] (FK_PCRTimes_PatientCareReport)
        /// </summary>
        public PcrTime PcrTime { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRTrauma].[PatientCareReportId] (FK_PCRTrauma_PatientCareReport)
        /// </summary>
        public PcrTrauma PcrTrauma { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRUnitAgency].[PatientCareReportId] (FK_PCRUnitAgency_PatientCareReport)
        /// </summary>
        public PcrUnitAgency PcrUnitAgency { get; set; }

        /// <summary>
        /// Parent (One-to-One) PatientCareReport pointed by [PCRUnitCall].[PatientCareReportId] (FK_PCRUnitCall_PatientCareReport)
        /// </summary>
        public PcrUnitCall PcrUnitCall { get; set; }

        /// <summary>
        /// Child PcrAssessmentExamsDifferents where [PCRAssessmentExamsDifferent].[PatientCareReportId] point to this  (FK_PCRAssessmentExamsDifferent_PatientCareReport)
        /// </summary>
        public ICollection<PcrAssessmentExamsDifferent> PcrAssessmentExamsDifferents { get; set; }

        /// <summary>
        /// Child PcrAssessmentInjuries where [PCRAssessmentInjury].[PatientCareReportId] point to this  (FK_PCRAssessmentInjury_PatientCareReport)
        /// </summary>
        public ICollection<PcrAssessmentInjury> PcrAssessmentInjuries { get; set; }

        /// <summary>
        /// Child PcrBillingConditionCodes where [PCRBillingConditionCodes].[PatientCareReportId] point to this  (FK_PCRBillingConditionCodes_PatientCareReport)
        /// </summary>
        public ICollection<PcrBillingConditionCode> PcrBillingConditionCodes { get; set; }

        /// <summary>
        /// Child PcrBillingConditionCodesModifiers where [PCRBillingConditionCodesModifier].[PatientCareReportId] point to this  (FK_PCRBillingConditionCodesModifier_PatientCareReport)
        /// </summary>
        public ICollection<PcrBillingConditionCodesModifier> PcrBillingConditionCodesModifiers { get; set; }

        /// <summary>
        /// Child PcrBillingInsurances where [PCRBillingInsurance].[PatientCareReportId] point to this  (FK_PCRBillingInsurance_PatientCareReport1)
        /// </summary>
        public ICollection<PcrBillingInsurance> PcrBillingInsurances { get; set; }

        /// <summary>
        /// Child PcrcprCardiacRhythmDeliveries where [PCRCPRCardiacRhythmDelivery].[PatientCareReportId] point to this  (FK_PCRCPRCardiacRhythmDelivery_PatientCareReport)
        /// </summary>
        public ICollection<PcrCprCardiacRhythmDelivery> PcrCprCardiacRhythmDeliveries { get; set; }

        /// <summary>
        /// Child PcrcprIndicationAttemptResuscitates where [PCRCPRIndicationAttemptResuscitate].[PatientCareReportId] point to this  (FK_PCRCPRIndicationAttemptResuscitate_PatientCareReport)
        /// </summary>
        public ICollection<PcrCprIndicationAttemptResuscitate> PcrCprIndicationAttemptResuscitates { get; set; }

        /// <summary>
        /// Child PcrInterventions where [PCRIntervention].[PatientCareReportId] point to this  (FK_PCRIntervention_PatientCareReport)
        /// </summary>
        public ICollection<PcrIntervention> PcrInterventions { get; set; }

        /// <summary>
        /// Child PcrInterventionMedications where [PCRInterventionMedications].[PatientCareReportId] point to this  (FK_PCRInterventionMedications_PatientCareReport)
        /// </summary>
        public ICollection<PcrInterventionMedication> PcrInterventionMedications { get; set; }

        /// <summary>
        /// Child PcrInterventionProceduresPerformeds where [PCRInterventionProceduresPerformed].[PatientCareReportId] point to this  (FK_PCRInterventionProceduresPerformed_PatientCareReport)
        /// </summary>
        public ICollection<PcrInterventionProceduresPerformed> PcrInterventionProceduresPerformeds { get; set; }

        /// <summary>
        /// Child PcrInterventionProceduresPerformedSuccessfulIvSites where [PCRInterventionProceduresPerformedSuccessfulIVSite].[PatientCareReportId] point to this  (FK_PCRInterventionProceduresPerformedSuccessfulIVSite_PatientCareReport)
        /// </summary>
        public ICollection<PcrInterventionProceduresPerformedSuccessfulIvSite> PcrInterventionProceduresPerformedSuccessfulIvSites { get; set; }

        /// <summary>
        /// Child PcrInterventionProceduresPerformedTubeConfirmations where [PCRInterventionProceduresPerformedTubeConfirmation].[PatientCareReportId] point to this  (FK_PCRInterventionProceduresPerformedTubeConfirmation_PatientCareReport)
        /// </summary>
        public ICollection<PcrInterventionProceduresPerformedTubeConfirmation> PcrInterventionProceduresPerformedTubeConfirmations { get; set; }

        /// <summary>
        /// Child PcrInterventionProceduresPerformedTubePlacements where [PCRInterventionProceduresPerformedTubePlacement].[PatientCareReportId] point to this  (FK_PCRInterventionProceduresPerformedTubePlacement_PatientCareReport)
        /// </summary>
        public ICollection<PcrInterventionProceduresPerformedTubePlacement> PcrInterventionProceduresPerformedTubePlacements { get; set; }

        /// <summary>
        /// Child PcrMedicalDeviceDatas where [PCRMedicalDeviceData].[PatientCareReportId] point to this  (FK_PCRMedicalDeviceData_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalDeviceData> PcrMedicalDeviceDatas { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryAlcoholDrugIndicators where [PCRMedicalHistoryAlcoholDrugIndicators].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryAlcoholDrugIndicators_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryAlcoholDrugIndicator> PcrMedicalHistoryAlcoholDrugIndicators { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryAllergies where [PCRMedicalHistoryAllergies].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryAllergies_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryAllergy> PcrMedicalHistoryAllergies { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryCurrentMedications where [PCRMedicalHistoryCurrentMedication].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryCurrentMedication_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryCurrentMedication> PcrMedicalHistoryCurrentMedications { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryImmunizationDetails where [PCRMedicalHistoryImmunizationDetails].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryImmunizationDetails_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryImmunizationDetail> PcrMedicalHistoryImmunizationDetails { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryLivingWills where [PCRMedicalHistoryLivingWill].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryLivingWill_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryLivingWill> PcrMedicalHistoryLivingWills { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryMedicationAllergies where [PCRMedicalHistoryMedicationAllergies].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryMedicationAllergies_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryMedicationAllergy> PcrMedicalHistoryMedicationAllergies { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryPatientBarriers where [PCRMedicalHistoryPatientBarriers].[PatientCareReportId] point to this  (FK_PCRMedicalHistoryPatientBarriers_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryPatientBarrier> PcrMedicalHistoryPatientBarriers { get; set; }

        /// <summary>
        /// Child PcrMedicalHistoryPreexistingMedicalSurgeries where [PCRMedicalHistoryPreexistingMedicalSurgery].[PatientCareReportId] point to this  (FK_MedicalHistoryPreexistingMedicalSurgery_PatientCareReport)
        /// </summary>
        public ICollection<PcrMedicalHistoryPreexistingMedicalSurgery> PcrMedicalHistoryPreexistingMedicalSurgeries { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousLocalAgencyResearchFields where [PCRMiscellaneousLocalAgencyResearchField].[PatientCareReportId] point to this  (FK_PCRMiscellaneousLocalAgencyResearchField_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousLocalAgencyResearchField> PcrMiscellaneousLocalAgencyResearchFields { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousPatientIndicationCriteriaRegistries where [PCRMiscellaneousPatientIndicationCriteriaRegistry].[PatientCareReportId] point to this  (FK_PCRMiscellaneousPatientIndicationCriteriaRegistry_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousPatientIndicationCriteriaRegistry> PcrMiscellaneousPatientIndicationCriteriaRegistries { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousPersonnelExposedFluids where [PCRMiscellaneousPersonnelExposedFluids].[PatientCareReportId] point to this  (FK_PCRMiscellaneousPersonnelExposedFluids_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousPersonnelExposedFluid> PcrMiscellaneousPersonnelExposedFluids { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousProtectiveEquipmentUseds where [PCRMiscellaneousProtectiveEquipmentUsed].[PatientCareReportId] point to this  (FK_PCRMiscellaneousProtectiveEquipmentUsed_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousProtectiveEquipmentUsed> PcrMiscellaneousProtectiveEquipmentUseds { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousSuspicionMultiCasualtyDomesticTerrorism where [PCRMiscellaneousSuspicionMultiCasualtyDomesticTerrorism].[PatientCareReportId] point to this  (FK_PCRMiscellaneousSuspicionMultiCasualtyDomesticTerrorism_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousSuspicionMultiCasualtyDomesticTerrorism> PcrMiscellaneousSuspicionMultiCasualtyDomesticTerrorism { get; set; }

        /// <summary>
        /// Child PcrMiscellaneousTypeExposureBodilyFluids where [PCRMiscellaneousTypeExposureBodilyFluids].[PatientCareReportId] point to this  (FK_PCRMiscellaneousTypeExposureBodilyFluids_PatientCareReport)
        /// </summary>
        public ICollection<PcrMiscellaneousTypeExposureBodilyFluid> PcrMiscellaneousTypeExposureBodilyFluids { get; set; }

        /// <summary>
        /// Child PcrSceneOtherEmsAgencies where [PCRSceneOtherEMSAgencies].[PatientCareReportId] point to this  (FK_PCRSceneOtherEMSAgencies_PatientCareReport)
        /// </summary>
        public ICollection<PcrSceneOtherEmsAgency> PcrSceneOtherEmsAgencies_PatientCareReportId { get; set; }

        /// <summary>
        /// Child PcrSceneOtherEmsAgencies where [PCRSceneOtherEMSAgencies].[PatientCareReportId] point to this  (FK_PCRSceneOtherEMSAgencies_PatientCareReport1)
        /// </summary>
        public ICollection<PcrSceneOtherEmsAgency> PcrSceneOtherEmsAgencies1 { get; set; }

        /// <summary>
        /// Child PcrSceneOtherServices where [PCRSceneOtherServices].[PatientCareReportId] point to this  (FK_PCRSceneOtherServices_PatientCareReport)
        /// </summary>
        public ICollection<PcrSceneOtherService> PcrSceneOtherServices { get; set; }

        /// <summary>
        /// Child PcrSituationOtherSymptoms where [PCRSituationOtherSymptoms].[PatientCareReportId] point to this  (FK_PCRSituationOtherSymptoms_PatientCareReport)
        /// </summary>
        public ICollection<PcrSituationOtherSymptom> PcrSituationOtherSymptoms { get; set; }

        /// <summary>
        /// Child PcrSituationPriorAids where [PCRSituationPriorAid].[PatientCareReportId] point to this  (FK_PCRSituationPriorAid_PatientCareReport)
        /// </summary>
        public ICollection<PcrSituationPriorAid> PcrSituationPriorAids { get; set; }

        /// <summary>
        /// Child PcrSituationPriorAidPerformedBies where [PCRSituationPriorAidPerformedBy].[PatientCareReportId] point to this  (FK_PCRSituationPriorAidPerformedBy_PatientCareReport)
        /// </summary>
        public ICollection<PcrSituationPriorAidPerformedBy> PcrSituationPriorAidPerformedBies { get; set; }

        /// <summary>
        /// Child PcrTraumaAirbagDeployments where [PCRTraumaAirbagDeployment].[PatientCareReportId] point to this  (FK_PCRTraumaAirbagDeployment_PatientCareReport)
        /// </summary>
        public ICollection<PcrTraumaAirbagDeployment> PcrTraumaAirbagDeployments { get; set; }

        /// <summary>
        /// Child PcrTraumaInjuryMechanism where [PCRTraumaInjuryMechanism].[PatientCareReportId] point to this  (FK_PCRTraumaInjuryMechanism_PatientCareReport)
        /// </summary>
        public ICollection<PcrTraumaInjuryMechanism> PcrTraumaInjuryMechanism { get; set; }

        /// <summary>
        /// Child PcrTraumaOccupantSafetyEquipments where [PCRTraumaOccupantSafetyEquipment].[PatientCareReportId] point to this  (FK_PCRTraumaOccupantSafetyEquipment_PatientCareReport)
        /// </summary>
        public ICollection<PcrTraumaOccupantSafetyEquipment> PcrTraumaOccupantSafetyEquipments { get; set; }

        /// <summary>
        /// Child PcrTraumaRiskFactorPredictors where [PCRTraumaRiskFactorPredictors].[PatientCareReportId] point to this  (FK_PCRTraumaRiskFactorPredictors_PatientCareReport)
        /// </summary>
        public ICollection<PcrTraumaRiskFactorPredictor> PcrTraumaRiskFactorPredictors { get; set; }

        /// <summary>
        /// Child PcrTraumaVehicleImpactLocations where [PCRTraumaVehicleImpactLocation].[PatientCareReportId] point to this  (FK_PCRTraumaVehicleImpactLocation_PatientCareReport)
        /// </summary>
        public ICollection<PcrTraumaVehicleImpactLocation> PcrTraumaVehicleImpactLocations { get; set; }

        /// <summary>
        /// Child PcrUnitAgencyDispatchDelays where [PCRUnitAgencyDispatchDelays].[PatientCareReportId] point to this  (FK_PCRUnitAgencyDispatchDelays_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitAgencyDispatchDelay> PcrUnitAgencyDispatchDelays { get; set; }

        /// <summary>
        /// Child PcrUnitAgencyResponseDelays where [PCRUnitAgencyResponseDelays].[PatientCareReportId] point to this  (FK_PCRUnitAgencyResponseDelays_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitAgencyResponseDelay> PcrUnitAgencyResponseDelays { get; set; }

        /// <summary>
        /// Child PcrUnitAgencySceneDelays where [PCRUnitAgencySceneDelays].[PatientCareReportId] point to this  (FK_PCRUnitAgencySceneDelays_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitAgencySceneDelay> PcrUnitAgencySceneDelays { get; set; }

        /// <summary>
        /// Child PcrUnitAgencyTransportDelays where [PCRUnitAgencyTransportDelays].[PatientCareReportId] point to this  (FK_PCRUnitAgencyTransportDelays_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitAgencyTransportDelay> PcrUnitAgencyTransportDelays { get; set; }

        /// <summary>
        /// Child PcrUnitAgencyTurnAroundDelays where [PCRUnitAgencyTurnAroundDelays].[PatientCareReportId] point to this  (FK_PCRUnitAgencyTurnAroundDelays_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitAgencyTurnAroundDelay> PcrUnitAgencyTurnAroundDelays { get; set; }

        /// <summary>
        /// Child PcrUnitPersonnels where [PCRUnitPersonnel].[PatientCareReportId] point to this  (FK_PCRUnitPersonnel_PatientCareReport)
        /// </summary>
        public ICollection<PcrUnitPersonnel> PcrUnitPersonnels { get; set; }

        /// <summary>
        /// Child PcrVitalSignsAssessments where [PCRVitalSignsAssessment].[PatientCareReportId] point to this  (FK_PCRVitalSignsAssessment_PatientCareReport)
        /// </summary>
        public ICollection<PcrVitalSignsAssessment> PcrVitalSignsAssessments { get; set; }

        /// <summary>
        /// Child PcrVitalSignsAssessmentInitialCardiacRhythms where [PCRVitalSignsAssessmentInitialCardiacRhythm].[PatientCareReportId] point to this  (FK_PCRVitalSignsAssessmentInitialCardiacRhythm_PatientCareReport)
        /// </summary>
        public ICollection<PcrVitalSignsAssessmentInitialCardiacRhythm> PcrVitalSignsAssessmentInitialCardiacRhythms { get; set; }

        /// <summary>
        /// Parent Agency pointed by [PatientCareReport].([AgencyId]) (FK_PatientCareReport_Agency)
        /// </summary>
        public Agency.Agency Agency { get; set; }
    }
}
