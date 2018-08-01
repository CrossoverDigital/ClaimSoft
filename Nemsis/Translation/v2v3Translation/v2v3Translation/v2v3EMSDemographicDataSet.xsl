<?xml version="1.0" encoding="UTF-8"?>
<!--

XML Stylesheet Language Transformation (XSLT) to transform NEMSIS v2 EMSDemographicDataSet to NEMSIS v3 DEMDataSet

Version: 3.4.0.160713CP2_171120
Revision Date: January 20, 2017

This product is provided by the NEMIS TAC, without charge, to facilitate a data mapping between
NEMSIS v2.2.1 and NEMSIS v3.4.0. The primary target audiences are state employees maintaining EMS
databases and software developers interested in enhancing the value of legacy data systems. In
most instances, mapping between the two standards is straightforward. For those instances in which
mappings are not direct, the NEMSIS TAC relied on our history and experience to confirm an
approach to mapping. Neither the NEMSIS TAC nor any employees associated with the TAC are
responsible for any perceived "lost data" or "inappropriate" associations detailed in the mapping.
By utilizing this program, users accept the decisions and approach taken to provide this mapping.

-->

<!-- 
Requires version 2.0 of XSLT.
-->
<xsl:transform xmlns="http://www.nemsis.org"
            xmlns:n="http://www.nemsis.org"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            version="2.0"
            exclude-result-prefixes="n xs xsl"
            xpath-default-namespace="http://www.nemsis.org">

  <!-- Import common functions/templates. -->
  <xsl:import href="includes/v2v3Common.xsl"/>

  <!-- Import XPath expression-based value mappings for EMSDemographicDataSet. -->
  <xsl:import href="includes/v2v3ValueMappingEMSDemographicDataSetExpression.xml"/>

  <!-- Strip non-significant whitespace (whitespace-only text nodes) in output. -->
  <xsl:strip-space elements="*"/>

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/EMSDemographicDataSet">

    <xsl:comment>&#32;This NEMSIS 3 file was generated from a NEMSIS 2 file via an XML Stylesheet Language Transformation (XSLT).&#32;</xsl:comment>
    <xsl:text>&#10;</xsl:text>

    <DEMDataSet xsi:schemaLocation="http://www.nemsis.org http://www.nemsis.org/media/nemsis_v3/release-3.4.0/XSDs/NEMSIS_XSDs/DEMDataSet_v3.xsd"  xmlns="http://www.nemsis.org">

      <!-- dState: No mapping. -->

      <dCustomConfiguration>
        <xsl:copy-of select="n:mapCustomConfiguration('d')"/>
      </dCustomConfiguration>

      <DemographicReport>
        <!-- Generate valid v3 timeStamp from D01/@Date. -->
        <xsl:attribute name="timeStamp">
          <xsl:choose>
            <xsl:when test="xs:dateTime(xs:date(D01/@Date))>=xs:dateTime('1950-01-01T00:00:00-00:00')">
              <xsl:value-of select="adjust-dateTime-to-timezone(xs:dateTime(xs:date(D01/@Date)))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'1950-01-01T00:00:00-00:00'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>

        <dAgency>
          <xsl:copy-of select="n:map('dAgency.01', 'D01_01', D01/D01_01)"/>
          <xsl:copy-of select="n:map('dAgency.02', 'D01_01', D01/D01_01)"/>
          <xsl:copy-of select="n:map('dAgency.03', 'D01_02', D01/D01_02)"/>
          <xsl:copy-of select="n:map('dAgency.04', 'D01_03', D01/D01_03)"/>

          <!-- Limitation: If there are any counties (D01_04) that are not within the listed states (D01_03), they will be excluded. -->
          <xsl:for-each select="D01/D01_03">
            <xsl:variable name="D01_03" select="."/>
            <dAgency.AgencyServiceGroup CorrelationID="{concat(generate-id(), '.dAgency.AgencyServiceGroup')}">
              <xsl:copy-of select="n:map('dAgency.05', 'D01_03', .)"/>
              <xsl:copy-of select="n:map('dAgency.06', 'D01_04', ../D01_04[substring(., 1, 2)=$D01_03])"/>
              <dAgency.07 xsi:nil="true" NV="7701003"/>
              <dAgency.08 xsi:nil="true" NV="7701003"/>
            </dAgency.AgencyServiceGroup>
          </xsl:for-each>

          <xsl:copy-of select="n:map('dAgency.09', 'D01_05', D01/D01_05)"/>
          <xsl:copy-of select="n:map('dAgency.10', 'D01_06', D01/D01_06)"/>
          <xsl:copy-of select="n:map('dAgency.11', 'D01_07', D01/D01_07)"/>
          <xsl:copy-of select="n:map('dAgency.12', 'D01_09', D01/D01_09)"/>
          <xsl:copy-of select="n:map('dAgency.13', 'D01_08', D01/D01_08)"/>
          <xsl:copy-of select="n:map('dAgency.14', 'D01_08', D01/D01_08)"/>

          <xsl:for-each select="D01/D01_10_0">
            <dAgency.AgencyYearGroup CorrelationID="{generate-id()}">
              <xsl:copy-of select="n:map('dAgency.15', 'D01_10', D01_10)"/>
              <xsl:copy-of select="n:map('dAgency.16', 'D01_12', D01_12)"/>
              <xsl:copy-of select="n:map('dAgency.17', 'D01_13', D01_13)"/>
              <xsl:copy-of select="n:map('dAgency.18', 'D01_14', D01_14)"/>
              <xsl:copy-of select="n:map('dAgency.19', 'D01_15', D01_15)"/>
              <xsl:copy-of select="n:map('dAgency.20', 'D01_16', D01_16)"/>
              <xsl:copy-of select="n:map('dAgency.21', 'D01_17', D01_17)"/>
              <xsl:copy-of select="n:map('dAgency.22', 'D01_18', D01_18)"/>
            </dAgency.AgencyYearGroup>
          </xsl:for-each>

          <xsl:copy-of select="n:map('dAgency.23', 'D01_19', D01/D01_19)"/>
          <xsl:copy-of select="n:map('dAgency.24', 'D01_20', D01/D01_20)"/>
          <xsl:copy-of select="n:map('dAgency.25', 'D01_21', D01/D01_21)"/>
          <!-- dAgency.26: No mapping. -->
          <dAgency.26 xsi:nil="true" NV="7701003"/>
        </dAgency>

        <dContact>

          <!-- dContact.ContactInfoGroup: Agency Contact. -->
          <dContact.ContactInfoGroup CorrelationID="{generate-id(D02)}">
            <!-- dContact.01: No mapping. -->
            <xsl:copy-of select="n:map('dContact.02', 'D02_01', D02/D02_01_0/D02_01)"/>
            <xsl:copy-of select="n:map('dContact.03', 'D02_03', D02/D02_01_0/D02_03)"/>
            <xsl:copy-of select="n:map('dContact.04', 'D02_02', D02/D02_01_0/D02_02)"/>
            <xsl:copy-of select="n:map('dContact.05', 'D02_04', D02/D02_04_0/D02_04)"/>
            <xsl:copy-of select="n:map('dContact.06', 'D02_05', D02/D02_04_0/D02_05)"/>
            <xsl:copy-of select="n:map('dContact.07', 'D02_06', D02/D02_04_0/D02_06)"/>
            <xsl:copy-of select="n:map('dContact.08', 'D02_07', D02/D02_04_0/D02_07)"/>
            <!-- dContact.09: No mapping. -->

            <!-- dContact.10: Set PhoneNumberType attribute for phone/fax numbers. -->
            <xsl:for-each select="D02/D02_08|D02/D02_09">
              <xsl:element name="dContact.10">
                <xsl:attribute name="PhoneNumberType">
                  <xsl:choose>
                    <!-- D02_09: "Fax". -->
                    <xsl:when test="local-name(.)='D02_09'">9913001</xsl:when>
                    <!-- Otherwise: Assume "Work". -->
                    <xsl:otherwise>9913009</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:copy-of  select="n:map('dContact.10', local-name(.), .)/@*"/>
                <xsl:value-of select="n:map('dContact.10', local-name(.), .)"/>
              </xsl:element>
            </xsl:for-each>

            <!-- dContact.11/@EmailAddressType: No mapping. -->
            <xsl:copy-of select="n:map('dContact.11', 'D02_10', D02/D02_10)"/>
            <xsl:copy-of select="n:map('dContact.12', 'D02_11', D02/D02_11)"/>
            <!-- dContact.EMSMedicalDirectorGroup: No mapping. -->
          </dContact.ContactInfoGroup>

          <!-- dContact.ContactInfoGroup: Agency Medical Director. -->
          <dContact.ContactInfoGroup CorrelationID="{generate-id(D03)}">
            <!-- dContact.01: EMS Medical Director. -->
            <dContact.01>1101011</dContact.01>
            <xsl:copy-of select="n:map('dContact.02', 'D03_01', D03/D03_01_0/D03_01)"/>
            <xsl:copy-of select="n:map('dContact.03', 'D03_03', D03/D03_01_0/D03_03)"/>
            <xsl:copy-of select="n:map('dContact.04', 'D03_02', D03/D03_01_0/D03_02)"/>
            <xsl:copy-of select="n:map('dContact.05', 'D03_04', D03/D03_04_0/D03_04)"/>
            <xsl:copy-of select="n:map('dContact.06', 'D03_05', D03/D03_04_0/D03_05)"/>
            <xsl:copy-of select="n:map('dContact.07', 'D03_06', D03/D03_04_0/D03_06)"/>
            <xsl:copy-of select="n:map('dContact.08', 'D03_07', D03/D03_04_0/D03_07)"/>
            <!-- dContact.09: No mapping. -->

            <!-- dContact.10: Set PhoneNumberType attribute for phone/fax numbers. -->
            <xsl:for-each select="D03/D03_08|D03/D03_09">
              <xsl:element name="dContact.10">
                <xsl:attribute name="PhoneNumberType">
                  <xsl:choose>
                    <!-- D03_09: "Fax". -->
                    <xsl:when test="local-name(.)='D03_09'">9913001</xsl:when>
                    <!-- Otherwise: Assume "Work". -->
                    <xsl:otherwise>9913009</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:copy-of  select="n:map('dContact.10', local-name(.), .)/@*"/>
                <xsl:value-of select="n:map('dContact.10', local-name(.), .)"/>
              </xsl:element>
            </xsl:for-each>

            <!-- dContact.11/@EmailAddressType: No mapping. -->
            <xsl:copy-of select="n:map('dContact.11', 'D03_11', D03/D03_11)"/>
            <!-- dContact.12: No mapping. -->
            <dContact.EMSMedicalDirectorGroup>
              <!-- dContact.13: No mapping. -->
              <xsl:copy-of select="n:map('dContact.14', 'D03_10', D03/D03_10)"/>
              <!-- dContact.15: No mapping. -->
              <!-- dContact.16: No mapping. -->
            </dContact.EMSMedicalDirectorGroup>
          </dContact.ContactInfoGroup>

        </dContact>

        <dConfiguration>
          <xsl:for-each select="D01/D01_03">
            <dConfiguration.ConfigurationGroup CorrelationID="{concat(generate-id(), '.dConfiguration.ConfigurationGroup')}">
              <xsl:copy-of select="n:map('dConfiguration.01', 'D01_03', .)"/>
              <xsl:copy-of select="n:map('dConfiguration.02', 'D04_01', ../../D04/D04_01)"/>
              <!-- dConfiguration.03: No mapping. -->
              <dConfiguration.03 xsi:nil="true" NV="7701003"/>
              <!-- dConfiguration.04: No mapping. -->
              <dConfiguration.04 xsi:nil="true" NV="7701003"/>
              <!-- dConfiguration.05: No mapping. -->
              <dConfiguration.05 xsi:nil="true" NV="7701003"/>

              <xsl:for-each-group select="../../D04/D04_04_0" group-by="D04_05">
                <dConfiguration.ProcedureGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dConfiguration.06', 'D04_05', current-grouping-key())"/>
                  <xsl:copy-of select="n:map('dConfiguration.07', 'D04_04', current-group()/D04_04)"/>
                </dConfiguration.ProcedureGroup>
              </xsl:for-each-group>

              <xsl:if test="../../D04/D04_04_0[not(D04_05)]">
                <dConfiguration.ProcedureGroup>
                  <xsl:copy-of select="n:map('dConfiguration.06', 'D04_05', '')"/>
                  <xsl:copy-of select="n:map('dConfiguration.07', 'D04_04', ../../D04/D04_04_0[not(D04_05)]/D04_04)"/>
                </dConfiguration.ProcedureGroup>
              </xsl:if>

              <xsl:if test="not(../../D04/D04_04_0)">
                <dConfiguration.ProcedureGroup>
                  <xsl:copy-of select="n:map('dConfiguration.06', 'D04_05', '')"/>
                  <xsl:copy-of select="n:map('dConfiguration.07', 'D04_04', '')"/>
                </dConfiguration.ProcedureGroup>
              </xsl:if>

              <xsl:for-each-group select="../../D04/D04_06_0" group-by="D04_07">
                <dConfiguration.MedicationGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dConfiguration.08', 'D04_07', current-grouping-key())"/>
                  <xsl:copy-of select="n:map('dConfiguration.09', 'D04_06', current-group()/D04_06)"/>
                </dConfiguration.MedicationGroup>
              </xsl:for-each-group>

              <xsl:if test="../../D04/D04_06_0[not(D04_07)]">
                <dConfiguration.MedicationGroup>
                  <xsl:copy-of select="n:map('dConfiguration.08', 'D04_07', '')"/>
                  <xsl:copy-of select="n:map('dConfiguration.09', 'D04_06', ../../D04/D04_06_0[not(D04_07)]/D04_06)"/>
                </dConfiguration.MedicationGroup>
              </xsl:if>

              <xsl:if test="not(../../D04/D04_06_0)">
                <dConfiguration.MedicationGroup>
                  <xsl:copy-of select="n:map('dConfiguration.08', 'D04_07', '')"/>
                  <xsl:copy-of select="n:map('dConfiguration.09', 'D04_06', '')"/>
                </dConfiguration.MedicationGroup>
              </xsl:if>

              <xsl:copy-of select="n:map('dConfiguration.10', 'D04_08', ../../D04/D04_08_0/D04_08)"/>
              <!-- dConfiguration.11: No mapping; set to "None". -->
              <dConfiguration.11>1211019</dConfiguration.11>
              <xsl:copy-of select="n:map('dConfiguration.12', 'D04_10', ../../D04/D04_10)"/>
              <!-- dConfiguration.13: No mapping; set to "Yes, 100% of the EMS Agency's Service Area". -->
              <dConfiguration.13>1213003</dConfiguration.13>
              <xsl:copy-of select="n:map('dConfiguration.14', 'D04_17', ../../D04/D04_17)"/>
              <xsl:copy-of select="n:map('dConfiguration.15', 'D04_04', ../../D04/D04_04_0/D04_04)"/>
              <xsl:copy-of select="n:map('dConfiguration.16', 'D04_02', ../../D04/D04_02)"/>
              <!-- dConfiguration.17: No mapping. -->
            </dConfiguration.ConfigurationGroup>
          </xsl:for-each>

        </dConfiguration>

        <dLocation>

          <xsl:for-each select="D05">
            <dLocation.LocationGroup CorrelationID="{generate-id()}">
              <!-- dLocation.01: No mapping. -->
              <xsl:copy-of select="n:map('dLocation.02', 'D05_01', D05_01)"/>
              <xsl:copy-of select="n:map('dLocation.03', 'D05_02', D05_02)"/>
              <xsl:copy-of select="n:map('dLocation.04', 'D05_04', D05_04)"/>
              <!-- dLocation.05: No mapping. -->
              <xsl:copy-of select="n:map('dLocation.06', 'D05_05', D05_05_0/D05_05)"/>
              <xsl:copy-of select="n:map('dLocation.07', 'D05_06', D05_05_0/D05_06)"/>
              <xsl:copy-of select="n:map('dLocation.08', 'D05_07', D05_05_0/D05_07)"/>
              <xsl:copy-of select="n:map('dLocation.09', 'D05_08', D05_05_0/D05_08)"/>
              <!-- dLocation.10: No mapping. -->
              <!-- dLocation.11: No mapping. -->
              <xsl:copy-of select="n:map('dLocation.12', 'D05_09', D05_09)"/>
            </dLocation.LocationGroup>
          </xsl:for-each>

        </dLocation>

        <dVehicle>

          <xsl:for-each select="D06">
            <dVehicle.VehicleGroup CorrelationID="{generate-id()}">
              <xsl:copy-of select="n:map('dVehicle.01', 'D06_01', D06_01)"/>
              <!-- dVehicle.02: No mapping. -->
              <!-- dVehicle.03: No mapping. -->
              <xsl:copy-of select="n:map('dVehicle.04', 'D06_03', D06_03)"/>
              <xsl:for-each select="D06_04_0">
                <dVehicle.VehicleCertificationLevelsGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dVehicle.05', 'D06_04', D06_04)"/>
                  <xsl:copy-of select="n:map('dVehicle.06', 'D06_05', D06_05)"/>
                  <!-- dVehicle.07: No mapping. -->
                  <!-- dVehicle.08: No mapping. -->
                </dVehicle.VehicleCertificationLevelsGroup>
              </xsl:for-each>

              <xsl:copy-of select="n:map('dVehicle.09', 'D06_06', D06_06)"/>
              <xsl:copy-of select="n:map('dVehicle.10', 'D06_07', D06_07)"/>

              <xsl:for-each select="D06_08_0">
                <dVehicle.YearGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dVehicle.11', 'D06_08', D06_08)"/>
                  <xsl:copy-of select="n:map('dVehicle.12', 'D06_09', D06_09)"/>

                  <!-- dVehicle.13/@DistanceUnit: Set to "Miles". -->
                  <xsl:for-each select="n:map('dVehicle.13', 'D06_10', D06_10)">
                    <xsl:element name="dVehicle.13">
                      <xsl:attribute name="DistanceUnit">9929003</xsl:attribute>
                      <xsl:value-of select="."/>
                    </xsl:element>
                  </xsl:for-each>

                </dVehicle.YearGroup>
              </xsl:for-each>

            </dVehicle.VehicleGroup>
          </xsl:for-each>

        </dVehicle>

        <dPersonnel>

          <xsl:for-each select="D07_D08">
            <dPersonnel.PersonnelGroup CorrelationID="{generate-id()}">
              <dPersonnel.NameGroup>
                <xsl:copy-of select="n:map('dPersonnel.01', 'D08_01', D08/D08_01_0/D08_01)"/>
                <xsl:copy-of select="n:map('dPersonnel.02', 'D08_03', D08/D08_01_0/D08_03)"/>
                <xsl:copy-of select="n:map('dPersonnel.03', 'D08_02', D08/D08_01_0/D08_02)"/>
              </dPersonnel.NameGroup>
              <dPersonnel.AddressGroup>
                <xsl:copy-of select="n:map('dPersonnel.04', 'D08_04', D08/D08_04_0/D08_04)"/>
                <xsl:copy-of select="n:map('dPersonnel.05', 'D08_05', D08/D08_04_0/D08_05)"/>
                <xsl:copy-of select="n:map('dPersonnel.06', 'D08_06', D08/D08_04_0/D08_06)"/>
                <xsl:copy-of select="n:map('dPersonnel.07', 'D08_07', D08/D08_04_0/D08_07)"/>
                <!-- dPersonnel.08: No mapping. -->
              </dPersonnel.AddressGroup>
              <!-- dPersonnel.09/@PhoneNumberType: No mapping. -->
              <xsl:copy-of select="n:map('dPersonnel.09', 'D08_09', D08/D08_09)"/>
              <!-- dPersonnel.10/@EmailAddressType: No mapping. -->
              <xsl:copy-of select="n:map('dPersonnel.10', 'D08_10', D08/D08_10)"/>
              <xsl:copy-of select="n:map('dPersonnel.11', 'D08_11', D08/D08_11)"/>
              <xsl:copy-of select="n:map('dPersonnel.12', 'D08_12', D08/D08_12)"/>
              <xsl:copy-of select="n:map('dPersonnel.13', 'D08_13', D08/D08_13)"/>
              <xsl:copy-of select="n:map('dPersonnel.13', 'D08_14', D08/D08_14)"/>
              <!-- dPersonnel.14: No mapping. -->
              <!-- dPersonnel.15: No mapping. -->
              <!-- dPersonnel.16: No mapping. -->
              <!-- dPersonnel.17: No mapping. -->
              <!-- dPersonnel.ImmunizationsGroup: No mapping. -->
              <!-- dPersonnel.20: No mapping. -->
              <xsl:copy-of select="n:map('dPersonnel.21', 'D07_01', D07/D07_01)"/>
              <dPersonnel.LicensureGroup CorrelationID="{concat(generate-id(), '.dPersonnel.LicensureGroup')}">
                <!-- dPersonnel.22: No mapping. -->
                <xsl:copy-of select="n:map('dPersonnel.23', 'D07_02', D07/D07_02|D08/D07_02)"/>
                <xsl:copy-of select="n:map('dPersonnel.24', 'D08_15', D08/D08_15_0/D08_15)"/>
                <xsl:copy-of select="n:map('dPersonnel.25', 'D08_17', D08/D08_15_0/D08_17)"/>
                <xsl:copy-of select="n:map('dPersonnel.26', 'D08_18', D08/D08_15_0/D08_18)"/>
                <!-- dPersonnel.27: No mapping. -->
              </dPersonnel.LicensureGroup>
              <!-- dPersonnel.28: No mapping. -->
              <!-- dPersonnel.29: No mapping. -->
              <!-- dPersonnel.30: No mapping. -->
              <xsl:copy-of select="n:map('dPersonnel.31', 'D07_03', D07/D07_03_0/D07_03)"/>
              <xsl:copy-of select="n:map('dPersonnel.32', 'D07_04', D07/D07_03_0/D07_04)"/>
              <!-- dPersonnel.33: No mapping. -->
              <!-- dPersonnel.34: No mapping. -->
              <!-- dPersonnel.35: No mapping. -->
              <xsl:copy-of select="n:map('dPersonnel.36', 'D08_19', D08/D08_19_0/D08_19)"/>
              <xsl:copy-of select="n:map('dPersonnel.37', 'D08_20', D08/D08_19_0/D08_20)"/>

              <xsl:for-each select="D07/D07_05_0">
                <dPersonnel.CertificationLevelGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dPersonnel.38', 'D07_05', D07_05)"/>
                  <xsl:copy-of select="n:map('dPersonnel.39', 'D07_06', D07_06)"/>
                </dPersonnel.CertificationLevelGroup>
              </xsl:for-each>

            </dPersonnel.PersonnelGroup>
          </xsl:for-each>

        </dPersonnel>

        <dDevice>

          <xsl:for-each select="D09">
            <dDevice.DeviceGroup CorrelationID="{generate-id()}">
              <xsl:copy-of select="n:map('dDevice.01', 'D09_01', D09_01)"/>
              <xsl:copy-of select="n:map('dDevice.02', 'D09_02', D09_02)"/>
              <!-- dDevice.03: No mapping. -->
              <xsl:copy-of select="n:map('dDevice.04', 'D09_03', D09_03)"/>
              <xsl:copy-of select="n:map('dDevice.05', 'D09_04', D09_04)"/>
              <xsl:copy-of select="n:map('dDevice.06', 'D09_05', D09_05)"/>
            </dDevice.DeviceGroup>
          </xsl:for-each>

        </dDevice>

        <dFacility>

          <!-- Hospitals Served. -->
          <xsl:if test="D04/D04_11_0">
            <dFacilityGroup CorrelationID="{concat(generate-id(), '.dFacilityGroup.1')}">
              <!-- dFacility.01: Set to "Hospital". -->
              <dFacility.01>1701005</dFacility.01>

              <xsl:for-each select="D04/D04_11_0">
                <dFacility.FacilityGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dFacility.02', 'D04_11', D04_11)"/>
                  <xsl:copy-of select="n:map('dFacility.03', 'D04_12', D04_12)"/>
                  <!-- dFacility.04: No mapping. -->
                  <!-- dFacility.05: No mapping. -->
                  <!-- dFacility.06: No mapping. -->
                  <!-- dFacility.07: No mapping. -->
                  <!-- dFacility.08: No mapping. -->
                  <!-- dFacility.09: No mapping. -->
                  <!-- dFacility.10: No mapping. -->
                  <!-- dFacility.11: No mapping. -->
                  <!-- dFacility.12: No mapping. -->
                  <!-- dFacility.13: No mapping. -->
                  <!-- dFacility.14: No mapping. -->
                </dFacility.FacilityGroup>
              </xsl:for-each>

            </dFacilityGroup>
          </xsl:if>

          <!-- Other Destinations. If there are any Other Destinations with a Destination Type of Hospital, another dFacilityGroup with a Facility Type of Hospital will be created. -->
          <xsl:for-each-group select="D04/D04_13_0" group-by="D04_15">
            <dFacilityGroup CorrelationID="{generate-id(D04_15)}">
              <xsl:copy-of select="n:map('dFacility.01', 'D04_15', current-grouping-key())"/>

              <xsl:for-each select="current-group()">
                <dFacility.FacilityGroup CorrelationID="{generate-id()}">
                  <xsl:copy-of select="n:map('dFacility.02', 'D04_13', D04_13)"/>
                  <xsl:copy-of select="n:map('dFacility.03', 'D04_14', D04_14)"/>
                  <!-- dFacility.04: No mapping. -->
                  <!-- dFacility.05: No mapping. -->
                  <!-- dFacility.06: No mapping. -->
                  <!-- dFacility.07: No mapping. -->
                  <!-- dFacility.08: No mapping. -->
                  <!-- dFacility.09: No mapping. -->
                  <!-- dFacility.10: No mapping. -->
                  <!-- dFacility.11: No mapping. -->
                  <!-- dFacility.12: No mapping. -->
                  <!-- dFacility.13: No mapping. -->
                  <!-- dFacility.14: No mapping. -->
                </dFacility.FacilityGroup>
              </xsl:for-each>

            </dFacilityGroup>
          </xsl:for-each-group>

        </dFacility>

        <dCustomResults>

          <dCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('dCustomResults.01', 'D01_11', D01/D01_11)"/>
            <dCustomResults.02>D01_11</dCustomResults.02>
            <!-- dCustomResults.03: No mapping. -->
          </dCustomResults.ResultsGroup>

          <dCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('dCustomResults.01', 'D04_03', D04/D04_03)"/>
            <dCustomResults.02>D04_03</dCustomResults.02>
            <!-- dCustomResults.03: No mapping. -->
          </dCustomResults.ResultsGroup>

          <xsl:for-each-group select="D04/D04_04_0" group-by="D04_05">
            <dCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('dCustomResults.01', 'D04_04', current-group()/D04_04)"/>
              <dCustomResults.02>D04_04</dCustomResults.02>
              <dCustomResults.03><xsl:value-of select="generate-id()"/></dCustomResults.03>
            </dCustomResults.ResultsGroup>
          </xsl:for-each-group>

          <xsl:for-each select="D04/D04_08_0">
            <dCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('dCustomResults.01', 'D04_09', D04_09)"/>
              <dCustomResults.02>D04_09</dCustomResults.02>
              <dCustomResults.03><xsl:value-of select="generate-id(D04_08)"/></dCustomResults.03>
            </dCustomResults.ResultsGroup>
          </xsl:for-each>

          <dCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('dCustomResults.01', 'D04_16', D04/D04_16)"/>
            <dCustomResults.02>D04_16</dCustomResults.02>
            <!-- dCustomResults.03: No mapping. -->
          </dCustomResults.ResultsGroup>

          <xsl:for-each select="D05/D05_03">
            <dCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('dCustomResults.01', 'D05_03', .)"/>
              <dCustomResults.02>D05_03</dCustomResults.02>
              <dCustomResults.03><xsl:value-of select="generate-id(..)"/></dCustomResults.03>
            </dCustomResults.ResultsGroup>
          </xsl:for-each>

          <xsl:for-each select="D07_D08/D08/D08_15_0/D08_16">
            <dCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('dCustomResults.01', 'D08_16', .)"/>
              <dCustomResults.02>D08_16</dCustomResults.02>
              <dCustomResults.03><xsl:value-of select="concat(generate-id(../../..), '.dPersonnel.LicensureGroup')"/></dCustomResults.03>
            </dCustomResults.ResultsGroup>
          </xsl:for-each>

        </dCustomResults>

      </DemographicReport>

    </DEMDataSet>

  </xsl:template>

  <xsl:template match="/*[name()!='EMSDemographicDataSet']">
    <xsl:comment>
      XML Stylesheet Language Transformation (XSLT) to transform NEMSIS v2 EMSDemographicDataSet to NEMSIS v3 DEMDataSet:
      An attempt was made to transform a dataset that is not a NEMSIS 2 EMSDemographicDataSet.
    </xsl:comment>
  </xsl:template>

</xsl:transform>