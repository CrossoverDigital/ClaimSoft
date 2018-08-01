<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="../utilities/html/schematronHtml.xsl"?><sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2" id="EMSDataSet" schemaVersion="3.4.0.170111" see="http://www.nemsis.org/v3/downloads/schematron.html">

  <sch:title>NEMSIS National ISO Schematron file for EMSDataSet</sch:title>

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

  <?DSDL_INCLUDE_START includes/pattern_consistency_dAgency.02_eResponse.01.xml?><sch:pattern id="nemSch_consistency_dAgency.02_eResponse.01">

  <!-- This pattern verifies that the EMS Agency Number in eResponse.01 matches the EMS Agency Number in dAgency.02. -->

  <sch:title>eResponse.01 EMS Agency Number matches dAgency.02 EMS Agency Number.</sch:title>

  <sch:rule id="nemSch_consistency_dAgency.02_eResponse.01_eResponse.01" context="nem:eResponse.01">

    <sch:let name="nemsisElements" value="., ancestor::nem:Header/nem:DemographicGroup/nem:dAgency.02"/>

    <sch:assert id="nemSch_consistency_dAgency.02_eResponse.01_eResponse.01_match" role="[WARNING]" diagnostics="nemsisDiagnostic" test=". = ancestor::nem:Header/nem:DemographicGroup/nem:dAgency.02">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> in the patient care report should match <sch:value-of select="key('nemSch_key_elements', 'dAgency.02', $nemSch_elements)"/> in the agency demographic information.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_dAgency.02_eResponse.01.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eArrest.xml?><sch:pattern id="nemSch_consistency_eArrest">

  <!-- This pattern validates consistency between the presence of cardiac arrest and the presence 
       of elements that are only collected in cardiac arrest cases. The elements in the eArrest 
       section should be recorded when (and only when) eArrest.01 Cardiac Arrest is "Yes...". -->

  <sch:title>When eArrest.01 Cardiac Arrest is "Yes...", other elements in the eArrest section are recorded, and when eArrest.01 Cardiac Arrest is not "Yes...", other elements in the eArrest section are not recorded.</sch:title>

  <sch:rule id="nemSch_consistency_eArrest_all" context="nem:eArrest[nem:eArrest.01 = ('3001003', '3001005')]">

    <!-- This rule fires when eArrest.01 Cardiac Arrest is "Yes...". -->

    <!-- Flag each of the following elements if it is empty. -->

    <sch:let name="eArrest.02" value="if(nem:eArrest.02 != '') then '' else key('nemSch_key_elements', 'eArrest.02', $nemSch_elements)"/>

    <sch:let name="eArrest.03" value="if(not(nem:eArrest.03 = '')) then '' else key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/>

    <sch:let name="eArrest.04" value="if(not(nem:eArrest.04 = '')) then '' else key('nemSch_key_elements', 'eArrest.04', $nemSch_elements)"/>

    <!-- Do not flag eArrest.05 CPR Care Provided Prior to EMS Arrival or eArrest.07 AED Use Prior 
         to EMS Arrival if Cardiac Arrest is not "Yes, Prior to EMS Arrival". -->

    <sch:let name="eArrest.05" value="if(nem:eArrest.05 != '' or nem:eArrest.01 != '3001003') then '' else key('nemSch_key_elements', 'eArrest.05', $nemSch_elements)"/>

    <sch:let name="eArrest.07" value="if(nem:eArrest.07 != '' or nem:eArrest.01 != '3001003') then '' else key('nemSch_key_elements', 'eArrest.07', $nemSch_elements)"/>

    <!-- Do not flag eArrest.17 Cardiac Rhythm on Arrival at Destination unless Disposition 
         indicates transport by EMS. -->

    <sch:let name="eArrest.17" value="if(nem:eArrest.17 != '' or not(../nem:eDisposition/nem:eDisposition.12 = (4212013, 4212017, 4212033))) then '' else key('nemSch_key_elements', 'eArrest.17', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(nem:eArrest.01, nem:eArrest.02[$eArrest.02], nem:eArrest.03[$eArrest.02], nem:eArrest.04[$eArrest.02], nem:eArrest.05[$eArrest.02], nem:eArrest.07[$eArrest.07], nem:eArrest.17[$eArrest.17])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements. -->

    <sch:assert id="nemSch_consistency_eArrest_all_present" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eArrest.02 or $eArrest.03 or $eArrest.04 or $eArrest.05 or $eArrest.07 or $eArrest.17)">
      When <sch:value-of select="key('nemSch_key_elements', 'eArrest.01', $nemSch_elements)"/> is "Yes", the following information related to cardiac arrest and resuscitation should be recorded:
      <sch:value-of select="string-join(($eArrest.02, $eArrest.03, $eArrest.04, $eArrest.05, $eArrest.07, $eArrest.17)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eArrest.01" context="nem:eArrest[some $element in .//*[local-name() != 'eArrest.01'] satisfies normalize-space($element) != '']">

    <!-- This rule fires when eArrest.01 Cardiac Arrest is not "Yes..." and the eArrest section 
         has a value recorded in any element other than eArrest.01. -->

    <sch:let name="nemsisElements" value="(nem:eArrest.01[. = ''], *[. != ''])"/>

    <sch:assert id="nemSch_consistency_eArrest.01_yes" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Information related to cardiac arrest and resuscitation should be recorded only when <sch:value-of select="key('nemSch_key_elements', 'eArrest.01', $nemSch_elements)"/> is "Yes".
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eArrest.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eArrest.03.xml?><sch:pattern id="nemSch_consistency_eArrest.03">

  <!-- This pattern validates consistency in eArrest.03 Resuscitation Attempted by EMS. -->

  <sch:title>eArrest.03 Resuscitation Attempted By EMS does not contain "Attempted/Initiated..." and "Not Attempted..." in the same record.</sch:title>

  <sch:rule id="nemSch_consistency_eArrest.03_attempted" context="nem:eArrest[nem:eArrest.03 != '']">

    <!-- This rule fires when there are non-empty instances of eArrest.03 within eArrest. -->

    <sch:let name="nemsisElements" value="nem:eArrest.03"/>

    <!-- Assert that eArrest.03 Resuscitation Attempted by EMS should not contain both "Attempted/Initiated..." and "Not Attempted..." in the same record.  -->

    <sch:assert id="nemSch_consistency_eArrest.03_attempted_not" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not(nem:eArrest.03 = ('3003001', '3003003', '3003005') and nem:eArrest.03 = ('3003007', '3003009', '3003011'))">
      <sch:value-of select="key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/> should not contain both "Attempted/Initiated..." and "Not Attempted..." in the same record.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eArrest.03.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eArrest.03_eArrest.09.xml?><sch:pattern id="nemSch_consistency_eArrest.03_eArrest.09">

  <!-- This pattern validates consistency between eArrest.03 Resuscitation Attempted by EMS and 
       eArrest.09 Type of CPR Provided. -->

  <sch:title>In eArrest.03 Resuscitation Attempted By EMS and eArrest.09 Type of CPR Provided, information is consistent regarding compressions and ventilation.</sch:title>

  <sch:rule id="nemSch_consistency_eArrest.03_eArrest.09_match" context="nem:eArrest[nem:eArrest.03 !='' or nem:eArrest.09 != '']">

    <!-- This rule fires when there are non-empty instances of eArrest.03 or eArrest.09 within 
         eArrest. -->

    <sch:let name="nemsisElements" value="(nem:eArrest.03, nem:eArrest.09)"/>

    <!-- Assert that when eArrest.03 Resuscitation Attempted by EMS contains "Initiated Chest 
         Compressions", eArrest.09 Type of CPR Provided should contain "Compressions...".  -->

    <sch:assert id="nemSch_consistency_eArrest.03_eArrest.09_compressions_1" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not(nem:eArrest.03 = '3003005') or nem:eArrest.09 = ('3009001', '3009003', '3009005', '3009007', '3009009', '3009011')">
      When <sch:value-of select="key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/> contains "Initiated Chest Compressions", <sch:value-of select="key('nemSch_key_elements', 'eArrest.09', $nemSch_elements)"/> should contain "Compressions...".
    </sch:assert>

    <!-- Assert that when eArrest.03 Resuscitation Attempted by EMS contains "Attempted 
         Ventilation", eArrest.09 Type of CPR Provided should contain "Ventilation...".  -->

    <sch:assert id="nemSch_consistency_eArrest.03_eArrest.09_ventilation_1" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not(nem:eArrest.03 = '3003003') or nem:eArrest.09 = ('3009013', '3009015', '3009017', '3009019')">
      When <sch:value-of select="key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/> contains "Attempted Ventilation", <sch:value-of select="key('nemSch_key_elements', 'eArrest.09', $nemSch_elements)"/> should contain "Ventilation...".
    </sch:assert>

    <!-- Assert that when eArrest.09 Type of CPR Provided contains "Compressions...", eArrest.03 
         Resuscitation Attempted by EMS should contain "Initiated Chest Compressions" .  -->

    <sch:assert id="nemSch_consistency_eArrest.03_eArrest.09_compressions_2" role="[WARNING]" diagnostics="nemsisDiagnostic" test="nem:eArrest.03 = '3003005' or not(nem:eArrest.09 = ('3009001', '3009003', '3009005', '3009007', '3009009', '3009011'))">
      When <sch:value-of select="key('nemSch_key_elements', 'eArrest.09', $nemSch_elements)"/> contains "Compressions...", <sch:value-of select="key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/> should contain "Initiated Chest Compressions".
    </sch:assert>

    <!-- Assert that when eArrest.09 Type of CPR Provided contains "Ventilation...", eArrest.03 
         Resuscitation Attempted by EMS should contain "Attempted Ventilation" .  -->

    <sch:assert id="nemSch_consistency_eArrest.03_eArrest.09_ventilation_2" role="[WARNING]" diagnostics="nemsisDiagnostic" test="nem:eArrest.03 = '3003003' or not(nem:eArrest.09 = ('3009013', '3009015', '3009017', '3009019'))">
      When <sch:value-of select="key('nemSch_key_elements', 'eArrest.09', $nemSch_elements)"/> contains "Ventilation...", <sch:value-of select="key('nemSch_key_elements', 'eArrest.03', $nemSch_elements)"/> should contain "Attempted Ventilation".
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eArrest.03_eArrest.09.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eDisposition.xml?><sch:pattern id="nemSch_consistency_eDisposition">

  <!-- This pattern validates consistency among elements in the eDisposition section. -->

  <sch:title>Elements in the eDisposition section are consistent.</sch:title>

  <sch:rule id="nemSch_consistency_eDisposition.06" context="nem:eDisposition.06[. != '']">

    <sch:let name="nemsisElements" value="../nem:eDisposition.05, ."/>

    <sch:assert id="nemSch_consistency_eDisposition.06_eDisposition.05" role="[WARNING]" diagnostics="nemsisDiagnostic" test="starts-with(., ../nem:eDisposition.05)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should belong within the <sch:value-of select="key('nemSch_key_elements', 'eDisposition.05', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eDisposition.21_hospital" context="nem:eDisposition.21[. = ('4221003', '4221005', '4221023')]">

    <!-- This rule fires when eDisposition.21 Destination Type is "Hospital..." or "Freestanding 
         Emergency Department". -->

    <sch:let name="nemsisElements" value="., ../(nem:eDisposition.22, nem:eDisposition.23[../nem:eDisposition.21 = '4221005'])[.='']"/>

    <sch:assert id="nemSch_consistency_eDisposition.21_hospital_eDisposition.22" role="[WARNING]" diagnostics="nemsisDiagnostic" test=". != '4221005' or ../nem:eDisposition.22!=''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "Hospital-Non-Emergency Department Bed", <sch:value-of select="key('nemSch_key_elements', 'eDisposition.22', $nemSch_elements)"/> should be recorded.
    </sch:assert>

    <sch:assert id="nemSch_consistency_eDisposition.21_hospital_eDisposition.23" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eDisposition.23!=''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "Hospital..." or "Freestanding Emergency Department", <sch:value-of select="key('nemSch_key_elements', 'eDisposition.23', $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eDisposition.21_nonhospital" context="nem:eDisposition.21">

    <!-- This rule fires when eDisposition.21 Destination Type is not "Hospital..." or 
         "Freestanding Emergency Department". -->

    <!-- Flag the following elements that should be "Not Applicable". -->
    
    <sch:let name="eDisposition.22" value="if(../nem:eDisposition.22/@NV = '7701001') then '' else key('nemSch_key_elements', 'eDisposition.22', $nemSch_elements)"/>

    <sch:let name="eDisposition.23" value="if(../nem:eDisposition.23/@NV = '7701001') then '' else key('nemSch_key_elements', 'eDisposition.23', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="., ../(nem:eDisposition.22[$eDisposition.22], nem:eDisposition.23[$eDisposition.23])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_consistency_eDisposition.21_nonhospital_all" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eDisposition.22 or $eDisposition.23)">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is not "Hospital..." or "Freestanding Emergency Department", the following should be "Not Applicable":
      <sch:value-of select="string-join(($eDisposition.22, $eDisposition.23)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eDisposition.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eDisposition.12.xml?><sch:pattern id="nemSch_consistency_eDisposition.12">

  <!-- This pattern validates that certain elements are recorded, based on the Incident/Patient 
       Disposition. -->

  <sch:title>Certain elements are recorded, based on eDisposition.12 Incident/Patient Disposition.</sch:title>

  <sch:rule id="nemSch_consistency_eDisposition.12_no_scene" context="nem:PatientCareReport[nem:eDisposition/nem:eDisposition.12[. = 4212007]]">

    <!-- This rule fires if Disposition is "Canceled (Prior to Arrival at Scene)". Nothing is 
         checked. -->

    <sch:let name="nemsisElements" value="nem:eDisposition.12"/>
    
    <sch:report role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Dummy report needed to make this rule valid. This report will never succeed.
    </sch:report>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eDisposition.12_all" context="nem:PatientCareReport">

    <!-- This rule fires on each PatientCareReport. -->

    <!-- Set flags based on eDisposition.12 Incident/Patient Disposition. -->

    <!-- no_scene: Canceled (Prior to Arrival at Scene). -->

    <sch:let name="no_scene" value="if(ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. = 4212007]) then true() else false()"/>

    <!-- no_patient: No scene or Assist, Canceled on Scene (No Patient), Standby, or Transport of 
                     Body Parts or Organs Only. -->

    <sch:let name="no_patient" value="if($no_scene or ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. &lt;= 4212011 or . = (4212039, 4212041, 4212043)]) then true() else false()"/>

    <!-- no_treatment: No patient or No Resuscitation Attempted, Patient Refused Evaluation/Care, 
                       or No Treatment/Transport Required. (Note: it is possible but not necessary 
                       that treatment was given in the case of Patient Refused Evaluation/Care.) -->

    <sch:let name="no_treatment" value="if($no_patient or ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. = (4212013, 4212015, 4212021, 4212023, 4212025)]) then true() else false()"/>

    <!-- no_transport: No patient or Without Transport, No Treatment/Transport Required, Released, 
                       or Transferred. -->

    <sch:let name="no_transport" value="if($no_patient or ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. = (4212015, 4212019, 4212021, 4212025, 4212027, 4212029, 4212031)]) then true() else false()"/>

    <!-- no_emstransport: No transport or Transported by Law Enforcement, Transported by Private 
                          Vehicle, Transport Non-Patient. -->

    <sch:let name="no_emstransport" value="if($no_transport or ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. = (4212035, 4212037, 4212043)]) then true() else false()"/>

    <!-- no_911: eResponse.05 Type of Service Requested is not "911 Response (Scene)". -->

    <sch:let name="no_911" value="if(ancestor-or-self::nem:PatientCareReport/nem:eResponse/nem:eResponse.ServiceGroup/nem:eResponse.05 != 2205001) then true() else false()"/>

    <!-- Flag each of the following elements if it is empty, contingent upon a flag that was set 
         based on the Disposition. -->

    <!-- eArrest.16: If Disposition is "Patient Dead at Scene-Resuscitation Attempted..." -->
    
    <sch:let name="eArrest.16" value="if(not(nem:eDisposition/nem:eDisposition.12 = (4212017, 4212019)) or nem:eArrest/nem:eArrest.16 != '') then '' else key('nemSch_key_elements', 'eArrest.16', $nemSch_elements)"/>

    <sch:let name="eDisposition.05" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.DestinationGroup/nem:eDisposition.05 != '') then '' else key('nemSch_key_elements', 'eDisposition.05', $nemSch_elements)"/>

    <sch:let name="eDisposition.06" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.DestinationGroup/nem:eDisposition.06 != '') then '' else key('nemSch_key_elements', 'eDisposition.06', $nemSch_elements)"/>

    <sch:let name="eDisposition.07" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.DestinationGroup/nem:eDisposition.07 != '') then '' else key('nemSch_key_elements', 'eDisposition.07', $nemSch_elements)"/>

    <sch:let name="eDisposition.16" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.16 != '') then '' else key('nemSch_key_elements', 'eDisposition.16', $nemSch_elements)"/>

    <sch:let name="eDisposition.17" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.17 != '') then '' else key('nemSch_key_elements', 'eDisposition.17', $nemSch_elements)"/>

    <sch:let name="eDisposition.19" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.19 != '') then '' else key('nemSch_key_elements', 'eDisposition.19', $nemSch_elements)"/>

    <sch:let name="eDisposition.20" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.20 != '') then '' else key('nemSch_key_elements', 'eDisposition.20', $nemSch_elements)"/>

    <sch:let name="eDisposition.21" value="if($no_emstransport or nem:eDisposition/nem:eDisposition.21 != '') then '' else key('nemSch_key_elements', 'eDisposition.21', $nemSch_elements)"/>

    <sch:let name="ePatient.07" value="if($no_emstransport or nem:ePatient/nem:ePatient.07 != '') then '' else key('nemSch_key_elements', 'ePatient.07', $nemSch_elements)"/>

    <sch:let name="ePatient.08" value="if($no_emstransport or nem:ePatient/nem:ePatient.08 != '') then '' else key('nemSch_key_elements', 'ePatient.08', $nemSch_elements)"/>

    <sch:let name="ePatient.09" value="if($no_emstransport or nem:ePatient/nem:ePatient.09 != '') then '' else key('nemSch_key_elements', 'ePatient.09', $nemSch_elements)"/>

    <sch:let name="ePatient.13" value="if($no_patient or nem:ePatient/nem:ePatient.13 != '') then '' else key('nemSch_key_elements', 'ePatient.13', $nemSch_elements)"/>

    <sch:let name="ePatient.14" value="if($no_emstransport or nem:ePatient/nem:ePatient.14 != '') then '' else key('nemSch_key_elements', 'ePatient.14', $nemSch_elements)"/>

    <sch:let name="ePatient.15" value="if($no_patient or nem:ePatient/nem:ePatient.AgeGroup/nem:ePatient.15 != '') then '' else key('nemSch_key_elements', 'ePatient.15', $nemSch_elements)"/>

    <sch:let name="ePatient.16" value="if($no_patient or nem:ePatient/nem:ePatient.AgeGroup/nem:ePatient.16 != '') then '' else key('nemSch_key_elements', 'ePatient.16', $nemSch_elements)"/>

    <sch:let name="ePayment.01" value="if($no_emstransport or nem:ePayment/nem:ePayment.01 != '') then '' else key('nemSch_key_elements', 'ePayment.01', $nemSch_elements)"/>

    <sch:let name="eScene.09" value="if($no_scene or nem:eScene/nem:eScene.09 != '') then '' else key('nemSch_key_elements', 'eScene.09', $nemSch_elements)"/>

    <sch:let name="eSituation.02" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.02 != '') then '' else key('nemSch_key_elements', 'eSituation.02', $nemSch_elements)"/>

    <sch:let name="eSituation.07" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.07 != '') then '' else key('nemSch_key_elements', 'eSituation.07', $nemSch_elements)"/>

    <sch:let name="eSituation.08" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.08 != '') then '' else key('nemSch_key_elements', 'eSituation.08', $nemSch_elements)"/>

    <sch:let name="eSituation.09" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.09 != '') then '' else key('nemSch_key_elements', 'eSituation.09', $nemSch_elements)"/>

    <sch:let name="eSituation.11" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.11 != '') then '' else key('nemSch_key_elements', 'eSituation.11', $nemSch_elements)"/>

    <sch:let name="eSituation.13" value="if($no_treatment or $no_emstransport or $no_911 or nem:eSituation/nem:eSituation.13 != '') then '' else key('nemSch_key_elements', 'eSituation.13', $nemSch_elements)"/>

    <sch:let name="eTimes.05" value="if($no_scene or nem:eTimes/nem:eTimes.05 != '') then '' else key('nemSch_key_elements', 'eTimes.05', $nemSch_elements)"/>

    <sch:let name="eTimes.06" value="if($no_scene or nem:eTimes/nem:eTimes.06 != '') then '' else key('nemSch_key_elements', 'eTimes.06', $nemSch_elements)"/>

    <sch:let name="eTimes.07" value="if($no_patient or nem:eTimes/nem:eTimes.07 != '') then '' else key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>

    <sch:let name="eTimes.09" value="if($no_emstransport or nem:eTimes/nem:eTimes.09 != '') then '' else key('nemSch_key_elements', 'eTimes.09', $nemSch_elements)"/>

    <sch:let name="eTimes.11" value="if($no_emstransport or nem:eTimes/nem:eTimes.11 != '') then '' else key('nemSch_key_elements', 'eTimes.11', $nemSch_elements)"/>

    <sch:let name="eTimes.12" value="if($no_emstransport or nem:eTimes/nem:eTimes.12 != '') then '' else key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="nem:eDisposition/nem:eDisposition.12, nem:eArrest.16[$eArrest.16], nem:eDisposition/(nem:eDisposition.DestinationGroup/(nem:eDisposition.05[$eDisposition.05], nem:eDisposition.06[$eDisposition.06], nem:eDisposition.07[$eDisposition.07]), nem:eDisposition.16[$eDisposition.16], nem:eDisposition.17[$eDisposition.17], nem:eDisposition.19[$eDisposition.19], nem:eDisposition.20[$eDisposition.20]), nem:eDisposition.21[$eDisposition.21], nem:ePatient/(nem:ePatient.07[$ePatient.07], nem:ePatient.08[$ePatient.08], nem:ePatient.09[$ePatient.09], nem:ePatient.13[$ePatient.13], nem:ePatient.14[$ePatient.14], nem:ePatient.AgeGroup/nem:ePatient.15[$ePatient.15], nem:ePatient.AgeGroup/nem:ePatient.16[$ePatient.16]), nem:ePayment.01[$ePayment.01], nem:eScene/nem:eScene.09[$eScene.09], nem:eSituation/(nem:eSituation.02[$eSituation.02], nem:eSituation.07[$eSituation.07], nem:eSituation.08[$eSituation.08], nem:eSituation.09[$eSituation.09], nem:eSituation.11[$eSituation.11], nem:eSituation.13[$eSituation.13]), nem:eTimes/(nem:eTimes.05[$eTimes.05], nem:eTimes.06[$eTimes.06], nem:eTimes.07[$eTimes.07], nem:eTimes.09[$eTimes.09], nem:eTimes.11[$eTimes.11], nem:eTimes.12[$eTimes.12])"/>

    <!-- Assert (as error) that none of certain elements above should be flagged. If the assert 
         fails, list the flagged elements.  -->

    <sch:assert id="nemSch_consistency_eDisposition.12_all_error" role="[ERROR]" diagnostics="nemsisDiagnostic" test="not($eDisposition.16 or $eDisposition.17 or $eDisposition.20 or $eDisposition.21)">
      Based on <sch:value-of select="key('nemSch_key_elements', 'eDisposition.12', $nemSch_elements)"/>, the following should be recorded:
      <sch:value-of select="string-join(($eDisposition.16, $eDisposition.17, $eDisposition.20, $eDisposition.21)[. != ''], ', ')"/>
    </sch:assert>

    <!-- Assert (as warning) that none of certain elements above should be flagged. If the assert 
         fails, list the flagged elements.  -->

    <sch:assert id="nemSch_consistency_eDisposition.12_all_warning" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eArrest.16 or $eDisposition.05 or $eDisposition.06 or $eDisposition.07 or $eDisposition.19 or $ePatient.07 or $ePatient.08 or $ePatient.09 or $ePatient.13 or $ePatient.14 or $ePatient.15 or $ePatient.16 or $ePayment.01 or $eScene.09 or $eSituation.02 or $eSituation.07 or $eSituation.08 or $eSituation.09 or $eSituation.11 or $eSituation.13 or $eTimes.05 or $eTimes.06 or $eTimes.07 or $eTimes.09 or $eTimes.11 or $eTimes.12)">
      Based on <sch:value-of select="key('nemSch_key_elements', 'eDisposition.12', $nemSch_elements)"/>, the following should be recorded:
      <sch:value-of select="string-join(($eArrest.16, $eDisposition.05, $eDisposition.06, $eDisposition.07, $eDisposition.19, $ePatient.07, $ePatient.08, $ePatient.09, $ePatient.13, $ePatient.14, $ePatient.15, $ePatient.16, $ePayment.01, $eScene.09, $eSituation.02, $eSituation.07, $eSituation.08, $eSituation.09, $eSituation.11, $eSituation.13, $eTimes.05, $eTimes.06, $eTimes.07, $eTimes.09, $eTimes.11, $eTimes.12)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eDisposition.12.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eDisposition.HospitalTeamActivationGroup.xml?><sch:pattern id="nemSch_consistency_eDisposition.HospitalTeamActivationGroup">

  <!-- This pattern validates that eDisposition.24 Destination Team Pre-Arrival Alert or 
       Activation and eDisposition.25 Date/Time of Destination Prearrival Alert or Activation are 
       both recorded when either one is recorded. -->

  <sch:title>eDisposition.24 Destination Team Pre-Arrival Alert or Activation and eDisposition.25 Date/Time of Destination Prearrival Alert or Activation are both recorded when either one is recorded.</sch:title>

  <sch:rule id="nemSch_consistency_eDisposition.HospitalTeamActivationGroup_eDisposition.24" context="nem:eDisposition.HospitalTeamActivationGroup[nem:eDisposition.25 != '']">

    <!-- This rule fires when eDisposition.25 Date/Time of Destination Prearrival Alert or 
         Activation is recorded. -->

    <sch:let name="nemsisElements" value="*"/>

    <!-- Assert that eDisposition.24 Destination Team Pre-Arrival Alert or Activation is also 
         recorded. -->

    <sch:assert id="nemSch_consistency_eDisposition.HospitalTeamActivationGroup_eDisposition.24_present" role="[WARNING]" diagnostics="nemsisDiagnostic" test="nem:eDisposition.24 != ''">
      When <sch:value-of select="key('nemSch_key_elements', 'eDisposition.25', $nemSch_elements)"/> is recorded, <sch:value-of select="key('nemSch_key_elements', 'eDisposition.24', $nemSch_elements)"/> should also be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eDisposition.HospitalTeamActivationGroup_eDisposition.25" context="nem:eDisposition.HospitalTeamActivationGroup[not(nem:eDisposition.24 = ('', '4224001'))]">

    <!-- This rule fires when eDisposition.25 Date/Time of Destination Prearrival Alert or 
         Activation is not recorded and eDisposition.24 Destination Team Pre-Arrival Alert or 
         Activation is recorded and is not "None". -->

    <sch:let name="nemsisElements" value="*"/>

    <!-- Assert that eDisposition.25 Date/Time of Destination Prearrival Alert or Activation is 
         also recorded. -->

    <sch:assert id="nemSch_consistency_eDisposition.HospitalTeamActivationGroup_eDisposition.25_present" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      When <sch:value-of select="key('nemSch_key_elements', 'eDisposition.24', $nemSch_elements)"/> is recorded, <sch:value-of select="key('nemSch_key_elements', 'eDisposition.25', $nemSch_elements)"/> should also be recorded.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eDisposition.HospitalTeamActivationGroup.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eInjury.xml?><sch:pattern id="nemSch_consistency_eInjury">

  <!-- This pattern validates consistency between the presence of possible injury and the 
       presence of elements that are only collected in possible injury cases. The elements in 
       the eInjury section should be recorded when (and only when) eSituation.02 Possible Injury 
       is "Yes". -->

  <sch:title>When eSituation.02 Possible Injury is "Yes" (and eDisposition.12 Incident/Patient Disposition indicates patient contact), elements in the eInjury section are recorded, and when eSituation.02 Possible Injury is not "Yes", elements in the eInjury section are not recorded.</sch:title>

  <sch:rule id="nemSch_consistency_eInjury_all" context="nem:eInjury[../nem:eSituation/nem:eSituation.02 = '9922005']">

    <!-- This rule fires when eSituation.02 Possible Injury is "Yes". -->

    <!-- Set no_patient flag based on eDisposition.12 Incident/Patient Disposition. -->

    <!-- no_patient: Assist, Canceled, Standby, or Transport of Body Parts or Organs Only. -->

    <sch:let name="no_patient" value="if(ancestor-or-self::nem:PatientCareReport/nem:eDisposition/nem:eDisposition.12[. &lt;= 4212011 or . = (4212039, 4212041, 4212043)]) then true() else false()"/>

    <!-- Flag each of the following elements if it is empty. -->

    <sch:let name="eInjury.01" value="if($no_patient or nem:eInjury.01 != '') then '' else key('nemSch_key_elements', 'eInjury.01', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(../nem:eSituation/nem:eSituation.02, (nem:eInjury.01)[. = ''])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_consistency_eInjury_all_present" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eInjury.01)">
      When <sch:value-of select="key('nemSch_key_elements', 'eSituation.02', $nemSch_elements)"/> is "Yes", the following information related to injury should be recorded:
      <sch:value-of select="string-join(($eInjury.01)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eInjury_eSituation.02" context="nem:eInjury[some $element in .//* satisfies normalize-space($element) != '']">

    <!-- This rule fires when eSituation.02 Possible Injury is not "Yes" and the eInjury section 
         has a value recorded in any element. -->

    <sch:let name="nemsisElements" value="(../nem:eSituation/nem:eSituation.02, *[. != ''])"/>

    <sch:assert id="nemSch_consistency_eInjury.01_yes" role="[WARNING]" diagnostics="nemsisDiagnostic" test="false()">
      Information related to injury should be recorded only when <sch:value-of select="key('nemSch_key_elements', 'eSituation.02', $nemSch_elements)"/> is "Yes".
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eInjury.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_ePatient.xml?><sch:pattern id="nemSch_consistency_ePatient">

  <!-- This pattern validates consistency among elements in the ePatient section. -->

  <sch:title>Elements in the ePatient section are consistent.</sch:title>

  <sch:rule id="nemSch_consistency_ePatient.07" context="nem:ePatient.07[. != '']">

    <sch:let name="nemsisElements" value="., ../nem:ePatient.08"/>

    <!-- Assert that the ePatient.07 Patient's Home County should belong within ePatient.08 
         Patient's Home State. -->
    
    <sch:assert id="nemSch_consistency_ePatient.07_ePatient.08" role="[WARNING]" diagnostics="nemsisDiagnostic" test="starts-with(., ../nem:ePatient.08)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should belong within the <sch:value-of select="key('nemSch_key_elements', 'ePatient.08', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_ePatient.15" context="nem:ePatient.15[. != '']">

    <sch:let name="nemsisElements" value="., ../nem:ePatient.16"/>

    <sch:assert id="nemSch_consistency_ePatient.15_ePatient.16" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:ePatient.16 != ''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is recorded, <sch:value-of select="key('nemSch_key_elements', 'ePatient.16', $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_ePatient.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eScene.xml?><sch:pattern id="nemSch_consistency_eScene">

  <!-- This pattern validates consistency among elements in the eScene section. -->

  <sch:title>Elements in the eScene section are consistent.</sch:title>

  <sch:rule id="nemSch_consistency_eScene.07_mci" context="nem:eScene.07[. = '9923003']">

    <!-- This rule fires when eScene.07 Mass Casualty Incident is "Yes". -->

    <sch:let name="nemsisElements" value="(../nem:eScene.06[.!='2707001'], ., ../nem:eScene.08[.=''])"/>

    <!-- Assert that eScene.06 Number of Patients at Scene should be "Multiple". -->

    <sch:assert id="nemSch_consistency_eScene.07_mci_eScene.06" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eScene.06 = '2707001'">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "Yes", <sch:value-of select="key('nemSch_key_elements', 'eScene.06', $nemSch_elements)"/> should be "Multiple".
    </sch:assert>

    <!-- Assert that eScene.08 Triage Classification for MCI Patient should be recorded. -->

    <sch:assert id="nemSch_consistency_eScene.07_mci_eScene.08" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eScene.08 != ''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "Yes", <sch:value-of select="key('nemSch_key_elements', 'eScene.08', $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eScene.21" context="nem:eScene.21[. != '']">

    <sch:let name="nemsisElements" value="., ../nem:eScene.18"/>

    <!-- Assert that eScene.21 Incident County should belong within eScene.18 Incident State. -->

    <sch:assert id="nemSch_consistency_eScene.21_eScene.18" role="[WARNING]" diagnostics="nemsisDiagnostic" test="starts-with(., ../nem:eScene.18)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should belong within the <sch:value-of select="key('nemSch_key_elements', 'eScene.18', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eScene.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_eSituation.xml?><sch:pattern id="nemSch_consistency_eSituation">

  <!-- This pattern validates consistency within elements in eSituation. -->

  <sch:title>Elements in the eSituation section are consistent.</sch:title>

  <sch:rule id="nemSch_consistency_eSituation.09" context="nem:eSituation.09[. = '']">

    <!-- This rule fires when eSituation.09 Primary Symptom is empty. -->

    <sch:let name="nemsisElements" value="(., ../nem:eSituation.10)"/>

    <!-- Assert that there should be no non-empty instances of eSituation.10 Other Associated 
         Symptoms.  -->

    <sch:assert id="nemSch_consistency_eSituation.09_eSituation.10" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not(../nem:eSituation.10 != '')">
      When <sch:value-of select="key('nemSch_key_elements', 'eSituation.09', $nemSch_elements)"/> is empty, <sch:value-of select="key('nemSch_key_elements', 'eSituation.10', $nemSch_elements)"/> should not be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eSituation.11" context="nem:eSituation.11[. = '']">

    <!-- This rule fires when eSituation.11 Provider's Primary Impression is empty. -->

    <sch:let name="nemsisElements" value="(., ../nem:eSituation.12)"/>

    <!-- Assert that there should be no non-empty instances of eSituation.12 Provider's Secondary 
         Impressions.  -->

    <sch:assert id="nemSch_consistency_eSituation.11_eSituation.12" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not(../nem:eSituation.12 != '')">
      When <sch:value-of select="key('nemSch_key_elements', 'eSituation.11', $nemSch_elements)"/> is empty, <sch:value-of select="key('nemSch_key_elements', 'eSituation.12', $nemSch_elements)"/> should not be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eSituation_injury" context="nem:eSituation[some $element in (nem:eSituation.09, nem:eSituation.10, nem:eSituation.11, nem:eSituation.12) satisfies matches($element , '^(S|T(0\d|1[0-4]))')]">

    <!-- This rule fires when eSituation.09, 10, 11, or 12 (Symptoms or Impressions) contain an 
         ICD-10 code that indicates an injury. -->

    <sch:let name="nemsisElements" value="(nem:eSituation.09, nem:eSituation.10, nem:eSituation.11, nem:eSituation.12)[matches(., '^(S|T(0\d|1[0-4]))')], nem:eSituation.02"/>

    <!-- Assert that eSituation.02 Possible Injury should be "Yes".  -->

    <sch:assert id="nemSch_consistency_eSituation_injury_eSituation.02" role="[WARNING]" diagnostics="nemsisDiagnostic" test="nem:eSituation.02 = '9922005'">
      When a symptom or impression is injury-related, <sch:value-of select="key('nemSch_key_elements', 'eSituation.02', $nemSch_elements)"/> should be "Yes".
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_eSituation.xml?>
  <?DSDL_INCLUDE_START includes/pattern_consistency_group.xml?><sch:pattern id="nemSch_consistency_group">

  <!-- This pattern validates that certain elements are recorded in each medication administration, 
       procedure, or set of vital signs. The rules in this pattern fire when an 
       eMedications.MedicationGroup, eProcedures.ProcedureGroup, or eVitals.VitalGroup has a value 
       recorded in any element. The XSD requires at least one instance of each of those groups, 
       even if no medications were administered, no procedures were performed, or no vitals signs 
       were obtained. In those cases, software should generate an instance of the group with all 
       of its required elements empty. The rules in this pattern do not fire in those cases.
       This pattern also validates consistency among elements in medication, procedure, and vital 
       sign groups. -->

  <sch:title>Certain elements are recorded in each real medication administration, procedure, or set of vital signs.</sch:title>

  <sch:rule id="nemSch_consistency_eMedications.MedicationGroup" context="nem:eMedications.MedicationGroup[some $element in .//* satisfies normalize-space($element) != '']">

    <!-- Flag each of the following elements if it is empty. -->

    <sch:let name="eMedications.01" value="if(nem:eMedications.01 != '' or nem:eMedications.02 = '9923003' or nem:eMedications.03/@PN) then '' else key('nemSch_key_elements', 'eMedications.01', $nemSch_elements)"/>

    <sch:let name="eMedications.03" value="if(nem:eMedications.03 != '') then '' else key('nemSch_key_elements', 'eMedications.03', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(nem:eMedications.02, nem:eMedications.03, (nem:eMedications.01)[. = ''])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_consistency_eMedications.MedicationGroup_all" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eMedications.01 or $eMedications.03)">
      When a medication is administered, the following should be recorded:
      <sch:value-of select="string-join(($eMedications.01, $eMedications.03)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eProcedures.ProcedureGroup" context="nem:eProcedures.ProcedureGroup[some $element in .//* satisfies normalize-space($element) != '']">

    <!-- Flag each of the following elements if it is empty. -->

    <sch:let name="eProcedures.01" value="if(nem:eProcedures.01 != '' or nem:eProcedures.02 = '9923003' or nem:eProcedures.03/@PN) then '' else key('nemSch_key_elements', 'eProcedures.01', $nemSch_elements)"/>

    <sch:let name="eProcedures.03" value="if(nem:eProcedures.03 != '') then '' else key('nemSch_key_elements', 'eProcedures.03', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(nem:eProcedures.02, nem:eProcedures.03, (nem:eProcedures.01)[. = ''])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_consistency_eProcedures.ProcedureGroup_all" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eProcedures.01 or $eProcedures.03)">
      When a procedure is performed, the following should be recorded:
      <sch:value-of select="string-join(($eProcedures.01, $eProcedures.03)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eVitals.VitalGroup" context="nem:eVitals.VitalGroup[some $element in .//* satisfies normalize-space($element) != '']">

    <!-- Flag each of the following elements if it is empty. -->

    <sch:let name="eVitals.01" value="if(nem:eVitals.01 != '' or nem:eVitals.02 = '9923003') then '' else key('nemSch_key_elements', 'eVitals.01', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(nem:eVitals.02, (nem:eVitals.01)[. = ''])"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_consistency_eVitals.VitalGroup_all" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eVitals.01)">
      When a set of vital signs is obtained, the following should be recorded:
      <sch:value-of select="string-join(($eVitals.01)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_consistency_eMedications.DosageGroup" context="nem:eMedications.05[. != '']">

    <!-- This rule fires when eMedications.05 Medication Dosage is recorded. -->

    <sch:let name="nemsisElements" value="../*"/>

    <!-- Assert that eMedications.06 Medication Dosage Units should be recorded.  -->

    <sch:assert id="nemSch_consistency_eMedications.DosageGroup_eMedications.06" role="[ERROR]" diagnostics="nemsisDiagnostic" test="../nem:eMedications.06 != ''">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is recorded, <sch:value-of select="key('nemSch_key_elements', 'eMedications.06', $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_consistency_group.xml?>
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
  <?DSDL_INCLUDE_START includes/pattern_sequence_time.xml?><sch:pattern id="nemSch_sequence_time">

  <!-- This pattern validates the sequence of date/time elements. Each date/time element in a 
       record should have a value that is not too early or too late compared to certain other 
       elements in the record. -->

  <sch:title>The sequence of date/time elements is appropriate.</sch:title>

  <sch:rule id="nemSch_sequence_time_eTimes" context="nem:eTimes">

    <!-- Flag each of the following elements if it occurs too early in the sequence of date/times. -->

    <!-- eAirway.10: Date/Time Decision to Manage the Patient with an Invasive Airway should not 
                     occur prior to: 
                     Unit Notified by Dispatch Date/Time. -->

    <sch:let name="eAirway.10" value="if(not(../nem:eAirway/nem:eAirway.AirwayGroup/nem:eAirway.10)                                           or (every $element in (nem:eTimes.03)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(../nem:eAirway/nem:eAirway.AirwayGroup/nem:eAirway.10)))                                          then '' else key('nemSch_key_elements', 'eAirway.10', $nemSch_elements)"/>

    <!-- eAirway.11: Date/Time Invasive Airway Placement Attempts Abandoned should not occur prior 
                     to: 
                     Date/Time Decision to Manage the Patient with an Invasive Airway, 
                     Unit Notified by Dispatch Date/Time, 
                     Dispatch Acknowledged Date/Time, 
                     Arrived at Patient Date/Time. -->

    <sch:let name="eAirway.11" value="if(not(../nem:eAirway/nem:eAirway.AirwayGroup/nem:eAirway.11)                                           or (every $element in (../nem:eAirway/nem:eAirway.AirwayGroup/nem:eAirway.10, nem:eTimes.03, nem:eTimes.04, nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(../nem:eAirway/nem:eAirway.AirwayGroup/nem:eAirway.11)))                                           then '' else key('nemSch_key_elements', 'eAirway.11', $nemSch_elements)"/>

    <!-- eArrest.14: Date/Time of Cardiac Arrest: No "should not occur prior to" constraints. -->

    <!-- eArrest.15: Date/Time Resuscitation Discontinued: No "should not occur prior to" 
                     constraints. -->

    <!-- eArrest.19: Date/Time of Initial CPR: No "should not occur prior to" constraints. -->

    <!-- eOutcome.11: Date/Time of Hospital Admission should not occur prior to: 
                      Unit Notified by Dispatch Date/Time, 
                      Dispatch Acknowledged Date/Time, 
                      Unit En Route Date/Time, 
                      Unit Arrived on Scene Date/Time, 
                      Arrived at Patient Date/Time, 
                      Transfer of EMS Patient Care Date/Time, 
                      Unit Left Scene Date/Time, 
                      Arrival at Destination Landing Area Date/Time, 
                      Patient Arrived at Destination Date/Time, 
                      Destination Patient Transfer of Care Date/Time. -->

    <sch:let name="eOutcome.11" value="if(not(../nem:eOutcome/nem:eOutcome.11)                                           or (every $element in (nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.09, nem:eTimes.10, nem:eTimes.11, nem:eTimes.12)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(../nem:eOutcome/nem:eOutcome.11)))                                            then '' else key('nemSch_key_elements', 'eOutcome.11', $nemSch_elements)"/>

    <!-- eOutcome.16: Date/Time of Hospital Discharge should not occur prior to: 
                      Date/Time of Hospital Admission, 
                      Unit Notified by Dispatch Date/Time, 
                      Dispatch Acknowledged Date/Time, 
                      Unit En Route Date/Time, 
                      Unit Arrived on Scene Date/Time, 
                      Arrived at Patient Date/Time, 
                      Transfer of EMS Patient Care Date/Time, 
                      Unit Left Scene Date/Time, 
                      Arrival at Destination Landing Area Date/Time, 
                      Patient Arrived at Destination Date/Time, 
                      Destination Patient Transfer of Care Date/Time. -->

    <sch:let name="eOutcome.16" value="if(not(../nem:eOutcome/nem:eOutcome.16)                                           or (every $element in (../nem:eOutcome/nem:eOutcome.11, nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.09, nem:eTimes.10, nem:eTimes.11, nem:eTimes.12)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(../nem:eOutcome/nem:eOutcome.16)))                                            then '' else key('nemSch_key_elements', 'eOutcome.16', $nemSch_elements)"/>

    <!-- ePayment.03: Date Physician Certification Statement Signed: No "should not occur prior to" 
                      constraints. -->

    <!-- eScene.05: Date/Time Initial Responder Arrived on Scene: No "should not occur prior to" 
                    constraints. -->

    <!-- eSituation.01: Date/Time of Symptom Onset: No "should not occur prior to" constraints. -->

    <!-- eSituation.18: Date/Time Last Known Well: No "should not occur prior to" constraints. -->

    <!-- eTimes.01: PSAP Call Date/Time: No "should not occur prior to" constraints. -->

    <!-- eTimes.02: Dispatch Notified Date/Time should not occur prior to: 
                    PSAP Call Date/Time. -->

    <sch:let name="eTimes.02" value="if(not(nem:eTimes.02)                                          or (every $element in (nem:eTimes.01)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.02)))                                          then '' else key('nemSch_key_elements', 'eTimes.02', $nemSch_elements)"/>

    <!-- eTimes.03: Unit Notified by Dispatch Date/Time should not occur prior to: 
                    PSAP Call Date/Time, 
                    Dispatch Notified Date/Time. -->

    <sch:let name="eTimes.03" value="if(                                                               (every $element in (nem:eTimes.01, nem:eTimes.02)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.03)))                                          then '' else key('nemSch_key_elements', 'eTimes.03', $nemSch_elements)"/>

    <!-- eTimes.04: Dispatch Acknowledged Date/Time should not occur prior to: 
                    Unit Notified Date/Time. -->

    <sch:let name="eTimes.04" value="if(not(nem:eTimes.04)                                          or (every $element in (nem:eTimes.03)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.04)))                                          then '' else key('nemSch_key_elements', 'eTimes.04', $nemSch_elements)"/>

    <!-- eTimes.05: Unit En Route Date/Time should not occur prior to: 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time. -->

    <sch:let name="eTimes.05" value="if(nem:eTimes.05 = ''                                         or (every $element in (nem:eTimes.03, nem:eTimes.04)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.05)))                                          then '' else key('nemSch_key_elements', 'eTimes.05', $nemSch_elements)"/>

    <!-- eTimes.06: Unit Arrived on Scene Date/Time should not occur prior to: 
                    Date/Time Initial Responder Arrived on Scene, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time. -->

    <sch:let name="eTimes.06" value="if(nem:eTimes.06 = ''                                         or (every $element in (../nem:eScene/nem:eScene.05, nem:eTimes.03, nem:eTimes.04, nem:eTimes.05)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.06)))                                          then '' else key('nemSch_key_elements', 'eTimes.06', $nemSch_elements)"/>

    <!-- eTimes.07: Arrived at Patient Date/Time should not occur prior to: 
                    Date/Time Initial Responder Arrived on Scene, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time. 
                    (It may occur prior to Unit En Route Date/Time or Unit Arrived on Scene 
                    Date/Time in cases where a crew member arrived before the unit arrived.) -->

    <sch:let name="eTimes.07" value="if(nem:eTimes.07 = ''                                         or (every $element in (../nem:eScene/nem:eScene.05, nem:eTimes.03, nem:eTimes.04)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.07)))                                         then '' else key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>

    <!-- eTimes.08: Transfer of EMS Patient Care Date/Time should not occur prior to: 
                    Date/Time Decision to Manage the Patient with an Invasive Airway, 
                    Date/Time Invasive Airway Placement Attempts Abandoned, 
                    Date/Time of Cardiac Arrest, 
                    Date/Time Resuscitation Discontinued, 
                    Date/Time of Initial CPR, 
                    Last Oral Intake, 
                    Date/Time of ACN Incident, 
                    Date/Time Initial Responder Arrived on Scene, 
                    Date/Time of Symptom Onset, 
                    Date/Time Last Known Well, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time. -->

    <sch:let name="eTimes.08" value="if(not(nem:eTimes.08) or nem:eTimes.08 = ''                                         or (every $element in (../nem:eAirway/nem:eAirway.AirwayGroup/(nem:eAirway.10, nem:eAirway.11), ../nem:eArrest/(nem:eArrest.14, nem:eArrest.15, nem:eArrest.19), ../nem:eHistory/nem:eHistory.19, ../nem:eInjury/nem:eInjury.CollisionGroup/nem:eInjury.14, ../nem:eScene/nem:eScene.05, ../nem:eSituation/(nem:eSituation.01, nem:eSituation.18), nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.08)))                                          then '' else key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/>

    <!-- eTimes.09: Unit Left Scene Date/Time should not occur prior to: 
                    Date/Time Initial Responder Arrived on Scene, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time. 
                    (It may occur prior to Transfer of EMS Patient Care Date/Time if the unit 
                    transported the patient to a rendezvous point prior to transferring care.) -->

    <sch:let name="eTimes.09" value="if(nem:eTimes.09 = ''                                         or (every $element in (../nem:eScene/nem:eScene.05, nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.09)))                                         then '' else key('nemSch_key_elements', 'eTimes.09', $nemSch_elements)"/>

    <!-- eTimes.10: Arrival at Destination Landing Area Date/Time should not occur prior to: 
                    Date/Time Initial Responder Arrived on Scene, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time, 
                    Unit Left Scene Date/Time. -->

    <sch:let name="eTimes.10" value="if(not(nem:eTimes.10)                                         or (every $element in (../nem:eScene/nem:eScene.05, nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.09)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.10)))                                         then '' else key('nemSch_key_elements', 'eTimes.10', $nemSch_elements)"/>

    <!-- eTimes.11: Patient Arrived at Destination Date/Time should not occur prior to: 
                    Date/Time Initial Responder Arrived on Scene, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time, 
                    Unit Left Scene Date/Time, 
                    Arrival at Destination Landing Area Date/Time. -->

    <sch:let name="eTimes.11" value="if(nem:eTimes.11 = ''                                         or (every $element in (../nem:eScene/nem:eScene.05, nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.09, nem:eTimes.10)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.11)))                                         then '' else key('nemSch_key_elements', 'eTimes.11', $nemSch_elements)"/>

    <!-- eTimes.12: Destination Patient Transfer of Care Date/Time should not occur prior to: 
                    Date/Time Decision to Manage the Patient with an Invasive Airway, 
                    Date/Time Invasive Airway Placement Attempts Abandoned, 
                    Date/Time of Cardiac Arrest, 
                    Date/Time Resuscitation Discontinued, 
                    Date/Time of Initial CPR, 
                    Last Oral Intake, 
                    Date/Time of ACN Incident, 
                    Date/Time Initial Responder Arrived on Scene, 
                    Date/Time of Symptom Onset, 
                    Date/Time Last Known Well, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time, 
                    Unit Left Scene Date/Time, 
                    Arrival at Destination Landing Area Date/Time. -->

    <sch:let name="eTimes.12" value="if(nem:eTimes.12 = ''                                         or (every $element in (../nem:eAirway/nem:eAirway.AirwayGroup/(nem:eAirway.10, nem:eAirway.11), ../nem:eArrest/(nem:eArrest.14, nem:eArrest.15, nem:eArrest.19), ../nem:eHistory/nem:eHistory.19, ../nem:eInjury/nem:eInjury.CollisionGroup/nem:eInjury.14, ../nem:eScene/nem:eScene.05, ../nem:eSituation/(nem:eSituation.01, nem:eSituation.18), nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.09, nem:eTimes.10, nem:eTimes.11)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.12)))                                         then '' else key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>

    <!-- eTimes.13: Unit Back in Service Date/Time should not occur prior to: 
                    Date/Time Decision to Manage the Patient with an Invasive Airway, 
                    Date/Time Invasive Airway Placement Attempts Abandoned, 
                    Date/Time of Cardiac Arrest, 
                    Date/Time Resuscitation Discontinued, 
                    Date/Time of Initial CPR, 
                    Last Oral Intake, 
                    Date/Time of ACN Incident, 
                    Date/Time Initial Responder Arrived on Scene, 
                    Date/Time of Symptom Onset, 
                    Date/Time Last Known Well, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time, 
                    Unit Left Scene Date/Time, 
                    Arrival at Destination Landing Area Date/Time, 
                    Transfer of EMS Patient Care Date/Time, 
                    Destination Patient Transfer of Care Date/Time, 
                    Unit Canceled Date/Time. -->

    <sch:let name="eTimes.13" value="if(                                         (every $element in (../nem:eAirway/nem:eAirway.AirwayGroup/(nem:eAirway.10, nem:eAirway.11), ../nem:eArrest/(nem:eArrest.14, nem:eArrest.15, nem:eArrest.19), ../nem:eHistory/nem:eHistory.19, ../nem:eInjury/nem:eInjury.CollisionGroup/nem:eInjury.14, ../nem:eScene/nem:eScene.05, ../nem:eSituation/(nem:eSituation.01, nem:eSituation.18), nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.09, nem:eTimes.10, nem:eTimes.11, nem:eTimes.12, nem:eTimes.14)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.13)))                                          then '' else key('nemSch_key_elements', 'eTimes.13', $nemSch_elements)"/>

    <!-- eTimes.14: Unit Canceled Date/Time should not occur prior to: Unit Notified Date/Time. -->

    <sch:let name="eTimes.14" value="if(not(nem:eTimes.14)                                         or (every $element in (nem:eTimes.03)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.14)))                                         then '' else key('nemSch_key_elements', 'eTimes.14', $nemSch_elements)"/>

    <!-- eTimes.15: Unit Back at Home Location Date/Time should not occur prior to: 
                    Date/Time Decision to Manage the Patient with an Invasive Airway, 
                    Date/Time Invasive Airway Placement Attempts Abandoned, 
                    Date/Time of Cardiac Arrest, 
                    Date/Time Resuscitation Discontinued, 
                    Date/Time of Initial CPR, 
                    Last Oral Intake, 
                    Date/Time of ACN Incident, 
                    Date/Time Initial Responder Arrived on Scene, 
                    Date/Time of Symptom Onset, 
                    Date/Time Last Known Well, 
                    Unit Notified by Dispatch Date/Time, 
                    Dispatch Acknowledged Date/Time, 
                    Unit En Route Date/Time, 
                    Unit Arrived on Scene Date/Time, 
                    Arrived at Patient Date/Time, 
                    Unit Left Scene Date/Time, 
                    Arrival at Destination Landing Area Date/Time, 
                    Transfer of EMS Patient Care Date/Time, 
                    Destination Patient Transfer of Care Date/Time, 
                    Unit Canceled Date/Time. -->

    <sch:let name="eTimes.15" value="if(not(nem:eTimes.15)                                         or (every $element in (../nem:eAirway/nem:eAirway.AirwayGroup/(nem:eAirway.10, nem:eAirway.11), ../nem:eArrest/(nem:eArrest.14, nem:eArrest.15, nem:eArrest.19), ../nem:eHistory/nem:eHistory.19, ../nem:eInjury/nem:eInjury.CollisionGroup/nem:eInjury.14, ../nem:eScene/nem:eScene.05, ../nem:eSituation/(nem:eSituation.01, nem:eSituation.18), nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.09, nem:eTimes.10, nem:eTimes.11, nem:eTimes.12, nem:eTimes.14)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.15)))                                         then '' else key('nemSch_key_elements', 'eTimes.15', $nemSch_elements)"/>

    <!-- eTimes.16: EMS Call Completed Date/Time should not occur prior to: 
                    Unit Back in Service Date/Time. -->

    <sch:let name="eTimes.16" value="if(not(nem:eTimes.16)                                         or (every $element in (nem:eTimes.13)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(nem:eTimes.16)))                                         then '' else key('nemSch_key_elements', 'eTimes.16', $nemSch_elements)"/>

    <sch:let name="nemsisElements" value="(../nem:eAirway/nem:eAirway.AirwayGroup/(nem:eAirway.10, nem:eAirway.11), ../nem:eArrest/(nem:eArrest.14, nem:eArrest.15, nem:eArrest.19), ../nem:eHistory/nem:eHistory.19, ../nem:eInjury/nem:eInjury.CollisionGroup/nem:eInjury.14, ../nem:eOutcome/nem:eOutcome.11, ../nem:eOutcome/nem:eOutcome.16, ../nem:eScene/nem:eScene.05, ../nem:eSituation/(nem:eSituation.01, nem:eSituation.18), *)[. != '']"/>

    <!-- eTimes.13: Unit Back in Service Date/Time should not occur after the current date/time. A 
                    window of up to one hour is allowed in case client and server clocks might be 
                    slightly off from each other.. -->

    <sch:let name="eTimes.13_current" value="if(                                         xs:dateTime(nem:eTimes.13) &lt; current-dateTime() + xs:dayTimeDuration('PT1H'))                                         then '' else concat(key('nemSch_key_elements', 'eTimes.13', $nemSch_elements), ' (and possibly other Date/Times)')"/>

    <!-- eTimes.15: Unit Back at Home Location Date/Time should not occur after the current 
                    date/time. A window of up to one hour is allowed in case client and server 
                    clocks might be slightly off from each other.. -->

    <sch:let name="eTimes.15_current" value="if(not(nem:eTimes.15)                                         or xs:dateTime(nem:eTimes.15) &lt; current-dateTime() + xs:dayTimeDuration('PT1H'))                                         then '' else key('nemSch_key_elements', 'eTimes.15', $nemSch_elements)"/>

    <!-- eTimes.16: EMS Call Completed Date/Time should not occur after the current date/time. A 
                    window of up to one hour is allowed in case client and server clocks might be 
                    slightly off from each other.. -->

    <sch:let name="eTimes.16_current" value="if(not(nem:eTimes.16)                                         or xs:dateTime(nem:eTimes.16) &lt; current-dateTime() + xs:dayTimeDuration('PT1H'))                                         then '' else key('nemSch_key_elements', 'eTimes.16', $nemSch_elements)"/>

    <!-- Assert that none of the elements above should be flagged. If the assert fails, list the 
         flagged elements.  -->

    <sch:assert id="nemSch_sequence_time_eTimes_order" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eAirway.10 or $eAirway.11 or $eOutcome.11 or $eOutcome.16 or $eTimes.02 or $eTimes.03 or $eTimes.04 or $eTimes.05 or $eTimes.06 or $eTimes.07 or $eTimes.08 or $eTimes.09 or $eTimes.10 or $eTimes.11 or $eTimes.12 or $eTimes.13 or $eTimes.14 or $eTimes.15 or $eTimes.16)">
      Date/Times should be in order. The following times are too early:
      <sch:value-of select="string-join(($eAirway.10, $eAirway.11, $eOutcome.11, $eOutcome.16, $eTimes.02, $eTimes.03, $eTimes.04, $eTimes.05, $eTimes.06, $eTimes.07, $eTimes.08, $eTimes.09, $eTimes.10, $eTimes.11, $eTimes.12, $eTimes.13, $eTimes.14, $eTimes.15, $eTimes.16)[. != ''], ', ')"/>
    </sch:assert>

    <!-- Assert that none of the "_current" elements above should be flagged. If the assert fails, 
         list the flagged elements.  -->

    <sch:assert id="nemSch_sequence_time_eTimes_current" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eTimes.13_current or $eTimes.15_current or $eTimes.16_current)">
      Date/Times should not be in the future (the current time according to this system is <sch:value-of select="format-dateTime(current-dateTime(),'[MNn] [D1], [Y0001], [H01]:[m01] [ZN]')"/>). The following times are too late:
      <sch:value-of select="string-join(($eTimes.13_current, $eTimes.15_current, $eTimes.16_current)[. != ''], ', ')"/>
    </sch:assert>

  </sch:rule>

  <!-- eAirway.02: Date/Time Airway Device Placement Confirmation: No sequence constraints. -->

  <sch:rule id="nemSch_sequence_time_eDevice.02" context="nem:eDevice.02[. != '']">

    <sch:let name="nemsisElements" value="(., ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eDevice.02: Date/Time of Event (per Medical Device) should not occur prior to: 
                     Date/Time Initial Responder Arrived on Scene, 
                     Unit Notified by Dispatch Date/Time, 
                     Dispatch Acknowledged Date/Time, 
                     Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eDevice.02_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eDevice.02: Date/Time of Event (per Medical Device) should not occur after: 
                     Transfer of EMS Patient Care Date/Time, 
                     Destination Patient Transfer of Care Date/Time, 
                     Unit Back in Service Date/Time, 
                     Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eDevice.02_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_sequence_time_eDisposition.25" context="nem:eDisposition.25[. != '']">

    <sch:let name="nemsisElements" value="(., ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eDisposition.25: Date/Time of Destination Prearrival Alert or Activation should not occur 
                          prior to: 
                          Unit Notified by Dispatch Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eDisposition.25_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03)[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.03', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eDisposition.25: Date/Time of Destination Prearrival Alert or Activation should not occur 
                          after: 
                          Destination Patient Transfer of Care Date/Time, 
                          Unit Back in Service Date/Time, 
                          Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eDisposition.25_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>, <sch:value-of select="key('nemSch_key_elements', 'eTimes.13', $nemSch_elements)"/>, or <sch:value-of select="key('nemSch_key_elements', 'eTimes.15', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_sequence_time_eExam.03" context="nem:eExam.03[. != '']">

    <sch:let name="nemsisElements" value="(., ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eExam.03: Date/Time of Assessment should not occur prior to: 
                   Date/Time Initial Responder Arrived on Scene, 
                   Unit Notified by Dispatch Date/Time, 
                   Dispatch Acknowledged Date/Time, 
                   Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eExam.03_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eExam.03: Date/Time of Assessment should not occur after: 
                   Transfer of EMS Patient Care Date/Time, 
                   Destination Patient Transfer of Care Date/Time, 
                   Unit Back in Service Date/Time, 
                   Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eExam.03_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.)">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_sequence_time_eLabs.01" context="nem:eLabs.01[. != '']">

    <sch:let name="eLabs.01_prior" value="if(../nem:eLabs.02 != '9923003' or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))) then false() else true()"/>

    <sch:let name="nemsisElements" value="(., ../nem:eLabs.02, ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eLabs.01: When eLabs.02 Study/Result Prior to this Unit's EMS Care is not "Yes", 
                   Date/Time of Laboratory or Imaging Result should not occur prior to: 
                   Unit Notified by Dispatch Date/Time, 
                   Dispatch Acknowledged Date/Time, 
                   Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eLabs.01_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eLabs.02 = '9923003' or (every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>, unless <sch:value-of select="key('nemSch_key_elements', 'eLabs.02', $nemSch_elements)"/> is "Yes".
    </sch:assert>

    <!-- eLabs.01: When eLabs.02 Study/Result Prior to this Unit's EMS Care is "Yes", Date/Time 
                   of Laboratory or Imaging Result should not occur after: 
                   Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eLabs.01_prior_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eLabs.01_prior)">
      When <sch:value-of select="key('nemSch_key_elements', 'eLabs.02', $nemSch_elements)"/> is "Yes," <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eLabs.01: Unless the previous assertion failed, Date/Time of Laboratory or Imaging Result 
                   should not occur after: 
                   Transfer of EMS Patient Care Date/Time, 
                   Destination Patient Transfer of Care Date/Time, 
                   Unit Back in Service Date/Time, 
                   Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eLabs.01_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="$eLabs.01_prior or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_sequence_time_eMedications.01" context="nem:eMedications.01[. != '']">

    <sch:let name="eMedications.01_prior" value="if(../nem:eMedications.02 != '9923003' or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))) then false() else true()"/>

    <sch:let name="nemsisElements" value="(., ../nem:eMedications.02, ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eMedications.01: Unless eMedications.02 Medication Administered Prior to this Unit's EMS 
                          Care is "Yes", Date/Time Medication Administered should not occur prior 
                          to: 
                          Date/Time Initial Responder Arrived on Scene, 
                          Unit Notified by Dispatch Date/Time, 
                          Dispatch Acknowledged Date/Time, 
                          Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eMedications.01_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eMedications.02 = '9923003' or (every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>, unless <sch:value-of select="key('nemSch_key_elements', 'eMedications.02', $nemSch_elements)"/> is "Yes".
    </sch:assert>

    <!-- eMedications.01: When eMedications.02 Medication Administered Prior to this Unit's EMS 
                          Care is "Yes", Date/Time Medication Administered should not occur after: 
                          Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eMedications.01_prior_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eMedications.01_prior)">
      When <sch:value-of select="key('nemSch_key_elements', 'eMedications.02', $nemSch_elements)"/> is "Yes," <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eMedications.01: Unless the previous assertion failed, Date/Time Medication Administered 
                          should not occur after: 
                          Transfer of EMS Patient Care Date/Time, 
                          Destination Patient Transfer of Care Date/Time, 
                          Unit Back in Service Date/Time, 
                          Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eMedications.01_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="$eMedications.01_prior or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <!-- eOther.19: Date/Time of Signature: No sequence constraints. -->

  <sch:rule id="nemSch_sequence_time_eProcedures.01" context="nem:eProcedures.01[. != '']">

    <sch:let name="eProcedures.01_prior" value="if(../nem:eProcedures.02 != '9923003' or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))) then false() else true()"/>

    <sch:let name="nemsisElements" value="(., ../nem:eProcedures.02, ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15))[. != '']"/>

    <!-- eProcedures.01: Unless eProcedures.02 Procedure Performed Prior to this Unit's EMS Care 
                         is "Yes", Date/Time Procedure Performed should not occur prior to: 
                         Date/Time Initial Responder Arrived on Scene, 
                         Unit Notified by Dispatch Date/Time, 
                         Dispatch Acknowledged Date/Time, 
                         Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eProcedures.01_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eProcedures.02 = '9923003' or (every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eScene.05', $nemSch_elements)"/>, unless <sch:value-of select="key('nemSch_key_elements', 'eProcedures.02', $nemSch_elements)"/> is "Yes".
    </sch:assert>

    <!-- eProcedures.01: When eProcedures.02 Procedure Performed Prior to this Unit's EMS Care is 
                         "Yes", Date/Time Procedure Performed should not occur after: 
                         Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eProcedures.01_prior_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eProcedures.01_prior)">
      When <sch:value-of select="key('nemSch_key_elements', 'eProcedures.02', $nemSch_elements)"/> is "Yes," <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eProcedures.01: Unless the previous assertion failed, Date/Time Procedure Performed 
                         should not occur after: 
                         Transfer of EMS Patient Care Date/Time, 
                         Destination Patient Transfer of Care Date/Time, 
                         Unit Back in Service Date/Time, 
                         Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eProcedures.01_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="$eProcedures.01_prior or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_sequence_time_eVitals.01" context="nem:eVitals.01[. != '']">

    <sch:let name="eVitals.01_prior" value="if(../nem:eVitals.02 != '9923003' or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.07)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))) then false() else true()"/>

    <sch:let name="nemsisElements" value="(., ../nem:eVitals.02, ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.05, nem:eTimes.06, nem:eTimes.07, nem:eTimes.08, nem:eTimes.12, nem:eTimes.13))[. != '']"/>

    <!-- eVitals.01: Unless eVitals.02 Obtained Prior to this Unit's EMS Care is "Yes", Date/Time 
                     Vital Signs Taken should not occur prior to: 
                     Date/Time Initial Responder Arrived on Scene, 
                     Unit Notified by Dispatch Date/Time, 
                     Dispatch Acknowledged Date/Time, 
                     Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eVitals.01_after" role="[WARNING]" diagnostics="nemsisDiagnostic" test="../nem:eVitals.02 = '9923003' or (every $element in (ancestor::nem:PatientCareReport/nem:eScene/nem:eScene.05, ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.03, nem:eTimes.04, nem:eTimes.07))[. != ''] satisfies xs:dateTime($element) &lt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no earlier than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>, unless <sch:value-of select="key('nemSch_key_elements', 'eVitals.02', $nemSch_elements)"/> is "Yes".
    </sch:assert>

    <!-- eVitals.01: When eVitals.02 Obtained Prior to this Unit's EMS Care is "Yes", Date/Time 
                     Vital Signs Taken should not occur after: 
                     Arrived at Patient Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eVitals.01_prior_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="not($eVitals.01_prior)">
      When <sch:value-of select="key('nemSch_key_elements', 'eVitals.02', $nemSch_elements)"/> is "Yes," <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.07', $nemSch_elements)"/>.
    </sch:assert>

    <!-- eVitals.01: Unless the previous assertion failed, Date/Time Vital Signs Taken should not 
                     occur after: 
                     Transfer of EMS Patient Care Date/Time, 
                     Destination Patient Transfer of Care Date/Time, 
                     Unit Back in Service Date/Time, 
                     Unit Back at Home Location Date/Time. -->

    <sch:assert id="nemSch_sequence_time_eVitals.01_before" role="[WARNING]" diagnostics="nemsisDiagnostic" test="$eVitals.01_prior or (every $element in ancestor::nem:PatientCareReport/nem:eTimes/(nem:eTimes.08, nem:eTimes.12, nem:eTimes.13, nem:eTimes.15)[. != ''] satisfies xs:dateTime($element) &gt;= xs:dateTime(.))">
      <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be no later than <sch:value-of select="key('nemSch_key_elements', 'eTimes.08', $nemSch_elements)"/> or <sch:value-of select="key('nemSch_key_elements', 'eTimes.12', $nemSch_elements)"/>.
    </sch:assert>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_sequence_time.xml?>
  <?DSDL_INCLUDE_START includes/pattern_uniqueness_EMSDataSet.xml?><sch:pattern id="nemSch_uniqueness_EMSDataSet">

  <!-- This pattern validates that values for certain recurring Patient Care Report elements are 
       unique within a list.  -->

  <sch:title>Certain recurring patient care report data elements are unique within a list.</sch:title>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_abstract" abstract="true">

    <sch:let name="nemsisElements" value="../*[local-name() = local-name(current())]"/>

    <!-- Assert that "None" should be the only value recorded for the element.  -->

    <sch:assert id="nemSch_uniqueness_EMSDataSet_none" role="[WARNING]" diagnostics="nemsisDiagnostic" test="count(../*[local-name() = local-name(current())]) = 1">
      When <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> is "<sch:value-of select="$none_label"/>", no other <sch:value-of select="key('nemSch_key_elements', local-name(), $nemSch_elements)"/> should be recorded.
    </sch:assert>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eArrest.04" context="nem:eArrest.04[. = '3004001']">

    <!-- This rule fires when there is an instance of eArrest.04 Arrest Witnessed By set to "Not 
         Witnessed". -->

    <sch:let name="none_label" value="'Not Witnessed'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eArrest.12" context="nem:eArrest.12[. = '3012001']">

    <!-- This rule fires when there is an instance of eArrest.12 Any Return of Spontaneous 
         Circulation set to "No". -->

    <sch:let name="none_label" value="'No'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eHistory.01" context="nem:eHistory.01[. = '3101009']">

    <!-- This rule fires when there is an instance of eHistory.01 Barriers to Patient Care set to 
         "None Noted". -->

    <sch:let name="none_label" value="'None Noted'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eMedications.08" context="nem:eMedications.08[. = '3708031']">

    <!-- This rule fires when there is an instance of eMedications.08 Medication Complication set 
         to "None". -->

    <sch:let name="none_label" value="'None'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eProcedures.07" context="nem:eProcedures.07[. = '3907033']">

    <!-- This rule fires when there is an instance of eProcedures.07 Procedure Complication set to 
         "None". -->

    <sch:let name="none_label" value="'None'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eResponse.08" context="nem:eResponse.08[. = '2208013']">

    <!-- This rule fires when there is an instance of eResponse.08 Type of Dispatch Delay set to 
         "None/No Delay". -->

    <sch:let name="none_label" value="'None/No Delay'"/>
    
    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eResponse.09" context="nem:eResponse.09[. = '2209011']">

    <!-- This rule fires when there is an instance of eResponse.09 Type of Response Delay set to 
         "None/No Delay". -->

    <sch:let name="none_label" value="'None/No Delay'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eResponse.10" context="nem:eResponse.10[. = '2210017']">

    <!-- This rule fires when there is an instance of eResponse.10 Type of Scene Delay set to 
         "None/No Delay". -->

    <sch:let name="none_label" value="'None/No Delay'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eResponse.11" context="nem:eResponse.11[. = '2211011']">

    <!-- This rule fires when there is an instance of eResponse.11 Type of Transport Delay set to 
         "None/No Delay". -->

    <sch:let name="none_label" value="'None/No Delay'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eResponse.12" context="nem:eResponse.12[. = '2212015']">

    <!-- This rule fires when there is an instance of eResponse.12 Type of Turn-Around Delay set to 
         "None/No Delay". -->

    <sch:let name="none_label" value="'None/No Delay'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

  <sch:rule id="nemSch_uniqueness_EMSDataSet_eVitals.22" context="nem:eVitals.22[. = '3322003']">

    <!-- This rule fires when there is an instance of eVitals.22 Glasgow Coma Score-Qualifier set 
         to "Initial GCS has legitimate values without interventions such as intubation and 
         sedation". -->

    <sch:let name="none_label" value="'Initial GCS has legitimate values without interventions such as intubation and sedation'"/>

    <sch:extends rule="nemSch_uniqueness_EMSDataSet_abstract"/>

  </sch:rule>

</sch:pattern><?DSDL_INCLUDE_END includes/pattern_uniqueness_EMSDataSet.xml?>
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