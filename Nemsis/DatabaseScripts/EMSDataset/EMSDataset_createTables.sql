CREATE TABLE EMSDataSet ( 
    pk_EMSDataSet    INT PRIMARY KEY
)

CREATE TABLE [Header] ( 
    [pk_Header]    INT PRIMARY KEY,
    [fk_pk_EMSDataSet]    INT FOREIGN KEY REFERENCES     [EMSDataSet]([pk_EMSDataSet])
,    [dAgency.01]    VARCHAR(255)
,    [dAgency.02]    VARCHAR(255)
,    [dAgency.04]    VARCHAR(255)
)

CREATE TABLE [PatientCareReport] ( 
    [pk_PatientCareReport]    INT PRIMARY KEY,
    [fk_pk_Header]    INT FOREIGN KEY REFERENCES     [Header]([pk_Header])
,    [eRecord.01]    VARCHAR(255)
,    [eRecord.02]    VARCHAR(255)
,    [eRecord.03]    VARCHAR(255)
,    [eRecord.04]    VARCHAR(255)
,    [eResponse.01]    VARCHAR(255)
,    [eResponse.02]    VARCHAR(255)
,    [eResponse.02_NV]    VARCHAR(255)
,    [eResponse.03]    VARCHAR(255)
,    [eResponse.03_NV]    VARCHAR(255)
,    [eResponse.04]    VARCHAR(255)
,    [eResponse.04_NV]    VARCHAR(255)
,    [eResponse.05]    VARCHAR(255)
,    [eResponse.06]    VARCHAR(255)
,    [eResponse.07]    VARCHAR(255)
,    [eResponse.13]    VARCHAR(255)
,    [eResponse.14]    VARCHAR(255)
,    [eResponse.15]    VARCHAR(255)
,    [eResponse.16]    VARCHAR(255)
,    [eResponse.17]    VARCHAR(255)
,    [eResponse.18]    VARCHAR(255)
,    [eResponse.19]    VARCHAR(255)
,    [eResponse.20]    VARCHAR(255)
,    [eResponse.21]    VARCHAR(255)
,    [eResponse.22]    VARCHAR(255)
,    [eResponse.23]    VARCHAR(255)
,    [eDispatch.01]    VARCHAR(255)
,    [eDispatch.02]    VARCHAR(255)
,    [eDispatch.02_NV]    VARCHAR(255)
,    [eDispatch.03]    VARCHAR(255)
,    [eDispatch.04]    VARCHAR(255)
,    [eDispatch.05]    VARCHAR(255)
,    [eDispatch.06]    VARCHAR(255)
,    [eTimes.01]    VARCHAR(255)
,    [eTimes.01_NV]    VARCHAR(255)
,    [eTimes.02]    VARCHAR(255)
,    [eTimes.03]    VARCHAR(255)
,    [eTimes.04]    VARCHAR(255)
,    [eTimes.05]    VARCHAR(255)
,    [eTimes.05_NV]    VARCHAR(255)
,    [eTimes.06]    VARCHAR(255)
,    [eTimes.06_NV]    VARCHAR(255)
,    [eTimes.07]    VARCHAR(255)
,    [eTimes.07_NV]    VARCHAR(255)
,    [eTimes.08]    VARCHAR(255)
,    [eTimes.08_NV]    VARCHAR(255)
,    [eTimes.09]    VARCHAR(255)
,    [eTimes.09_NV]    VARCHAR(255)
,    [eTimes.10]    VARCHAR(255)
,    [eTimes.11]    VARCHAR(255)
,    [eTimes.11_NV]    VARCHAR(255)
,    [eTimes.12]    VARCHAR(255)
,    [eTimes.12_NV]    VARCHAR(255)
,    [eTimes.13]    VARCHAR(255)
,    [eTimes.14]    VARCHAR(255)
,    [eTimes.15]    VARCHAR(255)
,    [eTimes.16]    VARCHAR(255)
,    [ePatient.01]    VARCHAR(255)
,    [ePatient.02]    VARCHAR(255)
,    [ePatient.02_NV]    VARCHAR(255)
,    [ePatient.02_PN]    VARCHAR(255)
,    [ePatient.03]    VARCHAR(255)
,    [ePatient.03_NV]    VARCHAR(255)
,    [ePatient.03_PN]    VARCHAR(255)
,    [ePatient.04]    VARCHAR(255)
,    [ePatient.05]    VARCHAR(255)
,    [ePatient.05_StreetAddress2]    VARCHAR(255)
,    [ePatient.06]    VARCHAR(255)
,    [ePatient.07]    VARCHAR(255)
,    [ePatient.07_NV]    VARCHAR(255)
,    [ePatient.08]    VARCHAR(255)
,    [ePatient.08_NV]    VARCHAR(255)
,    [ePatient.09]    VARCHAR(255)
,    [ePatient.09_NV]    VARCHAR(255)
,    [ePatient.10]    VARCHAR(255)
,    [ePatient.11]    VARCHAR(255)
,    [ePatient.12]    VARCHAR(255)
,    [ePatient.13]    VARCHAR(255)
,    [ePatient.13_NV]    VARCHAR(255)
,    [ePatient.15]    VARCHAR(255)
,    [ePatient.15_NV]    VARCHAR(255)
,    [ePatient.16]    VARCHAR(255)
,    [ePatient.16_NV]    VARCHAR(255)
,    [ePatient.17]    VARCHAR(255)
,    [ePatient.17_NV]    VARCHAR(255)
,    [ePatient.17_PN]    VARCHAR(255)
,    [ePatient.20]    VARCHAR(255)
,    [ePatient.21]    VARCHAR(255)
,    [ePayment.01]    VARCHAR(255)
,    [ePayment.01_NV]    VARCHAR(255)
,    [ePayment.02]    VARCHAR(255)
,    [ePayment.03]    VARCHAR(255)
,    [ePayment.05]    VARCHAR(255)
,    [ePayment.06]    VARCHAR(255)
,    [ePayment.07]    VARCHAR(255)
,    [ePayment.08]    VARCHAR(255)
,    [ePayment.23]    VARCHAR(255)
,    [ePayment.24]    VARCHAR(255)
,    [ePayment.25]    VARCHAR(255)
,    [ePayment.26]    VARCHAR(255)
,    [ePayment.26_StreetAddress2]    VARCHAR(255)
,    [ePayment.27]    VARCHAR(255)
,    [ePayment.28]    VARCHAR(255)
,    [ePayment.29]    VARCHAR(255)
,    [ePayment.30]    VARCHAR(255)
,    [ePayment.32]    VARCHAR(255)
,    [ePayment.33]    VARCHAR(255)
,    [ePayment.34]    VARCHAR(255)
,    [ePayment.34_StreetAddress2]    VARCHAR(255)
,    [ePayment.35]    VARCHAR(255)
,    [ePayment.36]    VARCHAR(255)
,    [ePayment.37]    VARCHAR(255)
,    [ePayment.38]    VARCHAR(255)
,    [ePayment.39]    VARCHAR(255)
,    [ePayment.39_PhoneNumberType]    VARCHAR(255)
,    [ePayment.40]    VARCHAR(255)
,    [ePayment.45]    VARCHAR(255)
,    [ePayment.46]    VARCHAR(255)
,    [ePayment.48]    VARCHAR(255)
,    [ePayment.49]    VARCHAR(255)
,    [ePayment.50]    VARCHAR(255)
,    [ePayment.50_NV]    VARCHAR(255)
,    [ePayment.53]    VARCHAR(255)
,    [ePayment.54]    VARCHAR(255)
,    [ePayment.57]    VARCHAR(255)
,    [eScene.01]    VARCHAR(255)
,    [eScene.01_NV]    VARCHAR(255)
,    [eScene.05]    VARCHAR(255)
,    [eScene.06]    VARCHAR(255)
,    [eScene.06_NV]    VARCHAR(255)
,    [eScene.07]    VARCHAR(255)
,    [eScene.07_NV]    VARCHAR(255)
,    [eScene.08]    VARCHAR(255)
,    [eScene.08_NV]    VARCHAR(255)
,    [eScene.09]    VARCHAR(255)
,    [eScene.09_NV]    VARCHAR(255)
,    [eScene.10]    VARCHAR(255)
,    [eScene.10_NV]    VARCHAR(255)
,    [eScene.11]    VARCHAR(255)
,    [eScene.12]    VARCHAR(255)
,    [eScene.13]    VARCHAR(255)
,    [eScene.14]    VARCHAR(255)
,    [eScene.14_NV]    VARCHAR(255)
,    [eScene.15]    VARCHAR(255)
,    [eScene.15_NV]    VARCHAR(255)
,    [eScene.15_StreetAddress2]    VARCHAR(255)
,    [eScene.16]    VARCHAR(255)
,    [eScene.16_NV]    VARCHAR(255)
,    [eScene.17]    VARCHAR(255)
,    [eScene.17_NV]    VARCHAR(255)
,    [eScene.18]    VARCHAR(255)
,    [eScene.18_NV]    VARCHAR(255)
,    [eScene.19]    VARCHAR(255)
,    [eScene.19_NV]    VARCHAR(255)
,    [eScene.20]    VARCHAR(255)
,    [eScene.20_NV]    VARCHAR(255)
,    [eScene.21]    VARCHAR(255)
,    [eScene.21_NV]    VARCHAR(255)
,    [eScene.22]    VARCHAR(255)
,    [eScene.23]    VARCHAR(255)
,    [eSituation.01]    VARCHAR(255)
,    [eSituation.01_NV]    VARCHAR(255)
,    [eSituation.02]    VARCHAR(255)
,    [eSituation.02_NV]    VARCHAR(255)
,    [eSituation.07]    VARCHAR(255)
,    [eSituation.07_NV]    VARCHAR(255)
,    [eSituation.08]    VARCHAR(255)
,    [eSituation.08_NV]    VARCHAR(255)
,    [eSituation.09]    VARCHAR(255)
,    [eSituation.09_NV]    VARCHAR(255)
,    [eSituation.11]    VARCHAR(255)
,    [eSituation.11_NV]    VARCHAR(255)
,    [eSituation.13]    VARCHAR(255)
,    [eSituation.13_NV]    VARCHAR(255)
,    [eSituation.14]    VARCHAR(255)
,    [eSituation.14_NV]    VARCHAR(255)
,    [eSituation.15]    VARCHAR(255)
,    [eSituation.16]    VARCHAR(255)
,    [eSituation.18]    VARCHAR(255)
,    [eInjury.05]    VARCHAR(255)
,    [eInjury.06]    VARCHAR(255)
,    [eInjury.09]    VARCHAR(255)
,    [eInjury.11]    VARCHAR(255)
,    [eInjury.12]    VARCHAR(255)
,    [eInjury.14]    VARCHAR(255)
,    [eInjury.15]    VARCHAR(255)
,    [eInjury.16]    VARCHAR(255)
,    [eInjury.17]    VARCHAR(255)
,    [eInjury.18]    VARCHAR(255)
,    [eInjury.19]    VARCHAR(255)
,    [eInjury.20]    VARCHAR(255)
,    [eInjury.21]    VARCHAR(255)
,    [eInjury.23]    VARCHAR(255)
,    [eInjury.24]    VARCHAR(255)
,    [eInjury.25]    VARCHAR(255)
,    [eArrest.01]    VARCHAR(255)
,    [eArrest.01_NV]    VARCHAR(255)
,    [eArrest.02]    VARCHAR(255)
,    [eArrest.02_NV]    VARCHAR(255)
,    [eArrest.05]    VARCHAR(255)
,    [eArrest.05_NV]    VARCHAR(255)
,    [eArrest.07]    VARCHAR(255)
,    [eArrest.07_NV]    VARCHAR(255)
,    [eArrest.11]    VARCHAR(255)
,    [eArrest.11_NV]    VARCHAR(255)
,    [eArrest.13]    VARCHAR(255)
,    [eArrest.14]    VARCHAR(255)
,    [eArrest.14_NV]    VARCHAR(255)
,    [eArrest.15]    VARCHAR(255)
,    [eArrest.15_NV]    VARCHAR(255)
,    [eArrest.16]    VARCHAR(255)
,    [eArrest.16_NV]    VARCHAR(255)
,    [eArrest.18]    VARCHAR(255)
,    [eArrest.18_NV]    VARCHAR(255)
,    [eArrest.19]    VARCHAR(255)
,    [eHistory.16]    VARCHAR(255)
,    [eHistory.18]    VARCHAR(255)
,    [eHistory.18_PN]    VARCHAR(255)
,    [eHistory.19]    VARCHAR(255)
,    [eNarrative.01]    VARCHAR(255)
,    [eNarrative.01_NV]    VARCHAR(255)
,    [eExam.01]    VARCHAR(255)
,    [eExam.01_NV]    VARCHAR(255)
,    [eExam.01_PN]    VARCHAR(255)
,    [eExam.02]    VARCHAR(255)
,    [eExam.02_NV]    VARCHAR(255)
,    [eExam.02_PN]    VARCHAR(255)
,    [eExam.21]    VARCHAR(255)
,    [eExam.21_PN]    VARCHAR(255)
,    [eExam.21_NV]    VARCHAR(255)
,    [eAirway.10]    VARCHAR(255)
,    [eAirway.11]    VARCHAR(255)
,    [eDisposition.01]    VARCHAR(255)
,    [eDisposition.01_NV]    VARCHAR(255)
,    [eDisposition.02]    VARCHAR(255)
,    [eDisposition.02_NV]    VARCHAR(255)
,    [eDisposition.03]    VARCHAR(255)
,    [eDisposition.03_StreetAddress2]    VARCHAR(255)
,    [eDisposition.04]    VARCHAR(255)
,    [eDisposition.05]    VARCHAR(255)
,    [eDisposition.05_NV]    VARCHAR(255)
,    [eDisposition.06]    VARCHAR(255)
,    [eDisposition.06_NV]    VARCHAR(255)
,    [eDisposition.07]    VARCHAR(255)
,    [eDisposition.07_NV]    VARCHAR(255)
,    [eDisposition.08]    VARCHAR(255)
,    [eDisposition.09]    VARCHAR(255)
,    [eDisposition.10]    VARCHAR(255)
,    [eDisposition.11]    VARCHAR(255)
,    [eDisposition.11_NV]    VARCHAR(255)
,    [eDisposition.12]    VARCHAR(255)
,    [eDisposition.15]    VARCHAR(255)
,    [eDisposition.16]    VARCHAR(255)
,    [eDisposition.16_NV]    VARCHAR(255)
,    [eDisposition.17]    VARCHAR(255)
,    [eDisposition.17_NV]    VARCHAR(255)
,    [eDisposition.19]    VARCHAR(255)
,    [eDisposition.19_NV]    VARCHAR(255)
,    [eDisposition.21]    VARCHAR(255)
,    [eDisposition.21_NV]    VARCHAR(255)
,    [eDisposition.22]    VARCHAR(255)
,    [eDisposition.22_NV]    VARCHAR(255)
,    [eDisposition.23]    VARCHAR(255)
,    [eDisposition.23_NV]    VARCHAR(255)
,    [eOutcome.01]    VARCHAR(255)
,    [eOutcome.01_NV]    VARCHAR(255)
,    [eOutcome.02]    VARCHAR(255)
,    [eOutcome.02_NV]    VARCHAR(255)
,    [eOutcome.06]    VARCHAR(255)
,    [eOutcome.07]    VARCHAR(255)
,    [eOutcome.11]    VARCHAR(255)
,    [eOutcome.14]    VARCHAR(255)
,    [eOutcome.15]    VARCHAR(255)
,    [eOutcome.16]    VARCHAR(255)
,    [eOutcome.17]    VARCHAR(255)
,    [eOther.01]    VARCHAR(255)
,    [eOther.08]    VARCHAR(255)
,    [eOther.08_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.08] ( 
    [pk_eResponse.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.08]    VARCHAR(255)
,    [eResponse.08_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.09] ( 
    [pk_eResponse.09]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.09]    VARCHAR(255)
,    [eResponse.09_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.10] ( 
    [pk_eResponse.10]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.10]    VARCHAR(255)
,    [eResponse.10_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.11] ( 
    [pk_eResponse.11]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.11]    VARCHAR(255)
,    [eResponse.11_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.12] ( 
    [pk_eResponse.12]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.12]    VARCHAR(255)
,    [eResponse.12_NV]    VARCHAR(255)
)

CREATE TABLE [eResponse.24] ( 
    [pk_eResponse.24]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eResponse.24]    VARCHAR(255)
,    [eResponse.24_NV]    VARCHAR(255)
)

