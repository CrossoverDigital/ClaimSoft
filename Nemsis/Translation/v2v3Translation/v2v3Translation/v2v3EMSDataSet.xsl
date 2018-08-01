<?xml version="1.0" encoding="UTF-8"?>
<!--

XML Stylesheet Language Transformation (XSLT) to transform NEMSIS v2 EMSDataSet to NEMSIS v3 EMSDataSet

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
  <xsl:import href="includes/v2v3ValueMappingEMSDataSetExpression.xml"/>

  <!-- Strip non-significant whitespace (whitespace-only text nodes) in output. -->
  <xsl:strip-space elements="*"/>

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/EMSDataSet">

    <xsl:comment>&#32;This NEMSIS 3 file was generated from a NEMSIS 2 file via an XML Stylesheet Language Transformation (XSLT).&#32;</xsl:comment>
    <xsl:text>&#10;</xsl:text>

    <EMSDataSet xsi:schemaLocation="http://www.nemsis.org http://www.nemsis.org/media/nemsis_v3/release-3.4.0/XSDs/NEMSIS_XSDs/EMSDataSet_v3.xsd"  xmlns="http://www.nemsis.org">

      <!-- eState: No mapping. -->
      
      <xsl:apply-templates select="Header"/>
        
    </EMSDataSet>
      
  </xsl:template>

  <xsl:template match="Header">
  
    <Header>

        <DemographicGroup>
          <xsl:copy-of select="n:map('dAgency.01', 'D01_01', D01_01)"/>
          <xsl:copy-of select="n:map('dAgency.02', 'D01_01', D01_01)"/>
          <xsl:copy-of select="n:map('dAgency.04', 'D01_03', D01_03)"/>
        </DemographicGroup>

        <eCustomConfiguration>
          <xsl:copy-of select="n:mapCustomConfiguration('e')"/>
      
          <!-- For each distinct value of E23_11, create an eCustomConfiguration.CustomGroup. -->
          <xsl:for-each-group select="Record/E23/E23_09_0" group-by="E23_11">
            <eCustomConfiguration.CustomGroup CustomElementID="{generate-id()}">
              <xsl:copy-of select="n:map('eCustomConfiguration.01', 'E23_11', current-group()/E23_11)"/>
              <eCustomConfiguration.02>A NEMSIS version 2 research element.</eCustomConfiguration.02>
              <eCustomConfiguration.03>9902009</eCustomConfiguration.03>
              <eCustomConfiguration.04>9923003</eCustomConfiguration.04>
              <eCustomConfiguration.05>9903007</eCustomConfiguration.05>
              <eCustomConfiguration.07>7701001</eCustomConfiguration.07>
              <eCustomConfiguration.07>7701003</eCustomConfiguration.07>
              <eCustomConfiguration.07>7701005</eCustomConfiguration.07>
            </eCustomConfiguration.CustomGroup>
          </xsl:for-each-group>

          <!-- If any E23_09_0 are missing E23_11, create an eCustomConfiguration.CustomGroup for those. -->
          <xsl:if test="Record/E23/E23_09_0[not(E23_11)]">
            <eCustomConfiguration.CustomGroup CustomElementID="{concat(generate-id(), '.eCustomResults.ResultsGroup')}">
              <xsl:copy-of select="n:map('eCustomConfiguration.01', 'E23_11', '')"/>
              <eCustomConfiguration.02>A NEMSIS version 2 research element with a title that is missing.</eCustomConfiguration.02>
              <eCustomConfiguration.03>9902009</eCustomConfiguration.03>
              <eCustomConfiguration.04>9923003</eCustomConfiguration.04>
              <eCustomConfiguration.05>9903007</eCustomConfiguration.05>
              <eCustomConfiguration.07>7701001</eCustomConfiguration.07>
              <eCustomConfiguration.07>7701003</eCustomConfiguration.07>
              <eCustomConfiguration.07>7701005</eCustomConfiguration.07>
            </eCustomConfiguration.CustomGroup>
          </xsl:if>
          
        </eCustomConfiguration>

        <xsl:apply-templates select="Record"/>
      
      </Header>
      
  </xsl:template>
    
  <xsl:template match="Record">

        <PatientCareReport>
          
          <eRecord>
            <xsl:copy-of select="n:map('eRecord.01', 'E01_01', E01/E01_01)"/>
            <eRecord.SoftwareApplicationGroup>
              <xsl:copy-of select="n:map('eRecord.02', 'E01_02', E01/E01_02)"/>
              <xsl:copy-of select="n:map('eRecord.03', 'E01_03', E01/E01_03)"/>
              <xsl:copy-of select="n:map('eRecord.04', 'E01_04', E01/E01_04)"/>
            </eRecord.SoftwareApplicationGroup>
          </eRecord>
            
          <eResponse>
            <eResponse.AgencyGroup>
              <xsl:copy-of select="n:map('eResponse.01', 'E02_01', E02/E02_01)"/>
              <!-- eResponse.02: No mapping. -->
            </eResponse.AgencyGroup>
            <xsl:copy-of select="n:map('eResponse.03', 'E02_02', E02/E02_02)"/>
            <xsl:copy-of select="n:map('eResponse.04', 'E02_03', E02/E02_03)"/>
            <eResponse.ServiceGroup>
              <xsl:copy-of select="n:map('eResponse.05', 'E02_04', E02/E02_04)"/>
              <!-- eResponse.06: No mapping. -->
            </eResponse.ServiceGroup>
            <xsl:copy-of select="n:map('eResponse.07', 'E02_05', E02/E02_05)"/>
            <xsl:copy-of select="n:map('eResponse.08', 'E02_06', E02/E02_06)"/>
            <xsl:copy-of select="n:map('eResponse.09', 'E02_07', E02/E02_07)"/>
            <xsl:copy-of select="n:map('eResponse.10', 'E02_08', E02/E02_08)"/>
            <xsl:copy-of select="n:map('eResponse.11', 'E02_09', E02/E02_09)"/>
            <xsl:copy-of select="n:map('eResponse.12', 'E02_10', E02/E02_10)"/>
            <xsl:copy-of select="n:map('eResponse.13', 'E02_11', E02/E02_11)"/>
            <xsl:copy-of select="n:map('eResponse.14', 'E02_12', E02/E02_12)"/>

            <!-- eResponse.15: First try to map from highest of E04_03; otherwise, map from D01_07. -->
            <xsl:variable name="E04_03">
              <xsl:perform-sort select="E04/E04_03">
                <xsl:sort select="." order="descending"/>
              </xsl:perform-sort>
            </xsl:variable>
            <xsl:variable name="eResponse.15" select="n:map('eResponse.15', 'E04_03', $E04_03/E04_03)"/>
            <xsl:choose>
              <xsl:when test="$eResponse.15"><xsl:copy-of select="$eResponse.15"/></xsl:when>
              <xsl:otherwise><xsl:copy-of select="n:map('eResponse.15', 'D01_07', ../D01_07)"/></xsl:otherwise>  
            </xsl:choose>
            
            <xsl:copy-of select="n:map('eResponse.16', 'E02_13', E02/E02_13)"/>
            <xsl:copy-of select="n:map('eResponse.17', 'E02_15', E02/E02_15)"/>
            <!-- eResponse.18: No mapping. -->
            <xsl:copy-of select="n:map('eResponse.19', 'E02_16', E02/E02_16)"/>
            <xsl:copy-of select="n:map('eResponse.20', 'E02_17', E02/E02_17)"/>
            <xsl:copy-of select="n:map('eResponse.21', 'E02_18', E02/E02_18)"/>
            <xsl:copy-of select="n:map('eResponse.22', 'E02_19', E02/E02_19)"/>
            <xsl:copy-of select="n:map('eResponse.23', 'E02_20', E02/E02_20)"/>
            <xsl:copy-of select="n:map('eResponse.24', 'E02_20', E02/E02_20)"/>
          </eResponse>
              
          <eDispatch>
            <xsl:copy-of select="n:map('eDispatch.01', 'E03_01', E03/E03_01)"/>
            <xsl:copy-of select="n:map('eDispatch.02', 'E03_02', E03/E03_02)"/>
            <xsl:copy-of select="n:map('eDispatch.03', 'E03_03', E03/E03_03)"/>
            <!-- eDispatch.04: No mapping. -->
            <xsl:copy-of select="n:map('eDispatch.05', 'E03_03', E03/E03_03)"/>
          </eDispatch>

          <eCrew>

            <xsl:for-each select="E04">
              <eCrew.CrewGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eCrew.01', 'E04_01', E04_01)"/>
                <xsl:copy-of select="n:map('eCrew.02', 'E04_03', E04_03)"/>
                <xsl:copy-of select="n:map('eCrew.03', 'E04_02', E04_02)"/>
              </eCrew.CrewGroup>
            </xsl:for-each>

          </eCrew>

          <eTimes>
            <xsl:copy-of select="n:map('eTimes.01', 'E05_02', E05/E05_02)"/>
            <xsl:copy-of select="n:map('eTimes.02', 'E05_03', E05/E05_03)"/>
            <xsl:copy-of select="n:map('eTimes.03', 'E05_04', E05/E05_04)"/>
            <!-- eTimes.04: No mapping. -->
            <xsl:copy-of select="n:map('eTimes.05', 'E05_05', E05/E05_05)"/>
            <xsl:copy-of select="n:map('eTimes.06', 'E05_06', E05/E05_06)"/>
            <xsl:copy-of select="n:map('eTimes.07', 'E05_07', E05/E05_07)"/>
            <xsl:copy-of select="n:map('eTimes.08', 'E05_08', E05/E05_08)"/>
            <xsl:copy-of select="n:map('eTimes.09', 'E05_09', E05/E05_09)"/>
            <!-- eTimes.10: No mapping. -->
            <xsl:copy-of select="n:map('eTimes.11', 'E05_10', E05/E05_10)"/>
            <!-- eTimes.12: No mapping. -->
            <eTimes.12 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eTimes.13', 'E05_11', E05/E05_11)"/>
            <xsl:copy-of select="n:map('eTimes.14', 'E05_12', E05/E05_12)"/>
            <xsl:copy-of select="n:map('eTimes.15', 'E05_13', E05/E05_13)"/>
            <!-- eTimes.16: No mapping. -->
          </eTimes>
          <ePatient>
            <!-- ePatient.01: No mapping. -->
            <ePatient.PatientNameGroup>
              <xsl:copy-of select="n:map('ePatient.02', 'E06_01', E06/E06_01_0/E06_01)"/>
              <xsl:copy-of select="n:map('ePatient.03', 'E06_02', E06/E06_01_0/E06_02)"/>
              <xsl:copy-of select="n:map('ePatient.04', 'E06_03', E06/E06_01_0/E06_03)"/>
            </ePatient.PatientNameGroup>
            <!-- ePatient.05/@StreetAddress2: No mapping. -->
            <xsl:copy-of select="n:map('ePatient.05', 'E06_04', E06/E06_04_0/E06_04)"/>
            <xsl:copy-of select="n:map('ePatient.06', 'E06_05', E06/E06_04_0/E06_05)"/>
            <xsl:copy-of select="n:map('ePatient.07', 'E06_06', E06/E06_06)"/>
            <xsl:copy-of select="n:map('ePatient.08', 'E06_07', E06/E06_04_0/E06_07)"/>
            <xsl:copy-of select="n:map('ePatient.09', 'E06_08', E06/E06_04_0/E06_08)"/>
            <xsl:copy-of select="n:map('ePatient.10', 'E06_09', E06/E06_09)"/>
            <!-- ePatient.11: No mapping. -->
            <xsl:copy-of select="n:map('ePatient.12', 'E06_10', E06/E06_10)"/>
            <xsl:copy-of select="n:map('ePatient.13', 'E06_11', E06/E06_11)"/>
            <xsl:copy-of select="n:map('ePatient.14', 'E06_12', E06/E06_12)"/>
            <xsl:copy-of select="n:map('ePatient.14', 'E06_13', E06/E06_13)"/>
            <ePatient.AgeGroup>
              <xsl:copy-of select="n:map('ePatient.15', 'E06_14', E06/E06_14_0/E06_14)"/>
              <xsl:copy-of select="n:map('ePatient.16', 'E06_15', E06/E06_14_0/E06_15)"/>
            </ePatient.AgeGroup>
            <xsl:copy-of select="n:map('ePatient.17', 'E06_16', E06/E06_16)"/>
            <!-- ePatient.18/@PhoneNumberType: No mapping. -->
            <xsl:copy-of select="n:map('ePatient.18', 'E06_17', E06/E06_17)"/>
            <!-- ePatient.19: No mapping. -->
            <xsl:copy-of select="n:map('ePatient.20', 'E06_18', E06/E06_19_0/E06_18)"/>
            <xsl:copy-of select="n:map('ePatient.21', 'E06_19', E06/E06_19_0/E06_19)"/>
          </ePatient>

          <ePayment>
            <xsl:copy-of select="n:map('ePayment.01', 'E07_01', E07/E07_01)"/>
            <ePayment.CertificateGroup>
              <xsl:copy-of select="n:map('ePayment.02', 'E07_02', E07/E07_02)"/>
              <!-- ePayment.03: No mapping. -->
              <!-- ePayment.04: No mapping. -->
              <!-- ePayment.05: No mapping. -->
              <!-- ePayment.06: No mapping. -->
              <!-- ePayment.07: No mapping. -->
            </ePayment.CertificateGroup>
            <!-- ePayment.08: No mapping. -->

            <xsl:for-each select="E07/E07_03_0">
              <ePayment.InsuranceGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('ePayment.09', 'E07_03', E07_03)"/>
                <!-- ePayment.10: No mapping. -->
                <xsl:copy-of select="n:map('ePayment.11', 'E07_04', E07_04)"/>
              <!-- ePayment.12/@StreetAddress2: No mapping. -->
                <xsl:copy-of select="n:map('ePayment.12', 'E07_05', E07_05_0/E07_05)"/>
                <xsl:copy-of select="n:map('ePayment.13', 'E07_06', E07_05_0/E07_06)"/>
                <xsl:copy-of select="n:map('ePayment.14', 'E07_07', E07_05_0/E07_07)"/>
                <xsl:copy-of select="n:map('ePayment.15', 'E07_08', E07_05_0/E07_08)"/>
                <!-- ePayment.16: No mapping. -->
                <xsl:copy-of select="n:map('ePayment.17', 'E07_09', E07_09)"/>
                <xsl:copy-of select="n:map('ePayment.18', 'E07_10', E07_10)"/>
                <xsl:copy-of select="n:map('ePayment.19', 'E07_11', E07_11_0/E07_11)"/>
                <xsl:copy-of select="n:map('ePayment.20', 'E07_12', E07_11_0/E07_12)"/>
                <xsl:copy-of select="n:map('ePayment.21', 'E07_13', E07_13)"/>
                <xsl:copy-of select="n:map('ePayment.22', 'E07_14', E07_14)"/>
              </ePayment.InsuranceGroup>
            </xsl:for-each>
              
            <ePayment.ClosestRelativeGroup>
              <xsl:copy-of select="n:map('ePayment.23', 'E07_18', E07/E07_18_0/E07_18_01/E07_18)"/>
              <xsl:copy-of select="n:map('ePayment.24', 'E07_19', E07/E07_18_0/E07_18_01/E07_19)"/>
              <xsl:copy-of select="n:map('ePayment.25', 'E07_20', E07/E07_18_0/E07_18_01/E07_20)"/>
              <!-- ePayment.26/@StreetAddress2: No mapping. -->
              <xsl:copy-of select="n:map('ePayment.26', 'E07_21', E07/E07_18_0/E07_21_0/E07_21)"/>
              <xsl:copy-of select="n:map('ePayment.27', 'E07_22', E07/E07_18_0/E07_21_0/E07_22)"/>
              <xsl:copy-of select="n:map('ePayment.28', 'E07_23', E07/E07_18_0/E07_21_0/E07_23)"/>
              <xsl:copy-of select="n:map('ePayment.29', 'E07_24', E07/E07_18_0/E07_21_0/E07_24)"/>
              <!-- ePayment.30: No mapping. -->
              <!-- ePayment.31/@PhoneNumberType: No mapping. -->
              <xsl:copy-of select="n:map('ePayment.31', 'E07_25', E07/E07_18_0/E07_25)"/>
              <xsl:copy-of select="n:map('ePayment.32', 'E07_26', E07/E07_18_0/E07_26)"/>
            </ePayment.ClosestRelativeGroup>
            <ePayment.EmployerGroup>
              <xsl:copy-of select="n:map('ePayment.33', 'E07_27', E07/E07_27_0/E07_27)"/>
              <!-- ePayment.34/@StreetAddress2: No mapping. -->
              <xsl:copy-of select="n:map('ePayment.34', 'E07_28', E07/E07_27_0/E07_28_0/E07_28)"/>
              <xsl:copy-of select="n:map('ePayment.35', 'E07_29', E07/E07_27_0/E07_28_0/E07_29)"/>
              <xsl:copy-of select="n:map('ePayment.36', 'E07_30', E07/E07_27_0/E07_28_0/E07_30)"/>
              <xsl:copy-of select="n:map('ePayment.37', 'E07_31', E07/E07_27_0/E07_28_0/E07_31)"/>
              <!-- ePayment.38: No mapping. -->
              <!-- ePayment.39/@PhoneNumberType: No mapping. -->
              <xsl:copy-of select="n:map('ePayment.39', 'E07_32', E07/E07_32)"/>
            </ePayment.EmployerGroup>
            <xsl:copy-of select="n:map('ePayment.40', 'E07_33', E07/E07_33)"/>
            <!-- ePayment.41: No mapping. -->
            <!-- ePayment.42: No mapping. -->
            <!-- ePayment.43: No mapping. -->
            <!-- ePayment.44: No mapping. -->
            <!-- ePayment.45: No mapping. -->
            <!-- ePayment.46: No mapping. -->
            <!-- ePayment.47: No mapping. -->
            <!-- ePayment.48: No mapping. -->
            <!-- ePayment.49: No mapping. -->
            <xsl:copy-of select="n:map('ePayment.50', 'E07_34', E07/E07_34)"/>
            <xsl:copy-of select="n:map('ePayment.51', 'E07_35', E07/E07_35_0/E07_35)"/>
            <xsl:copy-of select="n:map('ePayment.52', 'E07_35', E07/E07_35_0/E07_35)"/>
            <xsl:copy-of select="n:map('ePayment.52', 'E07_37', E07/E07_37)"/>
            <!-- ePayment.53: No mapping. -->
            <!-- ePayment.54: No mapping. -->
            <!-- ePayment.SupplyItemGroup: No mapping. -->
          </ePayment>

          <eScene>
            <!-- eScene.01: No mapping. -->
            <eScene.01 xsi:nil="true" NV="7701003"/>

            <!-- eScene.ResponderGroup: Other EMS Agencies as Scene. -->
            <xsl:for-each select="E08/E08_01">
              <eScene.ResponderGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eScene.02', 'E08_01', .)"/>
                <!-- eScene.03: No mapping. -->
                <!-- eScene.04: Set to "Other EMS Agency". -->
                <eScene.04>2704013</eScene.04>
              </eScene.ResponderGroup>
            </xsl:for-each>
              
            <!-- eScene.ResponderGroup: Other Services at Scene. -->
            <xsl:for-each select="E08/E08_02">
              <eScene.ResponderGroup>
                <!-- eScene.02: No mapping. -->
                <!-- eScene.03: No mapping. -->
                <xsl:copy-of select="n:map('eScene.04', 'E08_02', .)"/>
              </eScene.ResponderGroup>
            </xsl:for-each>
              
            <xsl:copy-of select="n:map('eScene.05', 'E08_04', E08/E08_04)"/>
            <xsl:copy-of select="n:map('eScene.06', 'E08_05', E08/E08_05)"/>
            <xsl:copy-of select="n:map('eScene.07', 'E08_06', E08/E08_06)"/>
            <!-- eScene.08: No mapping. -->
            <eScene.08 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eScene.09', 'E08_07', E08/E08_07)"/>
            <xsl:copy-of select="n:map('eScene.10', 'E08_08', E08/E08_08)"/>
            <xsl:copy-of select="n:map('eScene.11', 'E08_10', E08/E08_10)"/>
            <!-- eScene.12: No mapping. -->
            <!-- eScene.13: No mapping. -->
            <!-- eScene.14: No mapping. -->
            <!-- eScene.15/@StreetAddress2: No mapping. -->
            <xsl:copy-of select="n:map('eScene.15', 'E08_11', E08/E08_11_0/E08_11)"/>
            <!-- eScene.16: No mapping. -->
            <xsl:copy-of select="n:map('eScene.17', 'E08_12', E08/E08_11_0/E08_12)"/>
            <xsl:copy-of select="n:map('eScene.18', 'E08_14', E08/E08_11_0/E08_14)"/>
            <xsl:copy-of select="n:map('eScene.19', 'E08_15', E08/E08_11_0/E08_15)"/>
            <!-- eScene.20: No mapping. -->
            <xsl:copy-of select="n:map('eScene.21', 'E08_13', E08/E08_13)"/>
            <!-- eScene.22: No mapping. -->
            <!-- eScene.23: No mapping. -->
          </eScene>

          <eSituation>
            <xsl:copy-of select="n:map('eSituation.01', 'E05_01', E05/E05_01)"/>
            <xsl:copy-of select="n:map('eSituation.02', 'E09_04', E09/E09_04)"/>

            <!-- eSituation.PatientComplaintGroup: Chief Complaint. -->
            <eSituation.PatientComplaintGroup CorrelationID="{generate-id(E09/E09_05)}">
              <!-- eSituation.03: Set to Chief (Primary). -->
              <eSituation.03>2803001</eSituation.03>
              <xsl:copy-of select="n:map('eSituation.04', 'E09_05', E09/E09_05)"/>
              <xsl:copy-of select="n:map('eSituation.05', 'E09_06', E09/E09_06_0/E09_06)"/>
              <xsl:copy-of select="n:map('eSituation.06', 'E09_07', E09/E09_06_0/E09_07)"/>
            </eSituation.PatientComplaintGroup>

            <!-- eSituation.PatientComplaintGroup: Secondary Complaint. -->
            <eSituation.PatientComplaintGroup CorrelationID="{generate-id(E09/E09_08)}">
              <!-- eSituation.03: Set to Secondary. -->
              <eSituation.03>2803005</eSituation.03>
              <xsl:copy-of select="n:map('eSituation.04', 'E09_08', E09/E09_08)"/>
              <xsl:copy-of select="n:map('eSituation.05', 'E09_09', E09/E09_09_0/E09_09)"/>
              <xsl:copy-of select="n:map('eSituation.06', 'E09_10', E09/E09_09_0/E09_10)"/>
            </eSituation.PatientComplaintGroup>

            <xsl:copy-of select="n:map('eSituation.07', 'E09_11', E09/E09_11)"/>
            <xsl:copy-of select="n:map('eSituation.08', 'E09_12', E09/E09_12)"/>
            <xsl:copy-of select="n:map('eSituation.09', 'E09_13', E09/E09_13)"/>
            <xsl:copy-of select="n:map('eSituation.10', 'E09_14', E09/E09_14)"/>
            <xsl:copy-of select="n:map('eSituation.11', 'E09_15', E09/E09_15)"/>
            <xsl:copy-of select="n:map('eSituation.12', 'E09_16', E09/E09_16)"/>
            <eSituation.13>2813003</eSituation.13>
            <eSituation.WorkRelatedGroup>
              <eSituation.14>9922005</eSituation.14>
              <eSituation.15>2815023</eSituation.15>
              <eSituation.16>2816039</eSituation.16>
            </eSituation.WorkRelatedGroup>
            <eSituation.17>Y93.75</eSituation.17>
          </eSituation>

          <eInjury>
            <xsl:copy-of select="n:map('eInjury.01', 'E10_01', E10/E10_01)"/>
            <xsl:copy-of select="n:map('eInjury.02', 'E10_03', E10/E10_03)"/>
            <!-- eInjury.03: No mapping. -->
            <eInjury.03 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eInjury.04', 'E10_04', E10/E10_04)"/>
            <xsl:copy-of select="n:map('eInjury.05', 'E10_05', E10/E10_05)"/>
            <xsl:copy-of select="n:map('eInjury.06', 'E10_07', E10/E10_06_0/E10_07)"/>
            <xsl:copy-of select="n:map('eInjury.07', 'E10_08', E10/E10_08)"/>
            <xsl:copy-of select="n:map('eInjury.08', 'E10_09', E10/E10_09)"/>
            <xsl:copy-of select="n:map('eInjury.09', 'E10_10', E10/E10_10)"/>
            <!-- eInjury.10: No mapping. -->
            <!-- eInjury.CollisionGroup: No mapping. -->
          </eInjury>

          <eArrest>
            <xsl:copy-of select="n:map('eArrest.01', 'E11_01', E11/E11_01)"/>
            <xsl:copy-of select="n:map('eArrest.02', 'E11_02', E11/E11_02)"/>
            <xsl:copy-of select="n:map('eArrest.03', 'E11_03', E11/E11_03)"/>
            <xsl:copy-of select="n:map('eArrest.04', 'E11_04', E11/E11_04)"/>
            <!-- eArrest.05: No mapping. -->
            <eArrest.05 xsi:nil="true" NV="7701003"/>
            <!-- eArrest.06: No mapping. -->
            <!-- eArrest.07: No mapping. -->
            <eArrest.07 xsi:nil="true" NV="7701003"/>
            <!-- eArrest.08: No mapping. -->
            <xsl:copy-of select="n:map('eArrest.09', 'E19_03', E19/E19_01_0/E19_03)"/>
            <!-- eArrest.10: Element retired in v3.4.0. -->
            <xsl:copy-of select="n:map('eArrest.11', 'E11_05', E11/E11_05)"/>
            <xsl:copy-of select="n:map('eArrest.12', 'E11_06', E11/E11_06)"/>
            <xsl:copy-of select="n:map('eArrest.13', 'E11_07', E11/E11_07)"/>
            <!-- eArrest.14: No mapping. -->
            <eArrest.14 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eArrest.15', 'E11_09', E11/E11_09)"/>
            <xsl:copy-of select="n:map('eArrest.16', 'E11_10', E11/E11_10)"/>
            <xsl:copy-of select="n:map('eArrest.17', 'E11_11', E11/E11_11)"/>
            <!-- eArrest.18: No mapping. -->
            <eArrest.18 xsi:nil="true" NV="7701003"/>
          </eArrest>

          <eHistory>
            <xsl:copy-of select="n:map('eHistory.01', 'E12_01', E12/E12_01)"/>
            <eHistory.PractitionerGroup CorrelationID="{generate-id(E12/E12_4_0)}">
              <xsl:copy-of select="n:map('eHistory.02', 'E12_06', E12/E12_4_0/E12_06)"/>
              <xsl:copy-of select="n:map('eHistory.03', 'E12_04', E12/E12_4_0/E12_04)"/>
              <xsl:copy-of select="n:map('eHistory.04', 'E12_05', E12/E12_4_0/E12_05)"/>
            </eHistory.PractitionerGroup>
            <xsl:copy-of select="n:map('eHistory.05', 'E12_07', E12/E12_07)"/>
            <xsl:copy-of select="n:map('eHistory.06', 'E12_08', E12/E12_08)"/>
            <xsl:copy-of select="n:map('eHistory.07', 'E12_09', E12/E12_09)"/>
            <xsl:copy-of select="n:map('eHistory.08', 'E12_10', E12/E12_10)"/>
            <xsl:copy-of select="n:map('eHistory.09', 'E12_11', E12/E12_11)"/>
            
            <xsl:for-each select="E12/E12_12_0">
              <eHistory.ImmunizationsGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eHistory.10', 'E12_12', E12_12)"/>
                <xsl:copy-of select="n:map('eHistory.11', 'E12_13', E12_13)"/>
              </eHistory.ImmunizationsGroup>
            </xsl:for-each>

            <xsl:for-each select="E12/E12_14_0">
              <eHistory.CurrentMedsGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eHistory.12', 'E12_14', E12_14)"/>
                <xsl:copy-of select="n:map('eHistory.13', 'E12_15', E12_15_0/E12_15)"/>
                <xsl:copy-of select="n:map('eHistory.14', 'E12_16', E12_15_0/E12_16)"/>
                <xsl:copy-of select="n:map('eHistory.15', 'E12_17', E12_17)"/>
              </eHistory.CurrentMedsGroup>
            </xsl:for-each>
          
            <xsl:copy-of select="n:map('eHistory.16', 'E12_18', E12/E12_18)"/>
            <xsl:copy-of select="n:map('eHistory.17', 'E12_19', E12/E12_19)"/>
            <xsl:copy-of select="n:map('eHistory.18', 'E12_20', E12/E12_20)"/>
            <!-- eHistory.19: No mapping. -->
          </eHistory>

          <eNarrative>
            <xsl:copy-of select="n:map('eNarrative.01', 'E13_01', E13/E13_01)"/>
          </eNarrative>

          <eVitals>
            
            <!-- eVitals.VitalGroup: Assessment/Vital Signs. -->
            <xsl:for-each select="E14">
              <eVitals.VitalGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eVitals.01', 'E14_01', E14_01)"/>
                <xsl:copy-of select="n:map('eVitals.02', 'E14_02', E14_02)"/>
                <eVitals.CardiacRhythmGroup CorrelationID="{concat(generate-id(), '.eVitals.CardiacRhythmGroup')}">
                  <xsl:copy-of select="n:map('eVitals.03', 'E14_03', E14_03)"/>
                  <!-- eVitals.04: No mapping. -->
                  <eVitals.04 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.05: No mapping. -->
                  <eVitals.05 xsi:nil="true" NV="7701003"/>
                </eVitals.CardiacRhythmGroup>
                <eVitals.BloodPressureGroup>
                  <xsl:copy-of select="n:map('eVitals.06', 'E14_04', E14_04_0/E14_04)"/>
                  <xsl:copy-of select="n:map('eVitals.07', 'E14_05', E14_04_0/E14_05)"/>
                  <xsl:copy-of select="n:map('eVitals.08', 'E14_06', E14_04_0/E14_06)"/>
                  <!-- eVitals.09: No mapping. -->
                </eVitals.BloodPressureGroup>
                <eVitals.HeartRateGroup>
                  <xsl:copy-of select="n:map('eVitals.10', 'E14_08', E14_08)"/>
                  <!-- eVitals.11: No mapping. -->
                </eVitals.HeartRateGroup>
                  <xsl:copy-of select="n:map('eVitals.12', 'E14_09', E14_09)"/>
                  <xsl:copy-of select="n:map('eVitals.13', 'E14_10', E14_10)"/>
                  <xsl:copy-of select="n:map('eVitals.14', 'E14_11', E14_11)"/>
                  <xsl:copy-of select="n:map('eVitals.15', 'E14_12', E14_12)"/>
                  <xsl:copy-of select="n:map('eVitals.16', 'E14_13', E14_13)"/>
                <!-- eVitals.17: No mapping. -->
                <xsl:copy-of select="n:map('eVitals.18', 'E14_14', E14_14)"/>
                <eVitals.GlasgowScoreGroup>
                  <xsl:copy-of select="n:map('eVitals.19', 'E14_15', E14_15_0/E14_15)"/>
                  <xsl:copy-of select="n:map('eVitals.20', 'E14_16', E14_15_0/E14_16)"/>
                  <xsl:copy-of select="n:map('eVitals.21', 'E14_17', E14_15_0/E14_17)"/>
                  <xsl:copy-of select="n:map('eVitals.22', 'E14_18', E14_15_0/E14_18)"/>
                  <xsl:copy-of select="n:map('eVitals.23', 'E14_19', E14_19)"/>
                </eVitals.GlasgowScoreGroup>
                <eVitals.TemperatureGroup>
                  <xsl:copy-of select="n:map('eVitals.24', 'E14_20', E14_20_0/E14_20)"/>
                  <xsl:copy-of select="n:map('eVitals.25', 'E14_21', E14_20_0/E14_21)"/>
                </eVitals.TemperatureGroup>
                <xsl:copy-of select="n:map('eVitals.26', 'E14_22', E14_22)"/>
                <eVitals.PainScaleGroup>
                  <xsl:copy-of select="n:map('eVitals.27', 'E14_23', E14_23)"/>
                  <!-- eVitals.28: No mapping. -->
                </eVitals.PainScaleGroup>
                <eVitals.StrokeScaleGroup>
                  <xsl:copy-of select="n:map('eVitals.29', 'E14_24', E14_24)"/>
                  <xsl:copy-of select="n:map('eVitals.30', 'E14_24', E14_24)"/>
                </eVitals.StrokeScaleGroup>
                  <xsl:copy-of select="n:map('eVitals.31', 'E14_25', E14_25)"/>
                  <xsl:copy-of select="n:map('eVitals.32', 'E14_26', E14_26)"/>
                  <xsl:copy-of select="n:map('eVitals.33', 'E14_27', E14_27)"/>
              </eVitals.VitalGroup>
            </xsl:for-each>

            <!-- eVitals.VitalGroup: Medical Device Data. -->
            <xsl:for-each select="E21[E21_12|E21_13|E21_14|E21_15|E21_16|E21_17|E21_18_0/E21_18|E21_20]">
                <eVitals.VitalGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eVitals.01', 'E21_01', E21_01)"/>
                <!-- eVitals.02: No mapping. -->
                <eVitals.02 xsi:nil="true" NV="7701003"/>
                <eVitals.CardiacRhythmGroup>
                  <!-- eVitals.03: No mapping. -->
                  <eVitals.03 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.04: No mapping. -->
                  <eVitals.04 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.05: No mapping. -->
                  <eVitals.05 xsi:nil="true" NV="7701003"/>
                </eVitals.CardiacRhythmGroup>
                <eVitals.BloodPressureGroup>
                  <xsl:copy-of select="n:map('eVitals.06', 'E21_14', E21_14)"/>
                  <xsl:copy-of select="n:map('eVitals.07', 'E21_15', E21_15)"/>
                  <!-- eVitals.08: No mapping. -->
                  <eVitals.08 xsi:nil="true" NV="7701003"/>
                  <xsl:copy-of select="n:map('eVitals.09', 'E21_20', E21_20)"/>
                </eVitals.BloodPressureGroup>
                <eVitals.HeartRateGroup>
                  <xsl:copy-of select="n:map('eVitals.10', 'E21_12', E21_12|E21_13)"/>
                  <!-- eVitals.11: No mapping. -->
                </eVitals.HeartRateGroup>
                <xsl:copy-of select="n:map('eVitals.12', 'E21_17', E21_17)"/>
                <!-- eVitals.13: No mapping. -->
                <xsl:copy-of select="n:map('eVitals.14', 'E21_16', E21_16)"/>
                <!-- eVitals.15: No mapping. -->
                <xsl:copy-of select="n:map('eVitals.16', 'E21_18', E21_18_0/E21_18)"/>
                <!-- eVitals.17: No mapping. -->
                <xsl:copy-of select="n:map('eVitals.18', 'E14_14', E14_14)"/>
                <eVitals.GlasgowScoreGroup>
                  <!-- eVitals.19: No mapping. -->
                  <eVitals.19 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.20: No mapping. -->
                  <eVitals.20 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.21: No mapping. -->
                  <eVitals.21 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.22: No mapping. -->
                  <eVitals.22 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.23: No mapping. -->
                </eVitals.GlasgowScoreGroup>
                <!-- eVitals.TemperatureGroup: No mapping. -->
                <!-- eVitals.26: No mapping. -->
                <eVitals.26 xsi:nil="true" NV="7701003"/>
                <eVitals.PainScaleGroup>
                  <!-- eVitals.27: No mapping. -->
                  <eVitals.27 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.28: No mapping. -->
                </eVitals.PainScaleGroup>
                <eVitals.StrokeScaleGroup>
                  <!-- eVitals.29: No mapping. -->
                  <eVitals.29 xsi:nil="true" NV="7701003"/>
                  <!-- eVitals.30: No mapping. -->
                  <eVitals.30 xsi:nil="true" NV="7701003"/>
                </eVitals.StrokeScaleGroup>
                <!-- eVitals.31: No mapping. -->
                <eVitals.31 xsi:nil="true" NV="7701003"/>
                <!-- eVitals.32: No mapping. -->
                <!-- eVitals.33: No mapping. -->
              </eVitals.VitalGroup>
            </xsl:for-each>

            <!-- eVitals.VitalsGroup: Empty set if none are recorded. -->
            <xsl:if test="not(E14 or E21[E21_12|E21_13|E21_14|E21_15|E21_16|E21_17|E21_18_0/E21_18|E21_20])">
              <eVitals.VitalGroup>
                <eVitals.01 xsi:nil="true" NV="7701003"/>
                <eVitals.02 xsi:nil="true" NV="7701003"/>
                <eVitals.CardiacRhythmGroup>
                  <eVitals.03 xsi:nil="true" NV="7701003"/>
                  <eVitals.04 xsi:nil="true" NV="7701003"/>
                  <eVitals.05 xsi:nil="true" NV="7701003"/>
                </eVitals.CardiacRhythmGroup>
                <eVitals.BloodPressureGroup>
                  <eVitals.06 xsi:nil="true" NV="7701003"/>
                  <eVitals.08 xsi:nil="true" NV="7701003"/>
                </eVitals.BloodPressureGroup>
                <eVitals.HeartRateGroup>
                  <eVitals.10 xsi:nil="true" NV="7701003"/>
                </eVitals.HeartRateGroup>
                <eVitals.12 xsi:nil="true" NV="7701003"/>
                <eVitals.14 xsi:nil="true" NV="7701003"/>
                <eVitals.16 xsi:nil="true" NV="7701003"/>
                <eVitals.18 xsi:nil="true" NV="7701003"/>
                <eVitals.GlasgowScoreGroup>
                  <eVitals.19 xsi:nil="true" NV="7701003"/>
                  <eVitals.20 xsi:nil="true" NV="7701003"/>
                  <eVitals.21 xsi:nil="true" NV="7701003"/>
                  <eVitals.22 xsi:nil="true" NV="7701003"/>
                </eVitals.GlasgowScoreGroup>
                <eVitals.26 xsi:nil="true" NV="7701003"/>
                <eVitals.PainScaleGroup>
                  <eVitals.27 xsi:nil="true" NV="7701003"/>
                </eVitals.PainScaleGroup>
                <eVitals.StrokeScaleGroup>
                  <eVitals.29 xsi:nil="true" NV="7701003"/>
                  <eVitals.30 xsi:nil="true" NV="7701003"/>
                </eVitals.StrokeScaleGroup>
                <eVitals.31 xsi:nil="true" NV="7701003"/>
              </eVitals.VitalGroup>
            </xsl:if>

          </eVitals>

          <!-- eLabs: No mapping. -->

          <eExam>
            <xsl:copy-of select="n:map('eExam.01', 'E16_01', E16/E16_01)"/>
            <xsl:copy-of select="n:map('eExam.02', 'E16_02', E16/E16_02)"/>
          
            <!-- eExam.AssessmentGroup: Injury Matrix. -->
            <xsl:for-each select="E15">
              <eExam.AssessmentGroup CorrelationID="{generate-id()}">
                <!-- eExam.03: No mapping. -->
                <!-- eExam.04: No mapping. -->
                <xsl:copy-of select="n:map('eExam.05', 'E15_02', E15_02)"/>
                <xsl:copy-of select="n:map('eExam.06', 'E15_03', E15_03)"/>
                <xsl:copy-of select="n:map('eExam.07', 'E15_04', E15_04)"/>
                <xsl:copy-of select="n:map('eExam.08', 'E15_05', E15_05)"/>
                <!-- eExam.09: No mapping. -->
                <eExam.AbdomenGroup CorrelationID="{concat(generate-id(), '.eExam.AbdomenGroup')}">
                  <!-- eExam.10: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.11', 'E15_06', E15_06)"/>
                </eExam.AbdomenGroup>
                <xsl:copy-of select="n:map('eExam.12', 'E15_09', E15_09)"/>
                <eExam.SpineGroup CorrelationID="{concat(generate-id(), '.eExam.SpineGroup')}">
                  <!-- eExam.13: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.14', 'E15_07', E15_07)"/>
                </eExam.SpineGroup>
                
                <!-- eExam.ExtremityGroup: Upper Extremities. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.1')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E15_08', E15_08)"/>
                </eExam.ExtremityGroup>
                <!-- eExam.ExtremityGroup: Lower Extremities. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.2')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E15_10', E15_10)"/>
                </eExam.ExtremityGroup>

                <!-- eExam.EyeGroup: No mapping. -->
                <!-- eExam.19: No mapping. -->
                <!-- eExam.20: No mapping. -->
              </eExam.AssessmentGroup>
            </xsl:for-each>

            <!-- eExam.AssessmentGroup: Assessment/Exam. -->
            <xsl:for-each select="E16/E16_00_0">
              <eExam.AssessmentGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eExam.03', 'E16_03', E16_03)"/>
                <xsl:copy-of select="n:map('eExam.04', 'E16_04', E16_04)"/>
                <xsl:copy-of select="n:map('eExam.05', 'E16_05', E16_05)"/>
                <xsl:copy-of select="n:map('eExam.06', 'E16_05', E16_05)"/>
                <xsl:copy-of select="n:map('eExam.06', 'E16_24', E16_24)"/>
                <xsl:copy-of select="n:map('eExam.07', 'E16_06', E16_06)"/>
                <xsl:copy-of select="n:map('eExam.08', 'E16_07', E16_07)"/>
                <xsl:copy-of select="n:map('eExam.09', 'E16_08', E16_08)"/>

                <xsl:if test="E16_09">
                  <eExam.AbdomenGroup CorrelationID="{concat(generate-id(), '.eExam.AbdomenGroup.1')}">
                    <!-- eExam.10: Set to Left Upper Quadrant. -->
                    <eExam.10>3510005</eExam.10>
                    <xsl:copy-of select="n:map('eExam.11', 'E16_09', E16_09)"/>
                  </eExam.AbdomenGroup>
                </xsl:if>

                <xsl:if test="E16_10">
                  <eExam.AbdomenGroup CorrelationID="{concat(generate-id(), '.eExam.AbdomenGroup.2')}">
                    <!-- eExam.10: Set to Left Lower Quadrant. -->
                    <eExam.10>3510003</eExam.10>
                    <xsl:copy-of select="n:map('eExam.11', 'E16_10', E16_10)"/>
                  </eExam.AbdomenGroup>
                </xsl:if>

                <xsl:if test="E16_11">
                  <eExam.AbdomenGroup CorrelationID="{concat(generate-id(), '.eExam.AbdomenGroup.3')}">
                    <!-- eExam.10: Set to Right Upper Quadrant. -->
                    <eExam.10>3510011</eExam.10>
                    <xsl:copy-of select="n:map('eExam.11', 'E16_11', E16_11)"/>
                  </eExam.AbdomenGroup>
                </xsl:if>

                <xsl:if test="E16_12">
                  <eExam.AbdomenGroup CorrelationID="{concat(generate-id(), '.eExam.AbdomenGroup.4')}">
                    <!-- eExam.10: Set to Right Lower Quadrant. -->
                    <eExam.10>3510009</eExam.10>
                    <xsl:copy-of select="n:map('eExam.11', 'E16_12', E16_12)"/>
                  </eExam.AbdomenGroup>
                </xsl:if>

                <xsl:copy-of select="n:map('eExam.12', 'E16_13', E16_13)"/>

                <xsl:if test="E16_14">
                  <eExam.SpineGroup CorrelationID="{concat(generate-id(), '.eExam.SpineGroup.1')}">
                    <!-- eExam.13: set to Cervical-Midline. -->
                    <eExam.13>3513005</eExam.13>
                    <xsl:copy-of select="n:map('eExam.14', 'E16_14', E16_14)"/>
                  </eExam.SpineGroup>
                </xsl:if>

                <xsl:if test="E16_15">
                  <eExam.SpineGroup CorrelationID="{concat(generate-id(), '.eExam.SpineGroup.2')}">
                    <!-- eExam.13: set to Thoracic-Midline. -->
                    <eExam.13>3513017</eExam.13>
                    <xsl:copy-of select="n:map('eExam.14', 'E16_15', E16_15)"/>
                  </eExam.SpineGroup>
                </xsl:if>

                <xsl:if test="E16_16">
                  <eExam.SpineGroup CorrelationID="{concat(generate-id(), '.eExam.SpineGroup.3')}">
                    <!-- eExam.13: set to Lumbar-Midline. -->
                    <eExam.13>3513011</eExam.13>
                    <xsl:copy-of select="n:map('eExam.14', 'E16_16', E16_16)"/>
                  </eExam.SpineGroup>
                </xsl:if>
                
                <!-- eExam.ExtremityGroup: Extremities-Right Upper. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.1')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E16_17', E16_17)"/>
                </eExam.ExtremityGroup>
                <!-- eExam.ExtremityGroup: Extremities-Right Lower. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.2')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E16_18', E16_18)"/>
                </eExam.ExtremityGroup>
                <!-- eExam.ExtremityGroup: Extremities-Left Upper. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.3')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E16_19', E16_19)"/>
                </eExam.ExtremityGroup>
                <!-- eExam.ExtremityGroup: Extremities-Left Lower. -->
                <eExam.ExtremityGroup CorrelationID="{concat(generate-id(), '.eExam.ExtremityGroup.4')}">
                  <!-- eExam.15: No mapping. -->
                  <xsl:copy-of select="n:map('eExam.16', 'E16_20', E16_20)"/>
                </eExam.ExtremityGroup>
                
                <xsl:if test="E16_21">
                  <eExam.EyeGroup CorrelationID="{concat(generate-id(), '.eExam.EyeGroup.1')}">
                    <!-- eExam.17: Set to Left. -->
                    <eExam.17>3517003</eExam.17>
                    <xsl:copy-of select="n:map('eExam.18', 'E16_21', E16_21)"/>
                  </eExam.EyeGroup>
                  </xsl:if>

                <xsl:if test="E16_22">
                  <eExam.EyeGroup CorrelationID="{concat(generate-id(), '.eExam.EyeGroup.1')}">
                    <!-- eExam.17: Set to Right. -->
                    <eExam.17>3517005</eExam.17>
                    <xsl:copy-of select="n:map('eExam.18', 'E16_22', E16_22)"/>
                  </eExam.EyeGroup>
                </xsl:if>

                <xsl:copy-of select="n:map('eExam.19', 'E16_23', E16_23)"/>
                <xsl:copy-of select="n:map('eExam.20', 'E16_24', E16_24)"/>
              </eExam.AssessmentGroup>
            </xsl:for-each>

          </eExam>

          <eProtocols>
            
            <xsl:for-each select="E17">
              <eProtocols.ProtocolGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eProtocols.01', 'E17_01', E17_01)"/>
                <!-- eProtocols.02: No mapping. -->
                <eProtocols.02 xsi:nil="true" NV="7701003"/>
              </eProtocols.ProtocolGroup>
            </xsl:for-each>

            <!-- eProtocols.ProtocolGroup: Empty set if none are recorded. -->
            <xsl:if test="not(E17)">
              <eProtocols.ProtocolGroup>
                <eProtocols.01 xsi:nil="true" NV="7701003"/>
                <eProtocols.02 xsi:nil="true" NV="7701003"/>
              </eProtocols.ProtocolGroup>
            </xsl:if>
          </eProtocols>

          <eMedications>
            
            <!-- eMedications.medicationGroup: Prior Aid. -->
            <xsl:for-each select="E09/E09_01[n:map('eMedications.03', 'E09_01', .)!='']">
              <eMedications.MedicationGroup CorrelationID="{generate-id()}">
                <!-- eMedications.01: No mapping. -->
                <eMedications.01 xsi:nil="true"/>
                <!-- eMedications.02: Set to "Yes". -->
                <eMedications.02>9923003</eMedications.02>
                <xsl:copy-of select="n:map('eMedications.03', 'E09_01', .)"/>
                <!-- eMedications.04: No mapping. -->
                <eMedications.DosageGroup>
                  <!-- eMedications.05: No mapping. -->
                  <eMedications.05 xsi:nil="true"/>
                  <!-- eMedications.06: No mapping. -->
                  <eMedications.06 xsi:nil="true"/>
                </eMedications.DosageGroup>
                <xsl:copy-of select="n:map('eMedications.07', 'E09_03', ../E09_03)"/>
                <!-- eMedications.08: No mapping. -->
                <eMedications.08 xsi:nil="true"/>
                <!-- eMedications.09: No mapping. -->
                <xsl:copy-of select="n:map('eMedications.10', 'E09_02', ..[count(E09_02)=1]/E09_02)"/>
                <!-- eMedications.11: No mapping. -->
                <!-- eMedications.12: No mapping. -->
              </eMedications.MedicationGroup>
            </xsl:for-each>

            <!-- eMedications.medicationGroup: Intervention/Medication. -->
            <xsl:for-each select="E18">
              <eMedications.MedicationGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eMedications.01', 'E18_01', E18_01)"/>
                <xsl:copy-of select="n:map('eMedications.02', 'E18_02', E18_02)"/>
                <xsl:copy-of select="n:map('eMedications.03', 'E18_03', E18_03)"/>
                <xsl:copy-of select="n:map('eMedications.04', 'E18_04', E18_04)"/>
                <eMedications.DosageGroup>
                  <xsl:copy-of select="n:map('eMedications.05', 'E18_05', E18_05_0/E18_05)"/>
                  <xsl:copy-of select="n:map('eMedications.06', 'E18_06', E18_05_0/E18_06)"/>
                </eMedications.DosageGroup>
                <xsl:copy-of select="n:map('eMedications.07', 'E18_07', E18_07)"/>
                <xsl:copy-of select="n:map('eMedications.08', 'E18_08', E18_08)"/>
                <xsl:copy-of select="n:map('eMedications.09', 'E18_09', E18_09)"/>
                
                <!-- eMedications.10: Look up E04_03 based on match between E18_09 and E04_01. -->
                <xsl:variable name="E18_09" select="normalize-space(E18_09)"/>
                <xsl:copy-of select="n:map('eMedications.10', 'E04_03', ../E04[normalize-space(E04_01)=$E18_09]/E04_03)"/>
              
                <xsl:copy-of select="n:map('eMedications.11', 'E18_10', E18_10)"/>
                <xsl:copy-of select="n:map('eMedications.12', 'E18_11', E18_11)"/>
              </eMedications.MedicationGroup>
            </xsl:for-each>

          </eMedications>

          <eProcedures>

            <!-- eProcedures.ProcedureGroup: Prior Aid. -->
            <xsl:for-each select="E09/E09_01[n:map('eProcedures.03', 'E09_01', .)!='' or n:map('eCustomResults.01', 'E09_01', .)!='']">
              <eProcedures.ProcedureGroup CorrelationID="{generate-id()}">
                <!-- eProcedures.01: No mapping. -->
                <eProcedures.01 xsi:nil="true"/>
                <!-- eProcedures.02: Set to "Yes". -->
                <eProcedures.02>9923003</eProcedures.02>
                <xsl:copy-of select="n:map('eProcedures.03', 'E09_01', .)"/>
                <!-- eProcedures.04: No mapping. -->
                <!-- eProcedures.05: No mapping. -->
                <eProcedures.05 xsi:nil="true"/>
                <!-- eProcedures.06: No mapping. -->
                <eProcedures.06 xsi:nil="true"/>
                <!-- eProcedures.07: No mapping. -->
                <eProcedures.07 xsi:nil="true"/>
                <xsl:copy-of select="n:map('eProcedures.08', 'E09_03', ../E09_03)"/>
                <!-- eProcedures.09: No mapping. -->
                <xsl:copy-of select="n:map('eProcedures.10', 'E09_02', ..[count(E09_02)=1]/E09_02)"/>
                <!-- eProcedures.11: No mapping. -->
                <!-- eProcedures.12: No mapping. -->
                <!-- eProcedures.13: No mapping. -->
              </eProcedures.ProcedureGroup>
            </xsl:for-each>

            <!-- eProcedures.ProcedureGroup: Intervention/Procedure. -->
            <xsl:for-each select="E19/E19_01_0">
              <eProcedures.ProcedureGroup CorrelationID="{generate-id()}">
                <xsl:copy-of select="n:map('eProcedures.01', 'E19_01', E19_01)"/>
                <xsl:copy-of select="n:map('eProcedures.02', 'E19_02', E19_02)"/>
                <xsl:copy-of select="n:map('eProcedures.03', 'E19_03', E19_03)"/>
                <xsl:copy-of select="n:map('eProcedures.04', 'E19_04', E19_04)"/>
                <xsl:copy-of select="n:map('eProcedures.05', 'E19_05', E19_05)"/>
                <xsl:copy-of select="n:map('eProcedures.06', 'E19_06', E19_06)"/>
                <xsl:copy-of select="n:map('eProcedures.07', 'E19_07', E19_07)"/>
                <xsl:copy-of select="n:map('eProcedures.08', 'E19_08', E19_08)"/>
                <xsl:copy-of select="n:map('eProcedures.09', 'E19_09', E19_09)"/>
                
                <!-- eProcedures.10: Look up E04_03 based on match between E19_09 and E04_01. -->
                <xsl:variable name="E19_09" select="normalize-space(E19_09)"/>
                <xsl:copy-of select="n:map('eProcedures.10', 'E04_03', ../../E04[normalize-space(E04_01)=$E19_09]/E04_03)"/>
              
                <xsl:copy-of select="n:map('eProcedures.11', 'E19_10', E19_10)"/>
                <xsl:copy-of select="n:map('eProcedures.12', 'E19_11', E19_11)"/>
                <!-- eProcedures.13: No mapping. -->
              </eProcedures.ProcedureGroup>
            </xsl:for-each>

          </eProcedures>

          <eAirway>
            <eAirway.AirwayGroup>
              <!-- eAirway.01: No mapping. -->

              <!-- eAirway.ConfirmationGroup: Airway device procedures. -->
              <xsl:for-each select="E19/E19_01_0[n:map('eAirway.03', 'E19_03', E19_03)!='']">
                <eAirway.ConfirmationGroup ProcedureGroupCorrelationID="{generate-id()}" CorrelationID="{concat(generate-id(), '.eAirway.ConfirmationGroup')}">
                  <!-- eAirway.02: No mapping. -->
                  <xsl:copy-of select="n:map('eAirway.03', 'E19_03', E19_03)"/>
                  <!-- eAirway.04: No mapping. -->
                  <!-- eAirway.05: No mapping. -->
                  <!-- eAirway.06: No mapping. -->
                  <!-- eAirway.07: No mapping. -->
                </eAirway.ConfirmationGroup>
              </xsl:for-each>

              <!-- eAirway.ConfirmationGroup: Airway device confirmation procedures. -->
              <xsl:for-each select="E19/E19_01_0[n:map('eAirway.04', 'E19_03', E19_03)!='']">
                <!-- eAirway.confirmationGroup/@ProcedureGroupCorrelationID: No mapping. -->
                <eAirway.ConfirmationGroup CorrelationID="{concat(generate-id(), '.eAirway.ConfirmationGroup')}">
                  <xsl:copy-of select="n:map('eAirway.02', 'E19_01', E19_01)"/>
                  <!-- eAirway.03: No mapping. -->
                  <xsl:copy-of select="n:map('eAirway.04', 'E19_03', E19_03)"/>
                  <!-- eAirway.05: No mapping. -->
                  <!-- eAirway.06: No mapping. -->
                  <xsl:copy-of select="n:map('eAirway.07', 'E19_09', E19_09)"/>
                </eAirway.ConfirmationGroup>
              </xsl:for-each>

              <!-- eAirway.ConfirmationGroup: Tube Confirmation. -->
              <xsl:if test="E19/E19_13">
                <!-- eAirway.confirmationGroup/@ProcedureGroupCorrelationID: No mapping. -->
                <eAirway.ConfirmationGroup CorrelationID="{concat(generate-id(), '.eAirway.ConfirmationGroup.1')}">
                  <!-- eAirway.02: No mapping. -->
                  <!-- eAirway.03: No mapping. -->
                  <xsl:copy-of select="n:map('eAirway.04', 'E19_13', E19/E19_13)"/>
                  <!-- eAirway.05: No mapping. -->
                  <!-- eAirway.06: No mapping. -->
                  <!-- eAirway.07: No mapping. -->
                </eAirway.ConfirmationGroup>
              </xsl:if>

              <!-- eAirway.ConfirmationGroup: Destination Confirmation of Tube Placement. -->
              <xsl:if test="E19/E19_14">
                <!-- eAirway.confirmationGroup/@ProcedureGroupCorrelationID: No mapping. -->
                <eAirway.ConfirmationGroup CorrelationID="{concat(generate-id(), '.eAirway.ConfirmationGroup.2')}">
                  <!-- eAirway.02: No mapping. -->
                  <!-- eAirway.03: No mapping. -->
                  <xsl:copy-of select="n:map('eAirway.04', 'E19_14', E19/E19_14)"/>
                  <!-- eAirway.05: No mapping. -->
                  <!-- eAirway.06: Set to "Receiving Hospital Team". 4006007 Receiving Air Medical/EMS Crew may also be an appropriate v3 replacment. -->
                  <eAirway.06>4006009</eAirway.06>
                  <!-- eAirway.07: No mapping. -->
                </eAirway.ConfirmationGroup>
              </xsl:if>

              <!-- eAirway.08: Airway device procedures. -->
              <xsl:copy-of select="n:map('eAirway.08', 'E19_07', E19/E19_01_0[n:map('eAirway.03', 'E19_03', E19_03)!='']/E19_07)"/>
              <!-- eAirway.09: No mapping. -->
              <!-- eAirway.10: No mapping. -->
              <!-- eAirway.11: No mapping. -->
            </eAirway.AirwayGroup>

          </eAirway>

          <eDevice>

            <xsl:for-each select="E21[E21_02|E21_03|E21_04|E21_05|E21_06|E21_07|E21_08|E21_09|E21_10|E21_11]">
              <eDevice.DeviceGroup CorrelationID="{generate-id()}">
                <!-- eDevice.01: No mapping. -->
                <xsl:copy-of select="n:map('eDevice.02', 'E21_01', E21_01)"/>
                <xsl:copy-of select="n:map('eDevice.03', 'E21_02', E21_02)"/>
                <eDevice.WaveformGroup>
                  <xsl:copy-of select="n:map('eDevice.04', 'E21_03', E21_03_0/E21_03)"/>
                  <xsl:copy-of select="n:map('eDevice.05', 'E21_04', E21_03_0/E21_03)"/>
                  <xsl:copy-of select="n:map('eDevice.06', 'E21_05', E21_03_0/E21_05)"/>
                </eDevice.WaveformGroup>
                <xsl:copy-of select="n:map('eDevice.07', 'E21_06', E21_06)"/>
                <xsl:copy-of select="n:map('eDevice.08', 'E21_07', E21_07)"/>
                <eDevice.ShockGroup>
                  <xsl:copy-of select="n:map('eDevice.09', 'E21_08', E21_08)"/>
                  <xsl:copy-of select="n:map('eDevice.10', 'E21_09', E21_09)"/>
                  <xsl:copy-of select="n:map('eDevice.11', 'E21_10', E21_10)"/>
                  <xsl:copy-of select="n:map('eDevice.12', 'E21_11', E21_11)"/>
                </eDevice.ShockGroup>
              </eDevice.DeviceGroup>
            </xsl:for-each>

          </eDevice>

          <eDisposition>
            <eDisposition.DestinationGroup>
              <xsl:copy-of select="n:map('eDisposition.01', 'E20_01', E20/E20_01)"/>
              <xsl:copy-of select="n:map('eDisposition.02', 'E20_02', E20/E20_02)"/>
              <!-- eDisposition.03/@StreetAddress2: No mapping. -->
              <xsl:copy-of select="n:map('eDisposition.03', 'E20_03', E20/E20_03_0/E20_03)"/>
              <xsl:copy-of select="n:map('eDisposition.04', 'E20_04', E20/E20_03_0/E20_04)"/>
              <xsl:copy-of select="n:map('eDisposition.05', 'E20_05', E20/E20_03_0/E20_05)"/>
              <xsl:copy-of select="n:map('eDisposition.06', 'E20_06', E20/E20_06)"/>
              <xsl:copy-of select="n:map('eDisposition.07', 'E20_07', E20/E20_03_0/E20_07)"/>
              <!-- eDisposition.08: No mapping. -->
              <xsl:copy-of select="n:map('eDisposition.09', 'E20_08', E20/E20_08)"/>
              <!-- eDisposition.10: No mapping. -->
            </eDisposition.DestinationGroup>
            <!-- eDisposition.11: No mapping. -->
            <xsl:copy-of select="n:map('eDisposition.12', 'E20_10', E20/E20_10)"/>
            <xsl:copy-of select="n:map('eDisposition.13', 'E20_11', E20/E20_11)"/>
            <xsl:copy-of select="n:map('eDisposition.14', 'E20_12', E20/E20_12)"/>
            <xsl:copy-of select="n:map('eDisposition.15', 'E20_13', E20/E20_13)"/>
            <!-- eDisposition.16: No mapping. -->
            <eDisposition.16 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eDisposition.17', 'E20_14', E20/E20_14)"/>
            <xsl:copy-of select="n:map('eDisposition.18', 'E20_14', E20/E20_14)"/>
            <eDisposition.19 xsi:nil="true" NV="7701003"/>
            <xsl:copy-of select="n:map('eDisposition.20', 'E20_16', E20/E20_16)"/>
            <xsl:copy-of select="n:map('eDisposition.21', 'E20_17', E20/E20_17)"/>
            <!-- eDisposition.22: No mapping. -->
            <eDisposition.22 xsi:nil="true" NV="7701003"/>
            <!-- eDisposition.23: No mapping. -->
            <eDisposition.23 xsi:nil="true" NV="7701003"/>
            
            <xsl:for-each select="E19/E19_01_0[n:map('eDisposition.24', 'E19_03', E19_03)!='']">
              <eDisposition.HospitalTeamActivationGroup CorrelationID="{concat(generate-id(), '.eDisposition.HospitalTeamActivationGroup')}">
                <xsl:copy-of select="n:map('eDisposition.24', 'E19_03', E19_03)"/>
                <xsl:copy-of select="n:map('eDisposition.25', 'E19_01', E19_01)"/>
              </eDisposition.HospitalTeamActivationGroup>
            </xsl:for-each>

            <!-- eDisposition.HospitalTeamActivationGroup: Empty set if none are recorded. -->
            <xsl:if test="not(E19/E19_01_0[n:map('eDisposition.24', 'E19_03', E19_03)!=''])">
                <eDisposition.HospitalTeamActivationGroup>
                  <eDisposition.24 xsi:nil="true" NV="7701003"/>
                  <eDisposition.25 xsi:nil="true" NV="7701003"/>
                </eDisposition.HospitalTeamActivationGroup>
            </xsl:if>
            
            <!-- eDisposition.26: No mapping. -->
          </eDisposition>

          <eOutcome>
            <xsl:copy-of select="n:map('eOutcome.01', 'E22_01', E22/E22_01)"/>
            <xsl:copy-of select="n:map('eOutcome.02', 'E22_02', E22/E22_02)"/>
            
            <xsl:for-each select="E12/E12_02">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.1')}">
                <!-- eOutcome.03: Set to Hospital-Transferring. -->
                <eOutcome.03>4303007</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E12_02', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <xsl:for-each select="E12/E12_03">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.2')}">
                <!-- eOutcome.03: Set to Hospital-Receiving. -->
                <eOutcome.03>4303005</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E12_03', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <xsl:for-each select="E22/E22_03">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.3')}">
                <!-- eOutcome.03: Set to Law Enforcement Report. -->
                <eOutcome.03>4303009</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E22_03', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <xsl:for-each select="E22/E22_04">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.4')}">
                <!-- eOutcome.03: Set to Trauma Registry. -->
                <eOutcome.03>4303025</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E22_04', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <xsl:for-each select="E22/E22_05">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.5')}">
                <!-- eOutcome.03: Set to Fire Incident Report. -->
                <eOutcome.03>4303003</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E22_05', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <xsl:for-each select="E22/E22_06">
              <eOutcome.ExternalDataGroup CorrelationID="{concat(generate-id(), '.eOutcome.ExternalDataGroup.6')}">
                <!-- eOutcome.03: Set to Patient ID. -->
                <eOutcome.03>4303017</eOutcome.03>
                <xsl:copy-of select="n:map('eOutcome.04', 'E22_06', .)"/>
                <!-- eOutcome.05: No mapping. -->
              </eOutcome.ExternalDataGroup>
            </xsl:for-each>

            <!-- eOutcome.06: No mapping. -->
            <!-- eOutcome.07: No mapping. -->
            <!-- eOutcome.08: No mapping. -->
            <!-- eOutcome.09: No mapping. -->
            <!-- eOutcome.10: No mapping. -->
            <!-- eOutcome.11: No mapping. -->
            <!-- eOutcome.12: No mapping. -->
            <!-- eOutcome.13: No mapping. -->
            <!-- eOutcome.14: No mapping. -->
            <!-- eOutcome.15: No mapping. -->
            <!-- eOutcome.16: No mapping. -->
            <!-- eOutcome.17: No mapping. -->
          </eOutcome>
          
          <eCustomResults>
            
          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E02_14', E02/E02_14)"/>
            <eCustomResults.02>E02_14</eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <xsl:for-each select="E07/E07_35_0/E07_36">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E07_36', .)"/>
              <eCustomResults.02>E07_36</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id(../E07_35)"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:for-each>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E08_03', E08/E08_03)"/>
            <eCustomResults.02>E08_03</eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E08_09', E08/E08_09)"/>
            <eCustomResults.02>E08_09</eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <xsl:for-each select="E09/E09_01[n:map('eCustomResults.01', 'E09_01', .)!='']">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E09_01', .)"/>
              <eCustomResults.02>E09_01</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id()"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:for-each>

          <xsl:if test="count(E09/E09_02)>1">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E09_02', E09/E09_02)"/>
              <eCustomResults.02>E09_02</eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
            </eCustomResults.ResultsGroup>
          </xsl:if>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E09_13', E09/E09_13)"/>
            <eCustomResults.02>E09_13</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E09_14', E09/E09_14)"/>
            <eCustomResults.02>E09_14</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E10_02', E10/E10_02)"/>
            <eCustomResults.02>E10_02</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E10_04', E10/E10_04)"/>
            <eCustomResults.02>E10_04</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E10_05', E10/E10_05)"/>
            <eCustomResults.02>E10_05</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E11_08', E11/E11_08)"/>
            <eCustomResults.02>E11_08</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <xsl:for-each select="E14/E14_28">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E14_28', .)"/>
              <eCustomResults.02>E14_28</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id(..)"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:for-each>

          <xsl:if test="E15/E15_01">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E15_01', E15/E15_01)"/>
              <eCustomResults.02>E15_01</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id(E15)"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:if>

          <xsl:if test="E15/E15_11">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E15_11', E15/E15_11)"/>
              <eCustomResults.02>E15_11</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id(E15)"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:if>

          <xsl:for-each select="E19/E19_01_0[n:map('eCustomResults.01', 'E19_03', E19_03)!='']">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E19_03', E19_03)"/>
              <eCustomResults.02>E19_03</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="generate-id()"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:for-each>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E19_12', E19/E19_12)"/>
            <eCustomResults.02>E19_12</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E20_09', E20/E20_09)"/>
            <eCustomResults.02>E20_09</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E20_15', E20/E20_15)"/>
            <eCustomResults.02>E20_15</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <xsl:if test="E23/E23_07">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E23_07', E23/E23_07)"/>
              <eCustomResults.02>E23_07</eCustomResults.02>
              <eCustomResults.03><xsl:value-of select="concat(generate-id(), '.eOther.EMSCrewMemberGroup')"/></eCustomResults.03>
            </eCustomResults.ResultsGroup>
          </xsl:if>

          <eCustomResults.ResultsGroup>
            <xsl:copy-of select="n:map('eCustomResults.01', 'E23_08', E23/E23_08)"/>
            <eCustomResults.02>E23_08</eCustomResults.02>
          <!-- eCustomResults.03: No mapping. -->
          </eCustomResults.ResultsGroup>

          <xsl:for-each-group select="E23/E23_09_0" group-by="E23_11">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E23_09', current-group()/E23_09)"/>
              <eCustomResults.02><xsl:value-of select="generate-id()"/></eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
            </eCustomResults.ResultsGroup>
          </xsl:for-each-group>

          <xsl:if test="E23/E23_09_0[not(E23_11)]">
            <eCustomResults.ResultsGroup>
              <xsl:copy-of select="n:map('eCustomResults.01', 'E23_09', E23/E23_09_0[not(E23_11)]/E23_09)"/>
              <eCustomResults.02><xsl:value-of select="concat(generate-id(..), '.eCustomResults.ResultsGroup')"/></eCustomResults.02>
            <!-- eCustomResults.03: No mapping. -->
            </eCustomResults.ResultsGroup>
          </xsl:if>

        </eCustomResults>
            
          <eOther>
            <xsl:copy-of select="n:map('eOther.01', 'E23_01', E23/E23_01)"/>
            <xsl:copy-of select="n:map('eOther.02', 'E23_02', E23/E23_02)"/>
            <eOther.EMSCrewMemberGroup CorrelationID="{concat(generate-id(), '.eOther.EMSCrewMemberGroup')}">
              <xsl:copy-of select="n:map('eOther.03', 'E23_03', E23/E23_03)"/>
              <!-- eOther.04: No mapping. -->
              <xsl:copy-of select="n:map('eOther.05', 'E23_05', E23/E23_05)"/>
              <xsl:copy-of select="n:map('eOther.06', 'E23_06', E23/E23_06)"/>
            </eOther.EMSCrewMemberGroup>
            <xsl:copy-of select="n:map('eOther.07', 'E23_04', E23/E23_04)"/>
            <xsl:copy-of select="n:map('eOther.08', 'E23_10', E23/E23_10)"/>
            <!-- eOther.FileGroup: No mapping. -->
            <!-- eOther.SignatureGroup: No mapping. -->
          </eOther>
            
        </PatientCareReport>

  </xsl:template>

  <xsl:template match="/*[name()!='EMSDataSet']">
    <xsl:comment>
      XML Stylesheet Language Transformation (XSLT) to transform NEMSIS v2 EMSDataSet to NEMSIS v3 EMSDataSet:
      An attempt was made to transform a dataset that is not a NEMSIS 2 EMSDataSet.
    </xsl:comment>
  </xsl:template>

</xsl:transform>