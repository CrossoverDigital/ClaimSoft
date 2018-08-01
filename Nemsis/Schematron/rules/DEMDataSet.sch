<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="../utilities/html/schematronHtml.xsl"?><sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2" id="DEMDataSet" schemaVersion="3.4.0.170111" see="http://www.nemsis.org/v3/downloads/schematron.html">

  <sch:title>NEMSIS National ISO Schematron file for DEMDataSet</sch:title>

  <sch:ns prefix="nem" uri="http://www.nemsis.org"/>
  <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>

  <!-- "Initialize" variables used by nemsisDiagnostic. -->
  <sch:let name="nemsisElements" value="()"/>
  <sch:let name="nemsisElementsMissing" value="''"/>
  <sch:let name="nemsisElementsMissingContext" value="()"/>

  <!-- Set up key for NEMSIS element name lookup list (look up XML element name to retrieve NEMSIS element name). -->
  <xsl:variable name="nemSch_lookup_elements">
    <?DSDL_INCLUDE_START includes/lookup_elements.xml#nemSch_lookup_elements?><nemSch_lookup_elements xmlns="http://www.nemsis.org" xml:id="nemSch_lookup_elements">
  <element name="dAgency.01">EMS Agency Unique State ID</element>
  <element name="dAgency.02">EMS Agency Number</element>
  <element name="dAgency.03">EMS Agency Name</element>
  <element name="dAgency.04">EMS Agency State</element>
  <element name="dAgency.05">EMS Agency Service Area States</element>
  <element name="dAgency.06">EMS Agency Service Area County(ies)</element>
  <element name="dAgency.07">EMS Agency Census Tracts</element>
  <element name="dAgency.08">EMS Agency Service Area ZIP Codes</element>
  <element name="dAgency.09">Primary Type of Service</element>
  <element name="dAgency.10">Other Types of Service</element>
  <element name="dAgency.11">Level of Service</element>
  <element name="dAgency.12">Organization Status</element>
  <element name="dAgency.13">Organizational Type</element>
  <element name="dAgency.14">EMS Agency Organizational Tax Status</element>
  <element name="dAgency.15">Statistical Calendar Year</element>
  <element name="dAgency.16">Total Primary Service Area Size</element>
  <element name="dAgency.17">Total Service Area Population</element>
  <element name="dAgency.18">911 EMS Call Center Volume per Year</element>
  <element name="dAgency.19">EMS Dispatch Volume per Year</element>
  <element name="dAgency.20">EMS Patient Transport Volume per Year</element>
  <element name="dAgency.21">EMS Patient Contact Volume per Year</element>
  <element name="dAgency.22">EMS Billable Calls per Year</element>
  <element name="dAgency.23">EMS Agency Time Zone</element>
  <element name="dAgency.24">EMS Agency Daylight Savings Time Use</element>
  <element name="dAgency.25">National Provider Identifier</element>
  <element name="dAgency.26">Fire Department ID Number</element>
  <element name="dConfiguration.01">State Associated with the Certification/Licensure Levels</element>
  <element name="dConfiguration.02">State Certification/Licensure Levels</element>
  <element name="dConfiguration.03">Procedures Permitted by the State</element>
  <element name="dConfiguration.04">Medications Permitted by the State</element>
  <element name="dConfiguration.05">Protocols Permitted by the State</element>
  <element name="dConfiguration.06">EMS Certification Levels Permitted to Perform Each Procedure</element>
  <element name="dConfiguration.07">EMS Agency Procedures</element>
  <element name="dConfiguration.08">EMS Certification Levels Permitted to Administer Each Medication</element>
  <element name="dConfiguration.09">EMS Agency Medications</element>
  <element name="dConfiguration.10">EMS Agency Protocols</element>
  <element name="dConfiguration.11">EMS Agency Specialty Service Capability</element>
  <element name="dConfiguration.12">Billing Status</element>
  <element name="dConfiguration.13">Emergency Medical Dispatch (EMD) Provided to EMS Agency Service Area</element>
  <element name="dConfiguration.14">EMD Vendor</element>
  <element name="dConfiguration.15">Patient Monitoring Capability(ies)</element>
  <element name="dConfiguration.16">Crew Call Sign</element>
  <element name="dConfiguration.17">Dispatch Center (CAD) Name or ID</element>
  <element name="dContact.01">Agency Contact Type</element>
  <element name="dContact.02">Agency Contact Last Name</element>
  <element name="dContact.03">Agency Contact First Name</element>
  <element name="dContact.04">Agency Contact Middle Name/Initial</element>
  <element name="dContact.05">Agency Contact Address</element>
  <element name="dContact.06">Agency Contact City</element>
  <element name="dContact.07">Agency Contact State</element>
  <element name="dContact.08">Agency Contact ZIP Code</element>
  <element name="dContact.09">Agency Contact Country</element>
  <element name="dContact.10">Agency Contact Phone Number</element>
  <element name="dContact.11">Agency Contact Email Address</element>
  <element name="dContact.12">EMS Agency Contact Web Address</element>
  <element name="dContact.13">Agency Medical Director Degree</element>
  <element name="dContact.14">Agency Medical Director Board Certification Type</element>
  <element name="dContact.15">Medical Director Compensation</element>
  <element name="dContact.16">EMS Medical Director Fellowship Trained Status</element>
  <element name="dCustomConfiguration.01">Custom Data Element Title</element>
  <element name="dCustomConfiguration.02">Custom Definition</element>
  <element name="dCustomConfiguration.03">Custom Data Type</element>
  <element name="dCustomConfiguration.04">Custom Data Element Recurrence</element>
  <element name="dCustomConfiguration.05">Custom Data Element Usage</element>
  <element name="dCustomConfiguration.06">Custom Data Element Potential Values</element>
  <element name="dCustomConfiguration.07">Custom Data Element Potential NOT Values (NV)</element>
  <element name="dCustomConfiguration.08">Custom Data Element Potential Pertinent Negative Values (PN)</element>
  <element name="dCustomConfiguration.09">Custom Data Element Grouping ID</element>
  <element name="dCustomResults.01">Custom Data Element Result</element>
  <element name="dCustomResults.02">Custom Element ID Referenced</element>
  <element name="dCustomResults.03">CorrelationID of DemographicReport Element or Group</element>
  <element name="dDevice.01">Medical Device Serial Number</element>
  <element name="dDevice.02">Medical Device Name or ID</element>
  <element name="dDevice.03">Medical Device Type</element>
  <element name="dDevice.04">Medical Device Manufacturer</element>
  <element name="dDevice.05">Medical Device Model Number</element>
  <element name="dDevice.06">Medical Device Purchase Date</element>
  <element name="dFacility.01">Type of Facility</element>
  <element name="dFacility.02">Facility Name</element>
  <element name="dFacility.03">Facility Location Code</element>
  <element name="dFacility.04">Hospital Designations</element>
  <element name="dFacility.05">Facility National Provider Identifier</element>
  <element name="dFacility.06">Facility Room, Suite, or Apartment</element>
  <element name="dFacility.07">Facility Street Address</element>
  <element name="dFacility.08">Facility City</element>
  <element name="dFacility.09">Facility State</element>
  <element name="dFacility.10">Facility ZIP Code</element>
  <element name="dFacility.11">Facility County</element>
  <element name="dFacility.12">Facility Country</element>
  <element name="dFacility.13">Facility GPS Location</element>
  <element name="dFacility.14">Facility US National Grid Coordinates</element>
  <element name="dFacility.15">Facility Phone Number</element>
  <element name="dLocation.01">EMS Location Type</element>
  <element name="dLocation.02">EMS Location Name</element>
  <element name="dLocation.03">EMS Location Number</element>
  <element name="dLocation.04">EMS Location GPS</element>
  <element name="dLocation.05">EMS Location US National Grid Coordinates</element>
  <element name="dLocation.06">EMS Location Address</element>
  <element name="dLocation.07">EMS Location City</element>
  <element name="dLocation.08">EMS Location State</element>
  <element name="dLocation.09">EMS Station or Location ZIP Code</element>
  <element name="dLocation.10">EMS Location County</element>
  <element name="dLocation.11">EMS Location Country</element>
  <element name="dLocation.12">EMS Location Phone Number</element>
  <element name="dPersonnel.01">EMS Personnel's Last Name</element>
  <element name="dPersonnel.02">EMS Personnel's First Name</element>
  <element name="dPersonnel.03">EMS Personnel's Middle Name/Initial</element>
  <element name="dPersonnel.04">EMS Personnel's Mailing Address</element>
  <element name="dPersonnel.05">EMS Personnel's City of Residence</element>
  <element name="dPersonnel.06">EMS Personnel's State</element>
  <element name="dPersonnel.07">EMS Personnel's ZIP Code</element>
  <element name="dPersonnel.08">EMS Personnel's Country</element>
  <element name="dPersonnel.09">EMS Personnel's Phone Number</element>
  <element name="dPersonnel.10">EMS Personnel's Email Address</element>
  <element name="dPersonnel.11">EMS Personnel's Date of Birth</element>
  <element name="dPersonnel.12">EMS Personnel's Gender</element>
  <element name="dPersonnel.13">EMS Personnel's Race</element>
  <element name="dPersonnel.14">EMS Personnel's Citizenship</element>
  <element name="dPersonnel.15">EMS Personnel's Highest Educational Degree</element>
  <element name="dPersonnel.16">EMS Personnel's Degree Subject/Field of Study</element>
  <element name="dPersonnel.17">EMS Personnel's Motor Vehicle License Type</element>
  <element name="dPersonnel.18">EMS Personnel's Immunization Status</element>
  <element name="dPersonnel.19">EMS Personnel's Immunization Year</element>
  <element name="dPersonnel.20">EMS Personnel's Foreign Language Ability</element>
  <element name="dPersonnel.21">EMS Personnel's Agency ID Number</element>
  <element name="dPersonnel.22">EMS Personnel's State of Licensure</element>
  <element name="dPersonnel.23">EMS Personnel's State's Licensure ID Number</element>
  <element name="dPersonnel.24">EMS Personnel's State EMS Certification Licensure Level</element>
  <element name="dPersonnel.25">EMS Personnel's State EMS Current Certification Date</element>
  <element name="dPersonnel.26">EMS Personnel's Initial State's Licensure Issue Date</element>
  <element name="dPersonnel.27">EMS Personnel's Current State's Licensure Expiration Date</element>
  <element name="dPersonnel.28">EMS Personnel's National Registry Number</element>
  <element name="dPersonnel.29">EMS Personnel's National Registry Certification Level</element>
  <element name="dPersonnel.30">EMS Personnel's Current National Registry Expiration Date</element>
  <element name="dPersonnel.31">EMS Personnel's Employment Status</element>
  <element name="dPersonnel.32">EMS Personnel's Employment Status Date</element>
  <element name="dPersonnel.33">EMS Personnel's Hire Date</element>
  <element name="dPersonnel.34">EMS Personnel's Primary EMS Job Role</element>
  <element name="dPersonnel.35">EMS Personnel's Other Job Responsibilities</element>
  <element name="dPersonnel.36">EMS Personnel's Total Length of Service in Years</element>
  <element name="dPersonnel.37">EMS Personnel's Date Length of Service Documented</element>
  <element name="dPersonnel.38">EMS Personnel's Practice Level</element>
  <element name="dPersonnel.39">Date of Personnel's Certification or Licensure for Agency</element>
  <element name="dState.01">State Required Element</element>
  <element name="dVehicle.01">Unit/Vehicle Number</element>
  <element name="dVehicle.02">Vehicle Identification Number</element>
  <element name="dVehicle.03">EMS Unit Call Sign</element>
  <element name="dVehicle.04">Vehicle Type</element>
  <element name="dVehicle.05">Crew State Certification/Licensure Levels</element>
  <element name="dVehicle.06">Number of Each EMS Personnel Level on Normal 911 Ambulance Response</element>
  <element name="dVehicle.07">Number of Each EMS Personnel Level on Normal 911 Response (Non-Transport) Vehicle</element>
  <element name="dVehicle.08">Number of Each EMS Personnel Level on Normal Medical (Non-911) Transport Ambulance</element>
  <element name="dVehicle.09">Vehicle Initial Cost</element>
  <element name="dVehicle.10">Vehicle Model Year</element>
  <element name="dVehicle.11">Year Miles/Kilometers Hours Accrued</element>
  <element name="dVehicle.12">Annual Vehicle Hours</element>
  <element name="dVehicle.13">Annual Vehicle Miles/Kilometers</element>
  <element name="eAirway.01">Indications for Invasive Airway</element>
  <element name="eAirway.02">Date/Time Airway Device Placement Confirmation</element>
  <element name="eAirway.03">Airway Device Being Confirmed</element>
  <element name="eAirway.04">Airway Device Placement Confirmed Method</element>
  <element name="eAirway.05">Tube Depth</element>
  <element name="eAirway.06">Type of Individual Confirming Airway Device Placement</element>
  <element name="eAirway.07">Crew Member ID</element>
  <element name="eAirway.08">Airway Complications Encountered</element>
  <element name="eAirway.09">Suspected Reasons for Failed Airway Management</element>
  <element name="eAirway.10">Date/Time Decision to Manage the Patient with an Invasive Airway</element>
  <element name="eAirway.11">Date/Time Invasive Airway Placement Attempts Abandoned</element>
  <element name="eArrest.01">Cardiac Arrest</element>
  <element name="eArrest.02">Cardiac Arrest Etiology</element>
  <element name="eArrest.03">Resuscitation Attempted By EMS</element>
  <element name="eArrest.04">Arrest Witnessed By</element>
  <element name="eArrest.05">CPR Care Provided Prior to EMS Arrival</element>
  <element name="eArrest.06">Who Provided CPR Prior to EMS Arrival</element>
  <element name="eArrest.07">AED Use Prior to EMS Arrival</element>
  <element name="eArrest.08">Who Used AED Prior to EMS Arrival</element>
  <element name="eArrest.09">Type of CPR Provided</element>
  <element name="eArrest.11">First Monitored Arrest Rhythm of the Patient</element>
  <element name="eArrest.12">Any Return of Spontaneous Circulation</element>
  <element name="eArrest.13">Neurological Outcome at Hospital Discharge</element>
  <element name="eArrest.14">Date/Time of Cardiac Arrest</element>
  <element name="eArrest.15">Date/Time Resuscitation Discontinued</element>
  <element name="eArrest.16">Reason CPR/Resuscitation Discontinued</element>
  <element name="eArrest.17">Cardiac Rhythm on Arrival at Destination</element>
  <element name="eArrest.18">End of EMS Cardiac Arrest Event</element>
  <element name="eArrest.19">Date/Time of Initial CPR</element>
  <element name="eCrew.01">Crew Member ID</element>
  <element name="eCrew.02">Crew Member Level</element>
  <element name="eCrew.03">Crew Member Response Role</element>
  <element name="eCustomConfiguration.01">Custom Data Element Title</element>
  <element name="eCustomConfiguration.02">Custom Definition</element>
  <element name="eCustomConfiguration.03">Custom Data Type</element>
  <element name="eCustomConfiguration.04">Custom Data Element Recurrence</element>
  <element name="eCustomConfiguration.05">Custom Data Element Usage</element>
  <element name="eCustomConfiguration.06">Custom Data Element Potential Values</element>
  <element name="eCustomConfiguration.07">Custom Data Element Potential NOT Values (NV)</element>
  <element name="eCustomConfiguration.08">Custom Data Element Potential Pertinent Negative Values (PN)</element>
  <element name="eCustomConfiguration.09">Custom Data Element Grouping ID</element>
  <element name="eCustomResults.01">Custom Data Element Result</element>
  <element name="eCustomResults.02">Custom Element ID Referenced</element>
  <element name="eCustomResults.03">CorrelationID of PatientCareReport Element or Group</element>
  <element name="eDevice.01">Medical Device Serial Number</element>
  <element name="eDevice.02">Date/Time of Event (per Medical Device)</element>
  <element name="eDevice.03">Medical Device Event Type</element>
  <element name="eDevice.04">Medical Device Waveform Graphic Type</element>
  <element name="eDevice.05">Medical Device Waveform Graphic</element>
  <element name="eDevice.06">Medical Device Mode (Manual, AED, Pacing, CO2, O2, etc)</element>
  <element name="eDevice.07">Medical Device ECG Lead</element>
  <element name="eDevice.08">Medical Device ECG Interpretation</element>
  <element name="eDevice.09">Type of Shock</element>
  <element name="eDevice.10">Shock or Pacing Energy</element>
  <element name="eDevice.11">Total Number of Shocks Delivered</element>
  <element name="eDevice.12">Pacing Rate</element>
  <element name="eDispatch.01">Complaint Reported by Dispatch</element>
  <element name="eDispatch.02">EMD Performed</element>
  <element name="eDispatch.03">EMD Card Number</element>
  <element name="eDispatch.04">Dispatch Center Name or ID</element>
  <element name="eDispatch.05">Dispatch Priority (Patient Acuity)</element>
  <element name="eDispatch.06">Unit Dispatched CAD Record ID</element>
  <element name="eDisposition.01">Destination/Transferred To, Name</element>
  <element name="eDisposition.02">Destination/Transferred To, Code</element>
  <element name="eDisposition.03">Destination Street Address</element>
  <element name="eDisposition.04">Destination City</element>
  <element name="eDisposition.05">Destination State</element>
  <element name="eDisposition.06">Destination County</element>
  <element name="eDisposition.07">Destination ZIP Code</element>
  <element name="eDisposition.08">Destination Country</element>
  <element name="eDisposition.09">Destination GPS Location</element>
  <element name="eDisposition.10">Destination Location US National Grid Coordinates </element>
  <element name="eDisposition.11">Number of Patients Transported in this EMS Unit</element>
  <element name="eDisposition.12">Incident/Patient Disposition</element>
  <element name="eDisposition.13">How Patient Was Moved to Ambulance</element>
  <element name="eDisposition.14">Position of Patient During Transport</element>
  <element name="eDisposition.15">How Patient Was Transported From Ambulance</element>
  <element name="eDisposition.16">EMS Transport Method</element>
  <element name="eDisposition.17">Transport Mode from Scene</element>
  <element name="eDisposition.18">Additional Transport Mode Descriptors</element>
  <element name="eDisposition.19">Final Patient Acuity</element>
  <element name="eDisposition.20">Reason for Choosing Destination</element>
  <element name="eDisposition.21">Type of Destination</element>
  <element name="eDisposition.22">Hospital In-Patient Destination</element>
  <element name="eDisposition.23">Hospital Capability</element>
  <element name="eDisposition.24">Destination Team Pre-Arrival Alert or Activation</element>
  <element name="eDisposition.25">Date/Time of Destination Prearrival Alert or Activation</element>
  <element name="eDisposition.26">Disposition Instructions Provided</element>
  <element name="eExam.01">Estimated Body Weight in Kilograms</element>
  <element name="eExam.02">Length Based Tape Measure</element>
  <element name="eExam.03">Date/Time of Assessment</element>
  <element name="eExam.04">Skin Assessment</element>
  <element name="eExam.05">Head Assessment</element>
  <element name="eExam.06">Face Assessment</element>
  <element name="eExam.07">Neck Assessment</element>
  <element name="eExam.08">Chest/Lungs Assessment</element>
  <element name="eExam.09">Heart Assessment</element>
  <element name="eExam.10">Abdominal Assessment Finding Location</element>
  <element name="eExam.11">Abdomen Assessment</element>
  <element name="eExam.12">Pelvis/Genitourinary Assessment</element>
  <element name="eExam.13">Back and Spine Assessment Finding Location</element>
  <element name="eExam.14">Back and Spine Assessment</element>
  <element name="eExam.15">Extremity Assessment Finding Location</element>
  <element name="eExam.16">Extremities Assessment</element>
  <element name="eExam.17">Eye Assessment Finding Location</element>
  <element name="eExam.18">Eye Assessment</element>
  <element name="eExam.19">Mental Status Assessment</element>
  <element name="eExam.20">Neurological Assessment</element>
  <element name="eExam.21">Stroke/CVA Symptoms Resolved</element>
  <element name="eHistory.01">Barriers to Patient Care</element>
  <element name="eHistory.02">Last Name of Patient's Practitioner</element>
  <element name="eHistory.03">First Name of Patient's Practitioner</element>
  <element name="eHistory.04">Middle Name/Initial of Patient's Practitioner</element>
  <element name="eHistory.05">Advance Directives</element>
  <element name="eHistory.06">Medication Allergies</element>
  <element name="eHistory.07">Environmental/Food Allergies</element>
  <element name="eHistory.08">Medical/Surgical History</element>
  <element name="eHistory.09">Medical History Obtained From</element>
  <element name="eHistory.10">The Patient's Type of Immunization</element>
  <element name="eHistory.11">Immunization Year</element>
  <element name="eHistory.12">Current Medications</element>
  <element name="eHistory.13">Current Medication Dose</element>
  <element name="eHistory.14">Current Medication Dosage Unit</element>
  <element name="eHistory.15">Current Medication Administration Route</element>
  <element name="eHistory.16">Presence of Emergency Information Form</element>
  <element name="eHistory.17">Alcohol/Drug Use Indicators</element>
  <element name="eHistory.18">Pregnancy</element>
  <element name="eHistory.19">Last Oral Intake</element>
  <element name="eInjury.01">Cause of Injury</element>
  <element name="eInjury.02">Mechanism of Injury</element>
  <element name="eInjury.03">Trauma Center Criteria</element>
  <element name="eInjury.04">Vehicular, Pedestrian, or Other Injury Risk Factor</element>
  <element name="eInjury.05">Main Area of the Vehicle Impacted by the Collision</element>
  <element name="eInjury.06">Location of Patient in Vehicle</element>
  <element name="eInjury.07">Use of Occupant Safety Equipment</element>
  <element name="eInjury.08">Airbag Deployment</element>
  <element name="eInjury.09">Height of Fall (feet)</element>
  <element name="eInjury.10">OSHA Personal Protective Equipment Used</element>
  <element name="eInjury.11">ACN System/Company Providing ACN Data</element>
  <element name="eInjury.12">ACN Incident ID</element>
  <element name="eInjury.13">ACN Call Back Phone Number</element>
  <element name="eInjury.14">Date/Time of ACN Incident</element>
  <element name="eInjury.15">ACN Incident Location</element>
  <element name="eInjury.16">ACN Incident Vehicle Body Type</element>
  <element name="eInjury.17">ACN Incident Vehicle Manufacturer</element>
  <element name="eInjury.18">ACN Incident Vehicle Make</element>
  <element name="eInjury.19">ACN Incident Vehicle Model</element>
  <element name="eInjury.20">ACN Incident Vehicle Model Year</element>
  <element name="eInjury.21">ACN Incident Multiple Impacts</element>
  <element name="eInjury.22">ACN Incident Delta Velocity</element>
  <element name="eInjury.23">ACN High Probability of Injury</element>
  <element name="eInjury.24">ACN Incident PDOF</element>
  <element name="eInjury.25">ACN Incident Rollover</element>
  <element name="eInjury.26">ACN Vehicle Seat Location</element>
  <element name="eInjury.27">Seat Occupied</element>
  <element name="eInjury.28">ACN Incident Seatbelt Use</element>
  <element name="eInjury.29">ACN Incident Airbag Deployed</element>
  <element name="eLabs.01">Date/Time of Laboratory or Imaging Result</element>
  <element name="eLabs.02">Study/Result Prior to this Unit's EMS Care</element>
  <element name="eLabs.03">Laboratory Result Type</element>
  <element name="eLabs.04">Laboratory Result</element>
  <element name="eLabs.05">Imaging Study Type</element>
  <element name="eLabs.06">Imaging Study Results</element>
  <element name="eLabs.07">Imaging Study File or Waveform Graphic Type</element>
  <element name="eLabs.08">Imaging Study File or Waveform Graphic</element>
  <element name="eMedications.01">Date/Time Medication Administered</element>
  <element name="eMedications.02">Medication Administered Prior to this Unit's EMS Care</element>
  <element name="eMedications.03">Medication Given</element>
  <element name="eMedications.04">Medication Administered Route</element>
  <element name="eMedications.05">Medication Dosage</element>
  <element name="eMedications.06">Medication Dosage Units</element>
  <element name="eMedications.07">Response to Medication</element>
  <element name="eMedications.08">Medication Complication</element>
  <element name="eMedications.09">Medication Crew (Healthcare Professionals) ID</element>
  <element name="eMedications.10">Role/Type of Person Administering Medication</element>
  <element name="eMedications.11">Medication Authorization</element>
  <element name="eMedications.12">Medication Authorizing Physician</element>
  <element name="eNarrative.01">Patient Care Report Narrative</element>
  <element name="eOther.01">Review Requested</element>
  <element name="eOther.02">Potential System of Care/Specialty/Registry Patient</element>
  <element name="eOther.03">Personal Protective Equipment Used</element>
  <element name="eOther.04">EMS Professional (Crew Member) ID</element>
  <element name="eOther.05">Suspected EMS Work Related Exposure, Injury, or Death</element>
  <element name="eOther.06">The Type of Work-Related Injury, Death or Suspected Exposure</element>
  <element name="eOther.07">Natural, Suspected, Intentional, or Unintentional Disaster</element>
  <element name="eOther.08">Crew Member Completing this Report</element>
  <element name="eOther.09">External Electronic Document Type</element>
  <element name="eOther.10">File Attachment Type</element>
  <element name="eOther.11">File Attachment Image</element>
  <element name="eOther.12">Type of Person Signing</element>
  <element name="eOther.13">Signature Reason</element>
  <element name="eOther.14">Type Of Patient Representative</element>
  <element name="eOther.15">Signature Status</element>
  <element name="eOther.16">Signature File Name</element>
  <element name="eOther.17">Signature File Type</element>
  <element name="eOther.18">Signature Graphic</element>
  <element name="eOther.19">Date/Time of Signature</element>
  <element name="eOther.20">Signature Last Name</element>
  <element name="eOther.21">Signature First Name</element>
  <element name="eOutcome.01">Emergency Department Disposition</element>
  <element name="eOutcome.02">Hospital Disposition</element>
  <element name="eOutcome.03">External Report ID/Number Type</element>
  <element name="eOutcome.04">External Report ID/Number</element>
  <element name="eOutcome.05">Other Report Registry Type</element>
  <element name="eOutcome.06">Emergency Department Chief Complaint</element>
  <element name="eOutcome.07">First ED Systolic Blood Pressure</element>
  <element name="eOutcome.08">Emergency Department Recorded Cause of Injury</element>
  <element name="eOutcome.09">Emergency Department Procedures</element>
  <element name="eOutcome.10">Emergency Department Diagnosis</element>
  <element name="eOutcome.11">Date/Time of Hospital Admission</element>
  <element name="eOutcome.12">Hospital Procedures</element>
  <element name="eOutcome.13">Hospital Diagnosis</element>
  <element name="eOutcome.14">Total ICU Length of Stay</element>
  <element name="eOutcome.15">Total Ventilator Days</element>
  <element name="eOutcome.16">Date/Time of Hospital Discharge</element>
  <element name="eOutcome.17">Outcome at Hospital Discharge</element>
  <element name="ePatient.01">EMS Patient ID</element>
  <element name="ePatient.02">Last Name</element>
  <element name="ePatient.03">First Name</element>
  <element name="ePatient.04">Middle Initial/Name</element>
  <element name="ePatient.05">Patient's Home Address</element>
  <element name="ePatient.06">Patient's Home City</element>
  <element name="ePatient.07">Patient's Home County</element>
  <element name="ePatient.08">Patient's Home State</element>
  <element name="ePatient.09">Patient's Home ZIP Code</element>
  <element name="ePatient.10">Patient's Country of Residence</element>
  <element name="ePatient.11">Patient Home Census Tract</element>
  <element name="ePatient.12">Social Security Number</element>
  <element name="ePatient.13">Gender</element>
  <element name="ePatient.14">Race</element>
  <element name="ePatient.15">Age</element>
  <element name="ePatient.16">Age Units</element>
  <element name="ePatient.17">Date of Birth</element>
  <element name="ePatient.18">Patient's Phone Number</element>
  <element name="ePatient.19">Patient's Email Address</element>
  <element name="ePatient.20">State Issuing Driver's License</element>
  <element name="ePatient.21">Driver's License Number</element>
  <element name="ePayment.01">Primary Method of Payment</element>
  <element name="ePayment.02">Physician Certification Statement</element>
  <element name="ePayment.03">Date Physician Certification Statement Signed</element>
  <element name="ePayment.04">Reason for Physician Certification Statement</element>
  <element name="ePayment.05">Healthcare Provider Type Signing Physician Certification Statement</element>
  <element name="ePayment.06">Last Name of Individual Signing Physician Certification Statement</element>
  <element name="ePayment.07">First Name of Individual Signing Physician Certification Statement</element>
  <element name="ePayment.08">Patient Resides in Service Area</element>
  <element name="ePayment.09">Insurance Company ID</element>
  <element name="ePayment.10">Insurance Company Name</element>
  <element name="ePayment.11">Insurance Company Billing Priority</element>
  <element name="ePayment.12">Insurance Company Address</element>
  <element name="ePayment.13">Insurance Company City</element>
  <element name="ePayment.14">Insurance Company State</element>
  <element name="ePayment.15">Insurance Company ZIP Code</element>
  <element name="ePayment.16">Insurance Company Country</element>
  <element name="ePayment.17">Insurance Group ID</element>
  <element name="ePayment.18">Insurance Policy ID Number</element>
  <element name="ePayment.19">Last Name of the Insured</element>
  <element name="ePayment.20">First Name of the Insured</element>
  <element name="ePayment.21">Middle Initial/Name of the Insured</element>
  <element name="ePayment.22">Relationship to the Insured</element>
  <element name="ePayment.23">Closest Relative/Guardian Last Name</element>
  <element name="ePayment.24">Closest Relative/ Guardian First Name</element>
  <element name="ePayment.25">Closest Relative/ Guardian Middle Initial/Name</element>
  <element name="ePayment.26">Closest Relative/ Guardian Street Address</element>
  <element name="ePayment.27">Closest Relative/ Guardian City</element>
  <element name="ePayment.28">Closest Relative/ Guardian State</element>
  <element name="ePayment.29">Closest Relative/ Guardian ZIP Code</element>
  <element name="ePayment.30">Closest Relative/ Guardian Country</element>
  <element name="ePayment.31">Closest Relative/ Guardian Phone Number</element>
  <element name="ePayment.32">Closest Relative/ Guardian Relationship</element>
  <element name="ePayment.33">Patient's Employer</element>
  <element name="ePayment.34">Patient's Employer's Address</element>
  <element name="ePayment.35">Patient's Employer's City</element>
  <element name="ePayment.36">Patient's Employer's State</element>
  <element name="ePayment.37">Patient's Employer's ZIP Code</element>
  <element name="ePayment.38">Patient's Employer's Country</element>
  <element name="ePayment.39">Patient's Employer's Primary Phone Number</element>
  <element name="ePayment.40">Response Urgency</element>
  <element name="ePayment.41">Patient Transport Assessment</element>
  <element name="ePayment.42">Specialty Care Transport Care Provider</element>
  <element name="ePayment.44">Ambulance Transport Reason Code</element>
  <element name="ePayment.45">Round Trip Purpose Description</element>
  <element name="ePayment.46">Stretcher Purpose Description</element>
  <element name="ePayment.47">Ambulance Conditions Indicator</element>
  <element name="ePayment.48">Mileage to Closest Hospital Facility</element>
  <element name="ePayment.49">ALS Assessment Performed and Warranted</element>
  <element name="ePayment.50">CMS Service Level</element>
  <element name="ePayment.51">EMS Condition Code</element>
  <element name="ePayment.52">CMS Transportation Indicator</element>
  <element name="ePayment.53">Transport Authorization Code</element>
  <element name="ePayment.54">Prior Authorization Code Payer</element>
  <element name="ePayment.55">Supply Item Used Name</element>
  <element name="ePayment.56">Number of Supply Item(s) Used</element>
  <element name="ePayment.57">Payer Type</element>
  <element name="ePayment.58">Insurance Group Name</element>
  <element name="eProcedures.01">Date/Time Procedure Performed</element>
  <element name="eProcedures.02">Procedure Performed Prior to this Unit's EMS Care</element>
  <element name="eProcedures.03">Procedure</element>
  <element name="eProcedures.04">Size of Procedure Equipment</element>
  <element name="eProcedures.05">Number of Procedure Attempts</element>
  <element name="eProcedures.06">Procedure Successful</element>
  <element name="eProcedures.07">Procedure Complication</element>
  <element name="eProcedures.08">Response to Procedure</element>
  <element name="eProcedures.09">Procedure Crew Members ID</element>
  <element name="eProcedures.10">Role/Type of Person Performing the Procedure</element>
  <element name="eProcedures.11">Procedure Authorization</element>
  <element name="eProcedures.12">Procedure Authorizing Physician</element>
  <element name="eProcedures.13">Vascular Access Location</element>
  <element name="eProtocols.01">Protocols Used</element>
  <element name="eProtocols.02">Protocol Age Category</element>
  <element name="eRecord.01">Patient Care Report Number</element>
  <element name="eRecord.02">Software Creator</element>
  <element name="eRecord.03">Software Name</element>
  <element name="eRecord.04">Software Version</element>
  <element name="eResponse.01">EMS Agency Number</element>
  <element name="eResponse.02">EMS Agency Name</element>
  <element name="eResponse.03">Incident Number</element>
  <element name="eResponse.04">EMS Response Number</element>
  <element name="eResponse.05">Type of Service Requested</element>
  <element name="eResponse.06">Standby Purpose</element>
  <element name="eResponse.07">Primary Role of the Unit</element>
  <element name="eResponse.08">Type of Dispatch Delay</element>
  <element name="eResponse.09">Type of Response Delay</element>
  <element name="eResponse.10">Type of Scene Delay</element>
  <element name="eResponse.11">Type of Transport Delay</element>
  <element name="eResponse.12">Type of Turn-Around Delay</element>
  <element name="eResponse.13">EMS Vehicle (Unit) Number</element>
  <element name="eResponse.14">EMS Unit Call Sign</element>
  <element name="eResponse.15">Level of Care of This Unit</element>
  <element name="eResponse.16">Vehicle Dispatch Location</element>
  <element name="eResponse.17">Vehicle Dispatch GPS Location</element>
  <element name="eResponse.18">Vehicle Dispatch Location US National Grid Coordinates</element>
  <element name="eResponse.19">Beginning Odometer Reading of Responding Vehicle</element>
  <element name="eResponse.20">On-Scene Odometer Reading of Responding Vehicle</element>
  <element name="eResponse.21">Patient Destination Odometer Reading of Responding Vehicle</element>
  <element name="eResponse.22">Ending Odometer Reading of Responding Vehicle</element>
  <element name="eResponse.23">Response Mode to Scene</element>
  <element name="eResponse.24">Additional Response Mode Descriptors</element>
  <element name="eScene.01">First EMS Unit on Scene</element>
  <element name="eScene.02">Other EMS or Public Safety Agencies at Scene</element>
  <element name="eScene.03">Other EMS or Public Safety Agency ID Number</element>
  <element name="eScene.04">Type of Other Service at Scene</element>
  <element name="eScene.05">Date/Time Initial Responder Arrived on Scene</element>
  <element name="eScene.06">Number of Patients at Scene</element>
  <element name="eScene.07">Mass Casualty Incident</element>
  <element name="eScene.08">Triage Classification for MCI Patient</element>
  <element name="eScene.09">Incident Location Type</element>
  <element name="eScene.10">Incident Facility Code</element>
  <element name="eScene.11">Scene GPS Location</element>
  <element name="eScene.12">Scene US National Grid Coordinates</element>
  <element name="eScene.13">Incident Facility or Location Name</element>
  <element name="eScene.14">Mile Post or Major Roadway</element>
  <element name="eScene.15">Incident Street Address</element>
  <element name="eScene.16">Incident Apartment, Suite, or Room</element>
  <element name="eScene.17">Incident City</element>
  <element name="eScene.18">Incident State</element>
  <element name="eScene.19">Incident ZIP Code</element>
  <element name="eScene.20">Scene Cross Street or Directions</element>
  <element name="eScene.21">Incident County</element>
  <element name="eScene.22">Incident Country</element>
  <element name="eScene.23">Incident Census Tract</element>
  <element name="eSituation.01">Date/Time of Symptom Onset</element>
  <element name="eSituation.02">Possible Injury</element>
  <element name="eSituation.03">Complaint Type</element>
  <element name="eSituation.04">Complaint</element>
  <element name="eSituation.05">Duration of Complaint</element>
  <element name="eSituation.06">Time Units of Duration of Complaint</element>
  <element name="eSituation.07">Chief Complaint Anatomic Location</element>
  <element name="eSituation.08">Chief Complaint Organ System</element>
  <element name="eSituation.09">Primary Symptom</element>
  <element name="eSituation.10">Other Associated Symptoms</element>
  <element name="eSituation.11">Provider's Primary Impression</element>
  <element name="eSituation.12">Provider's Secondary Impressions</element>
  <element name="eSituation.13">Initial Patient Acuity</element>
  <element name="eSituation.14">Work-Related Illness/Injury</element>
  <element name="eSituation.15">Patient's Occupational Industry</element>
  <element name="eSituation.16">Patient's Occupation</element>
  <element name="eSituation.17">Patient Activity</element>
  <element name="eSituation.18">Date/Time Last Known Well</element>
  <element name="eState.01">State Required Element</element>
  <element name="eTimes.01">PSAP Call Date/Time</element>
  <element name="eTimes.02">Dispatch Notified Date/Time</element>
  <element name="eTimes.03">Unit Notified by Dispatch Date/Time</element>
  <element name="eTimes.04">Dispatch Acknowledged Date/Time</element>
  <element name="eTimes.05">Unit En Route Date/Time</element>
  <element name="eTimes.06">Unit Arrived on Scene Date/Time</element>
  <element name="eTimes.07">Arrived at Patient Date/Time</element>
  <element name="eTimes.08">Transfer of EMS Patient Care Date/Time</element>
  <element name="eTimes.09">Unit Left Scene Date/Time</element>
  <element name="eTimes.10">Arrival at Destination Landing Area Date/Time</element>
  <element name="eTimes.11">Patient Arrived at Destination Date/Time</element>
  <element name="eTimes.12">Destination Patient Transfer of Care Date/Time</element>
  <element name="eTimes.13">Unit Back in Service Date/Time</element>
  <element name="eTimes.14">Unit Canceled Date/Time</element>
  <element name="eTimes.15">Unit Back at Home Location Date/Time</element>
  <element name="eTimes.16">EMS Call Completed Date/Time</element>
  <element name="eVitals.01">Date/Time Vital Signs Taken</element>
  <element name="eVitals.02">Obtained Prior to this Unit's EMS Care</element>
  <element name="eVitals.03">Cardiac Rhythm / Electrocardiography (ECG)</element>
  <element name="eVitals.04">ECG Type</element>
  <element name="eVitals.05">Method of ECG Interpretation</element>
  <element name="eVitals.06">SBP (Systolic Blood Pressure)</element>
  <element name="eVitals.07">DBP (Diastolic Blood Pressure)</element>
  <element name="eVitals.08">Method of Blood Pressure Measurement</element>
  <element name="eVitals.09">Mean Arterial Pressure</element>
  <element name="eVitals.10">Heart Rate</element>
  <element name="eVitals.11">Method of Heart Rate Measurement</element>
  <element name="eVitals.12">Pulse Oximetry</element>
  <element name="eVitals.13">Pulse Rhythm</element>
  <element name="eVitals.14">Respiratory Rate</element>
  <element name="eVitals.15">Respiratory Effort</element>
  <element name="eVitals.16">End Tidal Carbon Dioxide (ETCO2)</element>
  <element name="eVitals.17">Carbon Monoxide (CO)</element>
  <element name="eVitals.18">Blood Glucose Level</element>
  <element name="eVitals.19">Glasgow Coma Score-Eye</element>
  <element name="eVitals.20">Glasgow Coma Score-Verbal</element>
  <element name="eVitals.21">Glasgow Coma Score-Motor</element>
  <element name="eVitals.22">Glasgow Coma Score-Qualifier</element>
  <element name="eVitals.23">Total Glasgow Coma Score</element>
  <element name="eVitals.24">Temperature</element>
  <element name="eVitals.25">Temperature Method</element>
  <element name="eVitals.26">Level of Responsiveness (AVPU)</element>
  <element name="eVitals.27">Pain Scale Score</element>
  <element name="eVitals.28">Pain Scale Type</element>
  <element name="eVitals.29">Stroke Scale Score</element>
  <element name="eVitals.30">Stroke Scale Type</element>
  <element name="eVitals.31">Reperfusion Checklist</element>
  <element name="eVitals.32">APGAR</element>
  <element name="eVitals.33">Revised Trauma Score</element>
