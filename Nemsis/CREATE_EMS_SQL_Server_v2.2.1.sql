/*
Created		07/01/2005
Modified	07/05/2005
Project		EMS National Dataset (NEMSIS)
Author		WesBowden
Database	MS SQL 2000 

Description:

This SQL script was created by Wes Bowden for NEMSIS in order to
generate a basic transactional oriented database schema for MS SQL
that meets the minimum requirements for storing the EMS National
Dataset Data Elements included in the NEMSIS XSDs. This schema is
relational and built with constraints related to valid data values.
This script WILL NOT generate an application capable of collecting
the pre-hospital care ambulance run data although it certainly can
be used in conjunction with such an application; nor will this
script be able to import properly formatted XML files into the
schema. To parse XML into this schema you must use an associated
XSLT or parser application.

	Naming Convention
	 * Table Name = Element Group (eg E01)
	 * Sub Table Name Single Field One to Many Relationship = Column Name (eg E07_37)
	 * Sub Table Name Multiple Fields = Element Tag (eg E07_03_0)
	 * Column Name = Element Designation (eg E01_01)
	 * Constraint Name: Type_Field
		CMI = Constraint Minimum; CEN = Constraint Entry; CP = Constraint Property;
		CMM = Constraint Minumum Maximum Range
	Design
	 * Designed to support basic mapping of the XSDs into a Microsoft SQL database schema
	 * In general each E Code Section gets its own table
	 * Subtables of an E Code Section are created to support 0 to many relationships
	 * Subtables of an E Code Section are also create to support large optional data groupings
	 * Subtables of an E Code Section or Data Element requiring excesive 1 to many relationsihps
	   may be configured in second normal form to prevent excesive subtable creation
	 * Fields to support table relationships are added, due to the limited hierarchical
	   relationships and lack of dependence among data elements as strongly defined in the
	   in the XSDs; most tables link directly to the root record table.
	 * In accordance with best practices for tables; an arbitrary primary key is added to
	   those tables which have 0 to many relationships. However, they will likely have a
	   clustered index in relation to the foreign key rather than the primary key.

		Sample relationship design:

		|>>>>>>	OriginDemographicTable
		|	  -> ODT_ID (primary key)
		|	  -> ODT_Info (data)
		|
		|>>>>>>>>>>>	MainRecordTable
			|	  -> MRT_ID (primary key)
			|	  -> fk_ODT_ID (foreign key)
			|	  -> MRT_Info (data)
			|
			|>>>>>>>>>>>>>	SectionTableSingleInstance
			|		  -> pk_MRT_ID (primary key - clustered index)
			|		  -> STSI_Info (data)
			|
			|>>>>>>>>>>>>>	SectionTableMultipleInstance
			|		  -> STMI_ID (primary key)
			|		  -> fk_MRT_ID (foreign key - clustered index)
			|		  -> STMI_Info (data)
			|
			|>>>>>>>>>>>>>	SectionTableWithSubSection
				|	  -> STWSS_ID (primary key)
				|	  -> fk_MRT_ID (foreign key - clustered index)
				|	  -> STWSS_Info (data)
				|
				|>>>>>>>>>>>>	SubSectioTableSingleInstance
				|		  -> pk_STWSS_ID (primary key - clustered index)
				|		  -> SSTSI_Info (data)
				|
				|>>>>>>>>>>>>	SubSectioTableMultipleInstance
				|		  -> STWSS_ID (primary key)
				|		  -> fk_STWSS_ID (foreign key - clustered index)
				|		  -> SSTSI_Info (data)
				
*/


CREATE DATABASE NEMSIS
GO

USE NEMSIS

/* Service Demographics */
CREATE TABLE [NEMSIS].[dbo].[Header] ( 
	[pk_D01] int identity (1,1) NOT NULL ,
	[D01_01] varchar (15) NOT NULL ,
	[D01_03] varchar (3) NOT NULL ,
	[D01_04] varchar (5) NOT NULL ,
	[D01_07] varchar (100) NOT NULL ,
	[D01_08] int NOT NULL ,
	[D01_09] int NOT NULL ,
	[D01_21] varchar (10) NOT NULL,
	[D02_07] varchar (255) NOT NULL
	)
GO
/* Record Information */
CREATE TABLE [NEMSIS].[dbo].[E01] (
	[pk_E01_01] int identity (1,1) NOT NULL ,
	[fk_D01] int NOT NULL ,
	[E01_01]varchar (30) NOT NULL,
	[E01_02] varchar (30) NOT NULL ,
	[E01_03] varchar (30) NOT NULL ,
	[E01_04] varchar (30) NOT NULL )
GO

/* Unit Agency Information */
CREATE TABLE [NEMSIS].[dbo].[E02] (
	[pk_E01_01] int NOT NULL ,
	[E02_01] varchar (15) NOT NULL ,
 	[E02_02] varchar (15) NULL ,
  	[E02_03] varchar (15) NULL ,
	[E02_04] int NOT NULL ,
 	[E02_05] int NOT NULL ,
 	[E02_11] varchar (30) NULL ,
	[E02_12] varchar (15) NOT NULL ,
 	[E02_13] varchar (30) NULL ,
 	[E02_14] varchar (30) NULL ,
	[E02_15_Lat] decimal (4,2) NULL ,
 	[E02_15_Long] decimal (5,2) NULL ,
	[E02_16] decimal (6,1) NULL ,
	[E02_17] decimal (6,1) NULL ,
 	[E02_18] decimal (6,1) NULL ,
 	[E02_19] decimal (6,1) NULL ,
 	[E02_20] int NOT NULL 
)
GO