CREATE TABLE [eCrew.CrewGroup] ( 
    [pk_eCrew.CrewGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eCrew.01]    VARCHAR(255)
,    [eCrew.01_NV]    VARCHAR(255)
,    [eCrew.02]    VARCHAR(255)
,    [eCrew.02_NV]    VARCHAR(255)
)

CREATE TABLE [eCrew.03] ( 
    [pk_eCrew.03]    INT PRIMARY KEY,
    [fk_pk_eCrew.CrewGroup]    INT FOREIGN KEY REFERENCES     [eCrew.CrewGroup]([pk_eCrew.CrewGroup])
,    [eCrew.03]    VARCHAR(255)
,    [eCrew.03_NV]    VARCHAR(255)
)

CREATE TABLE [ePatient.14] ( 
    [pk_ePatient.14]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePatient.14]    VARCHAR(255)
,    [ePatient.14_NV]    VARCHAR(255)
)

CREATE TABLE [ePatient.18] ( 
    [pk_ePatient.18]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePatient.18]    VARCHAR(255)
,    [ePatient.18_PhoneNumberType]    VARCHAR(255)
)

CREATE TABLE [ePatient.19] ( 
    [pk_ePatient.19]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePatient.19]    VARCHAR(255)
,    [ePatient.19_EmailAddressType]    VARCHAR(255)
)

