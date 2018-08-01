<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="facetFound" match="element/restrictions/*/facet" use="@name"/>
<xsl:output method="html" encoding="us-ascii"/>
<xsl:template match="/">  
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title><xsl:value-of select="element/@number"/> - <xsl:value-of select="element/name"/></title>
    <style type="text/css">
      body {font-family:arial,helvetica,sans-serif; position:relative;}
            
      .pageHeadingElement {font-size:20px;}
  
      .deprecated {width:80px;font-size:14px;text-align:center;color:white;background: PURPLE no-repeat;}
      .national {width:80px;font-size:14px;text-align:center;color:white;background-color:#E10000;}
      .state    {width:80px;font-size:14px;text-align:center;color:white;background-color:#008000;}
      
      .numberName {font-size:14px;color:white;padding:3px 0 3px 5px;background-color:#004080;}
         
      .definitionTitle {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}    
      .definitionValue {font-size:14px;}

      .summaryTitle         {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .summaryValue         {font-size:14px;padding:2px 0 2px 2px;border:1px solid #004080;}
            
      .attributeTitle         {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .attributeName          {font-size:12px;font-weight:bold;color:#004080;}
      .attributeValue         {font-size:12px;}
            
      .sectionCommentTitle    {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .sectionCommentValue    {font-size:12px;}
      
      .sectionV3ChangesTitle  {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .sectionV3ChangesValue  {font-size:12px;}

      .sectionDeprecatedCommentTitle  {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .sectionDeprecatedCommentValue  {font-size:12px;}
            
      .sectionRestrictionsEnumerationCodeTitle        {width:60px;  font-size:12px;font-weight:bold;}
      .sectionRestrictionsEnumerationDescriptionTitle {width:560px; font-size:12px;font-weight:bold;}
      .sectionRestrictionsEnumerationCodeValue        {width:60px;  font-size:12px;}
      .sectionRestrictionsEnumerationDescriptionValue {width:560px; font-size:12px;}     
             
      .sectionAssociatedMeasuresTitle     {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .sectionAssociatedMeasuresValue     {font-size:12px;padding-right:30px;}      
      
      .sectionRestrictionsTitle   {font-size:14px;background:#F0F0F0;color:#004080;padding:2px 0 2px 2px;border:1px solid #004080;}
      .sectionRestrictionsPattern {width:600px;font-size:12px;}
      
      .sectionRestrictionsDataTypeTitle   {width:120px;font-size:12px;font-weight:bold;}
      .sectionRestrictionsDataTypeValue   {width:120px;font-size:12px;}     
      .sectionRestrictionsConstraintTitle {width:155px;font-size:12px;font-weight:bold;}
      .sectionRestrictionsConstraintValue {width:155px;font-size:12px;}
      
      .sectionConstraintsHeaderDataType   {width:100px;font-size:12px;font-weight:bold;}
      .sectionConstraintsValueDataType    {width:100px;font-size:12px;}      
      .sectionConstraintsHeaderDateTime   {width:200px;font-size:12px;font-weight:bold;}
      .sectionConstraintsValueDateTime    {width:200px;font-size:12px;}
      
      .td1 {height:1px;width:1px;background-color:#004080;}
      .td2 {height:1px;background-color:#004080;}
      .td3 {width:1px;background-color:#004080;}
    </style>
</head>

<body>
    
         

        
        
  

  <table border="0" cellspacing="0" cellpadding="0" width="675px">    
    <tr><td>
        <table width="675px" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td align="right" class="pageHeadingElement">
              <xsl:value-of select="element/@number"/>
            </td>
          </tr>
        </table>
    </td></tr>  
    <xsl:choose><xsl:when test="element/deprecated/text()='Yes'">   
            <tr><td><table><tr width="80px"><td class="deprecated" height="23px" width="40px">Deprecated</td></tr></table></td></tr>
    </xsl:when></xsl:choose>  
    
    <xsl:choose><xsl:when test="element/state/text()='Yes' or element/national/text()='Yes'">
    <tr>
      <td style="padding:6px 2px 5px 0;">  
        <table border="0" cellspacing="0" cellpadding="0" align="right" >
          <tr>  
            <xsl:choose><xsl:when test="element/state/text()='Yes'">
            <td class="state" height="23px">State</td>
            </xsl:when></xsl:choose>                
            <xsl:choose><xsl:when test="element/national/text()='Yes'">
            <td width="5px;"></td> 
            <td class="national" height="23px">National</td>
            </xsl:when></xsl:choose>  
          </tr>
        </table>
    </td></tr>  
    </xsl:when></xsl:choose>    
    <tr><td style="padding:2px 0 5px 0">  
        <table width="675px" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="numberName" >
              <xsl:value-of select="element/@number"/> - 
                <xsl:choose>  
                  <xsl:when test="element/refNumber"> 
                    (<xsl:value-of select="element/refNumber"/>) 
                  </xsl:when>
                </xsl:choose> 
              <xsl:value-of select="element/name"/>
            </td>
          </tr>
        </table>
    </td></tr> 
    <tr><td  style="padding:0 0 5px 0">      
        <table border="0" cellspacing="0" cellpadding="0" width="675px">
          <tr>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0" width="675px" >
                <tr>
                  <td>
                    <table border="0" cellspacing="0" cellpadding="0" width="675px">
                      <tr>
                        <td width="667px" class="definitionTitle">Definition</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr><td height="2px;"></td></tr>
                <tr>                  
                  <td class="definitionValue" style="padding:0 0 0 5px"><xsl:value-of select="element/definition"/></td>
                </tr>
              </table>
            </td>        
          </tr>
        </table>
    </td></tr>    
    <tr><td style="padding:0 0 5px 0">   
        <table border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0" >
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td class="summaryTitle">National Element</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue"><xsl:value-of select="element/national"/></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="5px"></td>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">Pertinent Negatives (PN)</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue">                        
                          <xsl:choose>
                            <xsl:when test="element/attributes/PN">Yes</xsl:when>
                            <xsl:otherwise>No</xsl:otherwise>
                          </xsl:choose>    
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>            
          </tr>
          
          <tr>
            <td style="padding:3px 0 0 0">  
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">State Element</td>
                      </tr>
                    </table>
                  </td> 
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue"><xsl:value-of select="element/state"/></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>   
            <td width="5px"></td>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">NOT Values</td>
                      </tr>
                    </table>
                  </td>    
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue">
                          <xsl:choose>
                            <xsl:when test="element/attributes/NV">Yes</xsl:when>
                            <xsl:otherwise>No</xsl:otherwise>
                          </xsl:choose> 
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>                     
          </tr>          
          
          <tr><td style="padding:3px 0 0 0">
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">Version 2 Element</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue">                        
                          <xsl:choose>
                            <xsl:when test="string-length(element/v2Number) &gt; 0"><xsl:value-of select="element/v2Number"/></xsl:when>
                            <xsl:otherwise>&#160;</xsl:otherwise>
                          </xsl:choose>     
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="5px"></td>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">Is Nillable</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue"><xsl:value-of select="element/@isNillable"/></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>            
          </tr>   
          <tr><td style="padding:3px 0 0 0"> 
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="summaryTitle">Usage</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue">
                          <xsl:choose>
                            <xsl:when test="element/usage"><xsl:value-of select="element/usage"/></xsl:when>
                            <xsl:otherwise>&#160;</xsl:otherwise>
                          </xsl:choose>   
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="5px"></td>
            <td>  
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="180px" cellspacing="0" cellpadding="0px" border="0" >
                      <tr>
                        <td class="summaryTitle">Recurrence</td>
                      </tr>
                    </table>
                  </td>
                  <td width="2px"></td>
                  <td>
                    <table width="140px" cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td align="center" class="summaryValue">
                          <xsl:value-of select="element/@minOccurs"/> : <xsl:value-of select="element/@maxOccurs"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>            
          </tr>   
        </table>
    </td></tr>
        
    
    <!-- PERFORMANCE MEASURES SECTION -->  
    <xsl:choose>  
    <xsl:when test="element/performanceMeasuresGroup/*"> 
    <tr><td style="padding:0 0 5px 0">     
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="675px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="667px" class="sectionAssociatedMeasuresTitle">Associated Performance Measure Initiatives</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr style="padding:2px 0 0 0"><td>
              <table cellspacing="0" cellpadding="0" border="0" >
                <tr>
                <td width="5px"></td>
                <xsl:for-each select="element/performanceMeasuresGroup/*">                 
                    <td class="sectionAssociatedMeasuresValue">
                      <xsl:value-of select="."/>
                    </td>                 
                </xsl:for-each>  
                </tr>      
              </table>
            </td>                       
          </tr>
        </table>
    </td></tr>           
    </xsl:when>
    </xsl:choose>     
    
    
    
    <!-- ATTRIBUTES --> 
    <xsl:choose>  
    <xsl:when test="element/attributes/*">
    <tr><td style="padding:0 0 5px 0">    
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="675px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="667px" class="attributeTitle">Attributes</td>
                </tr>   
              </table>
            </td>
          </tr>
          
          <xsl:choose><xsl:when test="element/attributes/NV">          
          <tr style="padding:4px 0 0 0">
            <td>
              <table width="667px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="5px"></td>
                  <td width="667px" class="attributeName">NOT Values (NV)</td>
                </tr>         
                <tr>
                  <td width="5px"></td>
                  <td>                      
                    <div class="attributeValue" style="float:left;"> 
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
                        <xsl:for-each select="element/attributes/NV/*/facet">
                        <div class="attributeValue" style="width:220px;float:left;white-space: nowrap;">
                          <xsl:value-of select="@value"/> - <xsl:value-of select="@annotation" disable-output-escaping="yes"/>
                        </div>
                        </xsl:for-each> 
                        </td>
                      </tr>
                    </table>
                    </div>
                  </td>
                </tr>  
              </table>
            </td>
          </tr>
          </xsl:when></xsl:choose>
          
          <xsl:choose><xsl:when test="element/attributes/PN">
          <tr>
            <td style="padding:4px 0 0 0">
              <table width="667px" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td width="5px"></td>
                  <td width="667px" class="attributeName">Pertinent Negatives (PN)</td>
                </tr>         
                <tr>
                  <td width="5px"></td>
                  <td>                      
                    <div class="attributeValue" style="float:left;"> 
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
                        <xsl:for-each select="element/attributes/PN/*/facet">
                        <div class="attributeValue" style="width:220px;float:left;white-space: nowrap;">
                          <xsl:value-of select="@value"/> - <xsl:value-of select="@annotation"/>
                        </div>
                        </xsl:for-each> 
                        </td>
                      </tr>
                    </table>
                    </div>
                  </td>
                </tr>  
              </table>
            </td>
          </tr>
          </xsl:when></xsl:choose>
          
          <xsl:for-each select="element/attributes/*">
          <xsl:choose><xsl:when test="name()!='PN' and name()!='NV' and ./facet/@name!='enumeration' and name()!='TIMESTAMP' ">
          <tr><td style="padding:4px 0 0 0">
              <table width="667px" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td width="667px" class="attributeName" style="padding:0 0 0 5px"><xsl:value-of select="name()"/></td>
                </tr>         
                <tr>
                  <td style="padding:0 0 0 5px">                      
                    <div class="attributeValue" style="float:left;"> 
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td class="attributeValue" style="width:150px;"><b>Data Type: </b><xsl:value-of select="@baseType"/></td>
                        <xsl:for-each select="./facet">
                          <xsl:choose><xsl:when test="@name!='pattern'">
                          <td class="attributeValue" style="width:250px;"><b><xsl:value-of select="@name"/>: </b><xsl:value-of select="@value"/></td>
                          </xsl:when></xsl:choose>
                        </xsl:for-each> 
                      </tr>
                    </table>
                    </div>
                  </td>
                </tr>  
              </table>
            </td>
          </tr>
          </xsl:when></xsl:choose>
          </xsl:for-each> 
          
          
          
          <xsl:for-each select="element/attributes/*">
          <xsl:choose><xsl:when test="name()='TIMESTAMP'"> 
          <tr><td style="padding:4px 0 0 0">
              <table width="667px" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td width="667px" class="attributeName" style="padding:0 0 0 5px"><xsl:value-of select="name()"/></td>
                </tr>         
                <tr>
                  <td style="padding:0 0 0 5px">                      
                    <div class="attributeValue" style="float:left;"> 
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td class="attributeValue" style="width:150px;"><b>Data Type:</b> String</td>
                        <xsl:for-each select="./facet">
                          <xsl:choose><xsl:when test="@name!='pattern'">
                          <td class="attributeValue" style="width:250px;"><b><xsl:value-of select="@name"/>: </b><xsl:value-of select="@value"/></td>
                          </xsl:when></xsl:choose>
                        </xsl:for-each> 
                      </tr>
                    </table>
                    </div>
                  </td>
                </tr>  
              </table>
            </td>
          </tr>
          <tr>
            <td style="padding:4px 0 5px 5px">
              <table width="675px" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td width="675px" class="sectionRestrictionsDataTypeTitle">Pattern</td>
                </tr>         
                <xsl:for-each select="./facet">
                <xsl:choose><xsl:when test="@name='pattern'">
                <tr>
                  <td class="sectionRestrictionsPattern"> 
                    <xsl:value-of select="@value"/> 
                  </td>
                </tr>
                </xsl:when></xsl:choose>
                </xsl:for-each>   
              </table>
            </td>
          </tr>
          </xsl:when></xsl:choose> 
          </xsl:for-each>        
          
            
          
          <xsl:for-each select="element/attributes/*">
          <xsl:choose><xsl:when test="facet/@name='enumeration'">
          <tr><td style="padding:4px 0 0 0">
              <table width="667px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="667px" class="attributeName" style="padding:0 0 0 5px"><xsl:value-of select="name()"/></td>
                </tr>         
                <tr>
                  <td style="padding:0 0 0 5px">                      
                    <div class="attributeValue" style="float:left;"> 
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
                        <xsl:for-each select="./facet">                            
                          <div class="attributeValue" style="width:220px;float:left;white-space: nowrap;">
                          <xsl:value-of select="@value"/> - <xsl:value-of select="@annotation"/>
                          </div>
                        </xsl:for-each> 
                        </td>
                      </tr>
                    </table>
                    </div>
                  </td>
                </tr>  
              </table>
            </td>
          </tr>
          </xsl:when></xsl:choose>
          </xsl:for-each>          
                       
        </table>          
    </td></tr>    
    </xsl:when>
    </xsl:choose>        
    
    
    <!-- CONSTRAINTS SECTION & PATTERNS --> 
    <xsl:choose>  
    <xsl:when test="element/restrictions/*/facet/@name!='enumeration' or element/restrictions/*/@baseType='base64Binary'">
    <tr><td style="padding:0 0 5px 0">    
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="675px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="667px" class="sectionRestrictionsTitle">Constraints</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr><td height="3px;"></td></tr> 
          
          <xsl:choose><xsl:when test="element/restrictions/*/facet/@name!='pattern' or element/restrictions/*/@baseType='base64Binary'"> 
          <tr>
            <td style="padding:0 0 5px 5px">              
              <table cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td width="120px">
                    <table cellspacing="0" cellpadding="0" border="0" >
                      <tr>
                        <td class="sectionRestrictionsDataTypeTitle">Data Type</td>
                      </tr>
                      <tr>
                      <td class="sectionRestrictionsConstraintValue">
                        <xsl:value-of select="element/restrictions/*/@baseType"/>
                      </td>
                      </tr>
                    </table>
                  </td>          
                  <xsl:for-each select="element/restrictions/*/facet">
                    <xsl:if test="@name!='pattern'">
                    <td style="padding:0 10px 0 0">
                        <table cellspacing="0" cellpadding="0">
                        <tr>
                          <td class="sectionRestrictionsConstraintTitle"><xsl:value-of select="@name"/></td>   
                        </tr>
                        <tr>                 
                          <td class="sectionRestrictionsConstraintValue"> 
                            <xsl:choose>  
                              <xsl:when test="../@baseType='positiveInteger' ">
                                <xsl:value-of select="format-number(number(@value),'###,###')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="@value"/>
                              </xsl:otherwise>
                            </xsl:choose>  
                          </td>
                        </tr>
                      </table> 
                    </td>
                    </xsl:if>
                  </xsl:for-each>       
                </tr>  
              </table>  
            </td>
          </tr>    
          </xsl:when></xsl:choose> 
          
          <xsl:choose><xsl:when test="element/restrictions/*/facet/@name='pattern'"> 
            <tr>
              <td style="padding:0 0 5px 5px">
                <table width="675px" cellspacing="0" cellpadding="0" border="0">
                  <tr>
                    <td width="675px" class="sectionRestrictionsDataTypeTitle">Pattern</td>
                  </tr>         
                  <xsl:for-each select="element/restrictions/*/facet">
                  <xsl:choose><xsl:when test="@name='pattern'">
                  <tr>
                    <td class="sectionRestrictionsPattern"> 
                      <xsl:value-of select="@value"/> 
                    </td>
                  </tr>
                  </xsl:when></xsl:choose>
                  </xsl:for-each>   
                </table>
              </td>
            </tr>
          </xsl:when></xsl:choose> 
            
        </table>          
    </td></tr>    
    </xsl:when>
    </xsl:choose>         
        
    <!-- ENUMERATIONS SECTION -->
    <xsl:choose>  
    <xsl:when test="element/restrictions/*/facet/@name='enumeration'">
    <tr><td style="padding:0 0 5px 0"> 
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="675px" cellspacing="0" cellpadding="0" border="0" >
                <tr>
                  <td class="sectionCommentTitle">Code List</td>
                </tr>
              </table>
            </td>
          </tr> 
          <tr>
            <td style="padding:3px 0 0 0">
              <table cellspacing="0" cellpadding="0" border="0" style="padding:0 0 0 5px">
                <tr>
                  <td class="sectionRestrictionsEnumerationCodeTitle">Code</td>
                  <td class="sectionRestrictionsEnumerationCodeTitle">Description</td>
                </tr>
                <xsl:for-each select="element/restrictions/*/facet">
                  <tr>
                    <td class="sectionRestrictionsEnumerationCodeValue" valign="top">
                      <xsl:value-of select="@value"/>
                    </td>
                    <td class="sectionRestrictionsEnumerationDescriptionValue">
                      <xsl:value-of select="@annotation"  disable-output-escaping="yes"/>                      
    									<xsl:choose>  
    									<xsl:when test="@deprecated='true'">
                           <span style="background:purple;margin:0 2px;color:white;padding:0 2px">DEPRECATED</span>
    									</xsl:when>
    									</xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each> 
              </table>
            </td>                       
          </tr>
        </table>     
    </td></tr>          
    </xsl:when>
    </xsl:choose>    
        
        
    <!-- DATA ELEMENT COMMENT SECTION -->
    <!--<xsl:choose>  
    <xsl:when test="string-length(element/v3Comment) &gt;= 0">-->

    <tr><td style="padding:2px 0 5px 0">    
        <table border="0" cellspacing="0">
          <tr>
            <td width="667px" class="sectionCommentTitle">Data Element Comment</td>
          </tr>
          <tr>
            <td class="sectionCommentValue" style="padding:0 0 0 5px"><xsl:copy-of select="element/v3Comment"/></td>
          </tr>
        </table>     
    </td></tr>       
       
    <!-- VERSION 3 CHANGES IMPLEMENTED SECTION -->
    <xsl:choose>  
    <xsl:when test="string-length(element/v3Changes) &gt; 0">
    <tr><td>  
        <table border="0" cellspacing="0" cellpadding="0" width="675px">
          <tr>
            <td width="667px" class="sectionV3ChangesTitle">Version 3 Changes Implemented</td>
          </tr>
          <tr>
            <td class="sectionV3ChangesValue" style="padding:0 0 0 5px"><xsl:copy-of select="element/v3Changes"/></td>
          </tr>
        </table>     
    </td></tr>       
    </xsl:when>
    </xsl:choose>
     
    <!-- Deprecated Comment SECTION -->
    <xsl:choose>  
    <xsl:when test="string-length(element/deprecatedComment) &gt; 0">
    
    <tr><td>  
        <table border="0" cellspacing="0" cellpadding="0" width="675px">
          <tr>
            <td width="667px" class="sectionDeprecatedCommentTitle">Deprecated Comment</td>
          </tr>
          <tr>
            <td class="sectionDeprecatedCommentValue" style="padding:0 0 0 5px"><xsl:copy-of select="element/deprecatedComment"/></td>
          </tr>
        </table>     
    </td></tr>       
    </xsl:when>
    </xsl:choose>
     
  </table>

                 
</body>
</html>
</xsl:template>
</xsl:stylesheet>