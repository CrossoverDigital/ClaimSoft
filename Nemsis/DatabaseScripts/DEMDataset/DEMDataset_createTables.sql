CREATE TABLE DEMDataSet ( 
    pk_DEMDataSet    INT PRIMARY KEY
)

CREATE TABLE [DemographicReport] ( 
    [pk_DemographicReport]    INT PRIMARY KEY,
    [fk_pk_DEMDataSet]    INT FOREIGN KEY REFERENCES     [DEMDataSet]([pk_DEMDataSet])
,    [dAgency.01]    VARCHAR(255)
,    [dAgency.02]    VARCHAR(255)
,    [dAgency.03]    VARCHAR(255)
,    [dAgency.03_NV]    VARCHAR(255)
,    [dAgency.04]    VARCHAR(255)
,    [dAgency.09]    VARCHAR(255)
,    [dAgency.11]    VARCHAR(255)
,    [dAgency.12]    VARCHAR(255)
,    [dAgency.13]    VARCHAR(255)
,    [dAgency.14]    VARCHAR(255)
,    [dAgency.23]    VARCHAR(255)
,    [dAgency.24]    VARCHAR(255)
,    [DemographicReport_timeStamp]    VARCHAR(255)
)

CREATE TABLE [dAgency.AgencyServiceGroup] ( 
    [pk_dAgency.AgencyServiceGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dAgency.05]    VARCHAR(255)
)

CREATE TABLE [dAgency.06] ( 
    [pk_dAgency.06]    INT PRIMARY KEY,
    [fk_pk_dAgency.AgencyServiceGroup]    INT FOREIGN KEY REFERENCES     [dAgency.AgencyServiceGroup]([pk_dAgency.AgencyServiceGroup])
,    [dAgency.06]    VARCHAR(255)
)

CREATE TABLE [dAgency.07] ( 
    [pk_dAgency.07]    INT PRIMARY KEY,
    [fk_pk_dAgency.AgencyServiceGroup]    INT FOREIGN KEY REFERENCES     [dAgency.AgencyServiceGroup]([pk_dAgency.AgencyServiceGroup])
,    [dAgency.07]    VARCHAR(255)
,    [dAgency.07_NV]    VARCHAR(255)
)

CREATE TABLE [dAgency.08] ( 
    [pk_dAgency.08]    INT PRIMARY KEY,
    [fk_pk_dAgency.AgencyServiceGroup]    INT FOREIGN KEY REFERENCES     [dAgency.AgencyServiceGroup]([pk_dAgency.AgencyServiceGroup])
,    [dAgency.08]    VARCHAR(255)
,    [dAgency.08_NV]    VARCHAR(255)
)

CREATE TABLE [dAgency.10] ( 
    [pk_dAgency.10]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dAgency.10]    VARCHAR(255)
,    [dAgency.10_NV]    VARCHAR(255)
)

CREATE TABLE [dAgency.AgencyYearGroup] ( 
    [pk_dAgency.AgencyYearGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dAgency.15]    VARCHAR(255)
,    [dAgency.16]    VARCHAR(255)
,    [dAgency.16_NV]    VARCHAR(255)
,    [dAgency.17]    VARCHAR(255)
,    [dAgency.17_NV]    VARCHAR(255)
,    [dAgency.18]    VARCHAR(255)
,    [dAgency.18_NV]    VARCHAR(255)
,    [dAgency.19]    VARCHAR(255)
,    [dAgency.19_NV]    VARCHAR(255)
,    [dAgency.20]    VARCHAR(255)
,    [dAgency.20_NV]    VARCHAR(255)
,    [dAgency.21]    VARCHAR(255)
,    [dAgency.21_NV]    VARCHAR(255)
,    [dAgency.22]    VARCHAR(255)
,    [dAgency.22_NV]    VARCHAR(255)
)

CREATE TABLE [dAgency.25] ( 
    [pk_dAgency.25]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dAgency.25]    VARCHAR(255)
,    [dAgency.25_NV]    VARCHAR(255)
)

CREATE TABLE [dAgency.26] ( 
    [pk_dAgency.26]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dAgency.26]    VARCHAR(255)
,    [dAgency.26_NV]    VARCHAR(255)
)