CREATE TABLE [ePayment.04] ( 
    [pk_ePayment.04]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.04]    VARCHAR(255)
)

CREATE TABLE [ePayment.InsuranceGroup] ( 
    [pk_ePayment.InsuranceGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.09]    VARCHAR(255)
,    [ePayment.10]    VARCHAR(255)
,    [ePayment.11]    VARCHAR(255)
,    [ePayment.12]    VARCHAR(255)
,    [ePayment.12_StreetAddress2]    VARCHAR(255)
,    [ePayment.13]    VARCHAR(255)
,    [ePayment.14]    VARCHAR(255)
,    [ePayment.15]    VARCHAR(255)
,    [ePayment.16]    VARCHAR(255)
,    [ePayment.17]    VARCHAR(255)
,    [ePayment.18]    VARCHAR(255)
,    [ePayment.19]    VARCHAR(255)
,    [ePayment.20]    VARCHAR(255)
,    [ePayment.21]    VARCHAR(255)
,    [ePayment.22]    VARCHAR(255)
,    [ePayment.58]    VARCHAR(255)
)

CREATE TABLE [ePayment.31] ( 
    [pk_ePayment.31]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.31]    VARCHAR(255)
,    [ePayment.31_PhoneNumberType]    VARCHAR(255)
)

CREATE TABLE [ePayment.41] ( 
    [pk_ePayment.41]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.41]    VARCHAR(255)
)

