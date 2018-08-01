<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" 
	xmlns="http://www.nemsis.org"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:ns0="http://www.nemsis.org" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" 
	exclude-result-prefixes="ns0 xs fn">
	
	
<!-- Used by
	dFacility.11 : Optional
	dAgency.06 : Mandatory
	dLocation.10 : Optional
-->	
	<xsl:template name="ANSICountyCode">
    <xsl:param name="usage"/>
    <xsl:param name="elementName"/>
    <xsl:param name="elementNode" as="node()"/>
    <xsl:variable name="inputAttr" select="$elementNode/@node()"/>
    <xsl:variable name="inputValue" select="$elementNode/node()"/>
    <xsl:choose>
    	<xsl:when test="matches($inputValue,'[0-9]{5}')">
  			<xsl:element name="{$elementName}" exclude-result-prefixes="#all" >
      		<xsl:value-of select="$inputValue" />
  			</xsl:element>
			</xsl:when>
      <xsl:otherwise>
      	<xsl:choose>
    			<xsl:when test="$usage='REQUIRED'">
  					<xsl:element name="{$elementName}">
  						<xsl:attribute name="NV">7701001</xsl:attribute>
  						<xsl:attribute name="xsi:nil">true</xsl:attribute>
  					</xsl:element>
					</xsl:when>
    			<xsl:when test="$usage='MANDATORY'">
  					<xsl:element name="{$elementName}">Unable to transform <xsl:value-of select="$inputValue" /> to integer</xsl:element>
					</xsl:when>
    		</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
 	</xsl:template>

<!-- Used by 
	dAgency.04 : Mandatory
	dAgency.05 : Mandatory
	dConfiguration.01 : Mandatory
	dContact.07 : Recommended
	dFacility.09 : Optional
	dLocation.08 : Optional
	dPersonnel.06 : Optional
	dPersonnel.22 : Recommended
