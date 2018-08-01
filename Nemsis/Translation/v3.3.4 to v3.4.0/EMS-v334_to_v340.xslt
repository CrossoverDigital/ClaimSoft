<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
	xmlns="http://www.nemsis.org"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tbf="http://www.mf.com"
	xmlns:ns0="http://www.nemsis.org"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="tbf ns0 xs fn">

	<xsl:template name="ANSICountyCode">
    <xsl:param name="usage"/>
    <xsl:param name="elementName"/>
    <xsl:param name="elementNode" as="item()"/>
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
    		</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
 	</xsl:template>

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
    			<xsl:when test="$usage='REQUIRED'">
  					<xsl:element name="{$elementName}">
  						<xsl:attribute name="NV">7701001</xsl:attribute>
  						<xsl:attribute name="xsi:nil">true</xsl:attribute>
  					</xsl:element>
					</xsl:when>
    		</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
 	</xsl:template>



	<xsl:template name="tbf:tbf1_">
		<xsl:param name="input" select="()"/>
		<xsl:for-each select="$input/@NV">
			<xsl:attribute name="NV" select="fn:string(.)"/>
		</xsl:for-each>
		<xsl:for-each select="$input/@CorrelationID">
			<xsl:attribute name="CorrelationID" select="fn:string(.)"/>
		</xsl:for-each>
		<xsl:sequence select="fn:string($input)"/>
	</xsl:template>
	<xsl:template name="tbf:tbf2_">
		<xsl:param name="input" select="()"/>
		<xsl:for-each select="$input/@NV">
			<xsl:attribute name="NV" select="fn:string(.)"/>
		</xsl:for-each>
		<xsl:sequence select="fn:string($input)"/>
	</xsl:template>
	
	
	
	
	<xsl:output method="xml" encoding="UTF-8" byte-order-mark="no" indent="yes"/>
	<xsl:template match="/">
		<EMSDataSet xmlns="http://www.nemsis.org">
			<xsl:attribute name="xsi:schemaLocation" select="'http://www.nemsis.org http://nemsis.org/media/nemsis_v3/release-v3.4.0.150302/XSDs/NEMSIS_Xsds_v3.4.0.150302/EMSDataSet_v3.xsd'"/>
			<xsl:for-each select="ns0:EMSDataSet">
				<xsl:for-each select="ns0:eState">
					<eState>
						<xsl:sequence select="(./@node(), ./node())"/>
					</eState>
				</xsl:for-each>
				<xsl:for-each select="ns0:Header">
					<Header>
						<DemographicGroup>
							<xsl:sequence select="(./ns0:DemographicGroup/@node(), ./ns0:DemographicGroup/node())"/>
						</DemographicGroup>
						<xsl:for-each select="ns0:eCustomConfiguration">
							<eCustomConfiguration>
								<xsl:for-each select="ns0:eCustomConfiguration.CustomGroup">
									<eCustomConfiguration.CustomGroup>
										<xsl:attribute name="CustomElementID" namespace="" select="fn:string(@CustomElementID)"/>
										<eCustomConfiguration.01>
											<xsl:sequence select="(./ns0:eCustomConfiguration.01/@node(), ./ns0:eCustomConfiguration.01/node())"/>
										</eCustomConfiguration.01>
										<eCustomConfiguration.02>
											<xsl:sequence select="fn:string(ns0:eCustomConfiguration.02)"/>
										</eCustomConfiguration.02>
										<eCustomConfiguration.03>
											<xsl:sequence select="fn:string(ns0:eCustomConfiguration.03)"/>
										</eCustomConfiguration.03>
										<eCustomConfiguration.04>
											<xsl:sequence select="fn:string(ns0:eCustomConfiguration.04)"/>
										</eCustomConfiguration.04>
										<eCustomConfiguration.05>
											<xsl:sequence select="fn:string(ns0:eCustomConfiguration.05)"/>
										</eCustomConfiguration.05>
										<xsl:for-each select="ns0:eCustomConfiguration.06">
											<eCustomConfiguration.06>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eCustomConfiguration.06>
										</xsl:for-each>
										<xsl:for-each select="ns0:eCustomConfiguration.07">
											<eCustomConfiguration.07>
												<xsl:sequence select="fn:string(.)"/>
											</eCustomConfiguration.07>
										</xsl:for-each>
										<xsl:for-each select="ns0:eCustomConfiguration.08">
											<eCustomConfiguration.08>
												<xsl:sequence select="fn:string(.)"/>
											</eCustomConfiguration.08>
										</xsl:for-each>
									</eCustomConfiguration.CustomGroup>
								</xsl:for-each>
							</eCustomConfiguration>
						</xsl:for-each>
						<xsl:for-each select="ns0:PatientCareReport">
							<PatientCareReport>
								<eRecord>
									<eRecord.01>
										<xsl:sequence select="fn:string(ns0:eRecord/ns0:eRecord.01)"/>
									</eRecord.01>
									<eRecord.SoftwareApplicationGroup>
										<xsl:sequence select="(./ns0:eRecord/ns0:eRecord.SoftwareApplicationGroup/@node(), ./ns0:eRecord/ns0:eRecord.SoftwareApplicationGroup/node())"/>
									</eRecord.SoftwareApplicationGroup>
								</eRecord>
								<eResponse>
									<eResponse.AgencyGroup>
										<xsl:sequence select="(./ns0:eResponse/ns0:eResponse.AgencyGroup/@node(), ./ns0:eResponse/ns0:eResponse.AgencyGroup/node())"/>
									</eResponse.AgencyGroup>
									<eResponse.03>
										<xsl:sequence select="(./ns0:eResponse/ns0:eResponse.03/@node(), ./ns0:eResponse/ns0:eResponse.03/node())"/>
									</eResponse.03>
									<eResponse.04>
										<xsl:sequence select="(./ns0:eResponse/ns0:eResponse.04/@node(), ./ns0:eResponse/ns0:eResponse.04/node())"/>
									</eResponse.04>
									<eResponse.ServiceGroup>
										<xsl:sequence select="(./ns0:eResponse/ns0:eResponse.ServiceGroup/@node(), ./ns0:eResponse/ns0:eResponse.ServiceGroup/node())"/>
									</eResponse.ServiceGroup>
									
									<eResponse.07>
										<!--<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.07)"/>-->										
										<xsl:choose>
											<xsl:when test="fn:string(ns0:eResponse/ns0:eResponse.07)=fn:string(2207001)">
												<xsl:sequence select="'2207011'"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.07)"/>
											</xsl:otherwise>
										</xsl:choose>
									</eResponse.07>
									
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.08">
										<eResponse.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.09">
										<eResponse.09>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.09>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.10">
										<eResponse.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.11">
										<eResponse.11>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.11>
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.12">
										<eResponse.12>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.12>		
									</xsl:for-each>
									
									
									<eResponse.13>
										<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.13)"/>
									</eResponse.13>
									<eResponse.14>
										<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.14)"/>
									</eResponse.14>
									<eResponse.15>
										<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.15)"/>
									</eResponse.15>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.16">
										<eResponse.16>
											<xsl:sequence select="fn:string(.)"/>
										</eResponse.16>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.17">
										<eResponse.17>
											<xsl:sequence select="fn:string(.)"/>
										</eResponse.17>
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.18">
										<!--<eResponse.18>
											<xsl:sequence select="fn:string(.)"/>
										</eResponse.18> -->
										<xsl:choose>
											<xsl:when test="matches(fn:string(.),',')"></xsl:when>
											<xsl:otherwise>
												<eResponse.18><xsl:sequence select="fn:string(.)"/></eResponse.18>
											</xsl:otherwise>
										</xsl:choose>			
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.19">
										<eResponse.19>
											<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
										</eResponse.19>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.20">
										<eResponse.20>
											<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
										</eResponse.20>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.21">
										<eResponse.21>
											<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
										</eResponse.21>
									</xsl:for-each>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.22">
										<eResponse.22>
											<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
										</eResponse.22>
									</xsl:for-each>
									<eResponse.23>
										<xsl:sequence select="fn:string(ns0:eResponse/ns0:eResponse.23)"/>
									</eResponse.23>
									<xsl:for-each select="ns0:eResponse/ns0:eResponse.24">
										<eResponse.24>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eResponse.24>
									</xsl:for-each>
								</eResponse>
								<eDispatch>
									<eDispatch.01>
										<xsl:sequence select="fn:string(ns0:eDispatch/ns0:eDispatch.01)"/>
									</eDispatch.01>
									<eDispatch.02>
										<xsl:sequence select="(./ns0:eDispatch/ns0:eDispatch.02/@node(), ./ns0:eDispatch/ns0:eDispatch.02/node())"/>
									</eDispatch.02>
									<xsl:for-each select="ns0:eDispatch/ns0:eDispatch.03">
										<eDispatch.03>
											<xsl:sequence select="fn:string(.)"/>
										</eDispatch.03>
									</xsl:for-each>
									<xsl:for-each select="ns0:eDispatch/ns0:eDispatch.04">
										<eDispatch.04>
											<xsl:sequence select="fn:string(.)"/>
										</eDispatch.04>
									</xsl:for-each>
									<xsl:for-each select="ns0:eDispatch/ns0:eDispatch.05">
										<eDispatch.05>
											<xsl:sequence select="fn:string(.)"/>
										</eDispatch.05>
									</xsl:for-each>
								</eDispatch>
								<xsl:for-each select="ns0:eCrew">
									<eCrew>
										<xsl:for-each select="ns0:eCrew.CrewGroup">
											<xsl:variable name="var1_CorrelationID" as="node()?" select="@CorrelationID"/>
											<eCrew.CrewGroup>
												<xsl:if test="fn:exists($var1_CorrelationID)">
													<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var1_CorrelationID)"/>
												</xsl:if>
												<xsl:for-each select="ns0:eCrew.01">
													<eCrew.01>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eCrew.01>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:eCrew.02">
													<eCrew.02>
														<!--<xsl:sequence select="(./@node(), ./node())"/>	-->			
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(9925021)">
																<xsl:sequence select="(./@node(), '9925043')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</eCrew.02>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:eCrew.03">
													<eCrew.03>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eCrew.03>
												</xsl:for-each>
											</eCrew.CrewGroup>
										</xsl:for-each>
									</eCrew>
								</xsl:for-each>
								<eTimes>
									<xsl:sequence select="(./ns0:eTimes/@node(), ./ns0:eTimes/node())"/>
								</eTimes>
								<ePatient>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.01">
										<ePatient.01>
											<xsl:sequence select="fn:string(.)"/>
										</ePatient.01>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.PatientNameGroup">
										<ePatient.PatientNameGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.PatientNameGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.05">
										<ePatient.05>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.05>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.06">
										<ePatient.06>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</ePatient.06>
									</xsl:for-each>


									<!--<ePatient.07>
									<xsl:sequence select="(./ns0:ePatient/ns0:ePatient.07/@node(), ./ns0:ePatient/ns0:ePatient.07/node())"/>
									<ePatient.07>-->
									<xsl:call-template name="ANSICountyCode">
    								<xsl:with-param name="usage" select="'REQUIRED'" />
    								<xsl:with-param name="elementName" select="'ePatient.07'" />
    								<xsl:with-param name="elementNode" select="./ns0:ePatient/ns0:ePatient.07" />
									</xsl:call-template>


									<!--<ePatient.08>
										<xsl:sequence select="(./ns0:ePatient/ns0:ePatient.08/@node(), ./ns0:ePatient/ns0:ePatient.08/node())"/>
									</ePatient.08>-->
									<xsl:call-template name="ANSIStateCode">
    								<xsl:with-param name="usage" select="'REQUIRED'" />
    								<xsl:with-param name="elementName" select="'ePatient.08'" />
    								<xsl:with-param name="elementNode" select="./ns0:ePatient/ns0:ePatient.08" />
									</xsl:call-template>



									<ePatient.09>
										<xsl:sequence select="(./ns0:ePatient/ns0:ePatient.09/@node(), ./ns0:ePatient/ns0:ePatient.09/node())"/>
									</ePatient.09>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.10">
										<ePatient.10>
											<xsl:sequence select="fn:string(.)"/>
										</ePatient.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.11">
										<ePatient.11>
											<xsl:sequence select="fn:string(.)"/>
										</ePatient.11>
									</xsl:for-each>
									
									
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.12">										
											<!--<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>-->											
											<xsl:choose>
												<xsl:when test="matches(fn:string(.),'[0-9]{9}') and fn:string-length(fn:string(.))=9">
													<ePatient.12><xsl:sequence select="fn:string(.)"/></ePatient.12>
												</xsl:when>
												<xsl:otherwise></xsl:otherwise>
											</xsl:choose>	
									</xsl:for-each>
									
									
									<ePatient.13>
										<xsl:sequence select="(./ns0:ePatient/ns0:ePatient.13/@node(), ./ns0:ePatient/ns0:ePatient.13/node())"/>
									</ePatient.13>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.14">
										<ePatient.14>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.14>
									</xsl:for-each>
									<ePatient.AgeGroup>
										<xsl:sequence select="(./ns0:ePatient/ns0:ePatient.AgeGroup/@node(), ./ns0:ePatient/ns0:ePatient.AgeGroup/node())"/>
									</ePatient.AgeGroup>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.17">
										<ePatient.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.17>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.18">
										<ePatient.18>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.18>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePatient/ns0:ePatient.19">
										<ePatient.19>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePatient.19>
									</xsl:for-each>


									<xsl:for-each select="ns0:ePatient/ns0:ePatient.20">
										<!--<ePatient.20>
											<xsl:sequence select="fn:string(.)"/>
										</ePatient.20>-->
										<xsl:call-template name="ANSIStateCode">
    									<xsl:with-param name="usage" select="'OPTIONAL'" />
    									<xsl:with-param name="elementName" select="'ePatient.20'" />
    									<xsl:with-param name="elementNode" select="." />
										</xsl:call-template>
									</xsl:for-each>


									<xsl:for-each select="ns0:ePatient/ns0:ePatient.21">
										<ePatient.21>
											<xsl:sequence select="fn:string(.)"/>
										</ePatient.21>
									</xsl:for-each>
								</ePatient>
								<ePayment>
									<ePayment.01>
										<xsl:sequence select="(./ns0:ePayment/ns0:ePayment.01/@node(), ./ns0:ePayment/ns0:ePayment.01/node())"/>
									</ePayment.01>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.CertificateGroup">
										<ePayment.CertificateGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.CertificateGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.08">
										<ePayment.08>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.InsuranceGroup">
										<xsl:variable name="var2_CorrelationID" as="node()?" select="@CorrelationID"/>
										<ePayment.InsuranceGroup>
											<xsl:if test="fn:exists($var2_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var2_CorrelationID)"/>
											</xsl:if>
											<xsl:for-each select="ns0:ePayment.09">
												<ePayment.09>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.09>
											</xsl:for-each>
											
											
											<xsl:for-each select="ns0:ePayment.10">
												<ePayment.10>
													<!--<xsl:sequence select="fn:string(.)"/>-->
													<xsl:sequence select="fn:substring(.,1,60)"/>
												</ePayment.10>
											</xsl:for-each>
											
											
											<xsl:for-each select="ns0:ePayment.11">
												<ePayment.11>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.11>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.12">
												<ePayment.12>
													<xsl:sequence select="(./@node(), ./node())"/>
												</ePayment.12>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.13">
												<ePayment.13>
													<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
												</ePayment.13>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.14">
												<!--<ePayment.14>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.14>-->
												<xsl:call-template name="ANSIStateCode">
		    									<xsl:with-param name="usage" select="'OPTIONAL'" />
		    									<xsl:with-param name="elementName" select="'ePayment.14'" />
		    									<xsl:with-param name="elementNode" select="." />
												</xsl:call-template>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.15">
												<ePayment.15>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.15>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.16">
												<ePayment.16>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.16>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.17">
												<ePayment.17>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.17>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.18">
												<ePayment.18>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.18>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.19">
												<ePayment.19>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.19>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.20">
												<ePayment.20>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.20>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.21">
												<ePayment.21>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.21>
											</xsl:for-each>
											
											
											<xsl:for-each select="ns0:ePayment.22">
												<ePayment.22>
													<!--<xsl:sequence select="fn:string(.)"/>-->						
													<xsl:choose>
														<xsl:when test="fn:string(.)=fn:string(2622007)">
															<xsl:sequence select="'2622019'"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:sequence select="fn:string(.)"/>	
														</xsl:otherwise>
													</xsl:choose>
												</ePayment.22>
											</xsl:for-each>
											
											
										</ePayment.InsuranceGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.ClosestRelativeGroup">
										<ePayment.ClosestRelativeGroup>
											<xsl:for-each select="ns0:ePayment.23">
												<ePayment.23>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.23>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.24">
												<ePayment.24>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.24>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.25">
												<ePayment.25>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.25>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.26">
												<ePayment.26>
													<xsl:sequence select="(./@node(), ./node())"/>
												</ePayment.26>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.27">
												<ePayment.27>
													<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
												</ePayment.27>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.28">
												<!--<ePayment.28>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.28>-->
												<xsl:call-template name="ANSIStateCode">
		    									<xsl:with-param name="usage" select="'OPTIONAL'" />
		    									<xsl:with-param name="elementName" select="'ePayment.28'" />
		    									<xsl:with-param name="elementNode" select="." />
												</xsl:call-template>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.29">
												<ePayment.29>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.29>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.30">
												<ePayment.30>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.30>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.31">
												<ePayment.31>
													<xsl:sequence select="(./@node(), ./node())"/>
												</ePayment.31>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.32">
												<ePayment.32>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.32>
											</xsl:for-each>
										</ePayment.ClosestRelativeGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.EmployerGroup">
										<ePayment.EmployerGroup>
											<xsl:for-each select="ns0:ePayment.33">
												<ePayment.33>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.33>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.34">
												<ePayment.34>
													<xsl:sequence select="(./@node(), ./node())"/>
												</ePayment.34>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.35">
												<ePayment.35>
													<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
												</ePayment.35>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.36">
												<!--<ePayment.36>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.36>-->
												<xsl:call-template name="ANSIStateCode">
		    									<xsl:with-param name="usage" select="'OPTIONAL'" />
		    									<xsl:with-param name="elementName" select="'ePayment.36'" />
		    									<xsl:with-param name="elementNode" select="." />
												</xsl:call-template>
											</xsl:for-each>


											<xsl:for-each select="ns0:ePayment.37">
												<ePayment.37>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.37>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.38">
												<ePayment.38>
													<xsl:sequence select="fn:string(.)"/>
												</ePayment.38>
											</xsl:for-each>
											<xsl:for-each select="ns0:ePayment.39">
												<ePayment.39>
													<xsl:sequence select="(./@node(), ./node())"/>
												</ePayment.39>
											</xsl:for-each>
										</ePayment.EmployerGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.40">
										<ePayment.40>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.40>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.41">
										<ePayment.41>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.41>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.42">
										<ePayment.42>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.42>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.44">
										<ePayment.44>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.44>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.45">
										<ePayment.45>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.45>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.46">
										<ePayment.46>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.46>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.47">
										<ePayment.47>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.47>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.48">
										<ePayment.48>
											<xsl:sequence select="xs:string(xs:decimal(fn:string(.)))"/>
										</ePayment.48>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.49">
										<ePayment.49>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.49>
									</xsl:for-each>
									<ePayment.50>
										<xsl:sequence select="(./ns0:ePayment/ns0:ePayment.50/@node(), ./ns0:ePayment/ns0:ePayment.50/node())"/>
									</ePayment.50>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.51">
										<ePayment.51>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.51>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.52">
										<ePayment.52>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.52>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.53">
										<ePayment.53>
											<!--<xsl:sequence select="fn:string(.)"/>-->
											<xsl:sequence select="fn:substring(.,1,50)"/>
										</ePayment.53>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.54">
										<ePayment.54>
											<xsl:sequence select="fn:string(.)"/>
										</ePayment.54>
									</xsl:for-each>
									<xsl:for-each select="ns0:ePayment/ns0:ePayment.SupplyItemGroup">
										<ePayment.SupplyItemGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</ePayment.SupplyItemGroup>
									</xsl:for-each>
								</ePayment>
								<eScene>
									<eScene.01>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.01/@node(), ./ns0:eScene/ns0:eScene.01/node())"/>
									</eScene.01>
									<xsl:for-each select="ns0:eScene/ns0:eScene.ResponderGroup">
										<eScene.ResponderGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.ResponderGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.05">
										<eScene.05>
											<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
										</eScene.05>
									</xsl:for-each>
									<eScene.06>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.06/@node(), ./ns0:eScene/ns0:eScene.06/node())"/>
									</eScene.06>
									<eScene.07>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.07/@node(), ./ns0:eScene/ns0:eScene.07/node())"/>
									</eScene.07>
									<eScene.08>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.08/@node(), ./ns0:eScene/ns0:eScene.08/node())"/>
									</eScene.08>
									<eScene.09>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.09/@node(), ./ns0:eScene/ns0:eScene.09/node())"/>
									</eScene.09>
									<xsl:for-each select="ns0:eScene/ns0:eScene.10">
										<eScene.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.11">
										<eScene.11>
											<xsl:sequence select="fn:string(.)"/>
										</eScene.11>
									</xsl:for-each>
									
									<xsl:for-each select="ns0:eScene/ns0:eScene.12">
											<!--<xsl:sequence select="fn:string(.)"/>		-->					
											<xsl:choose>
												<xsl:when test="matches(fn:string(.),',')"></xsl:when>
												<xsl:otherwise>
													<eScene.12><xsl:sequence select="fn:string(.)"/></eScene.12>
												</xsl:otherwise>
											</xsl:choose>		
									</xsl:for-each>
									
									<xsl:for-each select="ns0:eScene/ns0:eScene.13">
										<eScene.13>
											<xsl:sequence select="fn:string(.)"/>
										</eScene.13>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.14">
										<eScene.14>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.14>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.15">
										<eScene.15>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.15>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.16">
										<eScene.16>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.16>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.17">
										<eScene.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.17>
									</xsl:for-each>


									<!--<eScene.18>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.18/@node(), ./ns0:eScene/ns0:eScene.18/node())"/>
									</eScene.18>-->
									<xsl:call-template name="ANSIStateCode">
    								<xsl:with-param name="usage" select="'REQUIRED'" />
    								<xsl:with-param name="elementName" select="'eScene.18'" />
    								<xsl:with-param name="elementNode" select="./ns0:eScene/ns0:eScene.18" />
									</xsl:call-template>

									<eScene.19>
										<xsl:sequence select="(./ns0:eScene/ns0:eScene.19/@node(), ./ns0:eScene/ns0:eScene.19/node())"/>
									</eScene.19>
									<xsl:for-each select="ns0:eScene/ns0:eScene.20">
										<eScene.20>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eScene.20>
									</xsl:for-each>


									<!-- <xsl:sequence select="(./ns0:eScene/ns0:eScene.21/@node(), ./ns0:eScene/ns0:eScene.21/node())"/> -->
									<xsl:call-template name="ANSICountyCode">
    								<xsl:with-param name="usage" select="'REQUIRED'" />
    								<xsl:with-param name="elementName" select="'eScene.21'" />
    								<xsl:with-param name="elementNode" select="./ns0:eScene/ns0:eScene.21" />
									</xsl:call-template>


									<xsl:for-each select="ns0:eScene/ns0:eScene.22">
										<eScene.22>
											<xsl:sequence select="fn:string(.)"/>
										</eScene.22>
									</xsl:for-each>
									<xsl:for-each select="ns0:eScene/ns0:eScene.23">
										<eScene.23>
											<xsl:sequence select="fn:string(.)"/>
										</eScene.23>
									</xsl:for-each>
								</eScene>
								<eSituation>
									<eSituation.01>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.01/@node(), ./ns0:eSituation/ns0:eSituation.01/node())"/>
									</eSituation.01>
									<eSituation.02>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.02/@node(), ./ns0:eSituation/ns0:eSituation.02/node())"/>
									</eSituation.02>
									<xsl:for-each select="ns0:eSituation/ns0:eSituation.PatientComplaintGroup">
										<eSituation.PatientComplaintGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eSituation.PatientComplaintGroup>
									</xsl:for-each>
									<eSituation.07>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.07/@node(), ./ns0:eSituation/ns0:eSituation.07/node())"/>
									</eSituation.07>
									<eSituation.08>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.08/@node(), ./ns0:eSituation/ns0:eSituation.08/node())"/>
									</eSituation.08>
									<eSituation.09>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.09/@node(), ./ns0:eSituation/ns0:eSituation.09/node())"/>
									</eSituation.09>
									<xsl:for-each select="ns0:eSituation/ns0:eSituation.10">
										<eSituation.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eSituation.10>
									</xsl:for-each>
									<eSituation.11>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.11/@node(), ./ns0:eSituation/ns0:eSituation.11/node())"/>
									</eSituation.11>
									<xsl:for-each select="ns0:eSituation/ns0:eSituation.12">
										<eSituation.12>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eSituation.12>
									</xsl:for-each>
									<eSituation.13>
										<xsl:sequence select="(./ns0:eSituation/ns0:eSituation.13/@node(), ./ns0:eSituation/ns0:eSituation.13/node())"/>
									</eSituation.13>
									<xsl:for-each select="ns0:eSituation/ns0:eSituation.WorkRelatedGroup">
										<eSituation.WorkRelatedGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eSituation.WorkRelatedGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eSituation/ns0:eSituation.17">
										<eSituation.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eSituation.17>
									</xsl:for-each>
								</eSituation>
								<eInjury>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.01">
										<eInjury.01>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.01>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.02">
										<eInjury.02>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.02>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.03">
										<eInjury.03>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.03>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.04">
										<xsl:variable name="var3_NV" as="node()?" select="@NV"/>
										<xsl:variable name="var4_CorrelationID" as="node()?" select="@CorrelationID"/>
										<eInjury.04>
											<xsl:if test="fn:exists($var3_NV)">
												<xsl:attribute name="NV" namespace="" select="fn:string($var3_NV)"/>
											</xsl:if>
											<xsl:if test="fn:exists($var4_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var4_CorrelationID)"/>
											</xsl:if>
											<xsl:if test="(fn:translate(fn:string(@xsi:nil), 'true ', '1') = '1')">
												<xsl:attribute name="xsi:nil" select="'true'"/>
											</xsl:if>
											<xsl:if test="fn:not((fn:translate(fn:string(@xsi:nil), 'true ', '1') = '1'))">
												<xsl:sequence select="fn:string(.)"/>
											</xsl:if>
										</eInjury.04>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.05">
										<eInjury.05>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</eInjury.05>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.06">
										<eInjury.06>
											<xsl:sequence select="fn:string(.)"/>
										</eInjury.06>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.07">
										<eInjury.07>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.07>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.08">
										<eInjury.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.09">
										<eInjury.09>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</eInjury.09>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.10">
										<eInjury.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:eInjury/ns0:eInjury.CollisionGroup">
										<eInjury.CollisionGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eInjury.CollisionGroup>
									</xsl:for-each>
								</eInjury>
								<eArrest>
									<eArrest.01>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.01/@node(), ./ns0:eArrest/ns0:eArrest.01/node())"/>
									</eArrest.01>
									<eArrest.02>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.02/@node(), ./ns0:eArrest/ns0:eArrest.02/node())"/>
									</eArrest.02>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.03">
										<eArrest.03>
											<xsl:sequence select="@xsi:nil"/>
											<xsl:call-template name="tbf:tbf1_">
												<xsl:with-param name="input" select="." as="node()"/>
											</xsl:call-template>
										</eArrest.03>
									</xsl:for-each>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.04">
										<eArrest.04>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.04>
									</xsl:for-each>
									<eArrest.05>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.05/@node(), ./ns0:eArrest/ns0:eArrest.05/node())"/>
									</eArrest.05>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.06">
										<eArrest.06>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.06>
									</xsl:for-each>
									<eArrest.07>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.07/@node(), ./ns0:eArrest/ns0:eArrest.07/node())"/>
									</eArrest.07>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.08">
										<eArrest.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.09">
										<eArrest.09>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.09>
									</xsl:for-each>
									
									
									<eArrest.11>
										<!--<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.11/@node(), ./ns0:eArrest/ns0:eArrest.11/node())"/>-->														
										<xsl:choose>
											<xsl:when test="./ns0:eArrest/ns0:eArrest.11/node()=fn:string(3011003)">
												<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.11/@node(), '3011005')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.11/@node(), ./ns0:eArrest/ns0:eArrest.11/node())"/>
											</xsl:otherwise>
										</xsl:choose>
									</eArrest.11>
									
									
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.12">
										<eArrest.12>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.12>
									</xsl:for-each>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.13">
										<eArrest.13>
											<xsl:sequence select="fn:string(.)"/>
										</eArrest.13>
									</xsl:for-each>
									<eArrest.14>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.14/@node(), ./ns0:eArrest/ns0:eArrest.14/node())"/>
									</eArrest.14>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.15">
										<eArrest.15>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.15>
									</xsl:for-each>
									<eArrest.16>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.16/@node(), ./ns0:eArrest/ns0:eArrest.16/node())"/>
									</eArrest.16>
									<xsl:for-each select="ns0:eArrest/ns0:eArrest.17">
										<eArrest.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eArrest.17>
									</xsl:for-each>
									<eArrest.18>
										<xsl:sequence select="(./ns0:eArrest/ns0:eArrest.18/@node(), ./ns0:eArrest/ns0:eArrest.18/node())"/>
									</eArrest.18>
								</eArrest>
								<eHistory>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.01">
										<eHistory.01>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.01>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.PractitionerGroup">
										<eHistory.PractitionerGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.PractitionerGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.05">
										<eHistory.05>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.05>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.06">
										<eHistory.06>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.06>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.07">
										<eHistory.07>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.07>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.08">
										<eHistory.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.09">
										<eHistory.09>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.09>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.ImmunizationsGroup">
										<xsl:variable name="var5_CorrelationID" as="node()?" select="@CorrelationID"/>
										<eHistory.ImmunizationsGroup>
											<xsl:if test="fn:exists($var5_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var5_CorrelationID)"/>
											</xsl:if>
											<xsl:for-each select="ns0:eHistory.10">
												<eHistory.10>
													<xsl:sequence select="fn:string(.)"/>
												</eHistory.10>
											</xsl:for-each>
											<xsl:for-each select="ns0:eHistory.11">
												<eHistory.11>
													<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
												</eHistory.11>
											</xsl:for-each>
										</eHistory.ImmunizationsGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.CurrentMedsGroup">
										<eHistory.CurrentMedsGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.CurrentMedsGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.16">
										<eHistory.16>
											<xsl:sequence select="fn:string(.)"/>
										</eHistory.16>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.17">
										<eHistory.17>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.17>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.18">
										<eHistory.18>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eHistory.18>
									</xsl:for-each>
									<xsl:for-each select="ns0:eHistory/ns0:eHistory.19">
										<eHistory.19>
											<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
										</eHistory.19>
									</xsl:for-each>
								</eHistory>
								<xsl:for-each select="ns0:eNarrative">
									<eNarrative>
										<xsl:sequence select="(./@node(), ./node())"/>
									</eNarrative>
								</xsl:for-each>
								<eVitals>
									<xsl:sequence select="(./ns0:eVitals/@node(), ./ns0:eVitals/node())"/>
								</eVitals>
								<xsl:for-each select="ns0:eLabs">
									<eLabs>
										<xsl:sequence select="(./@node(), ./node())"/>
									</eLabs>
								</xsl:for-each>
								<xsl:for-each select="ns0:eExam">
									<eExam>
										<xsl:for-each select="ns0:eExam.01">
											<eExam.01>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eExam.01>
										</xsl:for-each>
										<xsl:for-each select="ns0:eExam.02">
											<eExam.02>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eExam.02>
										</xsl:for-each>
										<xsl:for-each select="ns0:eExam.AssessmentGroup">
											<xsl:variable name="var6_CorrelationID" as="node()?" select="@CorrelationID"/>
											<eExam.AssessmentGroup>
												<xsl:if test="fn:exists($var6_CorrelationID)">
													<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var6_CorrelationID)"/>
												</xsl:if>
												<xsl:for-each select="ns0:eExam.03">
													<eExam.03>
														<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
													</eExam.03>
												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.04">
													<eExam.04>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eExam.04>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.05">
													<eExam.05>
														<!-- <xsl:sequence select="(./@node(), ./node())"/> -->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3505025) or fn:string(./node())=fn:string(3505027) ">
																<xsl:sequence select="(./@node(), '3505045')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</eExam.05>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.06">
														<!--<xsl:sequence select="(./@node(), ./node())"/>	-->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3506027) or fn:string(./node())=fn:string(3506029) ">
																<eExam.06><xsl:sequence select="(./@node(), '3506047')"/></eExam.06>
															</xsl:when>
															<xsl:when test="fn:string(./node())=fn:string(3506019)">
															</xsl:when>
															<xsl:otherwise>
																<eExam.06><xsl:sequence select="(./@node(), ./node())"/></eExam.06>
															</xsl:otherwise>
														</xsl:choose>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.07">
													<eExam.07>
														<!--<xsl:sequence select="(./@node(), ./node())"/>-->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3507021) or fn:string(./node())=fn:string(3507023) ">
																<xsl:sequence select="(./@node(), '3507049')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</eExam.07>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.08">
													<eExam.08>
														<!--<xsl:sequence select="(./@node(), ./node())"/>-->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3508043) or fn:string(./node())=fn:string(3508045) ">
																<xsl:sequence select="(./@node(), '3508097')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</eExam.08>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.09">
													<eExam.09>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eExam.09>
												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.AbdomenGroup">
													<xsl:variable name="var7_CorrelationID" as="node()?" select="@CorrelationID"/>
													<eExam.AbdomenGroup>
														<xsl:if test="fn:exists($var7_CorrelationID)">
															<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var7_CorrelationID)"/>
														</xsl:if>
														<xsl:for-each select="ns0:eExam.10">
															<eExam.10>
																<xsl:sequence select="fn:string(.)"/>
															</eExam.10>
														</xsl:for-each>


														<xsl:for-each select="ns0:eExam.11">
															<eExam.11>
																<!--<xsl:sequence select="(./@node(), ./node())"/>-->
																<xsl:choose>
																	<xsl:when test="fn:string(./node())=fn:string(3511027) or fn:string(./node())=fn:string(3511029) ">
																		<xsl:sequence select="(./@node(), '3511053')"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:sequence select="(./@node(), ./node())"/>
																	</xsl:otherwise>
																</xsl:choose>
															</eExam.11>
														</xsl:for-each>


													</eExam.AbdomenGroup>
												</xsl:for-each>


												<xsl:for-each select="ns0:eExam.12">
													<eExam.12>
														<!--<xsl:sequence select="(./@node(), ./node())"/>-->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3512029) or fn:string(./node())=fn:string(3512031) ">
																<xsl:sequence select="(./@node(), '3512059')"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="(./@node(), ./node())"/>
															</xsl:otherwise>
														</xsl:choose>
													</eExam.12>


												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.SpineGroup">
													<xsl:variable name="var8_CorrelationID" as="node()?" select="@CorrelationID"/>
													<eExam.SpineGroup>
														<xsl:if test="fn:exists($var8_CorrelationID)">
															<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var8_CorrelationID)"/>
														</xsl:if>


														<xsl:for-each select="ns0:eExam.13">
															<!--<xsl:sequence select="fn:string(.)"/>-->
															<xsl:choose>
																<xsl:when test="fn:string(./node())=fn:string(3513027)"></xsl:when>
																<xsl:otherwise>
																	<eExam.13><xsl:sequence select="fn:string(.)"/></eExam.13>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>


														<xsl:for-each select="ns0:eExam.14">
															<eExam.14>
																<!--<xsl:sequence select="(./@node(), ./node())"/>-->
																<xsl:choose>
																	<xsl:when test="fn:string(./node())=fn:string(3514021) or fn:string(./node())=fn:string(3514023) ">
																		<xsl:sequence select="(./@node(), '3514047')"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:sequence select="(./@node(), ./node())"/>
																	</xsl:otherwise>
																</xsl:choose>
															</eExam.14>
														</xsl:for-each>
														
														
													</eExam.SpineGroup>
												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.ExtremityGroup">
													<xsl:variable name="var9_CorrelationID" as="node()?" select="@CorrelationID"/>
													<eExam.ExtremityGroup>
														<xsl:if test="fn:exists($var9_CorrelationID)">
															<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var9_CorrelationID)"/>
														</xsl:if>
														<xsl:for-each select="ns0:eExam.15">
															<eExam.15>
																<xsl:sequence select="fn:string(.)"/>
															</eExam.15>
														</xsl:for-each>
														
														
														<xsl:for-each select="ns0:eExam.16">
															<eExam.16>
																<!--<xsl:sequence select="(./@node(), ./node())"/>-->
																<xsl:choose>
																	<xsl:when test="fn:string(./node())=fn:string(3516039) or fn:string(./node())=fn:string(3516037) ">
																		<xsl:sequence select="(./@node(), '3516077')"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:sequence select="(./@node(), ./node())"/>
																	</xsl:otherwise>
																</xsl:choose>
															</eExam.16>
														</xsl:for-each>
														
														
													</eExam.ExtremityGroup>
												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.EyeGroup">
													<eExam.EyeGroup>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eExam.EyeGroup>
												</xsl:for-each>
												<xsl:for-each select="ns0:eExam.19">
													<eExam.19>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eExam.19>
												</xsl:for-each>
												
												
												<xsl:for-each select="ns0:eExam.20">													
														<!--<xsl:sequence select="(./@node(), ./node())"/> -->
														<xsl:choose>
															<xsl:when test="fn:string(./node())=fn:string(3520047) or fn:string(./node())=fn:string(3520049) ">
															</xsl:when>
															<xsl:otherwise>
																<eExam.20><xsl:sequence select="(./@node(), ./node())"/></eExam.20>
															</xsl:otherwise>
														</xsl:choose>													
												</xsl:for-each>
												
												
											</eExam.AssessmentGroup>
										</xsl:for-each>
										
										
										<!-- Creates eExam.21 if 3520047 or 3520049 exists. 3520047 takes priority -->
										<xsl:choose>
											<xsl:when test="ns0:eExam.AssessmentGroup/ns0:eExam.20/fn:string(node())=fn:string(3520047)">
												<eExam.21>3521003</eExam.21>
											</xsl:when>
											<xsl:when test="ns0:eExam.AssessmentGroup/ns0:eExam.20/fn:string(node())=fn:string(3520049)">
												<eExam.21>3521005</eExam.21>
											</xsl:when>
										</xsl:choose>	
										               
										               
									</eExam>
								</xsl:for-each>
								<eProtocols>
									<xsl:sequence select="(./ns0:eProtocols/@node(), ./ns0:eProtocols/node())"/>
								</eProtocols>
								<eMedications>
									<xsl:for-each select="ns0:eMedications/ns0:eMedications.MedicationGroup">
										<xsl:variable name="var10_CorrelationID" as="node()?" select="@CorrelationID"/>
										<xsl:variable name="eMedications10" as="node()" select="ns0:eMedications.10"/>
										<xsl:variable name="eMedications10_NV" as="node()?" select="$eMedications10/@NV"/>
										<eMedications.MedicationGroup>
											<xsl:if test="fn:exists($var10_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var10_CorrelationID)"/>
											</xsl:if>
											<eMedications.01>
												<xsl:sequence select="(./ns0:eMedications.01/@node(), ./ns0:eMedications.01/node())"/>
											</eMedications.01>
											<eMedications.02>
												<xsl:sequence select="(./ns0:eMedications.02/@node(), ./ns0:eMedications.02/node())"/>
											</eMedications.02>
											<eMedications.03>
												<xsl:sequence select="(./ns0:eMedications.03/@node(), ./ns0:eMedications.03/node())"/>
											</eMedications.03>
											<xsl:for-each select="ns0:eMedications.04">
												<eMedications.04>
													<xsl:sequence select="fn:string(.)"/>
												</eMedications.04>
											</xsl:for-each>
											<eMedications.DosageGroup>
												<xsl:sequence select="(./ns0:eMedications.DosageGroup/@node(), ./ns0:eMedications.DosageGroup/node())"/>
											</eMedications.DosageGroup>
											<eMedications.07>
												<xsl:sequence select="(./ns0:eMedications.07/@node(), ./ns0:eMedications.07/node())"/>
											</eMedications.07>
											
											
											<xsl:for-each select="ns0:eMedications.08">												
													<!--<xsl:sequence select="(./@node(), ./node())"/>-->																						
													<xsl:choose>
														<xsl:when test="./node()=fn:string(3708027)">
															<eMedications.08><xsl:sequence select="(./@node(), '3708043')"/></eMedications.08>
															<eMedications.08><xsl:sequence select="(./@node(), '3708045')"/></eMedications.08>
														</xsl:when>
														<xsl:otherwise>
															<eMedications.08><xsl:sequence select="(./@node(), ./node())"/></eMedications.08>
														</xsl:otherwise>
													</xsl:choose>												
											</xsl:for-each>
											
											
											<xsl:for-each select="ns0:eMedications.09">
												<eMedications.09>
													<xsl:sequence select="(./@node(), ./node())"/>
												</eMedications.09>
											</xsl:for-each>



											<eMedications.10>
												<!-- <xsl:if test="fn:exists($var12_NV)">
														<xsl:attribute name="NV" namespace="" select="fn:string($var12_NV)"/>
													</xsl:if>
													<xsl:if test="(fn:translate(fn:string($var11_resultof_first/@xsi:nil), 'true ', '1') = '1')">
														<xsl:attribute name="xsi:nil" select="'true'"/>
													</xsl:if>
													<xsl:if test="fn:not((fn:translate(fn:string($var11_resultof_first/@xsi:nil), 'true ', '1') = '1'))">
														<xsl:sequence select="fn:string($var11_resultof_first)"/>
													</xsl:if> -->
												<xsl:if test="fn:exists($eMedications10_NV)">
														<xsl:attribute name="NV" namespace="" select="fn:string($eMedications10_NV)"/>
												</xsl:if>
												<xsl:if test="(fn:translate   (fn:string($eMedications10/@xsi:nil), 'true ', '1') = '1')">
													<xsl:attribute name="xsi:nil" select="'true'"/>
												</xsl:if>
												<xsl:if test="fn:not((fn:translate(fn:string($eMedications10/@xsi:nil), 'true ', '1') = '1'))">
													<xsl:choose>
														<xsl:when test="fn:string($eMedications10)=fn:string(9905017)">
															<xsl:sequence select="'9905041'"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:sequence select="fn:string($eMedications10)"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
											</eMedications.10>




											<xsl:for-each select="ns0:eMedications.11">
												<eMedications.11>
													<xsl:sequence select="fn:string(.)"/>
												</eMedications.11>
											</xsl:for-each>
											<xsl:for-each select="ns0:eMedications.12">
												<eMedications.12>
													<xsl:sequence select="fn:string(.)"/>
												</eMedications.12>
											</xsl:for-each>
										</eMedications.MedicationGroup>
									</xsl:for-each>
								</eMedications>
								<eProcedures>
									<xsl:for-each select="ns0:eProcedures/ns0:eProcedures.ProcedureGroup">
										<xsl:variable name="var13_CorrelationID" as="node()?" select="@CorrelationID"/>
										<eProcedures.ProcedureGroup>
											<xsl:if test="fn:exists($var13_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var13_CorrelationID)"/>
											</xsl:if>
											<eProcedures.01>
												<xsl:sequence select="(./ns0:eProcedures.01/@node(), ./ns0:eProcedures.01/node())"/>
											</eProcedures.01>
											<eProcedures.02>
												<xsl:sequence select="(./ns0:eProcedures.02/@node(), ./ns0:eProcedures.02/node())"/>
											</eProcedures.02>
											<eProcedures.03>
												<xsl:sequence select="(./ns0:eProcedures.03/@node(), ./ns0:eProcedures.03/node())"/>
											</eProcedures.03>
											<xsl:for-each select="ns0:eProcedures.04">
												<eProcedures.04>
													<xsl:sequence select="fn:string(.)"/>
												</eProcedures.04>
											</xsl:for-each>
											<eProcedures.05>
												<xsl:sequence select="(./ns0:eProcedures.05/@node(), ./ns0:eProcedures.05/node())"/>
											</eProcedures.05>
											<eProcedures.06>
												<xsl:sequence select="(./ns0:eProcedures.06/@node(), ./ns0:eProcedures.06/node())"/>
											</eProcedures.06>
											
											
											<xsl:for-each select="ns0:eProcedures.07">
												<!--<eProcedures.07>
													<xsl:sequence select="(./@node(), ./node())"/>
												</eProcedures.07>-->
													<xsl:choose>
														<xsl:when test="fn:string(./node())=fn:string(3907029)">
															<eProcedures.07><xsl:sequence select="(./@node(), 3907049)"/></eProcedures.07>
															<eProcedures.07><xsl:sequence select="(./@node(), 3907051)"/></eProcedures.07>
														</xsl:when>
														<xsl:when test="fn:string(./node())=fn:string(3907037)">
															<eProcedures.07 xsi:nil="true" NV="7701001"/>
														</xsl:when>
														<xsl:otherwise>
															<eProcedures.07><xsl:sequence select="(./@node(), ./node())"/></eProcedures.07>
														</xsl:otherwise>
													</xsl:choose>
											</xsl:for-each>
											
											
											<eProcedures.08>
												<xsl:sequence select="(./ns0:eProcedures.08/@node(), ./ns0:eProcedures.08/node())"/>
											</eProcedures.08>
											<xsl:for-each select="ns0:eProcedures.09">
												<eProcedures.09>
													<xsl:sequence select="(./@node(), ./node())"/>
												</eProcedures.09>
											</xsl:for-each>



											<eProcedures.10>
													<!-- <xsl:sequence select="(./ns0:eProcedures.10/@node(), ./ns0:eProcedures.10/node())"/> -->
													<xsl:choose>
														<xsl:when test="fn:string(./ns0:eProcedures.10/node())=fn:string(9905017)">
															<xsl:sequence select="(./ns0:eProcedures.10/@node(), '9905041')"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:sequence select="(./ns0:eProcedures.10/@node(), ./ns0:eProcedures.10/node())"/>
														</xsl:otherwise>
													</xsl:choose>
											</eProcedures.10>


											<xsl:for-each select="ns0:eProcedures.11">
												<eProcedures.11>
													<xsl:sequence select="fn:string(.)"/>
												</eProcedures.11>
											</xsl:for-each>
											<xsl:for-each select="ns0:eProcedures.12">
												<eProcedures.12>
													<xsl:sequence select="fn:string(.)"/>
												</eProcedures.12>
											</xsl:for-each>
											<xsl:for-each select="ns0:eProcedures.13">
												<eProcedures.13>
													<xsl:sequence select="(./@node(), ./node())"/>
												</eProcedures.13>
											</xsl:for-each>
										</eProcedures.ProcedureGroup>
									</xsl:for-each>
								</eProcedures>
								<xsl:for-each select="ns0:eAirway">
									<eAirway>
										<xsl:for-each select="ns0:eAirway.AirwayGroup">
											<eAirway.AirwayGroup>
												<xsl:for-each select="ns0:eAirway.01">
													<eAirway.01>
														<xsl:sequence select="(./@node(), ./node())"/>
													</eAirway.01>
												</xsl:for-each>
												<xsl:for-each select="ns0:eAirway.ConfirmationGroup">
													<xsl:variable name="var14_ProcedureGroupCorrelationID" as="node()?" select="@ProcedureGroupCorrelationID"/>
													<xsl:variable name="var15_CorrelationID" as="node()?" select="@CorrelationID"/>
													<eAirway.ConfirmationGroup>
														<xsl:if test="fn:exists($var15_CorrelationID)">
															<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var15_CorrelationID)"/>
														</xsl:if>
														<xsl:if test="fn:exists($var14_ProcedureGroupCorrelationID)">
															<xsl:attribute name="ProcedureGroupCorrelationID" namespace="" select="fn:string($var14_ProcedureGroupCorrelationID)"/>
														</xsl:if>
														<xsl:for-each select="ns0:eAirway.02">
															<eAirway.02>
																<xsl:sequence select="(./@node(), ./node())"/>
															</eAirway.02>
														</xsl:for-each>
														<xsl:for-each select="ns0:eAirway.03">
															<eAirway.03>
																<xsl:sequence select="(./@node(), ./node())"/>
															</eAirway.03>
														</xsl:for-each>
														<xsl:for-each select="ns0:eAirway.04">
															<eAirway.04>
																<xsl:sequence select="(./@node(), ./node())"/>
															</eAirway.04>
														</xsl:for-each>
														<xsl:for-each select="ns0:eAirway.05">
															<eAirway.05>
																<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
															</eAirway.05>
														</xsl:for-each>
														<xsl:for-each select="ns0:eAirway.06">
															<eAirway.06>
																<xsl:sequence select="(./@node(), ./node())"/>
															</eAirway.06>
														</xsl:for-each>
														<xsl:for-each select="ns0:eAirway.07">
															<eAirway.07>
																<xsl:sequence select="(./@node(), ./node())"/>
															</eAirway.07>
														</xsl:for-each>
													</eAirway.ConfirmationGroup>
												</xsl:for-each>
												<xsl:for-each select="ns0:eAirway.10">
													<eAirway.10>
														<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
													</eAirway.10>
												</xsl:for-each>
												<xsl:for-each select="ns0:eAirway.11">
													<eAirway.11>
														<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
													</eAirway.11>
												</xsl:for-each>
											</eAirway.AirwayGroup>
										</xsl:for-each>
									</eAirway>
								</xsl:for-each>
								<xsl:for-each select="ns0:eDevice">
									<eDevice>
										<xsl:sequence select="(./@node(), ./node())"/>
									</eDevice>
								</xsl:for-each>
								<eDisposition>
									<eDisposition.DestinationGroup>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.01">
											<eDisposition.01>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eDisposition.01>
										</xsl:for-each>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.02">
											<eDisposition.02>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eDisposition.02>
										</xsl:for-each>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.03">
											<eDisposition.03>
												<xsl:sequence select="(./@node(), ./node())"/>
											</eDisposition.03>
										</xsl:for-each>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.04">
											<eDisposition.04>
												<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
											</eDisposition.04>
										</xsl:for-each>

										<!--<eDisposition.05>
											<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.05/@node(), ./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.05/node())"/>
										</eDisposition.05>-->
										<xsl:call-template name="ANSIStateCode">
    									<xsl:with-param name="usage" select="'REQUIRED'" />
    									<xsl:with-param name="elementName" select="'eDisposition.05'" />
    									<xsl:with-param name="elementNode" select="./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.05" />
										</xsl:call-template>


										<!-- <xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.06/@node(), ./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.06/node())"/> -->
										<xsl:call-template name="ANSICountyCode">
    									<xsl:with-param name="usage" select="'REQUIRED'" />
    									<xsl:with-param name="elementName" select="'eDisposition.06'" />
    									<xsl:with-param name="elementNode" select="./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.06" />
										</xsl:call-template>


										<eDisposition.07>
											<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.07/@node(), ./ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.07/node())"/>
										</eDisposition.07>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.08">
											<eDisposition.08>
												<xsl:sequence select="fn:string(.)"/>
											</eDisposition.08>
										</xsl:for-each>
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.09">
											<eDisposition.09>
												<xsl:sequence select="fn:string(.)"/>
											</eDisposition.09>
										</xsl:for-each>
										
										
										<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.DestinationGroup/ns0:eDisposition.10">											
												<!-- <xsl:sequence select="fn:string(.)"/> -->
												<xsl:choose>
													<xsl:when test="matches(fn:string(.),',')"></xsl:when>
													<xsl:otherwise>
														<eDisposition.10><xsl:sequence select="fn:string(.)"/></eDisposition.10>
													</xsl:otherwise>
												</xsl:choose>											
										</xsl:for-each>
										
										
									</eDisposition.DestinationGroup>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.11">
										<eDisposition.11>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.11>
									</xsl:for-each>
									<eDisposition.12>
										<xsl:sequence select="fn:string(ns0:eDisposition/ns0:eDisposition.12)"/>
									</eDisposition.12>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.13">
										<eDisposition.13>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.13>
									</xsl:for-each>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.14">
										<eDisposition.14>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.14>
									</xsl:for-each>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.15">
										<eDisposition.15>
											<xsl:sequence select="fn:string(.)"/>
										</eDisposition.15>
									</xsl:for-each>
									<eDisposition.16>
										<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.16/@node(), ./ns0:eDisposition/ns0:eDisposition.16/node())"/>
									</eDisposition.16>
									<eDisposition.17>
										<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.17/@node(), ./ns0:eDisposition/ns0:eDisposition.17/node())"/>
									</eDisposition.17>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.18">
										<eDisposition.18>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.18>
									</xsl:for-each>

									<eDisposition.19 xsi:nil="true" NV="7701001">
										<!--<xsl:sequence select="ns0:eDisposition/ns0:eDisposition.19/@xsi:nil"/>
										<xsl:call-template name="tbf:tbf2_">
											<xsl:with-param name="input" select="ns0:eDisposition/ns0:eDisposition.19" as="node()"/>
										</xsl:call-template>-->
									</eDisposition.19>


									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.20">
										<eDisposition.20>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.20>
									</xsl:for-each>
									<eDisposition.21>
										<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.21/@node(), ./ns0:eDisposition/ns0:eDisposition.21/node())"/>
									</eDisposition.21>
									<eDisposition.22>
										<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.22/@node(), ./ns0:eDisposition/ns0:eDisposition.22/node())"/>
									</eDisposition.22>
									
									
									<eDisposition.23>			
										<!-- <xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.23/@node(), ./ns0:eDisposition/ns0:eDisposition.23/node())"/> -->								
										<xsl:choose>
											<xsl:when test="./ns0:eDisposition/ns0:eDisposition.23/node()=fn:string(9908013)">
												<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.23/@node(), '9908031')"/>
											</xsl:when>
											<xsl:when test="./ns0:eDisposition/ns0:eDisposition.23/node()=fn:string(9908015)">
												<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.23/@node(), '9908033')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:sequence select="(./ns0:eDisposition/ns0:eDisposition.23/@node(), ./ns0:eDisposition/ns0:eDisposition.23/node())"/>
											</xsl:otherwise>
										</xsl:choose>
									</eDisposition.23>
									
									
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.HospitalTeamActivationGroup">
										<eDisposition.HospitalTeamActivationGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.HospitalTeamActivationGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eDisposition/ns0:eDisposition.26">
										<eDisposition.26>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eDisposition.26>
									</xsl:for-each>
								</eDisposition>
								<eOutcome>
									<eOutcome.01>
										<xsl:sequence select="(./ns0:eOutcome/ns0:eOutcome.01/@node(), ./ns0:eOutcome/ns0:eOutcome.01/node())"/>
									</eOutcome.01>
									<eOutcome.02>
										<xsl:sequence select="(./ns0:eOutcome/ns0:eOutcome.02/@node(), ./ns0:eOutcome/ns0:eOutcome.02/node())"/>
									</eOutcome.02>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.ExternalDataGroup">
										<eOutcome.ExternalDataGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOutcome.ExternalDataGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.06">
										<eOutcome.06>
											<xsl:sequence select="fn:string(.)"/>
										</eOutcome.06>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.07">
										<eOutcome.07>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</eOutcome.07>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.08">
										<eOutcome.08>
											<xsl:sequence select="fn:string(.)"/>
										</eOutcome.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.09">
										<eOutcome.09>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOutcome.09>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.10">
										<eOutcome.10>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOutcome.10>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.11">
										<eOutcome.11>
											<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
										</eOutcome.11>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.12">
										<eOutcome.12>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOutcome.12>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.13">
										<eOutcome.13>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOutcome.13>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.14">
										<eOutcome.14>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</eOutcome.14>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.15">
										<eOutcome.15>
											<xsl:sequence select="xs:string(xs:integer(fn:string(.)))"/>
										</eOutcome.15>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.16">
										<eOutcome.16>
											<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
										</eOutcome.16>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOutcome/ns0:eOutcome.17">
										<eOutcome.17>
											<xsl:sequence select="fn:string(.)"/>
										</eOutcome.17>
									</xsl:for-each>
								</eOutcome>
								<xsl:for-each select="ns0:eCustomResults">
									<eCustomResults>
										<xsl:sequence select="(./@node(), ./node())"/>
									</eCustomResults>
								</xsl:for-each>
								<eOther>
									<xsl:for-each select="ns0:eOther/ns0:eOther.01">
										<eOther.01>
											<xsl:sequence select="fn:string(.)"/>
										</eOther.01>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.02">
										<eOther.02>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOther.02>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.EMSCrewMemberGroup">
										<eOther.EMSCrewMemberGroup>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOther.EMSCrewMemberGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.07">
										<eOther.07>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOther.07>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.08">
										<eOther.08>
											<xsl:sequence select="(./@node(), ./node())"/>
										</eOther.08>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.FileGroup">
										<xsl:variable name="var17_CorrelationID" as="node()?" select="@CorrelationID"/>
										<eOther.FileGroup>
											<xsl:if test="fn:exists($var17_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var17_CorrelationID)"/>
											</xsl:if>
											
											
											<xsl:for-each select="ns0:eOther.09">
												<eOther.09>
													<!-- <xsl:sequence select="fn:string(.)"/> -->
													<xsl:choose>
														<xsl:when test="fn:string(.)=fn:string(4509023)">
															<xsl:sequence select="'4509001'"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:sequence select="fn:string(.)"/>
														</xsl:otherwise>
													</xsl:choose>													
												</eOther.09>
											</xsl:for-each>
											
											
											<xsl:for-each select="ns0:eOther.10">
												<eOther.10>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.10>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.11">
												<eOther.11>
													<xsl:sequence select="xs:string(xs:base64Binary(fn:string(.)))"/>
												</eOther.11>
											</xsl:for-each>
										</eOther.FileGroup>
									</xsl:for-each>
									<xsl:for-each select="ns0:eOther/ns0:eOther.SignatureGroup">
										<xsl:variable name="var18_CorrelationID" as="node()?" select="@CorrelationID"/>
										<eOther.SignatureGroup>
											<xsl:if test="fn:exists($var18_CorrelationID)">
												<xsl:attribute name="CorrelationID" namespace="" select="fn:string($var18_CorrelationID)"/>
											</xsl:if>
											<xsl:for-each select="ns0:eOther.12">
												<eOther.12>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.12>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.13">
												<eOther.13>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.13>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.14">
												<eOther.14>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.14>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.15">
												<eOther.15>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.15>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.16">
												<eOther.16>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.16>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.17">
												<eOther.17>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.17>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.18">
												<eOther.18>
													<xsl:sequence select="xs:string(xs:base64Binary(fn:string(.)))"/>
												</eOther.18>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.19">
												<eOther.19>
													<xsl:sequence select="xs:string(xs:dateTime(fn:string(.)))"/>
												</eOther.19>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.20">
												<eOther.20>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.20>
											</xsl:for-each>
											<xsl:for-each select="ns0:eOther.21">
												<eOther.21>
													<xsl:sequence select="fn:string(.)"/>
												</eOther.21>
											</xsl:for-each>
										</eOther.SignatureGroup>
									</xsl:for-each>
								</eOther>
							</PatientCareReport>
						</xsl:for-each>
					</Header>
				</xsl:for-each>
			</xsl:for-each>
		</EMSDataSet>
	</xsl:template>
</xsl:stylesheet>