/*
Optional single table for delays E02_06 - E02_10. It wasn't
used because these data elements aren't self contained to a
tag, but are rather a grouping of like fields in a 0 to many
relationship with the parent record. Because it is a mandatory
field and will always populate a value it may be more efficient
transactionaly to seperate into seperate tables. If used please
remove tables E02_06 - E02_10 if they were generated.
*/

/* Dispatch Delays */
CREATE TABLE [NEMSIS].[dbo].[E02_06] (
	[pk_E02_06] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E02_06] int NOT NULL 
	
)
GO


/* Response Delays */
CREATE TABLE [NEMSIS].[dbo].[E02_07] ( 
	[pk_E02_07] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E02_07] int NOT NULL)
GO

/* Scene Delays */
CREATE TABLE [NEMSIS].[dbo].[E02_08] (
	[pk_E02_08] int identity(1,1), 
	[fk_E01_01] int NOT NULL ,
	[E02_08] int NOT NULL
	
)
GO


/* Transport Delays */
CREATE TABLE [NEMSIS].[dbo].[E02_09] ( 
	[pk_E02_09] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E02_09] int NOT NULL
	
)
GO


/* Turn Around Delays */
CREATE TABLE [NEMSIS].[dbo].[E02_10] ( 
	[pk_E02_10] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E02_10] int NOT NULL
	
)
GO


/* Unit Call */
CREATE TABLE [NEMSIS].[dbo].[E03] (
 	[pk_E01_01] int NOT NULL ,
	[E03_01] int NOT NULL ,
 	[E03_02] int NOT NULL ,
 	[E03_03] varchar (10) NULL)
GO

/* Unit Personnel */
CREATE TABLE [NEMSIS].[dbo].[E04] ( 
	[pk_E04] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E04_01] varchar (15) NULL ,
	[E04_02] int NULL ,
	[E04_03] int NULL 
)
GO
/* Times */
CREATE TABLE [NEMSIS].[dbo].[E05] (
	[pk_E01_01] int NOT NULL ,
	[E05_01] datetime NULL ,
	[E05_02] datetime NULL ,
	[E05_03] datetime NULL ,
	[E05_04] datetime NOT NULL ,
	[E05_05] datetime NULL ,
	[E05_06] datetime NULL ,
	[E05_07] datetime NULL ,
	[E05_08] datetime NULL ,
	[E05_09] datetime NULL ,
	[E05_10] datetime NULL ,
	[E05_11] datetime NOT NULL ,
	[E05_12] datetime NULL ,
	[E05_13] datetime NULL

)
GO

/* Patient */
CREATE TABLE [NEMSIS].[dbo].[E06] ( 
	[pk_E01_01] int NOT NULL ,
	[E06_01] varchar (20) NULL,
	[E06_02] varchar (20) NULL,
	[E06_03] varchar (20) NULL,
	[E06_04] varchar (30) NULL,
	[E06_05] varchar (30) NULL,
	[E06_06] varchar (5) NULL,
	[E06_07] varchar (3) NULL,
	[E06_08] varchar (10) NOT NULL,
	[E06_09] varchar (20) NULL,
	[E06_10] varchar (11) NULL,
	[E06_11] int NOT NULL,
	[E06_12] int NOT NULL,
	[E06_13] int NOT NULL,
	[E06_14] int NULL,
	[E06_15] int NOT NULL,
	[E06_16] datetime NULL,
	[E06_17] varchar (10) NULL,
	[E06_18] varchar (3) NULL ,
	[E06_19] varchar (30) NULL 

)
GO


/* Billing */
CREATE TABLE [NEMSIS].[dbo].[E07] (
	[pk_E01_01] int NOT NULL ,
	[E07_01] int NOT NULL ,
	[E07_02] int NULL ,
	[E07_15] int NULL ,
	[E07_16] int NULL ,
	[E07_17] int NULL ,
	[E07_32] varchar (10) NULL ,
	[E07_33] int NULL ,
	[E07_34] int NOT NULL)
GO


/* Insurance */
CREATE TABLE [NEMSIS].[dbo].[E07_03_0] ( 
	[pk_E07_03_0] int identity (1,1),
	[fk_E01_01] int NOT NULL ,
	[E07_03] varchar (30) NULL ,
	[E07_04] int NULL ,
	[E07_05] varchar (30) NULL ,
	[E07_06] varchar (30) NULL ,
	[E07_07] varchar (3) NULL ,
	[E07_08] varchar (10) NULL ,
	[E07_09] varchar (30) NULL ,	
	[E07_10] varchar (30) NULL ,
	[E07_11] varchar (20) NULL ,
	[E07_12] varchar (20) NULL ,
	[E07_13] varchar (20) NULL ,
	[E07_14] int NULL,
	[E07_18] varchar (20) NULL ,
	[E07_19] varchar (20) NULL ,	
	[E07_20] varchar (20) NULL ,
	[E07_21] varchar (30) NULL ,
	[E07_22] varchar (30) NULL ,
	[E07_23] varchar (3) NULL ,
	[E07_24] varchar (10) NULL ,
	[E07_25] varchar (10) NULL ,	
	[E07_26] int NULL,
	[E07_27] varchar (30) NULL ,
	[E07_28] varchar (30) NULL ,
	[E07_29] varchar (30) NULL ,
	[E07_30] varchar (3) NULL ,
	[E07_31] varchar (10) NULL )