-->
	<xsl:template name="ANSIStateCode">
    <xsl:param name="usage"/>
    <xsl:param name="elementName"/>
    <xsl:param name="elementNode" as="item()"/>
    <xsl:variable name="inputAttr" select="$elementNode/@node()"/>
    <xsl:variable name="inputValue" select="$elementNode/node()"/>
    <xsl:choose>
    	<xsl:when test="matches($inputValue,'[0-9]{2}')">
  			<xsl:element name="{$elementName}" exclude-result-prefixes="#all" >
      		<xsl:value-of select="$inputValue" />
  			</xsl:element>
			</xsl:when>
      <xsl:otherwise>
      	<xsl:choose>
    			<xsl:when test="$usage='REQUIRED'  or $usage='RECOMMENDED'">
  					<xsl:element name="{$elementName}">
  						<xsl:attribute name="NV">7701001</xsl:attribute>
  						<xsl:attribute name="xsi:nil">true</xsl:attribute>
  					</xsl:element>
					</xsl:when>
    			<xsl:when test="$usage='MANDATORY'">
  					<xsl:element name="{$elementName}">Unable to transform <xsl:value-of select="$inputValue" /> to integer</xsl:element>
					</xsl:when>
    		</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
 	</xsl:template>

	
	<xsl:output method="xml" encoding="UTF-8" byte-order-mark="no" indent="yes"/>
	<xsl:template match="/">
		<DEMDataSet xmlns="http://www.nemsis.org">
			<xsl:attribute name="xsi:schemaLocation" select="'http://www.nemsis.org http://nemsis.org/media/nemsis_v3/release-v3.4.0.150302/XSDs/NEMSIS_Xsds_v3.4.0.150302/DEMDataSet_v3.xsd'"/>
			<xsl:for-each select="ns0:DEMDataSet">
				<xsl:for-each select="ns0:dState">
					<dState>
						<xsl:sequence select="(./@node(), ./node())"/>
					</dState>
				</xsl:for-each>
				<xsl:for-each select="ns0:dCustomConfiguration">
					<dCustomConfiguration>
						<xsl:for-each select="ns0:dCustomConfiguration.CustomGroup">
							<xsl:variable name="var1_CustomElementID" as="node()?" select="@CustomElementID"/>
							<dCustomConfiguration.CustomGroup>
								<xsl:if test="fn:exists($var1_CustomElementID)">
									<xsl:attribute name="CustomElementID" namespace="" select="fn:string($var1_CustomElementID)"/>
								</xsl:if>
								<dCustomConfiguration.01>
									<xsl:sequence select="(./ns0:dCustomConfiguration.01/@node(), ./ns0:dCustomConfiguration.01/node())"/>
								</dCustomConfiguration.01>
								<dCustomConfiguration.02>
									<xsl:sequence select="fn:string(ns0:dCustomConfiguration.02)"/>
								</dCustomConfiguration.02>
								<dCustomConfiguration.03>
									<xsl:sequence select="fn:string(ns0:dCustomConfiguration.03)"/>
								</dCustomConfiguration.03>
								<dCustomConfiguration.04>
									<xsl:sequence select="fn:string(ns0:dCustomConfiguration.04)"/>
								</dCustomConfiguration.04>
								<dCustomConfiguration.05>
									<xsl:sequence select="fn:string(ns0:dCustomConfiguration.05)"/>
								</dCustomConfiguration.05>
								<xsl:for-each select="ns0:dCustomConfiguration.06">
									<dCustomConfiguration.06>
										<xsl:sequence select="(./@node(), ./node())"/>
									</dCustomConfiguration.06>
								</xsl:for-each>
								<xsl:for-each select="ns0:dCustomConfiguration.07">
									<dCustomConfiguration.07>
										<xsl:sequence select="fn:string(.)"/>
									</dCustomConfiguration.07>
								</xsl:for-each>
								<xsl:for-each select="ns0:dCustomConfiguration.08">
									<dCustomConfiguration.08>
										<xsl:sequence select="fn:string(.)"/>
									</dCustomConfiguration.08>
								</xsl:for-each>
							</dCustomConfiguration.CustomGroup>
						</xsl:for-each>
					</dCustomConfiguration>
				</xsl:for-each>
				<xsl:for-each select="ns0:DemographicReport">
					<DemographicReport>
						<xsl:attribute name="timeStamp" namespace="" select="xs:string(fn:string(@timeStamp))"/>
						<dAgency>
							<dAgency.01>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.01)"/>
							</dAgency.01>
							<dAgency.02>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.02)"/>
							</dAgency.02>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.03">
								<dAgency.03>
									<xsl:sequence select="(./@node(), ./node())"/>
								</dAgency.03>
							</xsl:for-each>
							
																	
							<!--<dAgency.04>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.04)"/>
							</dAgency.04>-->									
							<xsl:call-template name="ANSIStateCode">
    						<xsl:with-param name="usage" select="'MANDATORY'" />
    						<xsl:with-param name="elementName" select="'dAgency.04'" />
    						<xsl:with-param name="elementNode" select="ns0:dAgency/ns0:dAgency.04" />
							</xsl:call-template>
							
							
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.AgencyServiceGroup">
								<xsl:variable name="var2_CorrelationID" as="node()?" select="@CorrelationID"/>
								<dAgency.AgencyServiceGroup>
									<xsl:if test="fn:exists($var2_CorrelationID)">
										<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var2_CorrelationID)"/>
									</xsl:if>
									
									
									<!--<dAgency.05>
										<xsl:sequence select="fn:string(ns0:dAgency.05)"/>
									</dAgency.05>   -->															
									<xsl:call-template name="ANSIStateCode">
    								<xsl:with-param name="usage" select="'MANDATORY'" />
    								<xsl:with-param name="elementName" select="'dAgency.05'" />
    								<xsl:with-param name="elementNode" select="ns0:dAgency.05" />
									</xsl:call-template>
									
									
									<xsl:for-each select="ns0:dAgency.06">
										<!--<dAgency.06>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dAgency.06>   --> 																					
										<xsl:call-template name="ANSICountyCode">
    									<xsl:with-param name="usage" select="'MANDATORY'" />
    									<xsl:with-param name="elementName" select="'dAgency.06'" />
    									<xsl:with-param name="elementNode" select="." />
										</xsl:call-template>
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:dAgency.07">
										<dAgency.07>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dAgency.07>
									</xsl:for-each>
									<xsl:for-each select="ns0:dAgency.08">
										<dAgency.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dAgency.08>
									</xsl:for-each>
								</dAgency.AgencyServiceGroup>
							</xsl:for-each>
							<dAgency.09>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.09)"/>
							</dAgency.09>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.10">
								<dAgency.10>
									<xsl:sequence select="(./@node(), ./node())"/>
								</dAgency.10>
							</xsl:for-each>
							
							
							<dAgency.11>
								<!-- <xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.11)"/> -->																			
								<xsl:choose>
									<xsl:when test="fn:string(ns0:dAgency/ns0:dAgency.11)=fn:string(9917017)">
										<xsl:sequence select="'9917031'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.11)"/>
									</xsl:otherwise>
								</xsl:choose>
							</dAgency.11>
							
							
							<dAgency.12>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.12)"/>
							</dAgency.12>
							<dAgency.13>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.13)"/>
							</dAgency.13>
							<dAgency.14>
								<xsl:sequence select="fn:string(ns0:dAgency/ns0:dAgency.14)"/>
							</dAgency.14>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.AgencyYearGroup">
								<dAgency.AgencyYearGroup>
									<xsl:sequence select="(./@node(), ./node())"/>
								</dAgency.AgencyYearGroup>
							</xsl:for-each>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.23">
								<dAgency.23>
									<xsl:sequence select="fn:string(.)"/>
								</dAgency.23>
							</xsl:for-each>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.24">
								<dAgency.24>
									<xsl:sequence select="fn:string(.)"/>
								</dAgency.24>
							</xsl:for-each>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.25">
								<dAgency.25>
									<xsl:sequence select="(./@node(), ./node())"/>
								</dAgency.25>
							</xsl:for-each>
							<xsl:for-each select="ns0:dAgency/ns0:dAgency.26">
								<dAgency.26>
									<xsl:sequence select="(./@node(), ./node())"/>
								</dAgency.26>
							</xsl:for-each>
						</dAgency>
						<xsl:for-each select="ns0:dContact">
							<dContact>
								<xsl:for-each select="ns0:dContact.ContactInfoGroup">
									<xsl:variable name="var3_CorrelationID" as="node()?" select="@CorrelationID"/>
									<dContact.ContactInfoGroup>
										<xsl:if test="fn:exists($var3_CorrelationID)">
											<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var3_CorrelationID)"/>
										</xsl:if>
										<xsl:for-each select="ns0:dContact.01">
											<dContact.01>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.01>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.02">
											<dContact.02>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.02>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.03">
											<dContact.03>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.03>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.04">
											<dContact.04>
												<xsl:sequence select="fn:string(.)"/>
											</dContact.04>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.05">
											<dContact.05>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.05>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.06">
											<dContact.06>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.06>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dContact.07">
											<!-- <dContact.07>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.07> -->																		
											<xsl:call-template name="ANSIStateCode">
						    				<xsl:with-param name="usage" select="'RECOMMENDED'" />
						    				<xsl:with-param name="elementName" select="'dContact.07'" />
						    				<xsl:with-param name="elementNode" select="." />
											</xsl:call-template>         											
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dContact.08">
											<dContact.08>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.08>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.09">
											<dContact.09>
												<xsl:sequence select="fn:string(.)"/>
											</dContact.09>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.10">
											<dContact.10>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.10>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.11">
											<dContact.11>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.11>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.12">
											<dContact.12>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.12>
										</xsl:for-each>
										<xsl:for-each select="ns0:dContact.EMSMedicalDirectorGroup">
											<dContact.EMSMedicalDirectorGroup>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dContact.EMSMedicalDirectorGroup>
										</xsl:for-each>
									</dContact.ContactInfoGroup>
								</xsl:for-each>
							</dContact>
						</xsl:for-each>
						<dConfiguration>
							<xsl:for-each select="ns0:dConfiguration/ns0:dConfiguration.ConfigurationGroup">
								<xsl:variable name="var4_CorrelationID" as="node()?" select="@CorrelationID"/>
								<dConfiguration.ConfigurationGroup>
									<xsl:if test="fn:exists($var4_CorrelationID)">
										<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var4_CorrelationID)"/>
									</xsl:if>
									
									
									<!--<dConfiguration.01>
										<xsl:sequence select="fn:string(ns0:dConfiguration.01)"/>
									</dConfiguration.01>-->												
									<xsl:call-template name="ANSIStateCode">
    								<xsl:with-param name="usage" select="'MANDATORY'" />
    								<xsl:with-param name="elementName" select="'dConfiguration.01'" />
    								<xsl:with-param name="elementNode" select="ns0:dConfiguration.01" />
									</xsl:call-template>
									
									
									<!-- <xsl:for-each select="ns0:dConfiguration.02">
										<dConfiguration.02>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.02>
									</xsl:for-each> -->									
									<xsl:for-each select="ns0:dConfiguration.02">
										<dConfiguration.02>
											<!-- <xsl:sequence select="(./@node(), ./node())"/>			-->													
											<xsl:choose>
												<xsl:when test="./node()=fn:string(9911017)">
													<xsl:sequence select="(./@node(), '9911033')"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:sequence select="(./@node(), ./node())"/>
												</xsl:otherwise>
											</xsl:choose>
										</dConfiguration.02>
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:dConfiguration.03">
										<dConfiguration.03>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.03>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.04">
										<dConfiguration.04>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.04>
									</xsl:for-each>									
									<xsl:for-each select="ns0:dConfiguration.05">
										<dConfiguration.05>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.05>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.ProcedureGroup">
										<xsl:variable name="var5_CorrelationID" as="node()?" select="@CorrelationID"/>
										<dConfiguration.ProcedureGroup>
											<xsl:if test="fn:exists($var5_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var5_CorrelationID)"/>
											</xsl:if>
											
											<dConfiguration.06>
												<!--<xsl:sequence select="fn:string(ns0:dConfiguration.06)"/>	-->
												<xsl:choose>
													<xsl:when test="fn:string(ns0:dConfiguration.06)=fn:string(9917017)">
														<xsl:sequence select="'9917031'"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:sequence select="fn:string(ns0:dConfiguration.06)"/>
													</xsl:otherwise>
												</xsl:choose>
											</dConfiguration.06>
																						
											
											<xsl:for-each select="ns0:dConfiguration.07">
												<dConfiguration.07>
													<xsl:sequence select="(./@node(), ./node())"/>
												</dConfiguration.07>
											</xsl:for-each>
										</dConfiguration.ProcedureGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.MedicationGroup">
										<xsl:variable name="var6_CorrelationID" as="node()?" select="@CorrelationID"/>
										<dConfiguration.MedicationGroup>
											<xsl:if test="fn:exists($var6_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var6_CorrelationID)"/>
											</xsl:if>
											
											
											<dConfiguration.08>
												<!--<xsl:sequence select="fn:string(ns0:dConfiguration.08)"/>-->
												<xsl:choose>
													<xsl:when test="fn:string(ns0:dConfiguration.08)=fn:string(9917017)">
														<xsl:sequence select="'9917031'"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:sequence select="fn:string(ns0:dConfiguration.08)"/>
													</xsl:otherwise>
												</xsl:choose>
											</dConfiguration.08>
											
											
											<xsl:for-each select="ns0:dConfiguration.09">
												<dConfiguration.09>
													<xsl:sequence select="(./@node(), ./node())"/>
												</dConfiguration.09>
											</xsl:for-each>
										</dConfiguration.MedicationGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.10">
										<dConfiguration.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.11">
										<dConfiguration.11>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.11>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.12">
										<dConfiguration.12>
											<xsl:sequence select="fn:string(.)"/>
										</dConfiguration.12>
									</xsl:for-each>
									<dConfiguration.13>
										<xsl:sequence select="fn:string(ns0:dConfiguration.13)"/>
									</dConfiguration.13>
									<xsl:for-each select="ns0:dConfiguration.14">
										<dConfiguration.14>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.14>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.15">
										<dConfiguration.15>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.15>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.16">
										<dConfiguration.16>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.16>
									</xsl:for-each>
									<xsl:for-each select="ns0:dConfiguration.17">
										<dConfiguration.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</dConfiguration.17>
									</xsl:for-each>
								</dConfiguration.ConfigurationGroup>
							</xsl:for-each>
						</dConfiguration>
						<xsl:for-each select="ns0:dLocation">
							<dLocation>
								<xsl:for-each select="ns0:dLocation.LocationGroup">
									<xsl:variable name="var5_CorrelationID" as="node()?" select="@CorrelationID"/>
									<dLocation.LocationGroup>
										<xsl:if test="fn:exists($var5_CorrelationID)">
											<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var5_CorrelationID)"/>
										</xsl:if>
										<xsl:for-each select="ns0:dLocation.01">
											<dLocation.01>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.01>
										</xsl:for-each>
										<xsl:for-each select="ns0:dLocation.02">
											<dLocation.02>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.02>
										</xsl:for-each>
										<xsl:for-each select="ns0:dLocation.03">
											<dLocation.03>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.03>
										</xsl:for-each>
										<xsl:for-each select="ns0:dLocation.04">
											<dLocation.04>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.04>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dLocation.05">
											<!--<dLocation.05>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.05>-->
											<xsl:choose>
												<xsl:when test="matches(fn:string(.),',')"></xsl:when>
												<xsl:otherwise>
													<dLocation.05><xsl:sequence select="fn:string(.)"/></dLocation.05>
												</xsl:otherwise>
											</xsl:choose>						
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dLocation.06">
											<dLocation.06>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dLocation.06>
										</xsl:for-each>
										<xsl:for-each select="ns0:dLocation.07">
											<dLocation.07>
												<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
											</dLocation.07>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dLocation.08">
											<!--<dLocation.08>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.08>-->        											
											<xsl:call-template name="ANSIStateCode">
				    						<xsl:with-param name="usage" select="'OPTIONAL'" />
				    						<xsl:with-param name="elementName" select="'dLocation.08'" />
				    						<xsl:with-param name="elementNode" select="." />
											</xsl:call-template>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dLocation.09">
											<dLocation.09>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.09>
										</xsl:for-each>
										
										
										
										<xsl:for-each select="ns0:dLocation.10">
											<!--<dLocation.10>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.10>-->      																					
											<xsl:call-template name="ANSICountyCode">
    										<xsl:with-param name="usage" select="'OPTIONAL'" />
    										<xsl:with-param name="elementName" select="'dLocation.10'" />
    										<xsl:with-param name="elementNode" select="." />
											</xsl:call-template>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:dLocation.11">
											<dLocation.11>
												<xsl:sequence select="fn:string(.)"/>
											</dLocation.11>
										</xsl:for-each>
										<xsl:for-each select="ns0:dLocation.12">
											<dLocation.12>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dLocation.12>
										</xsl:for-each>
									</dLocation.LocationGroup>
								</xsl:for-each>
							</dLocation>
						</xsl:for-each>
						<xsl:for-each select="ns0:dVehicle">
							<dVehicle>
								<xsl:sequence select="(./@node(), ./node())"/>
							</dVehicle>
						</xsl:for-each>
						<xsl:for-each select="ns0:dPersonnel">
							<dPersonnel>
								<xsl:for-each select="ns0:dPersonnel.PersonnelGroup">
									<xsl:variable name="var6_CorrelationID" as="node()?" select="@CorrelationID"/>
									<dPersonnel.PersonnelGroup>
										<xsl:if test="fn:exists($var6_CorrelationID)">
											<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var6_CorrelationID)"/>
										</xsl:if>
										<xsl:for-each select="ns0:dPersonnel.NameGroup">
											<dPersonnel.NameGroup>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.NameGroup>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.AddressGroup">
											<dPersonnel.AddressGroup>
												<xsl:for-each select="ns0:dPersonnel.04">
													<dPersonnel.04>
														<xsl:sequence select="(./@node(), ./node())"/>
													</dPersonnel.04>
												</xsl:for-each>
												<xsl:for-each select="ns0:dPersonnel.05">
													<dPersonnel.05>
														<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
													</dPersonnel.05>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.06">
													<!--<dPersonnel.06>
														<xsl:sequence select="fn:string(.)"/>
													</dPersonnel.06>   		-->									
													<xsl:call-template name="ANSIStateCode">
						    						<xsl:with-param name="usage" select="'OPTIONAL'" />
						    						<xsl:with-param name="elementName" select="'dPersonnel.06'" />
						    						<xsl:with-param name="elementNode" select="." />
													</xsl:call-template>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.07">
													<dPersonnel.07>
														<xsl:sequence select="fn:string(.)"/>
													</dPersonnel.07>
												</xsl:for-each>
												<xsl:for-each select="ns0:dPersonnel.08">
													<dPersonnel.08>
														<xsl:sequence select="fn:string(.)"/>
													</dPersonnel.08>
												</xsl:for-each>
											</dPersonnel.AddressGroup>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.09">
											<dPersonnel.09>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.09>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.10">
											<dPersonnel.10>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.10>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.11">
											<dPersonnel.11>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.11>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.12">
											<dPersonnel.12>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.12>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.13">
											<dPersonnel.13>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.13>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.14">
											<dPersonnel.14>
												<xsl:sequence select="fn:string(.)"/>
											</dPersonnel.14>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.15">
											<dPersonnel.15>
												<xsl:sequence select="fn:string(.)"/>
											</dPersonnel.15>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.16">
											<dPersonnel.16>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.16>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.17">
											<dPersonnel.17>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.17>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.ImmunizationsGroup">
											<dPersonnel.ImmunizationsGroup>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.ImmunizationsGroup>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.20">
											<dPersonnel.20>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.20>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.21">
											<dPersonnel.21>
												<xsl:sequence select="fn:string(.)"/>
											</dPersonnel.21>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.LicensureGroup">
											<xsl:variable name="var7_CorrelationID" as="node()?" select="@CorrelationID"/>
											<dPersonnel.LicensureGroup>
												<xsl:if test="fn:exists($var7_CorrelationID)">
													<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var7_CorrelationID)"/>
												</xsl:if>
												
												
												
												<xsl:for-each select="ns0:dPersonnel.22">
													<!--<dPersonnel.22>
														<xsl:sequence select="(./@node(), ./node())"/>
													</dPersonnel.22>	-->															
													<xsl:call-template name="ANSIStateCode">
								    				<xsl:with-param name="usage" select="'RECOMMENDED'" />
								    				<xsl:with-param name="elementName" select="'dPersonnel.22'" />
								    				<xsl:with-param name="elementNode" select="." />
													</xsl:call-template>     
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.23">
													<dPersonnel.23>
														<xsl:sequence select="(./@node(), ./node())"/>
													</dPersonnel.23>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.24">
													<dPersonnel.24>
														<!-- <xsl:sequence select="(./@node(), ./node())"/> -->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(9925021)">
																<xsl:sequence select="(./@node(), '9925043')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</dPersonnel.24>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.25">
													<dPersonnel.25>
														<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
													</dPersonnel.25>
												</xsl:for-each>
												<xsl:for-each select="ns0:dPersonnel.26">
													<dPersonnel.26>
														<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
													</dPersonnel.26>
												</xsl:for-each>
												<xsl:for-each select="ns0:dPersonnel.27">
													<dPersonnel.27>
														<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
													</dPersonnel.27>
												</xsl:for-each>
											</dPersonnel.LicensureGroup>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.28">
											<dPersonnel.28>
												<xsl:sequence select="fn:string(.)"/>
											</dPersonnel.28>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.29">
											<dPersonnel.29>
												<xsl:sequence select="fn:string(.)"/>
											</dPersonnel.29>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.30">
											<dPersonnel.30>
												<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
											</dPersonnel.30>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.31">
											<dPersonnel.31>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.31>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.32">
											<dPersonnel.32>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.32>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.33">
											<dPersonnel.33>
												<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
											</dPersonnel.33>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.34">
											<dPersonnel.34>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.34>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.35">
											<dPersonnel.35>
												<xsl:sequence select="(./@node(), ./node())"/>
											</dPersonnel.35>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.36">
											<dPersonnel.36>
												<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
											</dPersonnel.36>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.37">
											<dPersonnel.37>
												<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
											</dPersonnel.37>
										</xsl:for-each>
										<xsl:for-each select="ns0:dPersonnel.CertificationLevelGroup">
											<xsl:variable name="var8_CorrelationID" as="node()?" select="@CorrelationID"/>
											<dPersonnel.CertificationLevelGroup>
												<xsl:if test="fn:exists($var8_CorrelationID)">
													<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var8_CorrelationID)"/>
												</xsl:if>
												
												
												<xsl:for-each select="ns0:dPersonnel.38">
													<dPersonnel.38>
														<!--<xsl:sequence select="fn:string(.)"/>-->														
														<xsl:choose>
															<xsl:when test="fn:string(fn:string(.))=fn:string(9925021)">
																<xsl:sequence select="'9925043'"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="fn:string(.)"/>
															</xsl:otherwise>
														</xsl:choose>
													</dPersonnel.38>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dPersonnel.39">
													<dPersonnel.39>
														<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
													</dPersonnel.39>
												</xsl:for-each>
											</dPersonnel.CertificationLevelGroup>
										</xsl:for-each>
									</dPersonnel.PersonnelGroup>
								</xsl:for-each>
							</dPersonnel>
						</xsl:for-each>
						<xsl:for-each select="ns0:dDevice">
							<dDevice>
								<xsl:sequence select="(./@node(), ./node())"/>
							</dDevice>
						</xsl:for-each>
						<xsl:for-each select="ns0:dFacility">
							<dFacility>
								<xsl:for-each select="ns0:dFacilityGroup">
									<xsl:variable name="var9_CorrelationID" as="node()?" select="@CorrelationID"/>
									<dFacilityGroup>
										<xsl:if test="fn:exists($var9_CorrelationID)">
											<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var9_CorrelationID)"/>
										</xsl:if>
										<xsl:for-each select="ns0:dFacility.01">
											<dFacility.01>
												<xsl:sequence select="fn:string(.)"/>
											</dFacility.01>
										</xsl:for-each>
										<xsl:for-each select="ns0:dFacility.FacilityGroup">
											<xsl:variable name="var10_CorrelationID" as="node()?" select="@CorrelationID"/>
											<dFacility.FacilityGroup>
												<xsl:if test="fn:exists($var10_CorrelationID)">
													<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var10_CorrelationID)"/>
												</xsl:if>
												<xsl:for-each select="ns0:dFacility.02">
													<dFacility.02>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.02>
												</xsl:for-each>
												<xsl:for-each select="ns0:dFacility.03">
													<dFacility.03>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.03>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dFacility.04">
													<dFacility.04>
														<!-- <xsl:sequence select="(./@node(), ./node())"/> -->																			
														<xsl:choose>
															<xsl:when test="./node()=fn:string(9908013)">
																<xsl:sequence select="(./@node(), '9908031')"/>
															</xsl:when>
															<xsl:when test="./node()=fn:string(9908015)">
																<xsl:sequence select="(./@node(), '9908033')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</dFacility.04>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dFacility.05">
													<dFacility.05>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.05>
												</xsl:for-each>
												<xsl:for-each select="ns0:dFacility.06">
													<dFacility.06>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.06>
												</xsl:for-each>
												<xsl:for-each select="ns0:dFacility.07">
													<dFacility.07>
														<xsl:sequence select="(./@node(), ./node())"/>
													</dFacility.07>
												</xsl:for-each>
												<xsl:for-each select="ns0:dFacility.08">
													<dFacility.08>
														<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
													</dFacility.08>
												</xsl:for-each>
												
												
												
												<!--
													<dFacility.09>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.09>
												</xsl:for-each>			-->						
												<xsl:for-each select="ns0:dFacility.09">		
													<xsl:call-template name="ANSIStateCode">
				    								<xsl:with-param name="usage" select="'OPTIONAL'" />
				    								<xsl:with-param name="elementName" select="'dFacility.09'" />
				    								<xsl:with-param name="elementNode" select="." />
													</xsl:call-template>
												</xsl:for-each>			
												
												
												<xsl:for-each select="ns0:dFacility.10">
													<dFacility.10>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.10>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dFacility.11">
													<!--<dFacility.11>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.11>-->													
													<xsl:call-template name="ANSICountyCode">
    												<xsl:with-param name="usage" select="'OPTIONAL'" />
    												<xsl:with-param name="elementName" select="'dFacility.11'" />
    												<xsl:with-param name="elementNode" select="." />
													</xsl:call-template>
												</xsl:for-each>
												
												
												
												<xsl:for-each select="ns0:dFacility.12">
													<dFacility.12>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.12>
												</xsl:for-each>
												<xsl:for-each select="ns0:dFacility.13">
													<dFacility.13>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.13>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:dFacility.14">
													<!--<dFacility.14>
														<xsl:sequence select="fn:string(.)"/>
													</dFacility.14>-->
													<xsl:choose>
														<xsl:when test="matches(fn:string(.),',')"></xsl:when>
														<xsl:otherwise>
															<dFacility.14><xsl:sequence select="fn:string(.)"/></dFacility.14>
														</xsl:otherwise>
													</xsl:choose>											
												</xsl:for-each>
												
												
												
											</dFacility.FacilityGroup>
										</xsl:for-each>
									</dFacilityGroup>
								</xsl:for-each>
							</dFacility>
						</xsl:for-each>
						<xsl:for-each select="ns0:dCustomResults">
							<dCustomResults>
								<xsl:sequence select="(./@node(), ./node())"/>
							</dCustomResults>
						</xsl:for-each>
					</DemographicReport>
				</xsl:for-each>
			</xsl:for-each>
		</DEMDataSet>
	</xsl:template>
</xsl:stylesheet>