CREATE TABLE [ePayment.42] ( 
    [pk_ePayment.42]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.42]    VARCHAR(255)
)

CREATE TABLE [ePayment.44] ( 
    [pk_ePayment.44]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.44]    VARCHAR(255)
)

CREATE TABLE [ePayment.47] ( 
    [pk_ePayment.47]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.47]    VARCHAR(255)
)

CREATE TABLE [ePayment.51] ( 
    [pk_ePayment.51]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.51]    VARCHAR(255)
)

CREATE TABLE [ePayment.52] ( 
    [pk_ePayment.52]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.52]    VARCHAR(255)
)

CREATE TABLE [ePayment.SupplyItemGroup] ( 
    [pk_ePayment.SupplyItemGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [ePayment.55]    VARCHAR(255)
,    [ePayment.56]    VARCHAR(255)
)

CREATE TABLE [eScene.ResponderGroup] ( 
    [pk_eScene.ResponderGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eScene.02]    VARCHAR(255)
,    [eScene.03]    VARCHAR(255)
,    [eScene.04]    VARCHAR(255)
)

CREATE TABLE [eSituation.PatientComplaintGroup] ( 
    [pk_eSituation.PatientComplaintGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eSituation.03]    VARCHAR(255)
,    [eSituation.03_NV]    VARCHAR(255)
,    [eSituation.04]    VARCHAR(255)
,    [eSituation.04_NV]    VARCHAR(255)
,    [eSituation.05]    VARCHAR(255)
,    [eSituation.05_NV]    VARCHAR(255)
,    [eSituation.06]    VARCHAR(255)
,    [eSituation.06_NV]    VARCHAR(255)
)

CREATE TABLE [eSituation.10] ( 
    [pk_eSituation.10]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eSituation.10]    VARCHAR(255)
,    [eSituation.10_NV]    VARCHAR(255)
)

CREATE TABLE [eSituation.12] ( 
    [pk_eSituation.12]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eSituation.12]    VARCHAR(255)
,    [eSituation.12_NV]    VARCHAR(255)
)

CREATE TABLE [eSituation.17] ( 
    [pk_eSituation.17]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eSituation.17]    VARCHAR(255)
,    [eSituation.17_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.01] ( 
    [pk_eInjury.01]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.01]    VARCHAR(255)
,    [eInjury.01_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.02] ( 
    [pk_eInjury.02]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.02]    VARCHAR(255)
,    [eInjury.02_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.03] ( 
    [pk_eInjury.03]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.03]    VARCHAR(255)
,    [eInjury.03_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.04] ( 
    [pk_eInjury.04]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.04]    VARCHAR(255)
,    [eInjury.04_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.07] ( 
    [pk_eInjury.07]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.07]    VARCHAR(255)
,    [eInjury.07_NV]    VARCHAR(255)
)

CREATE TABLE [eInjury.08] ( 
    [pk_eInjury.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.08]    VARCHAR(255)
)

CREATE TABLE [eInjury.10] ( 
    [pk_eInjury.10]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.10]    VARCHAR(255)
)

CREATE TABLE [eInjury.13] ( 
    [pk_eInjury.13]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.13]    VARCHAR(255)
,    [eInjury.13_PhoneNumberType]    VARCHAR(255)
)

CREATE TABLE [eInjury.22] ( 
    [pk_eInjury.22]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.22]    VARCHAR(255)
,    [eInjury.22_DeltaVelocityOrdinal]    VARCHAR(255)
,    [eInjury.22_VelocityUnit]    VARCHAR(255)
)

CREATE TABLE [eInjury.SeatGroup] ( 
    [pk_eInjury.SeatGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eInjury.26]    VARCHAR(255)
,    [eInjury.27]    VARCHAR(255)
,    [eInjury.28]    VARCHAR(255)
,    [eInjury.29]    VARCHAR(255)
)

CREATE TABLE [eArrest.03] ( 
    [pk_eArrest.03]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.03]    VARCHAR(255)
,    [eArrest.03_NV]    VARCHAR(255)
)

CREATE TABLE [eArrest.04] ( 
    [pk_eArrest.04]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.04]    VARCHAR(255)
,    [eArrest.04_NV]    VARCHAR(255)
)

CREATE TABLE [eArrest.06] ( 
    [pk_eArrest.06]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.06]    VARCHAR(255)
)

CREATE TABLE [eArrest.08] ( 
    [pk_eArrest.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.08]    VARCHAR(255)
)

CREATE TABLE [eArrest.09] ( 
    [pk_eArrest.09]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.09]    VARCHAR(255)
,    [eArrest.09_NV]    VARCHAR(255)
)

CREATE TABLE [eArrest.12] ( 
    [pk_eArrest.12]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.12]    VARCHAR(255)