CREATE TABLE [dContact.ContactInfoGroup] ( 
    [pk_dContact.ContactInfoGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dContact.01]    VARCHAR(255)
,    [dContact.01_NV]    VARCHAR(255)
,    [dContact.02]    VARCHAR(255)
,    [dContact.02_NV]    VARCHAR(255)
,    [dContact.03]    VARCHAR(255)
,    [dContact.03_NV]    VARCHAR(255)
,    [dContact.04]    VARCHAR(255)
,    [dContact.05]    VARCHAR(255)
,    [dContact.05_NV]    VARCHAR(255)
,    [dContact.05_StreetAddress2]    VARCHAR(255)
,    [dContact.06]    VARCHAR(255)
,    [dContact.06_NV]    VARCHAR(255)
,    [dContact.07]    VARCHAR(255)
,    [dContact.07_NV]    VARCHAR(255)
,    [dContact.08]    VARCHAR(255)
,    [dContact.08_NV]    VARCHAR(255)
,    [dContact.09]    VARCHAR(255)
,    [dContact.12]    VARCHAR(255)
,    [dContact.12_NV]    VARCHAR(255)
,    [dContact.13]    VARCHAR(255)
,    [dContact.13_NV]    VARCHAR(255)
,    [dContact.15]    VARCHAR(255)
,    [dContact.16]    VARCHAR(255)
)

CREATE TABLE [dContact.10] ( 
    [pk_dContact.10]    INT PRIMARY KEY,
    [fk_pk_dContact.ContactInfoGroup]    INT FOREIGN KEY REFERENCES     [dContact.ContactInfoGroup]([pk_dContact.ContactInfoGroup])
,    [dContact.10]    VARCHAR(255)
,    [dContact.10_PhoneNumberType]    VARCHAR(255)
,    [dContact.10_NV]    VARCHAR(255)
)

CREATE TABLE [dContact.11] ( 
    [pk_dContact.11]    INT PRIMARY KEY,
    [fk_pk_dContact.ContactInfoGroup]    INT FOREIGN KEY REFERENCES     [dContact.ContactInfoGroup]([pk_dContact.ContactInfoGroup])
,    [dContact.11]    VARCHAR(255)
,    [dContact.11_NV]    VARCHAR(255)
,    [dContact.11_EmailAddressType]    VARCHAR(255)
)

CREATE TABLE [dContact.14] ( 
    [pk_dContact.14]    INT PRIMARY KEY,
    [fk_pk_dContact.ContactInfoGroup]    INT FOREIGN KEY REFERENCES     [dContact.ContactInfoGroup]([pk_dContact.ContactInfoGroup])
,    [dContact.14]    VARCHAR(255)
,    [dContact.14_NV]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.ConfigurationGroup] ( 
    [pk_dConfiguration.ConfigurationGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dConfiguration.01]    VARCHAR(255)
,    [dConfiguration.12]    VARCHAR(255)
,    [dConfiguration.13]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.02] ( 
    [pk_dConfiguration.02]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.02]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.03] ( 
    [pk_dConfiguration.03]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.03]    VARCHAR(255)
,    [dConfiguration.03_NV]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.04] ( 
    [pk_dConfiguration.04]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.04]    VARCHAR(255)
,    [dConfiguration.04_NV]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.05] ( 
    [pk_dConfiguration.05]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.05]    VARCHAR(255)
,    [dConfiguration.05_NV]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.ProcedureGroup] ( 
    [pk_dConfiguration.ProcedureGroup]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.06]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.07] ( 
    [pk_dConfiguration.07]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ProcedureGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ProcedureGroup]([pk_dConfiguration.ProcedureGroup])
,    [dConfiguration.07]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.MedicationGroup] ( 
    [pk_dConfiguration.MedicationGroup]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.08]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.09] ( 
    [pk_dConfiguration.09]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.MedicationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.MedicationGroup]([pk_dConfiguration.MedicationGroup])
,    [dConfiguration.09]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.10] ( 
    [pk_dConfiguration.10]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.10]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.11] ( 
    [pk_dConfiguration.11]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.11]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.14] ( 
    [pk_dConfiguration.14]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.14]    VARCHAR(255)
,    [dConfiguration.14_NV]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.15] ( 
    [pk_dConfiguration.15]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.15]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.16] ( 
    [pk_dConfiguration.16]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.16]    VARCHAR(255)
)

CREATE TABLE [dConfiguration.17] ( 
    [pk_dConfiguration.17]    INT PRIMARY KEY,
    [fk_pk_dConfiguration.ConfigurationGroup]    INT FOREIGN KEY REFERENCES     [dConfiguration.ConfigurationGroup]([pk_dConfiguration.ConfigurationGroup])
,    [dConfiguration.17]    VARCHAR(255)
)

CREATE TABLE [dLocation.LocationGroup] ( 
    [pk_dLocation.LocationGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dLocation.01]    VARCHAR(255)
,    [dLocation.02]    VARCHAR(255)
,    [dLocation.03]    VARCHAR(255)
,    [dLocation.04]    VARCHAR(255)
,    [dLocation.05]    VARCHAR(255)
,    [dLocation.06]    VARCHAR(255)
,    [dLocation.06_StreetAddress2]    VARCHAR(255)
,    [dLocation.07]    VARCHAR(255)
,    [dLocation.08]    VARCHAR(255)
,    [dLocation.09]    VARCHAR(255)
,    [dLocation.10]    VARCHAR(255)
,    [dLocation.11]    VARCHAR(255)
)

