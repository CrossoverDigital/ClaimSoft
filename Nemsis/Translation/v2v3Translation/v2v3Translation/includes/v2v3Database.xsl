<?xml version="1.0" encoding="UTF-8"?>
<!-- 
XSLT to transform output from database that will be loaded or imported by main XSL transformation.
-->
<xsl:transform xmlns="http://www.nemsis.org"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:msxsl="urn:schemas-microsoft-com:xslt"
            version="1.0"
            exclude-result-prefixes="msxsl xsl">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <!-- This key is used for the expression-based transforms. -->
  <xsl:key name="typePair" match="/*/*" use="concat(v2TypeName, '&#8203;', v3TypeName)"/>

  <!-- Convert everything to local namespace -->
  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- All lists: Define and sort -->
  <xsl:template match="/*">
    <xsl:variable name="elementName">
      <xsl:choose>
        <xsl:when test="contains(local-name(*[1]),'query_')">
          <xsl:value-of select="substring-after(local-name(*[1]), 'query_')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name(*[1])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name="{$elementName}">
      <xsl:apply-templates select="*">

        <!-- This sort will apply to element list. -->
        <xsl:sort select="v2ElementName"/>
        <xsl:sort select="v3ElementName"/>

        <!-- This sort will apply to core list. -->
        <xsl:sort select="v2TypeName"/>
        <xsl:sort select="v3TypeName"/>
        <xsl:sort select="order"/>

        <!-- This sort will apply to most lists. -->
        <xsl:sort select="v2Pattern"/>
        <xsl:sort select="v3Replacement"/>

        <!-- This sort will apply to City list. -->
        <xsl:sort select="STATE_NUMERIC"/>
        <xsl:sort select="CENSUS_CODE"/>
        <!-- Prioritize city codes with a census class code that starts with "C" or "P". -->
        <xsl:sort select="not(starts-with(CENSUS_CLASS_CODE,'C') or starts-with(CENSUS_CLASS_CODE,'P'))"/>
        <xsl:sort select="CENSUS_CLASS_CODE"/>

        <!-- This sort will apply to NullNot list. -->
        <xsl:sort select="v3NotValueMemberTypes"/>
        <xsl:sort select="v2NullValue"/>

        <!-- This sort will apply to Custom lists. -->
        <xsl:sort select="customElementId"/>

        <!-- This sort will apply to Custom Value list. -->
        <xsl:sort select="customValue"/>

      </xsl:apply-templates>
    </xsl:element>
  </xsl:template>

  <!-- All lists: Output child elements. -->
  <xsl:template match="/*/*">
    <match>

      <!-- This will be output for ElementMapping list. -->
      <xsl:apply-templates select="v2ElementName"/>

      <!-- This will be output for ElementMapping and core ValueMapping lists. -->
      <xsl:apply-templates select="v2TypeName"/>

      <!-- These will be output for ElementMapping list. -->
      <xsl:apply-templates select="v2HasNulls"/>
      <xsl:apply-templates select="v3ElementName"/>

      <!-- This will be output for ElementMapping and core ValueMapping lists. -->
      <xsl:apply-templates select="v3TypeName"/>

      <!-- This will be output for core ValueMapping lists. -->
      <xsl:apply-templates select="order"/>

      <!-- These will be output for most lists. -->
      <xsl:apply-templates select="v2Pattern"/>
      <xsl:apply-templates select="v3Replacement"/>

      <!-- This will be output for MedicationAllergy list. -->
      <xsl:apply-templates select="v3CodeType"/>

      <!-- This will be output for ElementMapping list. -->
      <xsl:apply-templates select="v3MinOccurs"/>
      <xsl:apply-templates select="v3MaxOccurs"/>
      <xsl:apply-templates select="v3HasCorrelationID"/>

      <!-- This will be output for ElementMapping and NullNot lists. -->
      <xsl:apply-templates select="v3NotValueMemberTypes"/>

      <!-- These will be output for City list. -->
      <xsl:apply-templates select="STATE_NUMERIC"/>
      <xsl:apply-templates select="CENSUS_CODE"/>
      <xsl:apply-templates select="CENSUS_CLASS_CODE"/>
      <xsl:apply-templates select="FEATURE_ID"/>
      <xsl:apply-templates select="FEATURE_NAME"/>

      <!-- This will be output for Custom lists. -->
      <xsl:apply-templates select="customElementId"/>

      <!-- These will be output for Custom Element list. -->
      <xsl:apply-templates select="customTitle"/>
      <xsl:apply-templates select="nemsisElement"/>
      <xsl:apply-templates select="customDefinition"/>
      <xsl:apply-templates select="customDataType"/>
      <xsl:apply-templates select="customDataElementRecurrence"/>
      <xsl:apply-templates select="elementUsage"/>
      <xsl:apply-templates select="customAcceptableNV"/>

      <!-- These will be output for Custom Value list. -->
      <xsl:apply-templates select="customValue"/>
      <xsl:apply-templates select="customValueDescription"/>

    </match>
  </xsl:template>

  <!-- This template processes the expression-based transforms. -->
  <xsl:template match="/*[query_v2v3ValueMappingEMSDemographicDataSetExpression|query_v2v3ValueMappingEMSDataSetExpression]">
    <xsl:element name="xsl:transform">

      <!-- MSXSL 1.0 work-around for adding namespace declarations to the xsl:transform element. -->
      <xsl:variable name="namespaces">
        <xsl:element name="e" namespace="http://www.nemsis.org"/>
        <xsl:element name="n:e" namespace="http://www.nemsis.org"/>
        <xsl:element name="xs:e" namespace="http://www.w3.org/2001/XMLSchema"/>
        <xsl:element name="xsi:e" namespace="http://www.w3.org/2001/XMLSchema-instance"/>
      </xsl:variable>
      <xsl:copy-of select="msxsl:node-set($namespaces)/*/namespace::*"/>

      <xsl:attribute name="version">2.0</xsl:attribute>
      <xsl:attribute name="exclude-result-prefixes">n xs xsl</xsl:attribute>
      <xsl:attribute name="xpath-default-namespace">http://www.nemsis.org</xsl:attribute>
      <xsl:element name="xsl:function">
        <xsl:attribute name="name">n:mapExpression</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">v2Element</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">elementMapping</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:variable">
          <xsl:attribute name="name">result</xsl:attribute>
          <xsl:text>
          </xsl:text>
          <xsl:comment>The calling function will only send one instance of v2Element to this function, but the for-each allows us to change the context node so we can use "." notation to refer to v2Element.</xsl:comment>
          <xsl:text>
          </xsl:text>
          <xsl:element name="xsl:for-each">
            <xsl:attribute name="select">$v2Element</xsl:attribute>
            <xsl:element name="xsl:element">
              <xsl:attribute name="name">v3Replacement</xsl:attribute>
              <xsl:element name="xsl:choose">
                <!-- Group: pair of v2TypeName and v3TypeName. -->
                <xsl:for-each select="*[generate-id(.)=generate-id(key('typePair', concat(v2TypeName, '&#8203;', v3TypeName))[1])]">
                  <xsl:sort select="v2TypeName"/>
                  <xsl:sort select="v3TypeName"/>
                  <xsl:element name="xsl:when">
                    <xsl:attribute name="test">normalize-space($elementMapping/v2TypeName)='<xsl:value-of select="normalize-space(v2TypeName)"/>' and normalize-space($elementMapping/v3TypeName)='<xsl:value-of select="normalize-space(v3TypeName)"/>'</xsl:attribute>
                    <xsl:element name="xsl:choose">
                      <!-- Process each row from the database within the group. -->
                      <xsl:for-each select="key('typePair', concat(v2TypeName, '&#8203;', v3TypeName))">
                        <xsl:sort select="orderOtherwise"/>
                        <xsl:sort select="order"/>
                        <xsl:choose>
                          <xsl:when test="v2Pattern!='otherwise'">
                            <xsl:element name="xsl:when">
                              <xsl:attribute name="test">
                                <xsl:value-of select="v2Pattern"/>
                              </xsl:attribute>
                              <xsl:element name="xsl:value-of">
                                <xsl:attribute name="select">
                                  <xsl:value-of select="v3Replacement"/>
                                </xsl:attribute>
                              </xsl:element>
                            </xsl:element><!--/xsl:when-->
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:element name="xsl:otherwise">
                              <xsl:element name="xsl:attribute">
                                <xsl:attribute name="name">otherwise</xsl:attribute>
                                <xsl:text>true</xsl:text>
                              </xsl:element>
                              <xsl:element name="xsl:value-of">
                                <xsl:attribute name="select">
                                  <xsl:value-of select="v3Replacement"/>
                                </xsl:attribute>
                              </xsl:element>
                            </xsl:element>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:element><!--/xsl:choose-->
                  </xsl:element><!--/xsl:when-->
                </xsl:for-each>
              </xsl:element><!--/xsl:choose-->
            </xsl:element><!--/xsl:element-->
          </xsl:element><!--/xsl:for-each-->
        </xsl:element><!--/xsl:variable-->
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">$result/v3Replacement!=''</xsl:attribute>
          <xsl:element name="xsl:sequence">
            <xsl:attribute name="select">$result</xsl:attribute>
          </xsl:element>
        </xsl:element><!--/xsl:if-->
      </xsl:element><!--/xsl:function-->
    </xsl:element><!--/xsl:transform-->
  </xsl:template>

</xsl:transform>