GO

/* Condition Codes */
CREATE TABLE [NEMSIS].[dbo].[E07_35_0] ( 
	[pk_E07_35_0] int identity (1,1),
	[fk_E01_01] int NOT NULL ,
	[E07_35] varchar (30) NOT NULL ,
	[E07_36] varchar (30) NULL )
GO

/* CMS Air Ambulance Condition Code Modifier */
CREATE TABLE [NEMSIS].[dbo].[E07_37] ( 
	[pk_E07_37] int identity (1,1),
	[fk_E01_01] int NOT NULL ,
	[E07_37] int NOT NULL 
	
)
GO

/* Scene */
CREATE TABLE [NEMSIS].[dbo].[E08] ( 
	[pk_E01_01] int NOT NULL ,
	[E08_03] int NULL ,
	[E08_04] datetime NULL ,
	[E08_05] int NOT NULL ,
	[E08_06] int NOT NULL ,
	[E08_07] int NOT NULL ,
	[E08_08] varchar (30) NULL ,
	[E08_09] varchar (30) NULL ,
	[E08_10_Lat] decimal (4,2) NULL ,
	[E08_10_Long] decimal (5,2) NULL ,
	[E08_11] varchar (30) NULL ,
	[E08_12] varchar (30) NULL ,
	[E08_13] varchar (5) NULL ,
	[E08_14] varchar (3) NULL ,
	[E08_15] varchar (10) NOT NULL)
GO
/* Other EMS Agencies at the Scene */
CREATE TABLE [NEMSIS].[dbo].[E08_01] ( 
	[pk_E08_01] int identity (1,1),
	[fk_E01_01] int NOT NULL ,
	[E08_01] varchar (30) NOT NULL )
GO


/* Other Services at the Scene */
CREATE TABLE [NEMSIS].[dbo].[E08_02] ( 
	[pk_E08_02] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E08_02] int NOT NULL	
)
GO


/* Situation */
CREATE TABLE [NEMSIS].[dbo].[E09] (
	[pk_E01_01] int NOT NULL ,
	[E09_03] int NOT NULL ,
	[E09_04] int NOT NULL ,
	[E09_05] varchar (50) NULL ,
	[E09_06] int NULL ,
	[E09_07] int NULL ,
	[E09_08] varchar (50) NULL ,
	[E09_09] int NULL ,
	[E09_10] int NULL ,
	[E09_11] int NOT NULL ,
	[E09_12] int NOT NULL ,
	[E09_13] int NOT NULL ,
	[E09_15] int NOT NULL ,
	[E09_16] int NOT NULL
)
GO


/* Prior Aid */
CREATE TABLE [NEMSIS].[dbo].[E09_01] ( 
	[pk_E09_01] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E09_01] varchar (30) NOT NULL 
)
GO

/* Type of Individual Providing Prior Aid */
CREATE TABLE [NEMSIS].[dbo].[E09_02] (  
	[pk_E09_02] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E09_02] int NOT NULL 
	)
GO


/* Other Symptoms Identified */
CREATE TABLE [NEMSIS].[dbo].[E09_14] ( 
	[pk_E09_14] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E09_14] int NOT NULL 
	)
GO


/* Situation / Trauma */
CREATE TABLE [NEMSIS].[dbo].[E10] ( 
	[pk_E01_01] int NOT NULL ,
	[E10_01] int NOT NULL ,
	[E10_02] int NULL ,
	[E10_06] int NULL ,
	[E10_07] int NULL ,
	[E10_10] int NULL)
GO

/* The Mechanism of the Event Causing Injury */
CREATE TABLE [NEMSIS].[dbo].[E10_03] ( 
	[pk_E10_03] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E10_03] varchar (255) NOT NULL 
	)
GO


/* Type of Risk Factor Predictors located at the indident */
CREATE TABLE [NEMSIS].[dbo].[E10_04] ( 
	[pk_E10_04] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E10_04] int NOT NULL 
	)
GO


/* Location or area of impact on the vehicle */
CREATE TABLE [NEMSIS].[dbo].[E10_05] ( 
	[pk_E10_05] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E10_05] int NOT NULL)
GO

/* Safety Eqiupment in Use by Patient at Time of Injury */
CREATE TABLE [NEMSIS].[dbo].[E10_08] ( 
	[pk_E10_08] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E10_08] int NOT NULL 
	)
GO


/* Indication of Airbag Deployment */
CREATE TABLE [NEMSIS].[dbo].[E10_09] ( 
	[pk_E10_09] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E10_09] int NOT NULL 
	
)
GO


/* Situation CPR */
CREATE TABLE [NEMSIS].[dbo].[E11] (
 	[pk_E01_01] int NOT NULL ,
	[E11_01] int NOT NULL ,
	[E11_02] int NOT NULL ,	
	[E11_04] int NULL ,
	[E11_05] int NULL ,
	[E11_06] int NULL ,
	[E11_07] int NULL ,
	[E11_08] int NULL ,	
	[E11_09] datetime NULL ,	
	[E11_10] int NULL)
GO
/* Indication of attempt to resucitate cardiac arrest */
CREATE TABLE [NEMSIS].[dbo].[E11_03] ( 
	[pk_E11_03] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E11_03] varchar (255) NOT NULL 
	
)
GO


