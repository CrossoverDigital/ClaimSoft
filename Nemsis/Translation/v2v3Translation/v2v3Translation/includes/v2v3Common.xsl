<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform xmlns="http://www.nemsis.org"
            xmlns:n="http://www.nemsis.org"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            version="2.0"
            exclude-result-prefixes="n xs xsl"
            xpath-default-namespace="http://www.nemsis.org">


  <!--
  Define variables and keys.
  Many of the keys defined below are compound keys. Compound keys are not directly supported in XSLT 2, so the string-join() function is used,
  with zero-width space (&#8203;) as a delimiter. Zero-width space is unlikely to appear in NEMSIS 2 XML data in a way that would
  compromise the key lookups, but the possibility exists.
  -->

  <!-- Define variable and key for element mappings. -->
  <xsl:variable name="elementMappingVariable" select="document('v2v3ElementMapping.xml')/*"/>
  <xsl:key name="elementMappingKey" match="/v2v3ElementMapping/match" use="string-join((normalize-space(v2ElementName), normalize-space(v3ElementName)), '&#8203;')"/>

  <!-- Define variable and key for null/not value mappings. -->
  <xsl:variable name="nullNotVariable" select="document('v2v3ValueMappingNullNot.xml')/*"/>
  <xsl:key name="nullNotKey" match="/v2v3ValueMappingNullNot/match" use="string-join((normalize-space(v2Pattern), normalize-space(v3NotValueMemberTypes)), '&#8203;')"/>

  <!-- Define variable and key for enumerated value mappings for EMSDemographicDataSet or EMSDataSet. -->
  <xsl:variable name="lookupVariable">
    <xsl:choose>
      <xsl:when test="/EMSDataSet">
        <xsl:sequence select="document('v2v3ValueMappingEMSDataSet.xml')/*"/>
      </xsl:when>
      <xsl:when test="/EMSDemographicDataSet">
        <xsl:sequence select="document('v2v3ValueMappingEMSDemographicDataSet.xml')/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:key name="lookupKey" match="/v2v3ValueMappingEMSDemographicDataSet/match|v2v3ValueMappingEMSDataSet/match" use="string-join((normalize-space(v2TypeName), normalize-space(v3TypeName), normalize-space(lower-case(v2Pattern))), '&#8203;')"/>

  <!-- Define variable and key for city value mappings. -->
  <xsl:variable name="cityVariable" select="document('v2v3ValueMappingCity.xml')/*"/>
  <xsl:key name="cityKey" match="/v2v3ValueMappingCity/match" use="string-join((normalize-space(STATE_NUMERIC), normalize-space(CENSUS_CODE)), '&#8203;')"/>

  <!-- Define variable and key for medication value mappings. -->
  <xsl:variable name="medicationVariable" select="document('v2v3ValueMappingMedication.xml')/*"/>
  <xsl:key name="medicationKey" match="/v2v3ValueMappingMedication/match" use="normalize-space(lower-case(v2Pattern))"/>

  <!-- Define variable and key for current medication value mappings (only used for EMSDataSet, but variable must be defined even if not used). -->
  <xsl:variable name="currentMedicationVariable">
    <xsl:if test="/EMSDataSet">
      <xsl:sequence select="document('v2v3ValueMappingCurrentMedication.xml')/*"/>
    </xsl:if>
  </xsl:variable>
  <xsl:key name="currentMedicationKey" match="/v2v3ValueMappingCurrentMedication/match" use="normalize-space(lower-case(v2Pattern))"/>

  <!-- Define variable and key for current medication value mappings (only used for EMSDataSet, but variable must be defined even if not used). -->
  <xsl:variable name="medicalSurgicalHistoryVariable">
    <xsl:if test="/EMSDataSet">
      <xsl:sequence select="document('v2v3ValueMappingMedicalSurgicalHistory.xml')/*"/>
    </xsl:if>
  </xsl:variable>
  <xsl:key name="medicalSurgicalHistoryKey" match="/v2v3ValueMappingMedicalSurgicalHistory/match" use="normalize-space(lower-case(v2Pattern))"/>

  <!-- Define variable and key for current medication value mappings (only used for EMSDataSet, but variable must be defined even if not used). -->
  <xsl:variable name="medicationAllergyVariable">
    <xsl:if test="/EMSDataSet">
      <xsl:sequence select="document('v2v3ValueMappingMedicationAllergy.xml')/*"/>
    </xsl:if>
  </xsl:variable>
  <xsl:key name="medicationAllergyKey" match="v2v3ValueMappingMedicationAllergy/match" use="normalize-space(lower-case(v2Pattern))"/>

  <!-- Define variables and key for (d|e)customConfiguration. -->
  <xsl:variable name="elementMappingCustomConfigurationVariable" select="document('v2v3ElementMappingCustomConfiguration.xml')/*"/>
  <xsl:variable name="customConfigurationVariable" select="document('v2v3ValueMappingCustomConfiguration.xml')/*"/>
  <xsl:key name="customConfigurationKey" match="/v2v3ValueMappingCustomConfiguration/match" use="normalize-space(customElementId)"/>


  <!-- 
  n:map: Main mapping function.
  -->
  <xsl:function name="n:map">
    <xsl:param name="v3ElementName"/>
    <xsl:param name="v2ElementName"/>
    <xsl:param name="v2Element"/>
    <xsl:variable name="elementMapping" select="key('elementMappingKey', string-join((normalize-space($v2ElementName), normalize-space($v3ElementName)), '&#8203;'), $elementMappingVariable)"/>

    <xsl:variable name="finalResult">
      <xsl:for-each select="$v2Element">

        <!-- See if there's a null/NV match for this element mapping and value. -->
        <xsl:variable name="nullNotResult">
          <xsl:sequence select="n:mapNullNot(., $elementMapping)"/>
        </xsl:variable>

        <!-- If there's no null/NV match, see if there's a pattern test match for this element mapping and value. -->
        <xsl:variable name="expressionResult">
          <xsl:if test="not($nullNotResult/v3Replacement)">
            <xsl:sequence select="n:mapExpression(., $elementMapping)"/>
          </xsl:if>
        </xsl:variable>

        <!-- If there's no pattern test match or the "otherwise" choice was matched, see if there are enumerated list matches for this element mapping and value. -->
        <xsl:variable name="lookupResult">
          <xsl:if test="not($nullNotResult/v3Replacement) and (not($expressionResult/v3Replacement) or $expressionResult/v3Replacement/@otherwise='true')">
            <xsl:sequence select="n:mapLookup(., $elementMapping)"/>
          </xsl:if>
        </xsl:variable>

        <!-- Set final result. The priority is: 1) null/not mapping result; 2) pattern test "when" result; 3) lookup result; 4) pattern test "otherwise" result. -->
        <xsl:choose>
          <xsl:when test="$nullNotResult/v3Replacement[@NV!='']">
            <xsl:sequence select="n:mapCorrelationID($nullNotResult, $elementMapping, .)"/>
          </xsl:when>
          <xsl:when test="$lookupResult/v3Replacement">
            <xsl:sequence select="n:mapCorrelationID($lookupResult, $elementMapping, .)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="n:mapCorrelationID($expressionResult, $elementMapping, .)"/>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>

      <!-- If there is a result, generate a v3 element. -->
      <xsl:when test="$finalResult/v3Replacement">
        <xsl:sequence select="n:mapFinish($finalResult, $elementMapping)"/>
      </xsl:when>

      <!-- Otherwise, generate an appropriate v3 element if the v3 element is not optional. -->
      <xsl:otherwise>
        <xsl:sequence select="n:mapMissing($elementMapping)"/>
      </xsl:otherwise>

    </xsl:choose>

  </xsl:function>


  <!-- 
  n:mapNullNot: Function for processing null/not value transformations.
  -->
  <xsl:function name="n:mapNullNot">
    <xsl:param name="v2Element"/>
    <xsl:param name="elementMapping"/>

    <!-- If the v2 element allows null values, look for a null/NV match.  -->
    <xsl:if test="$elementMapping/v2HasNulls='true'">
      <xsl:variable name="result">
        <xsl:choose>

          <!-- If the v3 element allows not values, look for a null/NV match. -->
          <xsl:when test="$elementMapping/v3NotValueMemberTypes!=''">
            <xsl:element name="v3Replacement">
              <xsl:attribute name="xsi:nil">true</xsl:attribute>
              <xsl:attribute name="NV">
                <xsl:value-of select="key('nullNotKey', string-join((normalize-space($v2Element), normalize-space($elementMapping/v3NotValueMemberTypes)), '&#8203;'), $nullNotVariable)/v3Replacement"/>
              </xsl:attribute>
            </xsl:element>
          </xsl:when>

          <!-- If the v3 element is optional, look for a null/NV match and indicate not to generate the v3element if a match is found. -->
          <xsl:when test="$elementMapping/v3MinOccurs=0">
            <xsl:element name="v3Replacement">
              <xsl:attribute name="xsi:nil">true</xsl:attribute>
              <xsl:attribute name="noElement">
                <xsl:value-of select="key('nullNotKey', string-join((normalize-space($v2Element), 'NV'), '&#8203;'), $nullNotVariable)/v3Replacement"/>
              </xsl:attribute>
            </xsl:element>
          </xsl:when>

        </xsl:choose>
      </xsl:variable>

      <xsl:if test="$result/v3Replacement[@NV!='' or @noElement!='']">
        <xsl:sequence select="$result"/>
      </xsl:if>
    </xsl:if>

  </xsl:function>


  <!-- 
  n:mapLookup: Function for processing lookup transformations.
  -->
  <xsl:function name="n:mapLookup">
    <xsl:param name="v2Element"/>
    <xsl:param name="elementMapping"/>
    <xsl:variable name="lookupList">
      <xsl:choose>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='City'                        and normalize-space($elementMapping/v3TypeName)='CityGnisCode'"       >city</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='City'                        and normalize-space($elementMapping/v3TypeName)='CityGnisCodePayment'">city</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='CurrentMedicationName'       and normalize-space($elementMapping/v3TypeName)='Medication'"         >currentMedication</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='MedicalSurgicalHistory'      and normalize-space($elementMapping/v3TypeName)='icd10MedSurge'"      >medicalSurgicalHistory</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='DemographicMedicationsGiven' and normalize-space($elementMapping/v3TypeName)='Medication'"         >medication</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='MedicationsGiven'            and normalize-space($elementMapping/v3TypeName)='Medication'"         >medication</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='PriorAid'                    and normalize-space($elementMapping/v3TypeName)='Medication'"         >medication</xsl:when>
        <xsl:when test="normalize-space($elementMapping/v2TypeName)='MedicationAllergies'         and normalize-space($elementMapping/v3TypeName)='MedicationAllergies'">medicationAllergy</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>

      <xsl:when test="$lookupList='city'">

        <!-- Find the value of the accompanying v2 element that contains the state code. -->
        <xsl:variable name="stateCode">
          <xsl:choose>

            <!-- If the v2 element is E08_12, the state code is in E08_14. -->
            <xsl:when test="$elementMapping/v2ElementName='E08_12'">
              <xsl:value-of select="$v2Element/../E08_14" />
            </xsl:when>

            <!-- Otherwise, the state code is in the first following sibling element. -->
            <!-- This is an assumption that is true for the national v2 standard. -->
            <xsl:otherwise>
              <xsl:value-of select="$v2Element/following-sibling::*[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <!-- Prioritize city codes that have a census class code that starts with "C" or "P". -->
        <xsl:for-each select="key('cityKey', string-join((normalize-space($stateCode), normalize-space($v2Element)), '&#8203;'), $cityVariable)">
          <xsl:sort select="not(starts-with(normalize-space(CENSUS_CLASS_CODE),'C') or starts-with(normalize-space(CENSUS_CLASS_CODE),'P'))"/>
          <xsl:sort select="normalize-space(CENSUS_CLASS_CODE)"/>
          <!-- Assign v3Replacement. For v3 CityGnisCodePayment type, use FEATURE_NAME (text); otherwise, use FEATURE_ID (GNIS code). -->
          <xsl:element name="v3Replacement">
            <xsl:choose>
              <xsl:when test="normalize-space($elementMapping/v3TypeName)='CityGnisCodePayment'">
                <xsl:value-of select="normalize-space(FEATURE_NAME)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="normalize-space(FEATURE_ID)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
        </xsl:for-each>

      </xsl:when>

      <xsl:when test="$lookupList='currentMedication'">
        <xsl:sequence select="key('currentMedicationKey', normalize-space(lower-case($v2Element)), $currentMedicationVariable)/v3Replacement"/>
      </xsl:when>
      <xsl:when test="$lookupList='medicalSurgicalHistory'">
        <xsl:sequence select="key('medicalSurgicalHistoryKey', normalize-space(lower-case($v2Element)), $medicalSurgicalHistoryVariable)/v3Replacement"/>
      </xsl:when>
      <xsl:when test="$lookupList='medication'">
        <xsl:sequence select="key('medicationKey', normalize-space(lower-case($v2Element)), $medicationVariable)/v3Replacement"/>
      </xsl:when>
      <xsl:when test="$lookupList='medicationAllergy'">
        <xsl:sequence select="key('medicationAllergyKey', normalize-space(lower-case($v2Element)), $medicationAllergyVariable)/v3Replacement"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="key('lookupKey', string-join((normalize-space($elementMapping/v2TypeName), normalize-space($elementMapping/v3TypeName), normalize-space(lower-case($v2Element))), '&#8203;'), $lookupVariable)/v3Replacement"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:function>


  <!--
  n:mapMissing: Function for generating an appropriate v3 element when there have been no results and the v3 element is not optional.
  -->
  <xsl:function name="n:mapMissing">
    <xsl:param name="elementMapping"/>
    <!-- If the v3 element is not optional, generate an appropriate v3 element. -->
    <xsl:if test="not($elementMapping/v3MinOccurs='0')">
      <xsl:variable name="lookupMissingResult">
        <xsl:choose>
          <!-- If the v3 element allows not values, generate a v3 element with a not value representing "Not Recorded". -->
          <xsl:when test="$elementMapping/v3NotValueMemberTypes!=''">
            <xsl:element name="v3Replacement">
              <xsl:attribute name="xsi:nil">true</xsl:attribute>
              <xsl:attribute name="NV">7701003</xsl:attribute>
            </xsl:element>
          </xsl:when>
          <!-- Otherwise, find the enumerated list match for this element mapping and an empty value. -->
          <xsl:otherwise>
            <xsl:sequence select="n:mapLookup('', $elementMapping)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- Generate a v3 element. -->
      <xsl:sequence select="n:mapFinish($lookupMissingResult, $elementMapping)"/>
    </xsl:if>
  </xsl:function>


  <!--
  n:mapCorrelationID: Function for generating a CorrelationID if appropriate.
  -->
  <xsl:function name="n:mapCorrelationID">
    <xsl:param name="result"/>
    <xsl:param name="elementMapping"/>
    <xsl:param name="v2Element"/>

    <!-- Generate a copy of the result and add a CorrelationID if the v3 element can have one. -->
    <xsl:for-each select="$result/v3Replacement">
      <xsl:element name="v3Replacement">
        <xsl:if test="$v2Element and $elementMapping/v3HasCorrelationID='true'">
          <xsl:attribute name="CorrelationID">
            <xsl:value-of select="generate-id($v2Element)"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:sequence select="@*"/>
        <xsl:sequence select="."/>
      </xsl:element>
    </xsl:for-each>

  </xsl:function>


  <!-- 
  n:mapFinish: Function for finalizing transformation prior to output. 
  -->
  <xsl:function name="n:mapFinish">
    <xsl:param name="result"/>
    <xsl:param name="elementMapping"/>
    <!-- If there are multiple v3Replacements but the v3 element only allows one instance, pick the first v3Replacement; otherwise use all v3Replacements. -->
    <xsl:variable name="v3Replacement">
      <xsl:choose>
        <xsl:when test="not($elementMapping/v3MaxOccurs='unbounded') and count($result/v3Replacement)>1">
          <xsl:sequence select="$result/v3Replacement[1]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$result/v3Replacement"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="$v3Replacement/v3Replacement">
      <xsl:element name="{$elementMapping/v3ElementName}">

        <!-- Copy any attributes if present (these would come from n:mapNullNot). -->
        <xsl:sequence select="@*[name()!='otherwise']"/>

        <!-- 
        Some lookups return XML escaped strings of xsl:attribute definitions; if present, parse each of them into a real attribute. 
        The escaped string must be all on one line and not contain any extra whitespace within the xsl:attribute definitions.
        -->
        <xsl:analyze-string select="." regex="&lt;xsl:attribute name=&quot;(.*?)&quot;&gt;(.*?)&lt;/xsl:attribute&gt;">
          <xsl:matching-substring>
            <xsl:attribute name="{normalize-space(regex-group(1))}">
              <xsl:value-of select="normalize-space(regex-group(2))"/>
            </xsl:attribute>
          </xsl:matching-substring>
          <!-- Copy element content if present. -->
          <!-- This won't work if the content includes child nodes. It will only copy the text contents because of having used xsl:analyze-string. -->
          <xsl:non-matching-substring>
            <xsl:sequence select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>

      </xsl:element>
    </xsl:for-each>
  </xsl:function>


  <!--
  n:mapCustomConfiguration: Function for generating (d|e)CustomConfiguration section.
  $prefix is "d" (dCustomConfiguration) or "e" (eCustomConfiguration).
  -->
  <xsl:function name="n:mapCustomConfiguration">
    <xsl:param name="prefix"/>

      <!-- Create a custom element definition for each custom element that applies to the dataset (d or e). -->
      <xsl:for-each select="$elementMappingCustomConfigurationVariable/match[starts-with(customElementId, upper-case($prefix))]">
        <xsl:element name="{concat($prefix, 'CustomConfiguration.CustomGroup')}">
          <xsl:attribute name="CustomElementID">
            <xsl:value-of select="customElementId"/>
          </xsl:attribute>
          <xsl:element name="{concat($prefix, 'CustomConfiguration.01')}">
            <xsl:attribute name="nemsisElement">
              <xsl:value-of select="nemsisElement"/>
            </xsl:attribute>
            <xsl:value-of select="customTitle"/>
          </xsl:element>
          <xsl:element name="{concat($prefix, 'CustomConfiguration.02')}">
            <xsl:value-of select="customDefinition"/>
          </xsl:element>
          <xsl:element name="{concat($prefix, 'CustomConfiguration.03')}">
            <xsl:value-of select="customDataType"/>
          </xsl:element>
          <xsl:element name="{concat($prefix, 'CustomConfiguration.04')}">
            <xsl:value-of select="customDataElementRecurrence"/>
          </xsl:element>
          <xsl:element name="{concat($prefix, 'CustomConfiguration.05')}">
            <xsl:value-of select="elementUsage"/>
          </xsl:element>
          <xsl:for-each select="key('customConfigurationKey', normalize-space(customElementId), $customConfigurationVariable)">
            <xsl:element name="{concat($prefix, 'CustomConfiguration.06')}">
              <!-- @nemsisCode: No mapping. -->
              <xsl:attribute name="customValueDescription">
                <xsl:value-of select="customValueDescription"/>
              </xsl:attribute>
              <xsl:value-of select="customValue"/>
            </xsl:element>
          </xsl:for-each>
          <xsl:if test="customAcceptableNV='NV'">
            <xsl:element name="{concat($prefix, 'CustomConfiguration.07')}">7701001</xsl:element>
            <xsl:element name="{concat($prefix, 'CustomConfiguration.07')}">7701003</xsl:element>
            <xsl:element name="{concat($prefix, 'CustomConfiguration.07')}">7701005</xsl:element>
          </xsl:if>
        </xsl:element>
        <!-- (d|e)CustomConfiguration.08: No mapping. -->
      </xsl:for-each>

  </xsl:function>


</xsl:transform>
