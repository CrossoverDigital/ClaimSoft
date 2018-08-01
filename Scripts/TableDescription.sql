USE [cdTestDB]

--SELECT
--	  CONCAT('-- ',[SysTbls].[name],'                         ') + CONCAT(' - ',[SysCols].[name],'                   ') + CONCAT(' - ',CAST([ExtProp].[value] AS varchar(1000)),' ') AS [Extended Property]
	  
--FROM
--	[sys].[tables] AS [SysTbls]
--	LEFT JOIN
--	[sys].[extended_properties] AS [ExtProp]
--	ON
--	[ExtProp].[major_id] = [SysTbls].[object_id]
--	LEFT JOIN
--	[sys].[columns] AS [SysCols]
--	ON
--	[ExtProp].[major_id] = [SysCols].[object_id]
--	AND [ExtProp].[minor_id] = [SysCols].[column_id]
--	LEFT JOIN
--	[sys].[objects] AS [SysObj]
--	ON
--	[SysTbls].[object_id] = [SysObj].[object_id]
--	INNER JOIN
--	[sys].[types] AS [SysTyp]
--	ON
--	[SysCols].[user_type_id] = [SysTyp].[user_type_id]
--WHERE
--	[class] = 1 --Object or column
--	AND [SysTbls].[name] IS NOT NULL
--	AND [SysCols].[name] IS NOT NULL
--	--AND SUBSTRING(CAST([ExtProp].[value] AS varchar(1000)), 13, 3) 
--	--AND [SysTbls].[name] LIKE 'PCRUnitPersonnel%'
--ORDER BY
--	SUBSTRING(CAST([ExtProp].[value] AS varchar(1000)), 13, 6);



SELECT
	  [SysTbls].[name] AS [Table Name]
	, CONCAT('[',[SysCols].[name],']') AS [Column Name]
	, CONCAT(CONCAT(',[',[SysCols].[name],']'), ' ', UPPER([Systyp].[name]),
	CASE
	     WHEN [Systyp].[name] IN('varchar', 'nchar') THEN
			 CAST(CONCAT('(',([SysCols].[max_length] / 2), ')') AS varchar(8))
	     WHEN [Systyp].[name] IN('char')             THEN
			CAST(CONCAT('(',[SysCols].[max_length], ')') AS varchar(8))
		                                            ELSE
			NULL
	END, ' ', CONCAT('''n:', SUBSTRING(CAST([ExtProp].[value] AS varchar(1000)), 13, 6),'''')) AS 'DateType'
	, CONCAT('-- ',[SysTbls].[name],'                         ') + CONCAT(' - ',[SysCols].[name],'                   ') + CONCAT(' - ',CAST([ExtProp].[value] AS varchar(1000)),' ') AS [Extended Property]
	, CONCAT('''n:', SUBSTRING(CAST([ExtProp].[value] AS varchar(1000)), 13, 6),'''') AS [Attribute]
	, [ExtProp].[value] AS [Extended Property]
	, [Systyp].[name] AS [Data Type]
	, CASE
	     WHEN [Systyp].[name] IN ('varchar', 'nchar') THEN
			([SysCols].[max_length] / 2)
	     WHEN [Systyp].[name] IN('char')              THEN
			[SysCols].[max_length]
		                                             ELSE
			NULL
	END AS 'Length of Column'
	, CASE
	     WHEN [SysCols].[is_nullable] = 0 THEN
			'No'
	     WHEN [SysCols].[is_nullable] = 1 THEN
			'Yes'
		                                 ELSE
			NULL
	END AS 'Column is Nullable'
	, [SysObj].[create_date] AS [Table Create Date]
	, [SysObj].[modify_date] AS [Table Modify Date]
FROM
	[sys].[tables] AS [SysTbls]
	LEFT JOIN
	[sys].[extended_properties] AS [ExtProp]
	ON
	[ExtProp].[major_id] = [SysTbls].[object_id]
	LEFT JOIN
	[sys].[columns] AS [SysCols]
	ON
	[ExtProp].[major_id] = [SysCols].[object_id]
	AND [ExtProp].[minor_id] = [SysCols].[column_id]
	LEFT JOIN
	[sys].[objects] AS [SysObj]
	ON
	[SysTbls].[object_id] = [SysObj].[object_id]
	INNER JOIN
	[sys].[types] AS [SysTyp]
	ON
	[SysCols].[user_type_id] = [SysTyp].[user_type_id]
WHERE
	[class] = 1 --Object or column
	AND [SysTbls].[name] IS NOT NULL
	AND [SysCols].[name] IS NOT NULL
ORDER BY
	5;
