EXEC sp_configure filestream_access_level, 2

RECONFIGURE

GO

CREATE DATABASE cdTestDB

ON PRIMARY

(Name = cdTestDB,

FILENAME = 'D:\Sandbox\ClaimSoft\src\CD.ClaimSoft.UI\App_Data\cdTestDB.mdf'),

FILEGROUP FTFG CONTAINS FILESTREAM

(NAME = FileTableFS,

FILENAME='D:\FileTable\CDFS')

LOG ON

(Name = FileTableDBLog,

FILENAME = 'D:\Sandbox\ClaimSoft\src\CD.ClaimSoft.UI\App_Data\cdTestDB_Log.ldf')

WITH FILESTREAM (NON_TRANSACTED_ACCESS = FULL,

DIRECTORY_NAME = N'cdTestDB');

GO

USE cdTestDB

GO

CREATE TABLE AgencyLogo AS FileTable

WITH

(FileTable_Directory = 'AgencyLogo');

GO