/* Patient's cardiac rhythm at delivery or transfer */
CREATE TABLE [NEMSIS].[dbo].[E11_11] ( 
	[pk_E11_11] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E11_11] varchar (255) NULL 
	
)
GO


/* Medical History */
CREATE TABLE [NEMSIS].[dbo].[E12] (
	[pk_E01_01] int NOT NULL ,
	[E12_02] varchar (30) NULL ,
	[E12_03] varchar (30) NULL ,
	[E12_04] varchar (20) NULL ,
	[E12_05] varchar (20) NULL,
	[E12_06] varchar (20) NULL , 
	[E12_11] int NULL ,
	[E12_18] int NULL ,
	[E12_20] int NULL)
GO

/* Patient specific barriers at scene */
CREATE TABLE [NEMSIS].[dbo].[E12_01] ( 
	[pk_E12_01] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_01] int NOT NULL 
	
)
GO



/* Presence of a valid living will doc or eol treatment document */
CREATE TABLE [NEMSIS].[dbo].[E12_07] (
	[pk_E12_07] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_07] int NOT NULL 
	
)
GO


/* Medication Allergies */
CREATE TABLE [NEMSIS].[dbo].[E12_08] ( 
	[pk_E12_08] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_08] varchar (30) NOT NULL 

)
GO


/* Food and Environmental Allergies */
CREATE TABLE [NEMSIS].[dbo].[E12_09] ( 
	[pk_E12_09] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_09] int NOT NULL 
	
)
GO

/* Pre-existing medical and surgery history */
CREATE TABLE [NEMSIS].[dbo].[E12_10] ( 
	[pk_E12_10] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_10] varchar (30) NOT NULL 

)
GO


/* Details of Immunization */
CREATE TABLE [NEMSIS].[dbo].[E12_12_0] ( 
	[pk_E12_0] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_12] int NOT NULL ,
	[E12_13] int NULL)
GO

/* Current Medication */
CREATE TABLE [NEMSIS].[dbo].[E12_14_0] ( 
	[pk_E12_14_0] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_14] varchar (30) NOT NULL ,
	[E12_15] decimal (8,2) NULL ,
	[E12_16] int NULL ,
	[E12_17] int NULL)
GO

/* Indicators for the potential use of A&D by patient */
CREATE TABLE [NEMSIS].[dbo].[E12_19] ( 
	[pk_E12_19] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E12_19] int NOT NULL 
	
)
GO


/* Narrative */
CREATE TABLE [NEMSIS].[dbo].[E13] (
	[pk_E01_01] int NOT NULL ,
	[E13_01] varchar (4000) NOT NULL)
GO

/* Assessment / Vital Signs */
CREATE TABLE [NEMSIS].[dbo].[E14] (
	[pk_E14] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E14_01] datetime NULL ,
	[E14_02] int NULL ,
	[E14_04] int NULL ,
	[E14_05] int NULL ,
	[E14_06] int NULL ,
	[E14_07] int NULL ,
	[E14_08] int NULL ,
	[E14_09] int NULL ,
	[E14_10] int NULL ,
	[E14_11] int NULL ,
	[E14_12] int NULL ,
	[E14_13] int NULL ,
	[E14_14] int NULL ,
	[E14_15] int NULL ,
	[E14_16] int NULL ,
	[E14_17] int NULL ,
	[E14_18] int NULL ,
	[E14_19] int NULL ,
	[E14_20] decimal (4,2) NULL ,
	[E14_21] int NULL ,
	[E14_22] int NULL ,
	[E14_23] int NULL ,
	[E14_24] int NULL ,
	[E14_25] int NULL ,
	[E14_26] int NULL ,
	[E14_27] int NULL ,
	[E14_28] int NULL 

)
GO



/*
It is not explicitely defined in the XDSs that the cardiac rhythm
be associated with the data time stamp of the vitals. If this should
be the case the foreign key needs to be changed to the E14 table
instead of the base record table E01.
*/

/* Initial Cardiac Rhythm */
CREATE TABLE [NEMSIS].[dbo].[E14_03] ( 
	[pk_E14_03] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E14_03] varchar (255) NOT NULL 
	
)
GO
/*
Section E15 has special table requirements and is configured
in the second normal form. By configuring this table in second
normal form it breaks the table naming convention outlined above.
The Data Element (DE) Attribute (Column/Field) Name will be listed
in the E15_DE column as a value. The E15_DE_VALUE holds the value
for the identified Data Element.
*/

/* Assessment Injury */
CREATE TABLE [NEMSIS].[dbo].[E15] ( 
	[pk_E15] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E15_DE] char (6) NOT NULL,
	[E15_DE_VALUE] int NOT NULL

)
GO

/* Assessment Exam */
CREATE TABLE [NEMSIS].[dbo].[E16] (
	[pk_E01_01] int NOT NULL ,
	[E16_01] decimal (4,1) NULL ,
	[E16_02] int NULL)
GO

/*
Section E16 has special table requirements and is configured
in the second normal form. By configuring this table in second
normal form it breaks the table naming convention outlined above.
The Data Element Attribute (Column/Field) Name will be listed in
the E15_DE column as a value. The E15_DE_VALUE holds the value
for the identified Data Element. Technically the E16_03 is
independent of the other values according to the XSD, but it has
been interpreted here as being related to all the other data
elements in the tag as a set.
*/