CREATE TABLE [dLocation.12] ( 
    [pk_dLocation.12]    INT PRIMARY KEY,
    [fk_pk_dLocation.LocationGroup]    INT FOREIGN KEY REFERENCES     [dLocation.LocationGroup]([pk_dLocation.LocationGroup])
,    [dLocation.12]    VARCHAR(255)
,    [dLocation.12_PhoneNumberType]    VARCHAR(255)
)

CREATE TABLE [dVehicle.VehicleGroup] ( 
    [pk_dVehicle.VehicleGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dVehicle.01]    VARCHAR(255)
,    [dVehicle.01_NV]    VARCHAR(255)
,    [dVehicle.02]    VARCHAR(255)
,    [dVehicle.03]    VARCHAR(255)
,    [dVehicle.04]    VARCHAR(255)
,    [dVehicle.04_NV]    VARCHAR(255)
,    [dVehicle.09]    VARCHAR(255)
,    [dVehicle.10]    VARCHAR(255)
,    [dVehicle.10_NV]    VARCHAR(255)
)

CREATE TABLE [dVehicle.VehicleCertificationLevelsGroup] ( 
    [pk_dVehicle.VehicleCertificationLevelsGroup]    INT PRIMARY KEY,
    [fk_pk_dVehicle.VehicleGroup]    INT FOREIGN KEY REFERENCES     [dVehicle.VehicleGroup]([pk_dVehicle.VehicleGroup])
,    [dVehicle.05]    VARCHAR(255)
,    [dVehicle.06]    VARCHAR(255)
,    [dVehicle.07]    VARCHAR(255)
,    [dVehicle.08]    VARCHAR(255)
)

CREATE TABLE [dVehicle.YearGroup] ( 
    [pk_dVehicle.YearGroup]    INT PRIMARY KEY,
    [fk_pk_dVehicle.VehicleGroup]    INT FOREIGN KEY REFERENCES     [dVehicle.VehicleGroup]([pk_dVehicle.VehicleGroup])
,    [dVehicle.11]    VARCHAR(255)
,    [dVehicle.12]    VARCHAR(255)
,    [dVehicle.13]    VARCHAR(255)
,    [dVehicle.13_DistanceUnit]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.PersonnelGroup] ( 
    [pk_dPersonnel.PersonnelGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dPersonnel.01]    VARCHAR(255)
,    [dPersonnel.01_NV]    VARCHAR(255)
,    [dPersonnel.02]    VARCHAR(255)
,    [dPersonnel.02_NV]    VARCHAR(255)
,    [dPersonnel.03]    VARCHAR(255)
,    [dPersonnel.03_NV]    VARCHAR(255)
,    [dPersonnel.04]    VARCHAR(255)
,    [dPersonnel.04_StreetAddress2]    VARCHAR(255)
,    [dPersonnel.05]    VARCHAR(255)
,    [dPersonnel.06]    VARCHAR(255)
,    [dPersonnel.07]    VARCHAR(255)
,    [dPersonnel.08]    VARCHAR(255)
,    [dPersonnel.11]    VARCHAR(255)
,    [dPersonnel.11_NV]    VARCHAR(255)
,    [dPersonnel.12]    VARCHAR(255)
,    [dPersonnel.12_NV]    VARCHAR(255)
,    [dPersonnel.14]    VARCHAR(255)
,    [dPersonnel.15]    VARCHAR(255)
,    [dPersonnel.21]    VARCHAR(255)
,    [dPersonnel.28]    VARCHAR(255)
,    [dPersonnel.29]    VARCHAR(255)
,    [dPersonnel.30]    VARCHAR(255)
,    [dPersonnel.31]    VARCHAR(255)
,    [dPersonnel.31_NV]    VARCHAR(255)
,    [dPersonnel.32]    VARCHAR(255)
,    [dPersonnel.32_NV]    VARCHAR(255)
,    [dPersonnel.33]    VARCHAR(255)
,    [dPersonnel.34]    VARCHAR(255)
,    [dPersonnel.34_NV]    VARCHAR(255)
,    [dPersonnel.36]    VARCHAR(255)
,    [dPersonnel.37]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.09] ( 
    [pk_dPersonnel.09]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.09]    VARCHAR(255)
,    [dPersonnel.09_PhoneNumberType]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.10] ( 
    [pk_dPersonnel.10]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.10]    VARCHAR(255)
,    [dPersonnel.10_EmailAddressType]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.13] ( 
    [pk_dPersonnel.13]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.13]    VARCHAR(255)