,    [eArrest.12_NV]    VARCHAR(255)
)

CREATE TABLE [eArrest.17] ( 
    [pk_eArrest.17]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eArrest.17]    VARCHAR(255)
,    [eArrest.17_NV]    VARCHAR(255)
)

CREATE TABLE [eHistory.01] ( 
    [pk_eHistory.01]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.01]    VARCHAR(255)
,    [eHistory.01_NV]    VARCHAR(255)
)

CREATE TABLE [eHistory.PractitionerGroup] ( 
    [pk_eHistory.PractitionerGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.02]    VARCHAR(255)
,    [eHistory.03]    VARCHAR(255)
,    [eHistory.04]    VARCHAR(255)
)

CREATE TABLE [eHistory.05] ( 
    [pk_eHistory.05]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.05]    VARCHAR(255)
,    [eHistory.05_NV]    VARCHAR(255)
)

CREATE TABLE [eHistory.06] ( 
    [pk_eHistory.06]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.06]    VARCHAR(255)
,    [eHistory.06_NV]    VARCHAR(255)
,    [eHistory.06_PN]    VARCHAR(255)
,    [eHistory.06_CodeType]    VARCHAR(255)
)

CREATE TABLE [eHistory.07] ( 
    [pk_eHistory.07]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.07]    VARCHAR(255)
)

CREATE TABLE [eHistory.08] ( 
    [pk_eHistory.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.08]    VARCHAR(255)
,    [eHistory.08_NV]    VARCHAR(255)
,    [eHistory.08_PN]    VARCHAR(255)
)

CREATE TABLE [eHistory.09] ( 
    [pk_eHistory.09]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.09]    VARCHAR(255)
)

CREATE TABLE [eHistory.ImmunizationsGroup] ( 
    [pk_eHistory.ImmunizationsGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.10]    VARCHAR(255)
,    [eHistory.11]    VARCHAR(255)
)

CREATE TABLE [eHistory.CurrentMedsGroup] ( 
    [pk_eHistory.CurrentMedsGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.12]    VARCHAR(255)
,    [eHistory.12_PN]    VARCHAR(255)
,    [eHistory.12_NV]    VARCHAR(255)
,    [eHistory.13]    VARCHAR(255)
,    [eHistory.14]    VARCHAR(255)
,    [eHistory.15]    VARCHAR(255)
)

CREATE TABLE [eHistory.17] ( 
    [pk_eHistory.17]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eHistory.17]    VARCHAR(255)
,    [eHistory.17_PN]    VARCHAR(255)
,    [eHistory.17_NV]    VARCHAR(255)
)

CREATE TABLE [eVitals.VitalGroup] ( 
    [pk_eVitals.VitalGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eVitals.01]    VARCHAR(255)
,    [eVitals.01_NV]    VARCHAR(255)
,    [eVitals.02]    VARCHAR(255)
,    [eVitals.02_NV]    VARCHAR(255)
,    [eVitals.04]    VARCHAR(255)
,    [eVitals.04_NV]    VARCHAR(255)
,    [eVitals.06]    VARCHAR(255)
,    [eVitals.06_PN]    VARCHAR(255)
,    [eVitals.06_NV]    VARCHAR(255)
,    [eVitals.07]    VARCHAR(255)
,    [eVitals.07_PN]    VARCHAR(255)
,    [eVitals.07_NV]    VARCHAR(255)
,    [eVitals.08]    VARCHAR(255)
,    [eVitals.08_NV]    VARCHAR(255)
,    [eVitals.09]    VARCHAR(255)
,    [eVitals.10]    VARCHAR(255)
,    [eVitals.10_PN]    VARCHAR(255)
,    [eVitals.10_NV]    VARCHAR(255)
,    [eVitals.11]    VARCHAR(255)
,    [eVitals.12]    VARCHAR(255)
,    [eVitals.12_PN]    VARCHAR(255)
,    [eVitals.12_NV]    VARCHAR(255)
,    [eVitals.13]    VARCHAR(255)
,    [eVitals.14]    VARCHAR(255)
,    [eVitals.14_PN]    VARCHAR(255)
,    [eVitals.14_NV]    VARCHAR(255)
,    [eVitals.15]    VARCHAR(255)
,    [eVitals.16]    VARCHAR(255)
,    [eVitals.16_PN]    VARCHAR(255)
,    [eVitals.16_NV]    VARCHAR(255)
,    [eVitals.17]    VARCHAR(255)
,    [eVitals.17_PN]    VARCHAR(255)
,    [eVitals.17_NV]    VARCHAR(255)
,    [eVitals.18]    VARCHAR(255)
,    [eVitals.18_PN]    VARCHAR(255)
,    [eVitals.18_NV]    VARCHAR(255)
,    [eVitals.19]    VARCHAR(255)
,    [eVitals.19_PN]    VARCHAR(255)
,    [eVitals.19_NV]    VARCHAR(255)
,    [eVitals.20]    VARCHAR(255)
,    [eVitals.20_PN]    VARCHAR(255)
,    [eVitals.20_NV]    VARCHAR(255)
,    [eVitals.21]    VARCHAR(255)
,    [eVitals.21_PN]    VARCHAR(255)
,    [eVitals.21_NV]    VARCHAR(255)
,    [eVitals.23]    VARCHAR(255)
,    [eVitals.23_PN]    VARCHAR(255)
,    [eVitals.23_NV]    VARCHAR(255)
,    [eVitals.24]    VARCHAR(255)
,    [eVitals.24_PN]    VARCHAR(255)
,    [eVitals.24_NV]    VARCHAR(255)
,    [eVitals.25]    VARCHAR(255)
,    [eVitals.26]    VARCHAR(255)
,    [eVitals.26_NV]    VARCHAR(255)
,    [eVitals.27]    VARCHAR(255)
,    [eVitals.27_PN]    VARCHAR(255)
,    [eVitals.27_NV]    VARCHAR(255)
,    [eVitals.28]    VARCHAR(255)
,    [eVitals.28_NV]    VARCHAR(255)
,    [eVitals.29]    VARCHAR(255)
,    [eVitals.29_PN]    VARCHAR(255)
,    [eVitals.29_NV]    VARCHAR(255)
,    [eVitals.30]    VARCHAR(255)
,    [eVitals.30_NV]    VARCHAR(255)
,    [eVitals.31]    VARCHAR(255)
,    [eVitals.31_PN]    VARCHAR(255)
,    [eVitals.31_NV]    VARCHAR(255)
,    [eVitals.32]    VARCHAR(255)
,    [eVitals.32_PN]    VARCHAR(255)
,    [eVitals.33]    VARCHAR(255)
,    [eVitals.33_PN]    VARCHAR(255)
)