/* Different Asssessments */
CREATE TABLE [NEMSIS].[dbo].[E16_00_0] ( 
	[pk_E16_00_0] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E16_03] datetime NULL ,
	[E16_DE] char (6) NOT NULL,
	[E16_DE_VALUE] int NOT NULL

)
GO

/* Intervention (Protocol driving clinical care) */
CREATE TABLE [NEMSIS].[dbo].[E17] ( 
	[pk_E17] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E17_01] varchar (100) NOT NULL )
GO
/* Intervention Medications */
CREATE TABLE [NEMSIS].[dbo].[E18] (
	[pk_E18] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E18_01] datetime NULL ,
	[E18_02] int NULL ,
	[E18_03] varchar (30) NOT NULL ,
	[E18_04] int NULL ,
	[E18_05] decimal (8,2) NULL ,
	[E18_06] int NULL ,
	[E18_07] int NULL ,
	[E18_09] varchar (15) NULL ,
	[E18_10] int NULL ,
	[E18_11] varchar (20) NULL 
)
GO

/*
The XDSs for medication complications do not indicate a relationship
with a specific medication given. It makes little sence to document
the medication complication without associating the medication given
that caused the complication. Therefore a relationship has been added
here to support it. This may need to be revised if excesive numbers
of processed XML files fail to insert correctly do to the difference
in key constraints as compaired to the XSDs.
*/

/* EMS given Medication Complication */
CREATE TABLE [NEMSIS].[dbo].[E18_08] (
	[pk_E18_08] int identity(1,1),
	[fk_E18] int NOT NULL ,
	[E18_08] int NOT NULL 
	
)
GO
/*
The data elements E19_12 - 14 seem to go together as a group
even though the group may repeat, therefore they are grouped
together here in this table as a set.
*/

/* Intervention Procedure */


/* Intervention Procedures Performed */
CREATE TABLE [NEMSIS].[dbo].[E19_01_0] (
	[pk_E19_01_0] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E19_01] datetime NULL ,
	[E19_02] int NULL ,
	[E19_03] varchar (255) NOT NULL ,
	[E19_04] varchar (20) NULL ,
	[E19_05] varchar (255) NOT NULL ,
	[E19_06] int NOT NULL ,
	[E19_08] int NULL ,
	[E19_09] varchar (15) NULL ,
	[E19_10] int NULL ,	
	[E19_11] varchar (20) NULL )
GO

/*
The XDSs for procedure complications do not indicate a relationship
with a specific procedure performed. It makes little sence to document
the procedure complication without associating the procedure performed
that caused the complication. Therefore a relationship has been added
here to support it. This may need to be revised if excesive numbers
of processed XML files fail to insert correctly do to the difference
in key constraints as compaired to the XSDs.
*/

/* Intervention Procedures Complications */
CREATE TABLE [NEMSIS].[dbo].[E19_07] (
	[pk_E19_07] int identity(1,1),
	[fk_E19_01_0] int NOT NULL,
	[E19_07] int NOT NULL 
	
)
GO

CREATE TABLE [NEMSIS].[dbo].[E19_12] (
	[pk_E19_12] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E19_12] int NULL)
GO

CREATE TABLE [NEMSIS].[dbo].[E19_13] (
	[pk_E19_13] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E19_13] int NULL)
GO

CREATE TABLE [NEMSIS].[dbo].[E19_14] (
	[pk_E19_14] int identity(1,1),
	[fk_E01_01] int NOT NULL ,
	[E19_14] int NULL)
GO


/* Disposition */
CREATE TABLE [NEMSIS].[dbo].[E20] (
	[pk_E01_01] int NOT NULL,
	[E20_01] varchar (50) NULL ,
	[E20_02] varchar (50) NULL ,
	[E20_03] varchar (30) NULL ,
	[E20_04] varchar (30) NULL ,
	[E20_05] varchar (3) NULL ,
	[E20_06] varchar (5) NULL ,
	[E20_07] varchar (10) NOT NULL ,
	[E20_08_Lat] decimal (4,2) NULL ,
	[E20_08_Long] decimal (5,2) NULL ,
	[E20_09] varchar (30) NULL ,
	[E20_10] int NOT NULL ,
	[E20_11] int NULL ,
	[E20_12] int NULL ,
	[E20_13] int NULL ,
	[E20_14] int NOT NULL ,
	[E20_15] int NULL ,
	[E20_16] int NOT NULL ,
	[E20_17] int NOT NULL)
GO

/*
Parts of this table can be split out to reduce the number of unused fields
in the primary E21 table. (E.G. E21_18 and E21_19 are 2 fields that will only
be used for specific medical devices and therefore may be reported
at a lower frequency than the reset of the medical device data.) By spliting
these out into their own table (see example below) seek times and table space
can be saved. This may apply to other fields as well.

!!! ALERT !!! If you split out any columns remember to remove them from the
original table.
*/

/* Medical Device Data */
CREATE TABLE [NEMSIS].[dbo].[E21] (
	[pk_E21_01] int identity(1,1),
	[fk_E01_01] int NOT NULL,
	[E21_01] datetime NULL ,
	[E21_02] int NULL ,
	[E21_03] int NULL ,
	[E21_04] image NULL,
	[E21_05] int NULL ,
	[E21_06] int NULL ,
	[E21_07] varchar (2000) NULL ,
	[E21_08] int NULL ,
	[E21_09] decimal (5,1) NULL ,
	[E21_10] int NULL ,
	[E21_11] int NULL ,
	[E21_12] int NULL ,
	[E21_13] int NULL ,
	[E21_14] int NULL ,
	[E21_15] int NULL ,
	[E21_16] int NULL ,
	[E21_17] int NULL ,
	[E21_18] int NULL ,
	[E21_19] int NULL ,
	[E21_20] int NULL )
