USE [cdTestDB]

DROP FUNCTION FileTableExists
DROP FUNCTION DirectoryExists
DROP FUNCTION FileExists
DROP PROCEDURE CreateDirectory
DROP PROCEDURE CreateFile
GO

DROP ASSEMBLY FileTableFramework
GO

CREATE ASSEMBLY FileTableFramework from 'D:\Sandbox\ClaimSoft\src\CD.ClaimSoft.Database.FileTable\bin\Debug\CD.ClaimSoft.Database.FileTable.dll' WITH PERMISSION_SET = SAFE
GO

CREATE FUNCTION FileTableExists(@table NVARCHAR(100)) RETURNS BIT
AS EXTERNAL NAME FileTableFramework.[CD.ClaimSoft.Database.FileTable.FileTableExtensions].FileTableExists;
GO
CREATE FUNCTION DirectoryExists(@table NVARCHAR(100), @path NVARCHAR(400)) RETURNS NVARCHAR(MAX)
AS EXTERNAL NAME FileTableFramework.[CD.ClaimSoft.Database.FileTable.FileTableExtensions].DirectoryExists;
GO
CREATE FUNCTION FileExists(@table NVARCHAR(100), @path NVARCHAR(400)) RETURNS NVARCHAR(MAX)
AS EXTERNAL NAME FileTableFramework.[CD.ClaimSoft.Database.FileTable.FileTableExtensions].FileExists;
GO
CREATE Procedure CreateDirectory(@table NVARCHAR(100), @path NVARCHAR(400), @id NVARCHAR(MAX) OUTPUT)
AS EXTERNAL NAME FileTableFramework.[CD.ClaimSoft.Database.FileTable.FileTableExtensions].CreateDirectory;
GO
CREATE Procedure CreateFile(@table NVARCHAR(100), @file NVARCHAR(400), @data VARBINARY(MAX), @id uniqueidentifier OUTPUT)
AS EXTERNAL NAME FileTableFramework.[CD.ClaimSoft.Database.FileTable.FileTableExtensions].CreateFile;
GO
