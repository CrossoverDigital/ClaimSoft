<?xml version="1.0" encoding="UTF-8"?>

<!--

XML Stylesheet Language Transformation (XSLT) to transform NEMSIS EMSDataSet from 3.4.0 to v3.3.4

Version: 3.4.0.160713CP2_3.3.4.160713CP2_170227
Revision Date: February 27, 2017

-->

<xsl:stylesheet version="2.0"
	xmlns="http://www.nemsis.org"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:n="http://www.nemsis.org"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="n xs">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:comment>&#32;This NEMSIS 3.3.4 document was generated from a NEMSIS 3.4.0 document via an XML Stylesheet Language Transformation (XSLT).&#32;</xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:copy>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@xsi:schemaLocation">
    <xsl:attribute name="xsi:schemaLocation">http://www.nemsis.org http://www.nemsis.org/media/nemsis_v3/release-3.3.4/XSDs/NEMSIS_XSDs/EMSDataSet_v3.xsd</xsl:attribute>
  </xsl:template>

  <!-- @StreetAddress2: Truncate -->
  <xsl:template match="@StreetAddress2">
    <xsl:attribute name="StreetAddress2">
      <xsl:value-of select="substring(., 1, 55)"/>
    </xsl:attribute>
  </xsl:template>

  <!-- eCustomConfiguration.09: Remove -->
  <xsl:template match="n:eCustomConfiguration.09" />

  <!-- eRecord.01: Truncate and generate message and comment -->
  <xsl:template match="n:eRecord.01[string-length(.) > 32]">
    <xsl:variable name="message">eRecord.01 was truncated from "<xsl:value-of select="."/>" (<xsl:value-of select="string-length(.)"/> characters) to "<xsl:value-of select="substring(., 1, 32)"/>" (32 characters). eRecord.01 is a unique identifier and the truncation has caused it to be altered, which may affect the ability to track the patient care report.</xsl:variable>
    <xsl:message><xsl:value-of select="$message"/></xsl:message>
    <xsl:comment><xsl:value-of select="$message"/></xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:copy>
      <xsl:value-of select="substring(., 1, 32)"/>
    </xsl:copy>
  </xsl:template>

  <!-- eResponse.03: Truncate and generate comment -->
  <xsl:template match="n:eResponse.03[string-length(.) > 32]">
    <xsl:variable name="message">eResponse.03 was truncated from "<xsl:value-of select="."/>" (<xsl:value-of select="string-length(.)"/> characters) to "<xsl:value-of select="substring(., 1, 32)"/>" (32 characters).</xsl:variable>
    <xsl:comment><xsl:value-of select="$message"/></xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:copy>
      <xsl:value-of select="substring(., 1, 32)"/>
    </xsl:copy>
  </xsl:template>

  <!-- eDispatch.06: Remove -->
  <xsl:template match="n:eDispatch.06" />

  <!-- eCrew.01, eMedications.09, eProcedures.09, eOther.04, eOther.08, eAirway.07: Truncate -->
  <xsl:template match="n:eCrew.01 | n:eMedications.09 | n:eProcedures.09 | n:eOther.04 | n:eOther.08 | n:eAirway.07">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="substring(., 1, 15)"/>
    </xsl:copy>
  </xsl:template>

  <!-- ePatient.02, ePayment.06, ePayment.19, ePayment.23, eHistory.02, eOther.20: Truncate -->
  <xsl:template match="n:ePatient.02 | n:ePayment.06 | n:ePayment.19 | n:ePayment.23 | n:eHistory.02 | n:eOther.20">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="substring(., 1, 50)"/>
    </xsl:copy>
  </xsl:template>

  <!-- ePatient.05, ePayment.12, ePayment.26, ePayment.34, eScene.15, eDisposition.03: Truncate -->
  <xsl:template match="n:ePatient.05 | n:ePayment.12 | n:ePayment.26 | n:ePayment.34 | n:eScene.15 | n:eDisposition.03">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="substring(., 1, 55)"/>
    </xsl:copy>
  </xsl:template>

  <!-- ePayment.13, ePayment.27, ePayment.35: Remove if not positive integer (not translating from text to GNIS) -->
  <xsl:template match="n:ePayment.13[not(. castable as xs:integer and . >= 0)] | n:ePayment.27[not(. castable as xs:integer and . >= 0)] | n:ePayment.35[not(. castable as xs:integer and . >= 0)]" />

  <!-- ePayment.51, eOutcome.10: Remove if not matching pattern -->
  <xsl:template match="n:ePayment.51[not(matches(., '^[A-Z][0-9]{2}((\.[0-9A-Z]{1,3})?)$'))] |
                       n:eOutcome.10[not(matches(., '^[A-Z][0-9]{2}((\.[0-9A-Z]{1,3})?)$'))]" />

  <!-- ePayment.54, eMedications.12, eProcedures.12: Truncate -->
  <xsl:template match="n:ePayment.54 | n:eMedications.12 | n:eProcedures.12">
    <xsl:copy>
      <xsl:value-of select="substring(., 1, 50)"/>
    </xsl:copy>
  </xsl:template>

  <!-- ePayment.57: Remove -->
  <xsl:template match="n:ePayment.57" />

  <!-- ePayment.58: Remove -->
  <xsl:template match="n:ePayment.58" />

  <!-- eScene.14: Min 2 characters -->
  <xsl:template match="n:eScene.14[string-length() = 1]">
    <xsl:copy>_<xsl:value-of select="."/></xsl:copy>
  </xsl:template>

  <!-- eScene.14/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:eScene.14/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- eScene.15/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:eScene.15/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- eScene.16/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:eScene.16/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- eSituation.09, eSituation.10: Blank if not matching pattern -->
  <xsl:template match="n:eSituation.09[. != '' and not(matches(., '^(R[0-6][0-9](\.[0-9]{1,4})?|(R73\.9)|(R99))|([A-QSTZ][0-9]{2})((\.[0-9A-Z]{1,4})?)$'))] |
                       n:eSituation.10[. != '' and not(matches(., '^(R[0-6][0-9](\.[0-9]{1,4})?|(R73\.9)|(R99))|([A-QSTZ][0-9]{2})((\.[0-9A-Z]{1,4})?)$'))]">
    <xsl:copy>
      <xsl:attribute name="xsi:nil">true</xsl:attribute>
      <xsl:attribute name="NV">7701003</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- eSituation.11, eSituation.12: Blank if not matching pattern -->
  <xsl:template match="n:eSituation.11[. != '' and not(matches(., '^(R[0-6][0-9](\.[0-9]{1,3})?|(R73\.9)|(R99))|([A-QSTZ][0-9]{2})((\.[0-9A-Z]{1,4})?)$'))] |
                       n:eSituation.12[. != '' and not(matches(., '^(R[0-6][0-9](\.[0-9]{1,3})?|(R73\.9)|(R99))|([A-QSTZ][0-9]{2})((\.[0-9A-Z]{1,4})?)$'))]">
    <xsl:copy>
      <xsl:attribute name="xsi:nil">true</xsl:attribute>
      <xsl:attribute name="NV">7701003</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- eSituation.18: Remove -->
  <xsl:template match="n:eSituation.18" />

  <!-- eInjury.04: Map new values to "Not Recorded" -->
  <xsl:template match="n:eInjury.04[. > '2904023']">
    <xsl:copy>
      <xsl:attribute name="xsi:nil">true</xsl:attribute>
      <xsl:attribute name="NV">7701003</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- eArrest: Add eArrest.10 before eArrest.11 -->
  <xsl:template match="n:eArrest.11">
    <xsl:choose>
      <xsl:when test="ancestor::n:PatientCareReport/n:eProcedures/n:eProcedures.ProcedureGroup/n:eProcedures.03 = '430189000'"><eArrest.10>9923003</eArrest.10></xsl:when>
      <xsl:otherwise><eArrest.10 xsi:nil="true" NV="7701003"/></xsl:otherwise>
    </xsl:choose>
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <!-- eArrest.19: Remove -->
  <xsl:template match="n:eArrest.19" />

  <!-- eHistory.01: Map new value to "Not Recorded" -->
  <xsl:template match="n:eHistory.01[. > '3101029']">
    <xsl:copy>
      <xsl:attribute name="xsi:nil">true</xsl:attribute>
      <xsl:attribute name="NV">7701003</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- eHistory.06/@PN: Map "Unresponsive" to "Unable to Complete" -->
  <xsl:template match="n:eHistory.06/@PN[. = '8801021']">
    <xsl:attribute name="PN">8801023</xsl:attribute>
  </xsl:template>

  <!-- eHistory.08: Remove if not matching pattern -->
  <xsl:template match="n:eHistory.08[. != '' and not(matches(., '^([A-QSTZ][0-9]{2})((\.[0-9A-Z]{1,3})?)$'))]" />

  <!-- eHistory.08/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:eHistory.08/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- eHistory.14: Map new values to "other (Not Listed)" -->
  <xsl:template match="n:eHistory.14[. > '3114045']">
    <xsl:copy>3114041</xsl:copy>
  </xsl:template>

  <!-- eHistory.15, eMedications.04: Map "Portacath" to "Intravenous (IV)" -->
  <xsl:template match="n:eHistory.15[. = '9927061'] | n:eMedications.04[. = '9927061']">
    <xsl:copy>9927023</xsl:copy>
  </xsl:template>

  <!-- eVitals.16: Max 100 -->
  <xsl:template match="n:eVitals.16[. > '100']">
    <xsl:copy>100</xsl:copy>
  </xsl:template>

  <!-- eVitals.17: Round decimal to integer -->
  <xsl:template match="n:eVitals.17[. != '']">
    <xsl:copy>
      <xsl:value-of select="round(.)"/>
    </xsl:copy>
  </xsl:template>

  <!-- eVitals.17/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:eVitals.17/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- eExam.04: Remove new values -->
  <xsl:template match="n:eExam.04[. > '3504033']" />

  <!-- eExam.10: Remove new value -->
  <xsl:template match="n:eExam.10[. > '3510011']" />

  <!-- eExam.11: Remove new values -->
  <xsl:template match="n:eExam.11[. > '3511061']" />

  <!-- eExam.16: Remove new value -->
  <xsl:template match="n:eExam.16[. > '3516081']" />

  <!-- eExam.19: Remove new values -->
  <xsl:template match="n:eExam.19[. > '3519021']" />

  <!-- eExam.20: Remove new values -->
  <xsl:template match="n:eExam.20[. > '3520049']" />

  <!-- eExam.21: Map "Yes" values to eExam.20 values -->
  <xsl:template match="n:eExam[n:eExam.21 > '3521001']">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <eExam.AssessmentGroup>
        <xsl:if test="n:eExam.21 = '3521003'">
          <eExam.20>3520047</eExam.20>
        </xsl:if>
        <xsl:if test="n:eExam.21 = '3521005'">
          <eExam.20>3520049</eExam.20>
        </xsl:if>
      </eExam.AssessmentGroup>
    </xsl:copy>
  </xsl:template>

  <!-- eExam.21: Otherwise, remove -->
  <xsl:template match="n:eExam.21" />

  <!-- eProtocols.01: Map new values to existing values or "Other" -->
  <xsl:template match="n:eProtocols.01[. > '9914199']">
    <xsl:copy>
      <xsl:choose>
        <!-- Injury-Conducted Electrical Weapon (e.g., Taser) => Injury-Electrical Injuries -->
        <xsl:when test=". = '9914203'">9914095</xsl:when>
        <!-- Injury-Facial Trauma => Injury-Head -->
        <xsl:when test=". = '9914205'">9914101</xsl:when>
        <!-- [...] Poisoning/Overdose => General-Overdose/Poisoning/Toxic Ingestion -->
        <xsl:when test=". = '9914215' or . = '9914217' or . = '9914219' or .= '9914225'">9914135</xsl:when>
        <!-- Medical-Respiratory Distress-[...] => Medical-Respiratory Distress/Asthma/COPD/Reactive Airway-->
        <xsl:when test=". = '9914221' or . = '9914223'">9914139</xsl:when>
        <!-- Other new values => Other -->
        <xsl:otherwise>9914165</xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- eMedications.06: Map new values to "Other" -->
  <xsl:template match="n:eMedications.06[. > '3706029']">
    <xsl:copy>3706029</xsl:copy>
  </xsl:template>

  <!-- eProcedures.07: Map new values to existing values -->
  <xsl:template match="n:eProcedures.07[. > '3907047']">
    <xsl:copy>
      <xsl:choose>
        <!-- "Itching" => "Itching/Urticaria" -->
        <xsl:when test="'3907049'">3907029</xsl:when>
        <!-- "Urticaria" => "Itching/Urticaria" -->
        <xsl:when test="'3907051'">3907029</xsl:when>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- eAirway.AirwayGroup: Move eAirway.08 and eAirway.09 into an instance of eAirway.ConfirmationGroup -->
  <xsl:template match="n:eAirway.AirwayGroup[n:eAirway.08 or n:eAirway.09]">
    <xsl:copy>
      <xsl:apply-templates select="@* | n:eAirway.01 | n:eAirway.ConfirmationGroup"/>
      <eAirway.ConfirmationGroup>
        <xsl:apply-templates select="n:eAirway.08 | n:eAirway.09"/>
      </eAirway.ConfirmationGroup>
      <xsl:apply-templates select="n:eAirway.10 | n:eAirway.11"/>
    </xsl:copy>
  </xsl:template>

  <!-- eDisposition.19: Map new values to existing values by comparing to eDisposition.13 (not precise) -->
  <xsl:template match="n:eDisposition.19[ . != '']">
    <xsl:copy>
      <xsl:choose>
        <!-- If eSituation.13 is empty, unable to map -->
        <xsl:when test="../../n:eSituation/n:eSituation.13 = ''">
          <xsl:attribute name="xsi:nil">true</xsl:attribute>
          <xsl:attribute name="NV">7701003</xsl:attribute>
        </xsl:when>
        <!-- Dead without Resuscitation Efforts (Black) -->
        <xsl:when test=". = '4219007'">
          <xsl:choose>
            <!-- Dead without Resuscitation Efforts => Unchanged -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813007'">9916003</xsl:when>
            <!-- Otherwise => Worse -->
            <xsl:otherwise>9916005</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Critical (Red) -->
        <xsl:when test=". = '4219001'">
          <xsl:choose>
            <!-- Dead without Resuscitation Efforts => Improved -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813007'">9916001</xsl:when>
            <!-- Critical (Red) => Unchanged -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813001'">9916003</xsl:when>
            <!-- Otherwise => Worse -->
            <xsl:otherwise>9916005</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Emergent (Yellow) -->
        <xsl:when test=". = '4219003'">
          <xsl:choose>
            <!-- Lower Acuity (Green) => Worse -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813005'">9916005</xsl:when>
            <!-- Emergent (Yellow) => Unchanged -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813003'">9916003</xsl:when>
            <!-- Otherwise => Improved -->
            <xsl:otherwise>9916001</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Lower Acuity (Green) -->
        <xsl:when test=". = '4219005'">
          <xsl:choose>
            <!-- Lower Acuity (Green) => Unchanged -->
            <xsl:when test="../../n:eSituation/n:eSituation.13 = '2813005'">9916003</xsl:when>
            <!-- Otherwise => Improved -->
            <xsl:otherwise>9916001</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- eDisposition.22: Map new values to "Hospital-Other" -->
  <xsl:template match="n:eDisposition.22[. > '4222049']">
    <xsl:copy>4222035</xsl:copy>
  </xsl:template>

  <!-- eOutcome.08: Remove instances after first instance -->
  <xsl:template match="n:eOutcome.08[preceding-sibling::n:eOutcome.08]"/>

  <!-- eOutcome.08/@CorrelationID: Remove -->
  <xsl:template match="n:eOutcome.08/@CorrelationID"/>

  <!-- eOutcome.13: Remove if not matching pattern -->
  <xsl:template match="n:eOutcome.13[not(matches(., '^[A-Z][0-9]{2}((\.[0-9A-Z]{1,4})?)$'))]" />

  <!-- eOther.13: Remove instances after first instance -->
  <xsl:template match="n:eOther.13[preceding-sibling::n:eOther.13]"/>

  <!-- eOther.13/@CorrelationID: Remove -->
  <xsl:template match="n:eOther.13/@CorrelationID"/>

</xsl:stylesheet>