GO


/*
The Waveform table can be rolled up with the medical devices, but has been split out
to potentially improve the lookup performance of the medical device data
when images are not of concern in the results. Additionally not all medical
devices will be reporting this type of information. It is beneficial to
break out frequently unused fields into a seperate subtable where possible.

!!! ALERT !!! uploading image files can severly impact the performance of this
system under volume. It is recommended that a standardized interval / value
table be implemented in lieu of using images. An image can be reproduced in
the application based on these submitted values. Additionally, analysis can
be performed on these values as compared to other outcomes. An image doesn't
allow for this to be done.
*/


/* Outcome and Linkage */
CREATE TABLE [NEMSIS].[dbo].[E22] (
	[pk_E01_01] int NOT NULL,
	[E22_01] int NOT NULL ,
	[E22_02] int NOT NULL ,
	[E22_03] varchar (20) NULL ,
	[E22_04] varchar (20) NULL ,
	[E22_05] varchar (20) NULL ,
	[E22_06] varchar (20) NULL)
GO
/* Miscellaneous */
CREATE TABLE [NEMSIS].[dbo].[E23] (
	[pk_E01_01] int NOT NULL,
	[E23_01] int NULL ,
	[E23_05] int NULL ,
	[E23_08] int NULL ,
	[E23_10] varchar (15) NULL )
GO

/* Patient Indication Criteria for Injury or Illness Specific Registry */
CREATE TABLE [NEMSIS].[dbo].[E23_02] (
	[pk_E23_02] int identity (1,1) NOT NULL,
	[fk_E01_01] int NOT NULL,
	[E23_02] int NOT NULL 
	
)
GO


/* Personnel Protective Equipment Used During Patient Contact */
CREATE TABLE [NEMSIS].[dbo].[E23_03] (
	[pk_E23_03] int identity (1,1) NOT NULL,
	[fk_E01_01] int NOT NULL,
	[E23_03] int NOT NULL 
	
)
GO


/* Suspicsion of Multi-Casualty or Domestic Terrorism Causes */
CREATE TABLE [NEMSIS].[dbo].[E23_04] (
	[pk_E23_04] int identity (1,1) NOT NULL,
	[fk_E01_01] int NOT NULL,
	[E23_04] int NOT NULL 
	
)
GO


/* Type of exposure or unprotected contact with bodily fluids */
CREATE TABLE [NEMSIS].[dbo].[E23_06] (
	[pk_E23_06] int identity (1,1) NOT NULL,
	[fk_E01_01] int NOT NULL,
	[E23_06] int NOT NULL 
	
)
GO


/* The EMS personnel exposed to unprotected contact with blood or body fluids */
CREATE TABLE [NEMSIS].[dbo].[E23_07] (
	[pk_E23_07] int identity (1,1) NOT NULL,
	[fk_E01_01] int NOT NULL,
	[E23_07] int NOT NULL 
	
)
GO


/* Customizable Local Agency Research Field */
CREATE TABLE [NEMSIS].[dbo].[E23_09_0] (
	[pk_E23_09_0] int identity (1,1),
	[fk_E01_01] int NOT NULL,[E23_09] varchar (50) NOT NULL,[E23_11] varchar (30) NOT NULL)
GO


/*******************************************************************************/
/**************************** Add Primary Keys *********************************/
/*******************************************************************************/

ALTER TABLE [dbo].[E01] WITH NOCHECK ADD 
	CONSTRAINT [PK_E01] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02_06] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02_06] PRIMARY KEY  CLUSTERED 
	(
		[pk_E02_06]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02_07] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02_07] PRIMARY KEY  CLUSTERED 
	(
		[pk_E02_07]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02_08] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02_08] PRIMARY KEY  CLUSTERED 
	(
		[pk_E02_08]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02_09] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02_09] PRIMARY KEY  CLUSTERED 
	(
		[pk_E02_09]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E02_10] WITH NOCHECK ADD 
	CONSTRAINT [PK_E02_10] PRIMARY KEY  CLUSTERED 
	(
		[pk_E02_10]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E03] WITH NOCHECK ADD 
	CONSTRAINT [PK_E03] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E04] WITH NOCHECK ADD 
	CONSTRAINT [PK_E04] PRIMARY KEY  CLUSTERED 
	(
		[pk_E04]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E05] WITH NOCHECK ADD 
	CONSTRAINT [PK_E05] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E06] WITH NOCHECK ADD 
	CONSTRAINT [PK_E06] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E07] WITH NOCHECK ADD 
	CONSTRAINT [PK_E07] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E07_03_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E07_03_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E07_03_0]
	)  ON [PRIMARY] 
GO