,    [dPersonnel.13_NV]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.16] ( 
    [pk_dPersonnel.16]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.16]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.17] ( 
    [pk_dPersonnel.17]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.17]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.ImmunizationsGroup] ( 
    [pk_dPersonnel.ImmunizationsGroup]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.18]    VARCHAR(255)
,    [dPersonnel.19]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.20] ( 
    [pk_dPersonnel.20]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.20]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.LicensureGroup] ( 
    [pk_dPersonnel.LicensureGroup]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.22]    VARCHAR(255)
,    [dPersonnel.22_NV]    VARCHAR(255)
,    [dPersonnel.23]    VARCHAR(255)
,    [dPersonnel.23_NV]    VARCHAR(255)
,    [dPersonnel.24]    VARCHAR(255)
,    [dPersonnel.24_NV]    VARCHAR(255)
,    [dPersonnel.25]    VARCHAR(255)
,    [dPersonnel.26]    VARCHAR(255)
,    [dPersonnel.27]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.35] ( 
    [pk_dPersonnel.35]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.35]    VARCHAR(255)
,    [dPersonnel.35_NV]    VARCHAR(255)
)

CREATE TABLE [dPersonnel.CertificationLevelGroup] ( 
    [pk_dPersonnel.CertificationLevelGroup]    INT PRIMARY KEY,
    [fk_pk_dPersonnel.PersonnelGroup]    INT FOREIGN KEY REFERENCES     [dPersonnel.PersonnelGroup]([pk_dPersonnel.PersonnelGroup])
,    [dPersonnel.38]    VARCHAR(255)
,    [dPersonnel.39]    VARCHAR(255)
)

CREATE TABLE [dDevice.DeviceGroup] ( 
    [pk_dDevice.DeviceGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dDevice.01]    VARCHAR(255)
,    [dDevice.02]    VARCHAR(255)
,    [dDevice.04]    VARCHAR(255)
,    [dDevice.05]    VARCHAR(255)
,    [dDevice.06]    VARCHAR(255)
)

CREATE TABLE [dDevice.03] ( 
    [pk_dDevice.03]    INT PRIMARY KEY,
    [fk_pk_dDevice.DeviceGroup]    INT FOREIGN KEY REFERENCES     [dDevice.DeviceGroup]([pk_dDevice.DeviceGroup])
,    [dDevice.03]    VARCHAR(255)
)

CREATE TABLE [dFacilityGroup] ( 
    [pk_dFacilityGroup]    INT PRIMARY KEY,
    [fk_pk_DemographicReport]    INT FOREIGN KEY REFERENCES     [DemographicReport]([pk_DemographicReport])
,    [dFacility.01]    VARCHAR(255)
)

CREATE TABLE [dFacility.FacilityGroup] ( 
    [pk_dFacility.FacilityGroup]    INT PRIMARY KEY,
    [fk_pk_dFacilityGroup]    INT FOREIGN KEY REFERENCES     [dFacilityGroup]([pk_dFacilityGroup])
,    [dFacility.02]    VARCHAR(255)
,    [dFacility.03]    VARCHAR(255)
,    [dFacility.06]    VARCHAR(255)
,    [dFacility.07]    VARCHAR(255)
,    [dFacility.07_StreetAddress2]    VARCHAR(255)
,    [dFacility.08]    VARCHAR(255)
,    [dFacility.09]    VARCHAR(255)
,    [dFacility.10]    VARCHAR(255)
,    [dFacility.11]    VARCHAR(255)
,    [dFacility.12]    VARCHAR(255)
,    [dFacility.13]    VARCHAR(255)
,    [dFacility.14]    VARCHAR(255)
)

CREATE TABLE [dFacility.04] ( 
    [pk_dFacility.04]    INT PRIMARY KEY,
    [fk_pk_dFacility.FacilityGroup]    INT FOREIGN KEY REFERENCES     [dFacility.FacilityGroup]([pk_dFacility.FacilityGroup])
,    [dFacility.04]    VARCHAR(255)
)

CREATE TABLE [dFacility.05] ( 
    [pk_dFacility.05]    INT PRIMARY KEY,
    [fk_pk_dFacility.FacilityGroup]    INT FOREIGN KEY REFERENCES     [dFacility.FacilityGroup]([pk_dFacility.FacilityGroup])
,    [dFacility.05]    VARCHAR(255)
)

CREATE TABLE [dFacility.15] ( 
    [pk_dFacility.15]    INT PRIMARY KEY,
    [fk_pk_dFacility.FacilityGroup]    INT FOREIGN KEY REFERENCES     [dFacility.FacilityGroup]([pk_dFacility.FacilityGroup])
,    [dFacility.15]    VARCHAR(255)
,    [dFacility.15_PhoneNumberType]    VARCHAR(255)
)

