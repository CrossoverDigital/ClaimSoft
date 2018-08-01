<?xml version="1.0" encoding="UTF-8"?>

<!--

XML Stylesheet Language Transformation (XSLT) to transform NEMSIS DEMDataSet from 3.4.0 to v3.3.4

Version: 3.4.0.160713CP2_3.3.4.160713CP2_170227
Revision Date: February 27, 2017

-->

<xsl:stylesheet version="2.0"
	xmlns="http://www.nemsis.org"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:n="http://www.nemsis.org"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="n">

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
    <xsl:attribute name="xsi:schemaLocation">http://www.nemsis.org http://www.nemsis.org/media/nemsis_v3/release-3.3.4/XSDs/NEMSIS_XSDs/DEMDataSet_v3.xsd</xsl:attribute>
  </xsl:template>

  <!-- @StreetAddress2: Truncate -->
  <xsl:template match="@StreetAddress2">
    <xsl:attribute name="StreetAddress2">
      <xsl:value-of select="substring(., 1, 55)"/>
    </xsl:attribute>
  </xsl:template>

  <!-- dCustomConfiguration.09: Remove -->
  <xsl:template match="n:dCustomConfiguration.09"/>

  <!-- dAgency.22/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:dAgency.22/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- dContact.02, dPersonnel.01: Truncate -->
  <xsl:template match="n:dContact.02 | n:dPersonnel.01">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="substring(., 1, 50)"/>
    </xsl:copy>
  </xsl:template>

  <!-- dContact.05, dFacility.07, dLocation.06, dPersonnel.04: Truncate -->
  <xsl:template match="n:dContact.05 | n:dLocation.06 | n:dPersonnel.04 | n:dFacility.07">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="substring(., 1, 55)"/>
    </xsl:copy>
  </xsl:template>

  <!-- dConfiguration.05, dConfiguration.10: Map new values to existing values or "Other" -->
  <xsl:template match="n:dConfiguration.05[. > '9914199'] | n:dConfiguration.10[. > '9914199']">
    <xsl:copy>
      <xsl:choose>
        <!-- Injury-Conducted Electrical Weapon (e.g., Taser) => Injury-Electrical Injuries -->
        <xsl:when test=". = '9914203'">9914095</xsl:when>
        <!-- Injury-Facial Trauma => Injury-Head -->
        <xsl:when test=". = '9914205'">9914101</xsl:when>
        <!-- [...] Poisoning/Overdose => General-Overdose/Poisoning/Toxic Ingestion -->
        <xsl:when test=". = '9914215' or . = '9914217' or . = '9914219' or .= '9914225'">9914135</xsl:when>
        <!-- Medical-Respiratory Distress-[...] => Medical-Respiratory Distress/Asthma/COPD/Reactive Airway-->
        <xsl:when test=". = '9914221' or . = '9914023'">9914139</xsl:when>
        <!-- Other new values => Other -->
        <xsl:otherwise>9914165</xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- dPersonnel.24/@NV: Map "Not Reporting" to "Not Recorded" -->
  <xsl:template match="n:dPersonnel.24/@NV[. = '7701005']">
    <xsl:attribute name="NV">7701003</xsl:attribute>
  </xsl:template>

  <!-- dPersonnel.29: Translate code for 2009 Advanced Emergency Medical Technician (AEMT) -->
  <xsl:template match="n:dPersonnel.29[. = '1529001']">
    <xsl:copy>1529901</xsl:copy>
  </xsl:template>

  <!-- dFacility.01: Map new values to "Other" -->
  <xsl:template match="n:dFacility.01[. > '1701011']">
    <xsl:copy>1701009</xsl:copy>
  </xsl:template>

  <!-- dFacility.05: Remove instances after first instance -->
  <xsl:template match="n:dFacility.05[preceding-sibling::n:dFacility.05]"/>

  <!-- dFacility.05/@CorrelationID: Remove -->
  <xsl:template match="n:dFacility.05/@CorrelationID"/>

  <!-- dFacility.15: Remove -->
  <xsl:template match="n:dFacility.15"/>

</xsl:stylesheet>