ALTER TABLE [dbo].[E07_35_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E07_35_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E07_35_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E07_37] WITH NOCHECK ADD 
	CONSTRAINT [PK_E07_37] PRIMARY KEY  CLUSTERED 
	(
		[pk_E07_37]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E08] WITH NOCHECK ADD 
	CONSTRAINT [PK_E08] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E08_01] WITH NOCHECK ADD 
	CONSTRAINT [PK_E08_01] PRIMARY KEY  CLUSTERED 
	(
		[pk_E08_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E08_02] WITH NOCHECK ADD 
	CONSTRAINT [PK_E08_02] PRIMARY KEY  CLUSTERED 
	(
		[pk_E08_02]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E09] WITH NOCHECK ADD 
	CONSTRAINT [PK_E09] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E09_01] WITH NOCHECK ADD 
	CONSTRAINT [PK_E09_01] PRIMARY KEY  CLUSTERED 
	(
		[pk_E09_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E09_02] WITH NOCHECK ADD 
	CONSTRAINT [PK_E09_02] PRIMARY KEY  CLUSTERED 
	(
		[pk_E09_02]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E09_14] WITH NOCHECK ADD 
	CONSTRAINT [PK_E09_14] PRIMARY KEY  CLUSTERED 
	(
		[pk_E09_14]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10_03] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10_03] PRIMARY KEY  CLUSTERED 
	(
		[pk_E10_03]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10_04] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10_04] PRIMARY KEY  CLUSTERED 
	(
		[pk_E10_04]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10_05] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10_05] PRIMARY KEY  CLUSTERED 
	(
		[pk_E10_05]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10_08] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10_08] PRIMARY KEY  CLUSTERED 
	(
		[pk_E10_08]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E10_09] WITH NOCHECK ADD 
	CONSTRAINT [PK_E10_09] PRIMARY KEY  CLUSTERED 
	(
		[pk_E10_09]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E11] WITH NOCHECK ADD 
	CONSTRAINT [PK_E11] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E11_03] WITH NOCHECK ADD 
	CONSTRAINT [PK_E11_03] PRIMARY KEY  CLUSTERED 
	(
		[pk_E11_03]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E11_11] WITH NOCHECK ADD 
	CONSTRAINT [PK_E11_11] PRIMARY KEY  CLUSTERED 
	(
		[pk_E11_11]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_01] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_01] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_01]
	)  ON [PRIMARY] 
GO


ALTER TABLE [dbo].[E12_07] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_07] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_07]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_08] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_08] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_08]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_09] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_09] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_09]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_10] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_10] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_10]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_12_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_12_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_14_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_14_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_14_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E12_19] WITH NOCHECK ADD 
	CONSTRAINT [PK_E12_19] PRIMARY KEY  CLUSTERED 
	(
		[pk_E12_19]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E13] WITH NOCHECK ADD 
	CONSTRAINT [PK_E13] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E14] WITH NOCHECK ADD 
	CONSTRAINT [PK_E14] PRIMARY KEY  CLUSTERED 
	(
		[pk_E14]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E14_03] WITH NOCHECK ADD 
	CONSTRAINT [PK_E14_03] PRIMARY KEY  CLUSTERED 
	(
		[pk_E14_03]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E15] WITH NOCHECK ADD 
	CONSTRAINT [PK_E15] PRIMARY KEY  CLUSTERED 
	(
		[pk_E15]
	)  ON [PRIMARY] 
GO


ALTER TABLE [dbo].[E16] WITH NOCHECK ADD 
	CONSTRAINT [PK_E16] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E16_00_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E16_00_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E16_00_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E17] WITH NOCHECK ADD 
	CONSTRAINT [PK_E17] PRIMARY KEY  CLUSTERED 
	(
		[pk_E17]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E18] WITH NOCHECK ADD 
	CONSTRAINT [PK_E18] PRIMARY KEY  CLUSTERED 
	(
		[pk_E18]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E18_08] WITH NOCHECK ADD 
	CONSTRAINT [PK_E18_08] PRIMARY KEY  CLUSTERED 
	(
		[pk_E18_08]
	)  ON [PRIMARY] 
GO


ALTER TABLE [dbo].[E19_01_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E19_01_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E19_01_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E19_07] WITH NOCHECK ADD 
	CONSTRAINT [PK_E19_07] PRIMARY KEY  CLUSTERED 
	(
		[pk_E19_07]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E19_12] WITH NOCHECK ADD 
	CONSTRAINT [PK_E19_12] PRIMARY KEY  CLUSTERED 
	(
		[pk_E19_12]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E19_13] WITH NOCHECK ADD 
	CONSTRAINT [PK_E19_13] PRIMARY KEY  CLUSTERED 
	(
		[pk_E19_13]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E19_14] WITH NOCHECK ADD 
	CONSTRAINT [PK_E19_14] PRIMARY KEY  CLUSTERED 
	(
		[pk_E19_14]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E20] WITH NOCHECK ADD 
	CONSTRAINT [PK_E20] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E21] WITH NOCHECK ADD 
	CONSTRAINT [PK_E21] PRIMARY KEY  CLUSTERED 
	(
		[pk_E21_01]
	)  ON [PRIMARY] 
GO


ALTER TABLE [dbo].[E22] WITH NOCHECK ADD 
	CONSTRAINT [PK_E22] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23] PRIMARY KEY  CLUSTERED 
	(
		[pk_E01_01]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_02] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_02] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_02]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_03] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_03] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_03]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_04] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_04] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_04]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_06] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_06] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_06]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_07] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_07] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_07]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[E23_09_0] WITH NOCHECK ADD 
	CONSTRAINT [PK_E23_09_0] PRIMARY KEY  CLUSTERED 
	(
		[pk_E23_09_0]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Header] WITH NOCHECK ADD 
	CONSTRAINT [PK_Header] PRIMARY KEY  CLUSTERED 
	(
		[pk_D01]
	)  ON [PRIMARY] 
GO

/*******************************************************************************/
/*************************** Add Relationships *********************************/
/*******************************************************************************/