</nemSch_lookup_elements><?DSDL_INCLUDE_END includes/lookup_elements.xml#nemSch_lookup_elements?>
  </xsl:variable>
  <sch:let name="nemSch_elements" value="$nemSch_lookup_elements//*:nemSch_lookup_elements"/>
  <xsl:key name="nemSch_key_elements" match="nem:element" use="@name"/>

  <!-- PHASES -->
  
  <!-- No phases used. -->

  <!-- PATTERNS -->

  <?DSDL_INCLUDE_START includes/pattern_consistency_dAgency.13.xml?><sch:pattern id="nemSch_consistency_dAgency.13">

  <!-- This pattern validates that dAgency.26 Fire Department ID Number is recorded when dAgency.13 Organizational Type is "Fire Department" and is not recorded when dAgency.13 Organizational Type is not "Fire Department". -->

  <sch:title>Fire Department ID Number is recorded when Organizational Type is "Fire Department" and is not recorded when Organizational Type is not "Fire Department".</sch:title>

  <sch:rule id="nemSch_consistency_dAgency.13_dAgency.26" context="nem:dAgency.13">

    <sch:let name="nemsisElements" value="., ../nem:dAgency.26"/>

    <sch:assert id="nemSch_consistency_dAgency.13_dAgency.26_fire" role="[WARNING]" diagnostics="nemsisDiagnostic" test=". != '9912001' or ../nem:dAgency.26 != ''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "Fire Department", <sch:value-of select="key('nemSch_key_elements', 'dAgency.26', $nemSch_elements)"/> should be recorded.
    </sch:assert>

    <sch:assert id="nemSch_consistency_dAgency.13_dAgency.26_nonfire" role="[WARNING]" diagnostics="nemsisDiagnostic" test=". = '9912001' or ../nem:dAgency.26 = ''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is not "Fire Department", <sch:value-of select="key('nemSch_key_elements', 'dAgency.26', $nemSch_elements)"/> should not be recorded.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_dAgency.13.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_dAgency.ServiceGroup.xml?><sch:pattern id="nemSch_consistency_dAgency.ServiceGroup">

  <!-- This pattern validates that each instance of dAgency.06 EMS Agency Service Area County(ies) belongs within the state recorded in dAgency.05 EMS Agency Service Area States and each instance of dAgency.07 EMS Agency Census Tracts belongs within a county recorded in dAgency.06 EMS Agency Service Area County(ies) within the state recorded in dAgency.04 EMS Agency Service Area States. -->

  <sch:title>EMS Agency Service Area County belongs to the EMS Agency Service Area State with which it is grouped and EMS Agency Service Area Census Tract belongs to an EMS Agency Service Area County and the EMS Agency Service Area State with which it is grouped.</sch:title>

  <sch:rule id="nemSch_consistency_dAgency.ServiceGroup_dAgency.06" context="nem:dAgency.06">

    <sch:let name="nemsisElements" value="../nem:dAgency.05, ."/>

    <sch:assert id="nemSch_consistency_dAgency.ServiceGroup_dAgency.06_dAgency.05" role="[ERROR]" diagnostics="nemsisDiagnostic" test="substring(., 1, 2) = ../nem:dAgency.05">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should belong to the state with which it is grouped.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_dAgency.ServiceGroup_dAgency.07" context="nem:dAgency.07[. != '']">

    <sch:let name="nemsisElements" value="../nem:dAgency.05, ../nem:dAgency.06, ."/>

    <sch:assert id="nemSch_consistency_dAgency.ServiceGroup_dAgency.07_dAgency.06" role="[ERROR]" diagnostics="nemsisDiagnostic" test="substring(., 1, 5) = ../nem:dAgency.06">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should belong to a county recorded in <sch:value-of select="key('nemSch_key_elements', 'dAgency.06', $nemSch_elements)"/> in the state with which it is grouped.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_dAgency.ServiceGroup.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_NilNvPn.xml?><sch:pattern id="nemSch_consistency_nilNvPn">

  <!-- This pattern allows the following combinations of nil, NV, and PN attributes:
         * For dCustomResults.01 and eCustomResults.01: Any combination
         * For elements in eExam.AssessmentGroup: PN (nil and NV are not allowed per the XSD)
         * For eMedications.03 and eProcedures.03 only: PN and not(nil) and not(NV)
         * nil and either NV or PN but not both
       If an element has neither nil, NV, nor PN, the rules in this pattern are not fired (other 
       than the dummy rule for CustomResults).
       The XSD ensures consistency between the nil attribute and whether the element is empty, so 
       that combination is not checked here.
  -->

  <sch:title>The combination of nil, Not Value (NV), and Pertinent Negative (PN) attributes for an element is appropriate.</sch:title>

  <sch:rule id="nemSch_nilNvPn_customResults" context="nem:dCustomResults.01 | nem:eCustomResults.01">

    <!-- This rule fires when dCustomResults.01 or eCustomResults.01 Custom Data Element Result has 
         a Pertinent Negative attribute. Nothing is checked. CustomResults should be validated 
         based on information contained in CustomConfiguration. -->

    <sch:let name="nemsisElements" value="."/>

    <sch:report role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Dummy report needed to make this rule valid. This report will never succeed.
    </sch:report>

  </sch:rule>

  <sch:rule id="nemSch_nilNvPn_eExam.AssessmentGroup" context="nem:eExam.AssessmentGroup//*[@PN]">

    <!-- This rule fires when an element in eExam.AssessmentGroup has a Pertinent Negative 
         attribute. Nothing is checked, since the nil and NV attributes are not allowed.  -->

    <sch:let name="nemsisElements" value="."/>

    <sch:report role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Dummy report needed to make this rule valid. This report will never succeed.
    </sch:report>

  </sch:rule>

  <sch:rule id="nemSch_nilNvPn_Pn_medication_procedure" context="nem:eMedications.03[@PN] | nem:eProcedures.03[@PN]">

    <!-- This rule fires when eMedications.03 Medication Given or eProcedures.03 Procedure has a 
         Pertinent Negative attribute. -->

    <sch:let name="nemsisElements" value="."/>

    <!-- Assert that the element should also have a value and should not have a Not Value 
         attribute. -->

    <sch:assert id="nemSch_nilNvPn_Pn_Not_NilNv" role="[ERROR]" diagnostics="nemsisDiagnostic" test="not(@NV) and not(@xsi:nil = 'true')">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> has a Pertinent Negative, it should have a value and it should not have a Not Value (Not Applicable, Not Recorded, or Not Reporting).
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_nilNvPn_Pn" context="*[@PN]">

    <!-- This rule fires when an element (other than those selected in the previous rules) has a 
         Pertinent Negative attribute. -->

    <sch:let name="nemsisElements" value="."/>

    <!-- Assert that the element should be empty and should not have a Not Value attribute. -->

    <sch:assert id="nemSch_nilNvPn_Pn_Nv_Not_Nil" role="[ERROR]" diagnostics="nemsisDiagnostic" test="not(@NV) and @xsi:nil = 'true'">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> has a Pertinent Negative, it should be empty and it should not have a Not Value (Not Applicable, Not Recorded, or Not Reporting).
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_nilNvPn_nil" context="*[@xsi:nil = 'true']">

    <!-- This rule fires when an element is empty (and does not have a Pertinent Negative 
         attribute). -->

    <sch:let name="nemsisElements" value="."/>

    <!-- Assert that the element should have a Not Value attribute or a Pertinent Negative 
         attribute. The presence of a Pertinent Negative attribute is not specifically asserted
         because if it was present, one of the rules above would have fired instead of this one. -->

    <sch:assert id="nemSch_nilNvPn_nil_Nv" role="[ERROR]" diagnostics="nemsisDiagnostic" test="@NV">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is empty, it should have a Not Value (Not Applicable, Not Recorded, or Not Reporting, if allowed for the element) or a Pertinent Negative (if allowed for the element), or it should be omitted (if the element is optional).
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_nilNvPn_Nv" context="*[@NV]">

    <!-- This rule fires when an element has a Not Value attribute (but does not have a Pertinent 
         Negative attribute and is not empty). -->

    <sch:let name="nemsisElements" value="."/>

    <!-- Assert that the element should be empty. (This is not specifically asserted because if 
         the element was empty, the rule above would have fired instead of this one). -->
    
    <sch:assert id="nemSch_nilNvPn_Nv_Nil" role="[ERROR]" diagnostics="nemsisDiagnostic" test="false()">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> has a Not Value (Not Applicable, Not Recorded, or Not Reporting), it should be empty.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_NilNvPn.xml?>
  <?DSDL_INCLUDE_START includes/pattern_sequence_dAgency.AgencyYearGroup.xml?><sch:pattern id="nemSch_sequence_dAgency.AgencyYearGroup">

  <!-- This pattern validates that dAgency.15 Statistical Calendar Year is in the past. -->

  <sch:title>Statistical Calendar Year is in the past.</sch:title>

  <sch:rule id="nemSch_sequence_dAgency.AgencyYearGroup_dAgency.15" context="nem:dAgency.15[. &gt;= year-from-date(current-date())]">

    <sch:let name="nemsisElements" value="."/>

    <sch:assert id="nemSch_sequence_dAgency.AgencyYearGroup_dAgency.15_past" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be in the past.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_sequence_dAgency.AgencyYearGroup.xml?>
  <?DSDL_INCLUDE_START includes/pattern_uniqueness_DEMDataSet.xml?><sch:pattern id="nemSch_uniqueness_DEMDataSet">

  <!-- This pattern validates that values for certain recurring agency demographic elements are 
       unique within a list.  -->

  <sch:title>Certain recurring demographic data elements are unique within a list.</sch:title>

  <sch:rule id="nemSch_uniqueness_DEMDataSet_dAgency.AgencyYearGroup" context="nem:dAgency.15[.=../preceding-sibling::nem:dAgency.AgencyYearGroup/nem:dAgency.15]">

    <sch:let name="nemsisElements" value="../preceding-sibling::nem:dAgency.AgencyYearGroup/nem:dAgency.15[.=current()], ."/>

    <sch:assert id="nemSch_uniqueness_DEMDataSet_dAgency.15" role="[ERROR]" diagnostics="nemsisDiagnostic" test="false()">
      Agency statistics for a particular <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should only be recorded once.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_DEMDataSet_dConfiguration.11" context="nem:dConfiguration.11[.='1211019']">

    <sch:let name="nemsisElements" value="../nem:dConfiguration.11"/>

    <sch:assert id="nemSch_uniqueness_DEMDataSet_dConfiguration.11_none" role="[WARNING]" diagnostics="nemsisDiagnostic" test="count(../nem:dConfiguration.11)=1">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "None", no other values should be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_DEMDataSet_dConfiguration.16" context="nem:dConfiguration.16[.=preceding-sibling::nem:dConfiguration.16]">

    <sch:let name="nemsisElements" value="preceding-sibling::nem:dConfiguration.16[.=current()], ."/>

    <sch:assert id="nemSch_uniqueness_DEMDataSet_dConfiguration.16_assert" role="[ERROR]" diagnostics="nemsisDiagnostic" test="false()">
      Each <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be unique.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_uniqueness_DEMDataSet.xml?>
  <?DSDL_INCLUDE_START includes/pattern_uniqueness_NvPn.xml?><sch:pattern id="nemSch_uniqueness_NvPn">

  <!-- This pattern validates that if a Not Value or Pertinent Negative is recorded for a 
       recurring element, no other instances of the element are recorded. -->

  <sch:title>When a Not Value or Pertinent Negative is recorded for a recurring element, it is the only value recorded.</sch:title>

  <sch:rule id="nemSch_uniqueness_NvPn_customResults" context="nem:dCustomResults.01 | nem:eCustomResults.01">

    <!-- This rule fires when dCustomResults.01 or eCustomResults.01 Custom Data Element Result 
         has a Pertinent Negative attribute. Nothing is checked. CustomResults should be validated 
         based on information contained in CustomConfiguration. -->

    <sch:let name="nemsisElements" value="."/>

    <sch:report role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Dummy report needed to make this rule valid. This report will never succeed.
    </sch:report>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_NvPn_eExam.AssessmentGroup" context="nem:eExam.AssessmentGroup//*[@PN]">

    <!-- This rule fires when an element in eExam.AssessmentGroup has a Pertinent Negative 
         attribute. Nothing is checked, since the Pertinent Negative accompanies a value.  -->

    <sch:let name="nemsisElements" value="."/>

    <sch:report role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Dummy report needed to make this rule valid. This report will never succeed.
    </sch:report>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_NvPn_Nv" context="*[@NV][local-name() = (local-name(preceding-sibling::*[1]), local-name(following-sibling::*[1]))]">

    <!-- This rule fires when a recurring element (other than those selected in the previous 
         rules) has a Not Value attribute. -->

    <sch:let name="nemsisElements" value="../*[local-name() = local-name(current())]"/>

    <!-- Assert that the Not Value should be the only value recorded for the element.  -->

    <sch:assert id="nemSch_uniqueness_NvPn_Nv_only" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> has a Not Value, no other <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_NvPn_Pn" context="*[@PN][local-name() = (local-name(preceding-sibling::*[1]), local-name(following-sibling::*[1]))]">

    <!-- This rule fires when a recurring element (other than those selected in the previous 
         rules) has a Pertinent Negative attribute. -->

    <sch:let name="nemsisElements" value="../*[local-name() = local-name(current())]"/>

    <!-- Assert that the Pertinent Negative should be the only value recorded for the element.  -->

    <sch:assert id="nemSch_uniqueness_NvPn_Pn_only" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> has a Pertinent Negative, no other <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_uniqueness_NvPn.xml?>

  <!-- DIAGNOSTICS -->

  <sch:diagnostics>

    <?DSDL_INCLUDE_START includes/diagnostic_nemsisDiagnostic.xml?><sch:diagnostic id="nemsisDiagnostic">

  <!-- This is the NEMSIS national diagnostic. It must exist in every NEMSIS Schematron document, 
       and it should be referenced by every assert and report. It provides nationally-
       standardized, structured data to communicate which data elements are of interest in a 
       failed assert or successful report. -->

  <nemsisDiagnostic xmlns="http://www.nemsis.org" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <!-- Elements that uniquely identify the record where the problem happened. -->

    <record>
      <xsl:copy-of select="ancestor-or-self::*:DemographicReport/*:dAgency/(*:dAgency.01 | *:dAgency.02 | *:dAgency.04)"/>
      <xsl:copy-of select="ancestor-or-self::*:Header/*:DemographicGroup/*"/>
      <xsl:copy-of select="ancestor-or-self::*:PatientCareReport/*:eRecord/*:eRecord.01"/>
    </record>

    <!-- Elements that the user may want to revisit to resolve the problem, along with their values. -->

    <elements>
      <xsl:for-each select="$nemsisElements">
        <xsl:element name="element">
          <xsl:attribute name="location">
            <xsl:apply-templates select="." mode="schematron-get-full-path"/>
          </xsl:attribute>
          <xsl:for-each select="@*">
            <xsl:attribute name="{name()}">
              <xsl:value-of select="."/>
            </xsl:attribute>
          </xsl:for-each>
          <xsl:if test="not(*)">
            <xsl:value-of select="."/>
          </xsl:if>
        </xsl:element>
      </xsl:for-each>
    </elements>

    <!-- Elements that were missing, that the user may want to visit to resolve the problem. -->

    <elementsMissing>
      <xsl:variable name="default_context" select="."/>
      <xsl:for-each select="tokenize($nemsisElementsMissing, ' ')">
        <xsl:variable name="parent" select="$nemsisElementsMissingContext[contains(local-name(), substring-before(current(), '.'))][1]"/>
        <element>
          <xsl:attribute name="parentLocation">
            <xsl:choose>
              <xsl:when test="$parent">
                <xsl:apply-templates select="$parent" mode="schematron-get-full-path"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="$default_context" mode="schematron-get-full-path"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="name">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </element>
      </xsl:for-each>
    </elementsMissing>

  </nemsisDiagnostic>

</sch:diagnostic><?DSDL_INCLUDE_END includes/diagnostic_nemsisDiagnostic.xml?>

  </sch:diagnostics>

</sch:schema>