CREATE TABLE [eVitals.03] ( 
    [pk_eVitals.03]    INT PRIMARY KEY,
    [fk_pk_eVitals.VitalGroup]    INT FOREIGN KEY REFERENCES     [eVitals.VitalGroup]([pk_eVitals.VitalGroup])
,    [eVitals.03]    VARCHAR(255)
,    [eVitals.03_PN]    VARCHAR(255)
,    [eVitals.03_NV]    VARCHAR(255)
)

CREATE TABLE [eVitals.05] ( 
    [pk_eVitals.05]    INT PRIMARY KEY,
    [fk_pk_eVitals.VitalGroup]    INT FOREIGN KEY REFERENCES     [eVitals.VitalGroup]([pk_eVitals.VitalGroup])
,    [eVitals.05]    VARCHAR(255)
,    [eVitals.05_NV]    VARCHAR(255)
)

CREATE TABLE [eVitals.22] ( 
    [pk_eVitals.22]    INT PRIMARY KEY,
    [fk_pk_eVitals.VitalGroup]    INT FOREIGN KEY REFERENCES     [eVitals.VitalGroup]([pk_eVitals.VitalGroup])
,    [eVitals.22]    VARCHAR(255)
,    [eVitals.22_NV]    VARCHAR(255)
)

CREATE TABLE [eLabs.LabGroup] ( 
    [pk_eLabs.LabGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eLabs.01]    VARCHAR(255)
,    [eLabs.02]    VARCHAR(255)
)

CREATE TABLE [eLabs.LabResultGroup] ( 
    [pk_eLabs.LabResultGroup]    INT PRIMARY KEY,
    [fk_pk_eLabs.LabGroup]    INT FOREIGN KEY REFERENCES     [eLabs.LabGroup]([pk_eLabs.LabGroup])
,    [eLabs.03]    VARCHAR(255)
,    [eLabs.04]    VARCHAR(255)
)

CREATE TABLE [eLabs.LabImageGroup] ( 
    [pk_eLabs.LabImageGroup]    INT PRIMARY KEY,
    [fk_pk_eLabs.LabGroup]    INT FOREIGN KEY REFERENCES     [eLabs.LabGroup]([pk_eLabs.LabGroup])
,    [eLabs.05]    VARCHAR(255)
,    [eLabs.06]    VARCHAR(255)
)

CREATE TABLE [eLabs.WaveformGraphicGroup] ( 
    [pk_eLabs.WaveformGraphicGroup]    INT PRIMARY KEY,
    [fk_pk_eLabs.LabImageGroup]    INT FOREIGN KEY REFERENCES     [eLabs.LabImageGroup]([pk_eLabs.LabImageGroup])
,    [eLabs.07]    VARCHAR(255)
,    [eLabs.08]    VARCHAR(255)
)

CREATE TABLE [eExam.AssessmentGroup] ( 
    [pk_eExam.AssessmentGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eExam.03]    VARCHAR(255)
)

CREATE TABLE [eExam.04] ( 
    [pk_eExam.04]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.04]    VARCHAR(255)
,    [eExam.04_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.05] ( 
    [pk_eExam.05]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.05]    VARCHAR(255)
,    [eExam.05_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.06] ( 
    [pk_eExam.06]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.06]    VARCHAR(255)
,    [eExam.06_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.07] ( 
    [pk_eExam.07]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.07]    VARCHAR(255)
,    [eExam.07_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.08] ( 
    [pk_eExam.08]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.08]    VARCHAR(255)
,    [eExam.08_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.09] ( 
    [pk_eExam.09]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.09]    VARCHAR(255)
,    [eExam.09_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.AbdomenGroup] ( 
    [pk_eExam.AbdomenGroup]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.10]    VARCHAR(255)
)

CREATE TABLE [eExam.11] ( 
    [pk_eExam.11]    INT PRIMARY KEY,
    [fk_pk_eExam.AbdomenGroup]    INT FOREIGN KEY REFERENCES     [eExam.AbdomenGroup]([pk_eExam.AbdomenGroup])
,    [eExam.11]    VARCHAR(255)
,    [eExam.11_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.12] ( 
    [pk_eExam.12]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.12]    VARCHAR(255)
,    [eExam.12_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.SpineGroup] ( 
    [pk_eExam.SpineGroup]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.13]    VARCHAR(255)
)

CREATE TABLE [eExam.14] ( 
    [pk_eExam.14]    INT PRIMARY KEY,
    [fk_pk_eExam.SpineGroup]    INT FOREIGN KEY REFERENCES     [eExam.SpineGroup]([pk_eExam.SpineGroup])
,    [eExam.14]    VARCHAR(255)
,    [eExam.14_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.ExtremityGroup] ( 
    [pk_eExam.ExtremityGroup]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.15]    VARCHAR(255)
)

CREATE TABLE [eExam.16] ( 
    [pk_eExam.16]    INT PRIMARY KEY,
    [fk_pk_eExam.ExtremityGroup]    INT FOREIGN KEY REFERENCES     [eExam.ExtremityGroup]([pk_eExam.ExtremityGroup])
,    [eExam.16]    VARCHAR(255)
,    [eExam.16_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.EyeGroup] ( 
    [pk_eExam.EyeGroup]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.17]    VARCHAR(255)
)