ALTER TABLE [dbo].[E01] ADD 
	CONSTRAINT [FK_E01_Header] FOREIGN KEY 
	(
		[fk_D01]
	) REFERENCES [dbo].[Header] (
		[pk_D01]
	)
GO

ALTER TABLE [dbo].[E02] ADD 
	CONSTRAINT [FK_E02_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E02_06] ADD 
	CONSTRAINT [FK_E02_06_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E02_07] ADD 
	CONSTRAINT [FK_E02_07_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E02_08] ADD 
	CONSTRAINT [FK_E02_08_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E02_09] ADD 
	CONSTRAINT [FK_E02_09_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E02_10] ADD 
	CONSTRAINT [FK_E02_10_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E03] ADD 
	CONSTRAINT [FK_E03_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E04] ADD 
	CONSTRAINT [FK_E04_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E05] ADD 
	CONSTRAINT [FK_E05_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E06] ADD 
	CONSTRAINT [FK_E06_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E07] ADD 
	CONSTRAINT [FK_E07_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E07_03_0] ADD 
	CONSTRAINT [FK_E07_03_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO


ALTER TABLE [dbo].[E07_35_0] ADD 
	CONSTRAINT [FK_E07_35_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E07_37] ADD 
	CONSTRAINT [FK_E07_37_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E08] ADD 
	CONSTRAINT [FK_E08_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E08_01] ADD 
	CONSTRAINT [FK_E08_01_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E08_02] ADD 
	CONSTRAINT [FK_E08_02_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E09] ADD 
	CONSTRAINT [FK_E09_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E09_01] ADD 
	CONSTRAINT [FK_E09_01_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E09_02] ADD 
	CONSTRAINT [FK_E09_02_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E09_14] ADD 
	CONSTRAINT [FK_E09_14_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10] ADD 
	CONSTRAINT [FK_E10_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10_03] ADD 
	CONSTRAINT [FK_E10_03_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10_04] ADD 
	CONSTRAINT [FK_E10_04_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10_05] ADD 
	CONSTRAINT [FK_E10_05_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10_08] ADD 
	CONSTRAINT [FK_E10_08_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E10_09] ADD 
	CONSTRAINT [FK_E10_09_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E11] ADD 
	CONSTRAINT [FK_E11_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E11_03] ADD 
	CONSTRAINT [FK_E11_03_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E11_11] ADD 
	CONSTRAINT [FK_E11_11_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12] ADD 
	CONSTRAINT [FK_E12_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_01] ADD 
	CONSTRAINT [FK_E12_01_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO


ALTER TABLE [dbo].[E12_07] ADD 
	CONSTRAINT [FK_E12_07_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_08] ADD 
	CONSTRAINT [FK_E12_08_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_09] ADD 
	CONSTRAINT [FK_E12_09_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_10] ADD 
	CONSTRAINT [FK_E12_10_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_12_0] ADD 
	CONSTRAINT [FK_E12_12_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_14_0] ADD 
	CONSTRAINT [FK_E12_14_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E12_19] ADD 
	CONSTRAINT [FK_E12_19_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E13] ADD 
	CONSTRAINT [FK_E13_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E14] ADD 
	CONSTRAINT [FK_E14_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E14_03] ADD 
	CONSTRAINT [FK_E14_03_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E15] ADD 
	CONSTRAINT [FK_E15_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E16] ADD 
	CONSTRAINT [FK_E16_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E16_00_0] ADD 
	CONSTRAINT [FK_E16_00_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E17] ADD 
	CONSTRAINT [FK_E17_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E18] ADD 
	CONSTRAINT [FK_E18_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E18_08] ADD 
	CONSTRAINT [FK_E18_08_E18] FOREIGN KEY 
	(
		[fk_E18]
	) REFERENCES [dbo].[E18] (
		[pk_E18]
	)
GO


ALTER TABLE [dbo].[E19_01_0] ADD 
	CONSTRAINT [FK_E19_01_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E19_07] ADD 
	CONSTRAINT [FK_E19_07_E19_01_0] FOREIGN KEY 
	(
		[fk_E19_01_0]
	) REFERENCES [dbo].[E19_01_0] (
		[pk_E19_01_0]
	)
GO

ALTER TABLE [dbo].[E19_12] ADD 
	CONSTRAINT [FK_E19_12_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E19_13] ADD 
	CONSTRAINT [FK_E19_13_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E19_14] ADD 
	CONSTRAINT [FK_E19_14_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E20] ADD 
	CONSTRAINT [FK_E20_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E21] ADD 
	CONSTRAINT [FK_E21_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO


ALTER TABLE [dbo].[E22] ADD 
	CONSTRAINT [FK_E22_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23] ADD 
	CONSTRAINT [FK_E23_E01] FOREIGN KEY 
	(
		[pk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_02] ADD 
	CONSTRAINT [FK_E23_02_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_03] ADD 
	CONSTRAINT [FK_E23_03_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_04] ADD 
	CONSTRAINT [FK_E23_04_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_06] ADD 
	CONSTRAINT [FK_E23_06_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_07] ADD 
	CONSTRAINT [FK_E23_07_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO

ALTER TABLE [dbo].[E23_09_0] ADD 
	CONSTRAINT [FK_E23_09_0_E01] FOREIGN KEY 
	(
		[fk_E01_01]
	) REFERENCES [dbo].[E01] (
		[pk_E01_01]
	)
GO