CREATE TABLE [eExam.18] ( 
    [pk_eExam.18]    INT PRIMARY KEY,
    [fk_pk_eExam.EyeGroup]    INT FOREIGN KEY REFERENCES     [eExam.EyeGroup]([pk_eExam.EyeGroup])
,    [eExam.18]    VARCHAR(255)
,    [eExam.18_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.19] ( 
    [pk_eExam.19]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.19]    VARCHAR(255)
,    [eExam.19_PN]    VARCHAR(255)
)

CREATE TABLE [eExam.20] ( 
    [pk_eExam.20]    INT PRIMARY KEY,
    [fk_pk_eExam.AssessmentGroup]    INT FOREIGN KEY REFERENCES     [eExam.AssessmentGroup]([pk_eExam.AssessmentGroup])
,    [eExam.20]    VARCHAR(255)
,    [eExam.20_PN]    VARCHAR(255)
)

CREATE TABLE [eProtocols.ProtocolGroup] ( 
    [pk_eProtocols.ProtocolGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eProtocols.01]    VARCHAR(255)
,    [eProtocols.01_NV]    VARCHAR(255)
,    [eProtocols.02]    VARCHAR(255)
,    [eProtocols.02_NV]    VARCHAR(255)
)

CREATE TABLE [eMedications.MedicationGroup] ( 
    [pk_eMedications.MedicationGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eMedications.01]    VARCHAR(255)
,    [eMedications.01_NV]    VARCHAR(255)
,    [eMedications.02]    VARCHAR(255)
,    [eMedications.02_NV]    VARCHAR(255)
,    [eMedications.03]    VARCHAR(255)
,    [eMedications.03_PN]    VARCHAR(255)
,    [eMedications.03_NV]    VARCHAR(255)
,    [eMedications.04]    VARCHAR(255)
,    [eMedications.05]    VARCHAR(255)
,    [eMedications.05_NV]    VARCHAR(255)
,    [eMedications.06]    VARCHAR(255)
,    [eMedications.06_NV]    VARCHAR(255)
,    [eMedications.07]    VARCHAR(255)
,    [eMedications.07_NV]    VARCHAR(255)
,    [eMedications.09]    VARCHAR(255)
,    [eMedications.09_NV]    VARCHAR(255)
,    [eMedications.10]    VARCHAR(255)
,    [eMedications.10_NV]    VARCHAR(255)
,    [eMedications.11]    VARCHAR(255)
,    [eMedications.12]    VARCHAR(255)
)

CREATE TABLE [eMedications.08] ( 
    [pk_eMedications.08]    INT PRIMARY KEY,
    [fk_pk_eMedications.MedicationGroup]    INT FOREIGN KEY REFERENCES     [eMedications.MedicationGroup]([pk_eMedications.MedicationGroup])
,    [eMedications.08]    VARCHAR(255)
,    [eMedications.08_NV]    VARCHAR(255)
)

CREATE TABLE [eProcedures.ProcedureGroup] ( 
    [pk_eProcedures.ProcedureGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eProcedures.01]    VARCHAR(255)
,    [eProcedures.01_NV]    VARCHAR(255)
,    [eProcedures.02]    VARCHAR(255)
,    [eProcedures.02_NV]    VARCHAR(255)
,    [eProcedures.03]    VARCHAR(255)
,    [eProcedures.03_NV]    VARCHAR(255)
,    [eProcedures.03_PN]    VARCHAR(255)
,    [eProcedures.04]    VARCHAR(255)
,    [eProcedures.05]    VARCHAR(255)
,    [eProcedures.05_NV]    VARCHAR(255)
,    [eProcedures.06]    VARCHAR(255)
,    [eProcedures.06_NV]    VARCHAR(255)
,    [eProcedures.08]    VARCHAR(255)
,    [eProcedures.08_NV]    VARCHAR(255)
,    [eProcedures.09]    VARCHAR(255)
,    [eProcedures.09_NV]    VARCHAR(255)
,    [eProcedures.10]    VARCHAR(255)
,    [eProcedures.10_NV]    VARCHAR(255)
,    [eProcedures.11]    VARCHAR(255)
,    [eProcedures.12]    VARCHAR(255)
,    [eProcedures.13]    VARCHAR(255)
,    [eProcedures.13_NV]    VARCHAR(255)
)

CREATE TABLE [eProcedures.07] ( 
    [pk_eProcedures.07]    INT PRIMARY KEY,
    [fk_pk_eProcedures.ProcedureGroup]    INT FOREIGN KEY REFERENCES     [eProcedures.ProcedureGroup]([pk_eProcedures.ProcedureGroup])
,    [eProcedures.07]    VARCHAR(255)
,    [eProcedures.07_NV]    VARCHAR(255)
)

CREATE TABLE [eAirway.01] ( 
    [pk_eAirway.01]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eAirway.01]    VARCHAR(255)
,    [eAirway.01_NV]    VARCHAR(255)
)

CREATE TABLE [eAirway.ConfirmationGroup] ( 
    [pk_eAirway.ConfirmationGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eAirway.02]    VARCHAR(255)
,    [eAirway.02_NV]    VARCHAR(255)
,    [eAirway.03]    VARCHAR(255)
,    [eAirway.03_NV]    VARCHAR(255)
,    [eAirway.05]    VARCHAR(255)
,    [eAirway.06]    VARCHAR(255)
,    [eAirway.06_NV]    VARCHAR(255)
,    [eAirway.07]    VARCHAR(255)
,    [eAirway.07_NV]    VARCHAR(255)
,    [eAirway.ConfirmationGroup_ProcedureGroupCorrelationID]    VARCHAR(255)
)

CREATE TABLE [eAirway.04] ( 
    [pk_eAirway.04]    INT PRIMARY KEY,
    [fk_pk_eAirway.ConfirmationGroup]    INT FOREIGN KEY REFERENCES     [eAirway.ConfirmationGroup]([pk_eAirway.ConfirmationGroup])
,    [eAirway.04]    VARCHAR(255)
,    [eAirway.04_NV]    VARCHAR(255)
)

CREATE TABLE [eAirway.08] ( 
    [pk_eAirway.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eAirway.08]    VARCHAR(255)
,    [eAirway.08_NV]    VARCHAR(255)
)

CREATE TABLE [eAirway.09] ( 
    [pk_eAirway.09]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eAirway.09]    VARCHAR(255)
)

CREATE TABLE [eDevice.DeviceGroup] ( 
    [pk_eDevice.DeviceGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDevice.01]    VARCHAR(255)
,    [eDevice.02]    VARCHAR(255)
,    [eDevice.04]    VARCHAR(255)
,    [eDevice.05]    VARCHAR(255)
,    [eDevice.06]    VARCHAR(255)
,    [eDevice.08]    VARCHAR(255)
,    [eDevice.09]    VARCHAR(255)
,    [eDevice.10]    VARCHAR(255)
,    [eDevice.11]    VARCHAR(255)
,    [eDevice.12]    VARCHAR(255)
)

CREATE TABLE [eDevice.03] ( 
    [pk_eDevice.03]    INT PRIMARY KEY,
    [fk_pk_eDevice.DeviceGroup]    INT FOREIGN KEY REFERENCES     [eDevice.DeviceGroup]([pk_eDevice.DeviceGroup])
,    [eDevice.03]    VARCHAR(255)
)

CREATE TABLE [eDevice.07] ( 
    [pk_eDevice.07]    INT PRIMARY KEY,
    [fk_pk_eDevice.DeviceGroup]    INT FOREIGN KEY REFERENCES     [eDevice.DeviceGroup]([pk_eDevice.DeviceGroup])
,    [eDevice.07]    VARCHAR(255)
)

CREATE TABLE [eDisposition.13] ( 
    [pk_eDisposition.13]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.13]    VARCHAR(255)
)

CREATE TABLE [eDisposition.14] ( 
    [pk_eDisposition.14]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.14]    VARCHAR(255)
)

CREATE TABLE [eDisposition.18] ( 
    [pk_eDisposition.18]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.18]    VARCHAR(255)
,    [eDisposition.18_NV]    VARCHAR(255)
)

CREATE TABLE [eDisposition.20] ( 
    [pk_eDisposition.20]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.20]    VARCHAR(255)
,    [eDisposition.20_NV]    VARCHAR(255)
)

CREATE TABLE [eDisposition.HospitalTeamActivationGroup] ( 
    [pk_eDisposition.HospitalTeamActivationGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.24]    VARCHAR(255)
,    [eDisposition.24_NV]    VARCHAR(255)
,    [eDisposition.25]    VARCHAR(255)
,    [eDisposition.25_NV]    VARCHAR(255)
)

CREATE TABLE [eDisposition.26] ( 
    [pk_eDisposition.26]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eDisposition.26]    VARCHAR(255)
)

CREATE TABLE [eOutcome.ExternalDataGroup] ( 
    [pk_eOutcome.ExternalDataGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.03]    VARCHAR(255)
,    [eOutcome.04]    VARCHAR(255)
,    [eOutcome.05]    VARCHAR(255)
)

CREATE TABLE [eOutcome.08] ( 
    [pk_eOutcome.08]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.08]    VARCHAR(255)
)

CREATE TABLE [eOutcome.09] ( 
    [pk_eOutcome.09]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.09]    VARCHAR(255)
)

CREATE TABLE [eOutcome.10] ( 
    [pk_eOutcome.10]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.10]    VARCHAR(255)
)

CREATE TABLE [eOutcome.12] ( 
    [pk_eOutcome.12]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.12]    VARCHAR(255)
)

CREATE TABLE [eOutcome.13] ( 
    [pk_eOutcome.13]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOutcome.13]    VARCHAR(255)
)

CREATE TABLE [eOther.02] ( 
    [pk_eOther.02]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOther.02]    VARCHAR(255)
)

CREATE TABLE [eOther.EMSCrewMemberGroup] ( 
    [pk_eOther.EMSCrewMemberGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOther.04]    VARCHAR(255)
,    [eOther.05]    VARCHAR(255)
,    [eOther.05_NV]    VARCHAR(255)
)

CREATE TABLE [eOther.03] ( 
    [pk_eOther.03]    INT PRIMARY KEY,
    [fk_pk_eOther.EMSCrewMemberGroup]    INT FOREIGN KEY REFERENCES     [eOther.EMSCrewMemberGroup]([pk_eOther.EMSCrewMemberGroup])
,    [eOther.03]    VARCHAR(255)
)

CREATE TABLE [eOther.06] ( 
    [pk_eOther.06]    INT PRIMARY KEY,
    [fk_pk_eOther.EMSCrewMemberGroup]    INT FOREIGN KEY REFERENCES     [eOther.EMSCrewMemberGroup]([pk_eOther.EMSCrewMemberGroup])
,    [eOther.06]    VARCHAR(255)
,    [eOther.06_NV]    VARCHAR(255)
)

CREATE TABLE [eOther.07] ( 
    [pk_eOther.07]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOther.07]    VARCHAR(255)
)

CREATE TABLE [eOther.FileGroup] ( 
    [pk_eOther.FileGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOther.09]    VARCHAR(255)
,    [eOther.10]    VARCHAR(255)
,    [eOther.11]    VARCHAR(255)
)

CREATE TABLE [eOther.SignatureGroup] ( 
    [pk_eOther.SignatureGroup]    INT PRIMARY KEY,
    [fk_pk_PatientCareReport]    INT FOREIGN KEY REFERENCES     [PatientCareReport]([pk_PatientCareReport])
,    [eOther.12]    VARCHAR(255)
,    [eOther.14]    VARCHAR(255)
,    [eOther.15]    VARCHAR(255)
,    [eOther.16]    VARCHAR(255)
,    [eOther.17]    VARCHAR(255)
,    [eOther.18]    VARCHAR(255)
,    [eOther.19]    VARCHAR(255)
,    [eOther.20]    VARCHAR(255)
,    [eOther.21]    VARCHAR(255)
)

CREATE TABLE [eOther.13] ( 
    [pk_eOther.13]    INT PRIMARY KEY,
    [fk_pk_eOther.SignatureGroup]    INT FOREIGN KEY REFERENCES     [eOther.SignatureGroup]([pk_eOther.SignatureGroup])
,    [eOther.13]    VARCHAR(255)
)

