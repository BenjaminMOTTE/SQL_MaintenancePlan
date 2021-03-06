--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------        PARTIE : CREATION DE LA BASE DE DONNEE SQLALERTS     ----------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Script généré en partie part et sous SQL Server 2014 12.0.2000
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --


----------------------------------------------------------------------------------------
----------------            Activation des options avancées              ---------------
----------------------------------------------------------------------------------------

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ole Automation Procedures', 1;
RECONFIGURE;


--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------

USE [master]
GO
/****** Object:  Database [SQLAlerts] ******/
CREATE DATABASE [SQLAlerts]
GO
 
 ALTER DATABASE [SQLAlerts] MODIFY FILE
( NAME = N'SQLAlerts', SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 GO
 ALTER DATABASE [SQLAlerts] MODIFY FILE
 ( NAME = N'SQLAlerts_log', SIZE = 2048KB , MAXSIZE = UNLIMITED , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [SQLAlerts] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SQLAlerts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SQLAlerts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SQLAlerts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SQLAlerts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SQLAlerts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SQLAlerts] SET ARITHABORT OFF 
GO
ALTER DATABASE [SQLAlerts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SQLAlerts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SQLAlerts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SQLAlerts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SQLAlerts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SQLAlerts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SQLAlerts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SQLAlerts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SQLAlerts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SQLAlerts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SQLAlerts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SQLAlerts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SQLAlerts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SQLAlerts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SQLAlerts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SQLAlerts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SQLAlerts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SQLAlerts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SQLAlerts] SET  MULTI_USER 
GO
ALTER DATABASE [SQLAlerts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SQLAlerts] SET DB_CHAINING OFF 
GO

USE [SQLAlerts]
GO


		

/****** Object:  Table [dbo].[Journal] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Journal](
	[num_inc_log] [int] IDENTITY(1,1) NOT NULL,
	[date_log] [datetime] NOT NULL,
	[incident_avere_log] [bit] NOT NULL,
	[nom_base_log] [nvarchar](max) NULL,
	[message_log] [nvarchar](max) NULL,
 CONSTRAINT [PK_Journal] PRIMARY KEY CLUSTERED 
(
	[num_inc_log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Sauvegarde] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sauvegarde](
	[num_inc_bak] [int] IDENTITY(1,1) NOT NULL,
	[date_bak] [datetime] NOT NULL,
	[incident_avere_bak] [bit] NOT NULL,
	[nom_base_bak] [nvarchar](max) NULL,
	[message_bak] [nvarchar](max) NULL,
 CONSTRAINT [PK_Sauvegarde] PRIMARY KEY CLUSTERED 
(
	[num_inc_bak] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Cleaning_history] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cleaning_history](
	[num_inc_ch] [int] IDENTITY(1,1) NOT NULL,
	[date_ch] [datetime] NOT NULL,
	[incident_avere_ch] [bit] NOT NULL,
	[nom_base_ch] [nvarchar](max) NULL,
	[message_ch] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cleaning_history] PRIMARY KEY CLUSTERED 
(
	[num_inc_ch] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Integrite] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Integrite](
	[num_inc_int] [int] IDENTITY(1,1) NOT NULL,
	[date_int] [datetime] NOT NULL,
	[incident_avere_int] [bit] NOT NULL,
	[nom_base_int] [nvarchar](max) NULL,
	[message_int] [nvarchar](max) NULL,
 CONSTRAINT [PK_Integrite] PRIMARY KEY CLUSTERED 
(
	[num_inc_int] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rebuild] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rebuild](
	[num_inc_reb] [int] IDENTITY(1,1) NOT NULL,
	[date_reb] [datetime] NOT NULL,
	[incident_avere_reb] [bit] NOT NULL,
	[nom_base_reb] [nvarchar](max) NULL,
	[message_reb] [nvarchar](max) NULL,
 CONSTRAINT [PK_Rebuild] PRIMARY KEY CLUSTERED 
(
	[num_inc_reb] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/**** Object:  Table [dbo].[Reorganize] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reorganize](
	[num_inc_reo] [int] IDENTITY(1,1) NOT NULL,
	[date_reo] [datetime] NOT NULL,
	[incident_avere_reo] [bit] NOT NULL,
	[nom_base_reo] [nvarchar](max) NULL,
	[message_reo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Reorganize] PRIMARY KEY CLUSTERED 
(
	[num_inc_reo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T-SQL] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T-SQL](
	[num_inc_tsql] [int] IDENTITY(1,1) NOT NULL,
	[date_tsql] [datetime] NOT NULL,
	[incident_avere_tsql] [bit] NOT NULL,
	[nom_base_tsql] [nvarchar](max) NULL,
	[message_tsql] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tsql] PRIMARY KEY CLUSTERED 
(
	[num_inc_tsql] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Update] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAJ](
	[num_inc_up] [int] IDENTITY(1,1) NOT NULL,
	[date_up] [datetime] NOT NULL,
	[incident_avere_up] [bit] NOT NULL,
	[nom_base_up] [nvarchar](max) NULL,
	[message_up] [nvarchar](max) NULL,
 CONSTRAINT [PK_Update] PRIMARY KEY CLUSTERED 
(
	[num_inc_up] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Performance] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Performance](
	[num_perf] [int] IDENTITY(1,1) NOT NULL
	,[date_perf] [datetime] NOT NULL
	,[Info] varchar(500) NOT NULL
	,[Valeur] sql_variant NOT NULL
	,
 CONSTRAINT [PK_Perf] PRIMARY KEY CLUSTERED 
(
	[num_perf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configuration] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuration](
	[num_conf] [int] IDENTITY(1,1) NOT NULL
	,[libelle_parametre] varchar(50) NOT NULL
	,[parametre] [int] NOT NULL
	,[info] varchar(500) NULL
	,
 CONSTRAINT [PK_Conf] PRIMARY KEY CLUSTERED 
(
	[num_conf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


IF NOT EXISTS ( SELECT  *
            FROM    dbo.Configuration
           )
BEGIN
	INSERT INTO [dbo].[Configuration](
	[libelle_parametre]
	,[parametre]
	,[info]
	)
	VALUES 
	('retention_bak',	4,	'nombre de jours de rétention fichiers de sauvegarde .BAK'),
	('retention_trn',	1,	'nombre de jours de rétention fichiers journal de sauvegarde .TRN'),
	('retention_his',	180,	'nombre de jours de rétention de l''historique conservée au sein de SQLAlerts et des journaux dans SQL SERVER')
	--,('version',	   '1.2.25022015',	'Version du logiciel')
	;
END
GO


ALTER DATABASE [SQLAlerts] SET  READ_WRITE 
GO


--------------------------------------------------------------------------------------
---------   PARTIE : CREATION DES VUES POUR LE MONITORING EN FONCTION ----------------
----------------            DE LA VERSION DE SQL SERVER               ----------------
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
---------                     VUE INCIDENTS DU JOUR                   ----------------
--------------------------------------------------------------------------------------

USE SQLAlerts
GO

CREATE VIEW INCIDENTS_DU_JOUR
AS

Select 't_sql' as job, date_tsql as date_incident, incident_avere_tsql as incident, nom_base_tsql as nom_base from [T-SQL] where incident_avere_tsql = 1 AND (cast (date_tsql as date) = cast(getdate()as date))
UNION
SELECT 'Sauvegarde' as job,  date_bak as date_incident, incident_avere_bak as incident, nom_base_bak as nom_base FROM Sauvegarde where incident_avere_bak = 1 AND (cast (date_bak as date) = cast(getdate()as date))
UNION
SELECT 'Reorganize'as job,  date_reo as date_incident, incident_avere_reo as incident, nom_base_reo as nom_base FROM Reorganize where incident_avere_reo = 1 AND (cast (date_reo as date) = cast(getdate()as date))
UNION
SELECT 'Rebuild' as job,  date_reb as date_incident, incident_avere_reb as incident, nom_base_reb as nom_base FROM Rebuild where incident_avere_reb = 1 AND (cast (date_reb as date) = cast(getdate()as date))
UNION
SELECT 'Update Stats' as job,  date_up as date_incident, incident_avere_up as incident, nom_base_up as nom_base FROM MAJ where incident_avere_up = 1 AND (cast (date_up as date) = cast(getdate()as date))
UNION
SELECT 'Sauvegarde du journal'as job,  date_log as date_incident, incident_avere_log as incident, nom_base_log as nom_base FROM Journal where incident_avere_log = 1 AND (cast (date_log as date) = cast(getdate()as date))
UNION
SELECT 'CHECKDB'as job, date_int as date_incident, incident_avere_int as incident, nom_base_int as nom_base FROM Integrite where incident_avere_int = 1 AND (cast (date_int as date) = cast(getdate()as date))
UNION
SELECT 'Nettoyage historique'as job, date_ch as date_incident, incident_avere_ch as incident, nom_base_ch as nom_base FROM Cleaning_history where incident_avere_ch = 1 AND (cast (date_ch as date) = cast(getdate()as date));

GO

--------------------------------------------------------------------------------------
---------                     VUE INCIDENTS AGENT                     ----------------
--------------------------------------------------------------------------------------

USE msdb
Go 


IF EXISTS
(
	SELECT	*
	FROM	SYS.VIEWS
	WHERE	name = 'INCIDENTS_AGENT'
)

BEGIN
	DROP VIEW dbo.INCIDENTS_AGENT
END

GO

CREATE VIEW DBO.INCIDENTS_AGENT
AS

SELECT j.name JobName,h.step_name StepName, 
CONVERT(CHAR(10), CAST(STR(h.run_date,8, 0) AS dateTIME), 111) RunDate, 
STUFF(STUFF(RIGHT('000000' + CAST ( h.run_time AS VARCHAR(6 ) ) ,6),5,0,':'),3,0,':') RunTime, 
h.run_duration StepDuration,
case h.run_status when 0 then 'failed'
when 1 then 'Succeded' 
when 2 then 'Retry' 
when 3 then 'Cancelled' 
when 4 then 'In Progress' 
end as ExecutionStatus, 
h.message MessageGenerated
FROM sysjobhistory h inner join sysjobs j
ON j.job_id = h.job_id
WHERE j.name LIKE '%Evolucare%'
AND h.run_status = 0
AND (cast(str(h.run_date) as date) = CAST (getdate() as date))

GO


--------------------------------------------------------------------------------------
---------            PARTIE : CREATION DES PROCEDURES STOCKEES        ----------------
--------------------------------------------------------------------------------------



--------------------------------------------------------------
-- Connexion base
--------------------------------------------------------------

USE SQLAlerts
GO

--------------------------------------------------------------
-- Verification présence procédure
--------------------------------------------------------------

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'dbo.geterror')
                    AND type IN ( N'P', N'PC' )
)
BEGIN
	DROP PROCEDURE dbo.geterror
END
GO

--------------------------------------------------------------
-- Création procédure
--------------------------------------------------------------

CREATE PROCEDURE dbo.geterror
	@DBName varchar(50)
AS

--------------------------------------------------------------
-- Verification présence table
--------------------------------------------------------------

IF EXISTS
(
	
	SELECT	*
	FROM	INFORMATION_SCHEMA.TABLES
	WHERE	TABLE_SCHEMA = 'dbo'
	AND	TABLE_NAME = 'Checkint'
)

BEGIN
	DROP TABLE dbo.Checkint
END

--------------------------------------------------------------
-- Création table temporaire de collecte de résultats
--------------------------------------------------------------

if left(CAST(SERVERPROPERTY('ProductVersion')AS sysname),5) = '11.0.' 
OR left(CAST(SERVERPROPERTY('ProductVersion')AS sysname),5) = '12.0.'
BEGIN
	CREATE TABLE dbo.Checkint 
		([Error] int NOT NULL 
		,[Level] int NOT NULL
		,[State] int NOT NULL
		,[MessageText] nvarchar(MAX) NOT NULL
		,[RepairLevel] nvarchar(100) NULL
		,[Status] int NOT NULL
		,[DbId] int NOT NULL
		,[DbFragId] int NOT NULL -- (SQL 2012+)
		,[ObjectID] int NOT NULL
		,[IndexId] int NOT NULL
		,[PartitionId] bigint NOT NULL
		,[AllocUnitId] bigint NOT NULL
		,[RidDbId] int NOT NULL  -- (SQL 2012+)
		,[RidPruId] int NOT NULL  -- (SQL 2012+)
		,[File] int NOT NULL
		,[Page] int NOT NULL
		,[Slot] int NOT NULL
		,[RefDbID] int NOT NULL  -- (SQL 2012+)
		,[RefPruId] int NOT NULL  -- (SQL 2012+)
		,[RefFile] int NOT NULL
		,[RefPage] int NOT NULL
		,[RefSlot] int NOT NULL
		,[Allocation] int NOT NULL)
 
	INSERT INTO dbo.Checkint 
		([Error]
		, [Level]
		, [State]
		, [MessageText]
		, [RepairLevel]
		, [Status]
		, [DbId]
		, [DbFragId] -- (SQL 2012+)
		, [ObjectID]
		, [IndexId]
		, [PartitionId]
		, [AllocUnitId]
		, [RidDbId] -- (SQL 2012+)
		, [RidPruId] -- (SQL 2012+)
		, [File]
		, [Page]
		, [Slot]
		, [RefDbID] -- (SQL 2012+)
		, [RefPruId] -- (SQL 2012+)
		, [RefFile]
		, [RefPage]
		, [RefSlot]
		, [Allocation]) 
		EXEC ('DBCC CHECKDB([' + @DBName + ']) WITH TABLERESULTS');
END
ELSE
BEGIN
	CREATE TABLE dbo.Checkint 
    ([Error] int NOT NULL 
    ,[Level] int NOT NULL
    ,[State] int NOT NULL
    ,[MessageText] nvarchar(MAX) NOT NULL
    ,[RepairLevel] nvarchar(100) NULL
    ,[Status] int NOT NULL
    ,[DbId] int NOT NULL
    --,[DbFragId] int NOT NULL (SQL 2012+)
    ,[ObjectID] int NOT NULL
    ,[IndexId] int NOT NULL
    ,[PartitionId] bigint NOT NULL
    ,[AllocUnitId] bigint NOT NULL
    --,[RidDbId] int NOT NULL  (SQL 2012+)
    --,[RidPruId] int NOT NULL  (SQL 2012+)
    ,[File] int NOT NULL
    ,[Page] int NOT NULL
    ,[Slot] int NOT NULL
    --,[RefDbID] int NOT NULL  (SQL 2012+)
    --,[RefPruId] int NOT NULL  (SQL 2012+)
    ,[RefFile] int NOT NULL
    ,[RefPage] int NOT NULL
    ,[RefSlot] int NOT NULL
    ,[Allocation] int NOT NULL)
 
	INSERT INTO dbo.Checkint 
    ([Error]
    , [Level]
    , [State]
    , [MessageText]
    , [RepairLevel]
    , [Status]
    , [DbId]
    --, [DbFragId] (SQL 2012+)
    , [ObjectID]
    , [IndexId]
    , [PartitionId]
    , [AllocUnitId]
    --, [RidDbId] (SQL 2012+)
    --, [RidPruId] (SQL 2012+)
    , [File]
    , [Page]
    , [Slot]
    --, [RefDbID] (SQL 2012+)
    --, [RefPruId] (SQL 2012+)
    , [RefFile]
    , [RefPage]
    , [RefSlot]
    , [Allocation]) 
	 EXEC ('DBCC CHECKDB([' + @DBName + ']) WITH TABLERESULTS');
END ;
--------------------------------------------------------------
-- Verification de l'échec du checkdb
--------------------------------------------------------------

DECLARE @ERROR bit
SET @ERROR = 0

BEGIN
IF EXISTS (SELECT (Level) FROM dbo.Checkint WHERE Level > 10 )
	SET @ERROR = 1
END

--------------------------------------------------------------
-- alimentation de la base de collecte intégrité
--------------------------------------------------------------
 
INSERT INTO dbo.Integrite ([date_int], [incident_avere_int], [nom_base_int], [message_int]) 
VALUES (getdate(), @ERROR, @DBName,(SELECT TOP 1 [MessageText] FROM dbo.Checkint WHERE [Error] = 8989));

--------------------------------------------------------------
-- nettoyage
--------------------------------------------------------------

DROP TABLE dbo.Checkint
GO

--------------------------------------------------------------------------------------
---------        PARTIE : CREATION DES TACHES DU PLAN DE MAINTENANCE  ----------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
---------                      PLAN DE SAUVEGARDE                       --------------
--------------------------------------------------------------------------------------

USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Sauvegarde des BDD]    Script Date: 24/07/2015 16:33:28 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 24/07/2015 16:33:28 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Sauvegarde des BDD', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Partie du plan de maintenance Evolucare (vTSQL) : Sauvegarde et Nettoyage des fichiers de sauvegarde (BAK). Reorganiser les index et mise à jour des statistiques.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Sauvegarde et Nettoyage]    Script Date: 24/07/2015 16:33:28 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Sauvegarde et Nettoyage', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=5, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------       PARTIE : SAUVEGARDE + NETTOYAGE DE L''HISTORIQUE(BAK) -----------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--------- Script sous SQL Server 2014 12.0.2000
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --


--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------

--- /!\ VARIABLE A RENSEIGNER EVENTUELLEMENT : /!
---  @path utilisera l''EMPLACEMENT DU REPERTOIRE DES SAUVEGARDE configuré dans les paramètres
---  de l''instance. (base de registre après 1ère installation)
---  Vous pouvez configurer manuellement le chemin s''il n''est pas correct, 
---  Soit en renseignant la variable @PATH ici
---  Il doit être terminé par "\" Le répertoire doit exister.
---  Ou en executant le script CHANGER CHEMIN SAUVEGARDE pour changer le répertoire par défaut
---  Il doit être terminé par "\" Le répertoire doit exister.

---  @DeleteDate RETENTION DE LA SAUVEGARDE
---  (spécifier wk pour semaine à la place de day si necessaire)

USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Déclaration des variables
--------------------------------------------------------------------------------------

DECLARE @name VARCHAR(50) -- nom base de données
DECLARE @path VARCHAR(256) -- Chemin du répertoire de la sauvegarde
DECLARE @fileName VARCHAR(256) -- nom du fichier 
DECLARE @fileDate VARCHAR(20) -- formatage de la date pour le nom du fichier
DECLARE @sql nvarchar(max)
DECLARE @timedelay INT
SET @timedelay = (SELECT parametre FROM Configuration WHERE libelle_parametre = ''retention_bak'')
DECLARE @DeleteDate DATETIME = DATEADD(day,-@timedelay,GETDATE()); -- Nombre de jours de la rétention
DECLARE @KOMP nvarchar(max) -- Compression active ou non

DECLARE @folder nvarchar(500) -- Chemin du dossier de sauvegarde final

--------------------------------------------------------------------------------------
-- Gestion FICHIER et répertoire de sauvegarde
--------------------------------------------------------------------------------------

-- Chemin de la sauvegarde par défaut
EXEC master.dbo.xp_instance_regread N''HKEY_LOCAL_MACHINE'',
N''Software\Microsoft\MSSQLServer\MSSQLServer'',N''BackupDirectory'',@path OUTPUT ;

SET @path = @path + CHAR(92) 
-- SET @path = CHAR(39) + @path + CHAR(39) 
-- SET @path = C:\Backupprint @path

-- Préparation du nom du fichier de sauvegarde 
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),'':'','''')



--------------------------------------------------------------------------------------
-- Procédure
--------------------------------------------------------------------------------------

IF EXISTS
(
	
	SELECT	*
	FROM	INFORMATION_SCHEMA.TABLES
	WHERE	TABLE_SCHEMA = ''dbo''
	AND TABLE_NAME = ''curseur''
)

BEGIN
	DROP TABLE curseur
END


CREATE TABLE dbo.curseur(
id[INT] NOT NULL,
nombase[varchar](50) NOT NULL)

INSERT INTO curseur
	([id], [nombase])
	EXEC (''SELECT ROW_NUMBER() OVER (order by name) AS ligne, name
	FROM master.dbo.sysdatabases 
	WHERE name NOT IN (''''master'''',''''model'''',''''msdb'''',''''tempdb'''')  
	AND DATABASEPROPERTYEX(name, ''''Status'''') = ''''ONLINE'''' '')    ;


DECLARE @nblignes INT;
SET @nblignes = ( SELECT count(id) FROM curseur )

DECLARE @compteur INT;
SET @compteur = (SELECT TOP 1 id FROM curseur)

WHILE @compteur <= @nblignes 
BEGIN
	
	SET @name = (SELECT nombase FROM curseur WHERE id = @compteur);
	
	BEGIN TRY
		
		SET @folder = @path + @name
		
		DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT) -- Collecte de la structure
		INSERT INTO @DirTree(subdirectory, depth)
		EXEC master.sys.xp_dirtree @folder

		IF NOT EXISTS (SELECT 1 FROM @DirTree WHERE subdirectory = @name)
		EXEC master.dbo.xp_create_subdir @folder

		IF (SELECT value FROM sys.configurations WHERE name = ''backup compression default'') = 1
		BEGIN
	
			SET @fileName = @folder + CHAR(92) + @name + ''_'' + @fileDate + ''.BAK''  
			SET @KOMP = ''BACKUP DATABASE ['' + @name + ''] TO DISK = '' + CHAR(39) + @fileName + CHAR(39) + '' WITH NOFORMAT, NOINIT, COMPRESSION, CHECKSUM, STOP_ON_ERROR, SKIP, REWIND, NOUNLOAD''
			EXEC (@KOMP)
		END
		ELSE
		BEGIN
			SET @fileName = @folder + CHAR(92) + @name + ''_'' + @fileDate + ''.BAK''  
			SET @KOMP = ''BACKUP DATABASE ['' + @name + ''] TO DISK = '' + CHAR(39) + @fileName + CHAR(39) + '' WITH NOFORMAT, NOINIT, NO_COMPRESSION, CHECKSUM, STOP_ON_ERROR, SKIP, REWIND, NOUNLOAD''
			EXEC (@KOMP)
		END
		
		PRINT ''REUSSITE !''
		PRINT @name
		SET @SQL = ''INSERT INTO SQLAlerts.dbo.Sauvegarde 
			([date_bak]
			, [incident_avere_bak]
			, [nom_base_bak]
			, [message_bak]) 
			VALUES (getdate(), 0, @name, ''''Réussite'''')''

		EXEC sp_executesql @sql, N''@name nvarchar(max)'', @name
		 
		 -- Suppression des anciens fichiers de sauvegarde en cas de succès.
		EXEC master.sys.xp_delete_file 0,@folder,''BAK'',@DeleteDate,0;
		EXEC master.sys.xp_delete_file 0,@path,''BAK'',@DeleteDate,0;
 
 	END TRY

	BEGIN CATCH
		-- collecte de données en cas d''erreur.
		PRINT ''ECHEC !''
		PRINT @name
		SET @SQL = ''INSERT INTO SQLAlerts.dbo.Sauvegarde 
			([date_bak]
			, [incident_avere_bak]
			, [nom_base_bak]
			, [message_bak]) 
			VALUES (getdate(), 1, @name, ERROR_MESSAGE())''

		EXEC sp_executesql @sql, N''@name nvarchar(max)'', @name

	END CATCH
	
	SET @compteur = @compteur + 1;
	
END ;

DROP TABLE curseur;
', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Reorganisation]    Script Date: 24/07/2015 16:33:28 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Reorganisation', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
--------------------------------------------------------------------------------------
---------               PARTIE : REORGANISER LES INDEX                  --------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --



--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------
-- Connexion base
--------------------------------------------------------------------------------------

USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Recensement des bases de données de l''instance
--------------------------------------------------------------------------------------

DECLARE @alldb TABLE (idx int identity(1,1), NAME varchar(50))
INSERT INTO @alldb 
    ([NAME]) 
	
	 EXEC    sp_msforeachdb 
"IF      ''?''     NOT IN (''tempdb'')   BEGIN
        USE [?] SELECT DB_NAME();
END"

--------------------------------------------------------------------------------------
-- Exécution de la procédure stockée sur l''ensemble des bases de données
--------------------------------------------------------------------------------------

DECLARE @COMPTEUR int
DECLARE @Sql nvarchar(4000)

SET @COMPTEUR = 0

WHILE(@COMPTEUR <= (SELECT MAX(idx) FROM @alldb))
BEGIN
    DECLARE @colVar VARCHAR(50)

    SELECT @colVar = [NAME] FROM @alldb WHERE idx = @compteur

   	SET @SQl = ''USE ['' +@colvar+'']
						
						BEGIN TRY
							-- Tentative de la tâche.
							EXEC sp_MSforeachtable @command1="print ''''Reorganizing indexes for ?'''' ALTER INDEX ALL ON ? REORGANIZE "
							PRINT ''''REUSSITE !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.Reorganize 
								([date_reo]
								, [incident_avere_reo]
								, [nom_base_reo]
								, [message_reo]) 
								VALUES (getdate(), 0, DB_NAME(), ''''''''Réussite'''''''')'''')
						END TRY

						BEGIN CATCH
							-- Collecte de données en cas de non succès.
							PRINT ''''ECHEC !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.Reorganize 
								([date_reo]
								, [incident_avere_reo]
								, [nom_base_reo]
								, [message_reo]) 
								VALUES (getdate(), 1, DB_NAME(), ERROR_MESSAGE())'''')
						END CATCH; 
						''
				
			EXEC sp_executesql @sql

    SET @compteur = @compteur + 1
END', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Mise à jour des Statistiques]    Script Date: 24/07/2015 16:33:28 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Mise à jour des Statistiques', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
--------------------------------------------------------------------------------------
-------              PARTIE : MISE A JOUR DES STATISTIQUES                  ----------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --



--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Connexion base
--------------------------------------------------------------------------------------

USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Recensement des bases de données de l''instance
--------------------------------------------------------------------------------------

DECLARE @alldb TABLE (idx int identity(1,1), NAME varchar(50))
INSERT INTO @alldb 
			([NAME]) 


	 EXEC    sp_msforeachdb 
"IF      ''?''     NOT IN (''tempdb'')   BEGIN
        USE [?] SELECT DB_NAME();
END"

-------------------------------------------------------------------------------------
-- Exécution de la procédure stockée sur l''ensemble des bases de données
-------------------------------------------------------------------------------------

DECLARE @COMPTEUR int
DECLARE @Sql nvarchar(4000)

SET @COMPTEUR = 0

WHILE(@COMPTEUR <= (SELECT MAX(idx) FROM @alldb))
BEGIN
    DECLARE @colVar VARCHAR(50)

    SELECT @colVar = [NAME] FROM @alldb WHERE idx = @compteur

   	SET @SQl = ''USE ['' +@colvar+'']
						
						BEGIN TRY
							-- Tentative de la tâche.							
							EXEC sp_MSforeachtable @command1="print '''' Updating data for ?'''' UPDATE STATISTICS ? WITH FULLSCAN "
							PRINT ''''REUSSITE !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.MAJ 
								([date_up]
								, [incident_avere_up]
								, [nom_base_up]
								, [message_up]) 
								VALUES (getdate(), 0, DB_NAME(), ''''''''Réussite'''''''')'''')
			
						END TRY

						BEGIN CATCH
							-- Collecte de données en cas de non succès.
							PRINT ''''ECHEC !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.MAJ 
								([date_up], [incident_avere_up]
								, [nom_base_up]
								, [message_up]) 
								VALUES (getdate(), 1, DB_NAME(), ERROR_MESSAGE())'''')
						END CATCH; 
						''
									
			EXEC sp_executesql @sql

    SET @compteur = @compteur + 1
END', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Sauvegarde des BDD - Reorg - UpdteStats', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'0c96ebdc-ea17-49eb-b90f-103978841ed8'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO





--------------------------------------------------------------------------------------
---------                             CHECKDB                           --------------
--------------------------------------------------------------------------------------


USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Vérifier l'intégrité]    Script Date: 20/02/2015 10:59:23 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 20/02/2015 10:59:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Vérifier l''intégrité', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Partie du plan de maintenance Evolucare (vTSQL) : Vérifier l''intégrité des BDD.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Vérifier l'intégrité]    Script Date: 20/02/2015 10:59:23 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Vérifier l''intégrité', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Recensement des bases de données de l''instance
--------------------------------------------------------------------------------------

DECLARE @alldb TABLE (idx int identity(1,1), NAME varchar(50))
INSERT INTO @alldb 
    ([NAME]) 
	 EXEC sp_MSforeachDB ''USE [?] SELECT DB_NAME();''
	 

--------------------------------------------------------------------------------------
-- Exécution de la procédure stockée sur l''ensemble des bases de données
--------------------------------------------------------------------------------------

DECLARE @COMPTEUR int
SET @COMPTEUR = 1

WHILE(@COMPTEUR < (SELECT MAX(idx) FROM @alldb))
BEGIN
    DECLARE @colVar VARCHAR(50)

    SELECT @colVar = NAME FROM @alldb WHERE idx = @compteur

    EXEC dbo.geterror @DBName = @colvar; 

    SET @compteur = @compteur + 1
END', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Vérifier l''intégrité', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959, 
		@schedule_uid=N'df5e2319-2973-4066-ae1f-db7634a9ee5f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


--------------------------------------------------------------------------------------
---------                           NETTOYAGE                           --------------
--------------------------------------------------------------------------------------


USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Nettoyage de l'historique]    Script Date: 20/02/2015 11:00:26 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 20/02/2015 11:00:26 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Nettoyage de l''historique', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Partie du plan de maintenance Evolucare (vTSQL) : Nettoyage de l''historique et de la BDD SQLAlerts sur 30 jours.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Nettoyage de l'historique]    Script Date: 20/02/2015 11:00:26 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Nettoyage de l''historique', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
--------------------------------------------------------------------------------------
---------             PARTIE : NETTOYAGE DE L''HISTORIQUE                 -------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --



--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------
USE SQLAlerts
GO

DECLARE @retentiondate int
SET @retentiondate = (SELECT parametre FROM Configuration WHERE libelle_parametre = ''retention_his'')

BEGIN TRY
	-- Tentative de la tâche	
	DECLARE @jours DATETIME
	-- Rétention de l''historique définie sur 30 jours (@retentiondate voir table configuration)
	SET @jours = CONVERT(VARCHAR(10), DATEADD(dd, -@retentiondate, GETDATE()), 112)     
	-- Suppresion de l''historique des sauvegardes
	EXEC msdb.dbo.sp_delete_backuphistory @jours
	-- Suppression de l''historique de l''agent							
	EXEC msdb.dbo.sp_purge_jobhistory @Oldest_date = @jours					
	-- Suppresion de l''historique du plan de maintenance
	EXEC msdb.dbo.sp_maintplan_delete_log null,null, @oldest_time = @jours  

	-- Nettoyage de la base de données SQLAlerts
	DELETE FROM [dbo].[Cleaning_history] WHERE date_ch < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[Journal] WHERE date_log < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[MAJ] WHERE date_up < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[Rebuild] WHERE date_reb < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[Reorganize] WHERE date_reo < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[Sauvegarde] WHERE date_bak < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[T-SQL] WHERE date_tsql < DATEADD(day, -@retentiondate, GETDATE())
	DELETE FROM [dbo].[Performance] WHERE date_perf < DATEADD(day, -@retentiondate, GETDATE()) 

	PRINT ''REUSSITE !''
	EXEC (''INSERT INTO SQLAlerts.dbo.Cleaning_history 
		([date_ch]
		, [incident_avere_ch]
		, [nom_base_ch]
		, [message_ch]) 
		VALUES (getdate(), 0, DB_NAME(), ''''Réussite'''')'')
END TRY

BEGIN CATCH
	-- Collecte de données en cas d''échec. 
	PRINT ''ECHEC !''
	EXEC (''INSERT INTO SQLAlerts.dbo.Cleaning_history 
		([date_ch]
		, [incident_avere_ch]
		, [nom_base_ch]
		, [message_ch]) 
		VALUES (getdate(), 1, DB_NAME(), ERROR_MESSAGE())'')
END CATCH; 
', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Nettoyage de l''historique', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=200000, 
		@active_end_time=235959, 
		@schedule_uid=N'1525f48f-0f04-4bdd-b006-c8c33dba63c6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


--------------------------------------------------------------------------------------
---------                             REBUILD                           --------------
--------------------------------------------------------------------------------------


USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Reconstruction des index]    Script Date: 20/02/2015 11:01:47 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 20/02/2015 11:01:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Reconstruction des index', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Partie du plan de maintenance Evolucare (vTSQL) : Reconstruction des index.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Reconstruction des index]    Script Date: 20/02/2015 11:01:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Reconstruction des index', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=2, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
--------------------------------------------------------------------------------------
---------              PARTIE : RECONSTRUCTION DES INDEX                  ------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --



--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Connexion base
--------------------------------------------------------------------------------------

USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Recensement des bases de données de l''instance
--------------------------------------------------------------------------------------

DECLARE @alldb TABLE (idx int identity(1,1), NAME varchar(50))
INSERT INTO @alldb 
    ([NAME]) 

	 EXEC    sp_msforeachdb 
"IF      ''?''     NOT IN (''tempdb'')   BEGIN
        USE [?] SELECT DB_NAME();
END"

--------------------------------------------------------------------------------------
-- Exécution de la procédure stockée sur l''ensemble des bases de données
--------------------------------------------------------------------------------------

DECLARE @COMPTEUR int
DECLARE @Sql nvarchar(4000)

SET @COMPTEUR = 0

WHILE(@COMPTEUR <= (SELECT MAX(idx) FROM @alldb))
BEGIN
    DECLARE @colVar VARCHAR(50)

    SELECT @colVar = [NAME] FROM @alldb WHERE idx = @compteur

   	SET @SQl = ''USE ['' +@colvar+'']
						
						BEGIN TRY
							-- Tentative de la tâche.
							EXEC sp_MSforeachtable @command1="print ''''Rebuilding indexes for ?'''' SET QUOTED_IDENTIFIER ON; ALTER INDEX ALL ON ? REBUILD "
							PRINT ''''REUSSITE !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.Rebuild 
								([date_reb]
								, [incident_avere_reb]
								, [nom_base_reb]
								, [message_reb]) 
								VALUES (getdate(), 0, DB_NAME(), ''''''''Réussite'''''''')'''')
						END TRY

						BEGIN CATCH
							-- Collecte de données en cas de non succès.
							PRINT ''''ECHEC !''''
							EXEC (''''INSERT INTO SQLAlerts.dbo.Rebuild 
								([date_reb]
								, [incident_avere_reb]
								, [nom_base_reb]
								, [message_reb]) 
								VALUES (getdate(), 1, DB_NAME(), ERROR_MESSAGE())'''')
						END CATCH; 
						''
				
			EXEC sp_executesql @sql

    SET @compteur = @compteur + 1
END', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Reconstruction des index', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=64, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=50000, 
		@active_end_time=235959, 
		@schedule_uid=N'273f387a-b7cf-4ae1-8f69-481a9fd4d4ab'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


--------------------------------------------------------------------------------------
---------                  SAUVEGARDE ET NETTOYAGE DES LOG              --------------
--------------------------------------------------------------------------------------


USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Sauvegarde des LOG]    Script Date: 20/02/2015 11:02:15 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 20/02/2015 11:02:15 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Sauvegarde des LOG', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Partie du Plan de maintenance Evolucare (vTSQL) : Sauvegarde et Nettoyage des fichiers transactionnels (LOG).', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Sauvegarde des LOG]    Script Date: 20/02/2015 11:02:15 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Sauvegarde des LOG', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--------------------------------------------------------------------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------    PARTIE : SAUVEGARDE LOG + NETTOYAGE DE L''HISTORIQUE(TRN) ----------------
--------------------------------------------------------------------------------------


--------- sources de la structure des scripts :
--------- http://msdn.microsoft.com/
--------- http://technet.microsoft.com
--------- Les blogueurs MVP SQL SERVER Actif sur technet.microsoft.com
--------- Script sous SQL Server 2014 12.0.2000
--- Rédacteur de la présente procédure : Thomas TISSOT Technicien système Evolucare --


--------------------------------------------------------------------------------------
-----------------                   SCRIPT                         -------------------
--------------------------------------------------------------------------------------

--- /!\ VARIABLE A RENSEIGNER EVENTUELLEMENT : /!
---  @path utilisera l''EMPLACEMENT DU REPERTOIRE DES SAUVEGARDE configuré dans les paramètres
---  de l''instance. (base de registre après 1ère installation)
---  Vous pouvez configurer manuellement le chemin s''il n''est pas correct, 
---  Soit en renseignant la variable @PATH ici
---  Il doit être terminé par "\" Le répertoire doit exister.
---  Ou en executant le script CHANGER CHEMIN SAUVEGARDE pour changer le répertoire par défaut
---  Il doit être terminé par "\" Le répertoire doit exister.

---  @DeleteDate RETENTION DE LA SAUVEGARDE
---  (spécifier wk pour semaine à la place de day si necessaire)

USE SQLAlerts
GO

--------------------------------------------------------------------------------------
-- Déclaration des variables
--------------------------------------------------------------------------------------


DECLARE @name VARCHAR(50) -- nom base de données 
DECLARE @path VARCHAR(256) -- Chemin du répertoire de la sauvegarde   
DECLARE @fileName VARCHAR(256) -- nom du fichier  
DECLARE @fileDate VARCHAR(20) -- formatage de la date pour le nom du fichier
DECLARE @sql nvarchar(max)
DECLARE @timedelay INT
SET @timedelay = (SELECT parametre FROM Configuration WHERE libelle_parametre = ''retention_trn'')
DECLARE @DeleteDate DATETIME = DATEADD(day,-@timedelay,GETDATE()); -- Nombre de jours de la rétention
DECLARE @KOMP nvarchar(max) -- Compression active ou non
DECLARE @folder nvarchar(500) -- Chemin du dossier de sauvegarde final

--------------------------------------------------------------------------------------
-- Gestion FICHIER et répertoire de sauvegarde
--------------------------------------------------------------------------------------

-- Chemin de la sauvegarde par défaut
EXEC master.dbo.xp_instance_regread N''HKEY_LOCAL_MACHINE'',
N''Software\Microsoft\MSSQLServer\MSSQLServer'',N''BackupDirectory'',@path OUTPUT ;

SET @path = @path + CHAR(92) 
-- SET @path = CHAR(39) + @path + CHAR(39) 
-- SET @path = C:\Backupprint @path

-- Préparation du nom du fichier de sauvegarde 
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),'':'','''')


--------------------------------------------------------------------------------------
-- Procédure
--------------------------------------------------------------------------------------


DECLARE db_cursor CURSOR FOR  
	SELECT name
	FROM master.dbo.sysdatabases  
	WHERE name NOT IN (''master'',''model'',''msdb'',''tempdb'')  -- Exclusion des bases de données SYS
	AND DATABASEPROPERTYEX(name, ''Recovery'') = ''FULL''	  -- Exclusion des bases de données en mode de récupération SIMPLE ou BULK
	AND DATABASEPROPERTYEX(name, ''Status'') = ''ONLINE''     -- Exclusion des bases de données OFFLINE
	

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
 
WHILE @@FETCH_STATUS = 0   
BEGIN
		
	BEGIN TRY

		SET @folder = @path + @name
		
		DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT) -- Collecte de la structure
		INSERT INTO @DirTree(subdirectory, depth)
		EXEC master.sys.xp_dirtree @folder

		IF NOT EXISTS (SELECT 1 FROM @DirTree WHERE subdirectory = @name)
		EXEC master.dbo.xp_create_subdir @folder

		IF (SELECT value FROM sys.configurations WHERE name = ''backup compression default'') = 1
		BEGIN
	
			SET @fileName = @folder + CHAR(92) + @name + ''_'' + @fileDate + ''.TRN''  
			SET @KOMP = ''BACKUP LOG ['' + @name + ''] TO DISK = '' + CHAR(39) + @fileName + CHAR(39) + '' WITH NOFORMAT, NOINIT, COMPRESSION, CHECKSUM, STOP_ON_ERROR, STATS=10, SKIP, REWIND, NOUNLOAD''
			EXEC (@KOMP)
		END
		ELSE
		BEGIN
	
			SET @fileName = @folder + CHAR(92) + @name + ''_'' + @fileDate + ''.TRN''  
			SET @KOMP = ''BACKUP LOG ['' + @name + ''] TO DISK = '' + CHAR(39) + @fileName + CHAR(39) + '' WITH NOFORMAT, NOINIT, NO_COMPRESSION, CHECKSUM, STOP_ON_ERROR, STATS=10, SKIP, REWIND, NOUNLOAD''
			EXEC (@KOMP)
		END

		PRINT ''REUSSITE !''
		PRINT @name
		SET @SQL = ''INSERT INTO SQLAlerts.dbo.Journal 
			([date_log]
			, [incident_avere_log]
			, [nom_base_log]
			, [message_log]) 
			VALUES (getdate(), 0, @name, ''''Réussite'''')''

		EXEC sp_executesql @sql, N''@name nvarchar(max)'', @name
		 
		 -- Suppression des anciens fichiers TRN de sauvegarde en cas de succès.
		EXEC master.sys.xp_delete_file 0,@folder,''TRN'',@DeleteDate,0;
		EXEC master.sys.xp_delete_file 0,@path,''TRN'',@DeleteDate,0;
 
 	END TRY

	BEGIN CATCH
		-- collecte de données en cas d''erreur.
		PRINT ''ECHEC !''
		PRINT @name
		SET @SQL = ''INSERT INTO SQLAlerts.dbo.Journal 
			([date_log]
			, [incident_avere_log]
			, [nom_base_log]
			, [message_log]) 
			VALUES (getdate(), 1, @name, ERROR_MESSAGE())''

		EXEC sp_executesql @sql, N''@name nvarchar(max)'', @name
	END CATCH
	
	FETCH NEXT FROM db_cursor INTO @name   
	
END  
	
CLOSE db_cursor   
DEALLOCATE db_cursor


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Sauvegarde des LOG', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'95da5d05-0f27-4c2d-b3c1-ae23f4db4dfa'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


--------------------------------------------------------------------------------------
---------                    VERIFICATION PERFORMANCE                   --------------
--------------------------------------------------------------------------------------

USE [msdb]
GO

/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Vérification performance]    Script Date: 23/02/2015 09:09:06 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 23/02/2015 09:09:06 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Plan de maintenance Evolucare (v5TSQL).Vérification performance', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Plan de maintenance Evolucare (vTSQL).Vérification performance compteurs SQL, CPU, Mémoire, espace disque.', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Vérification Preformance]    Script Date: 23/02/2015 09:09:07 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Vérification Preformance', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=2, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE master
GO


/**
1=Buffer Cache Hit ratio
2=Page life expectancy
3=Free pages
4=Total RAM du serveur
5=Ram disponible du serveur
6=Taille du Buffer Pool
7=Taille Maximum de la mémoire allouée à l''instance
8=%Processeur-sqlserv.exe moyenne derniere heure
9=%Processeur-systemIdle moyenne derniere heure
10=%Processeur-autres processus moyenne derniere heure
Les données 8,9 et 10 sont liées de la façon suivante : 8+9+10 = 99-100%
**/


EXEC sp_configure ''Allow Updates'', 0;
RECONFIGURE WITH OVERRIDE;
GO


SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON

----------------------------------------------------------------------------------------
----------------               DECLARATION VARIABLES                     ---------------
----------------------------------------------------------------------------------------


DECLARE @hitratio int;
DECLARE @pagelife bigint;
DECLARE @freepages bigint;
DECLARE @exec nvarchar(max);
DECLARE @totalram nvarchar(100);
DECLARE @availableram int;
DECLARE @bufferpool decimal;
DECLARE @maxmemory sql_variant;
DECLARE @sao as INT;
DECLARE @oap as INT;


DECLARE @StartTime DATETIME = ''01/01/1900 00:00:00''
	,@EndTime DATETIME = ''01/01/2100 23:59:59''
	,@ShowDetails BIT = 1 -- 1 = True, 0 = False

DECLARE @ts_now BIGINT

DECLARE @Results TABLE
	(record_ID BIGINT NOT NULL
	,EventTime datetime NOT NULL
	,SQLProcessUtilization tinyint NOT NULL
	,SystemIdle tinyint NOT NULL
	,OtherProcessUtilization tinyint NOT NULL
  )  

DECLARE @hr int
DECLARE @fso int
DECLARE @drive char(1)
DECLARE @odrive int
DECLARE @TotalSize varchar(20) 
DECLARE @MB Numeric ; SET @MB = 1048576

SET @sao = (CONVERT(INT,(SELECT value FROM sys.configurations WHERE name = ''show advanced options'')));
SET @oap = (CONVERT(INT,(SELECT value FROM sys.configurations WHERE name = ''Ole Automation Procedures'')));




----------------------------------------------------------------------------------------
----------------            Activation des options avancées              ---------------
----------------------------------------------------------------------------------------

EXEC sp_configure ''show advanced options'', 1;
RECONFIGURE;
EXEC sp_configure ''Ole Automation Procedures'', 1;
RECONFIGURE;

----------------------------------------------------------------------------------------
----------------         CALCUL DU SEUIL BUFFER CACHE HIT RATIO          ---------------
----------------------------------------------------------------------------------------


SET @hitratio = (SELECT MIN(cntr_value)
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE ''%Buffer Manager%''
AND [counter_name] = ''Buffer cache hit ratio'') * 100 /  (SELECT cntr_value
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE ''%Buffer Manager%''
AND [counter_name] = ''Buffer cache hit ratio base'')



----------------------------------------------------------------------------------------
----------------         CALCUL DU SEUIL PAGE LIFE EXPECTANCY            ---------------
----------------------------------------------------------------------------------------




SET @pagelife = (SELECT MIN(cntr_value)
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE ''%Buffer Manager%''
AND [counter_name] = ''Page life expectancy'')



-----------------------------------------------------------------------------------------
----------------   CALCUL DU SEUIL FREE PAGES  ou FREE NODE     -------------------------
-----------------------------------------------------------------------------------------


if left(CAST(SERVERPROPERTY(''ProductVersion'')AS sysname),5) = ''10.50''  
OR left(CAST(SERVERPROPERTY(''ProductVersion'')AS sysname),5) = ''10.0.'' 

BEGIN

	SET @freepages = (SELECT MIN(cntr_value)
	FROM sys.dm_os_performance_counters
	WHERE [object_name] LIKE ''%Buffer Manager%'' 
	AND [counter_name] = ''Free pages'')
	
END
ELSE
BEGIN
	SET @freepages = (SELECT MIN(cntr_value)
	FROM sys.dm_os_performance_counters
	WHERE [object_name] LIKE ''%memory node%''
	AND [counter_name] = ''Free Node Memory (KB)'')
	SET @freepages = @freepages / 8
END



-----------------------------------------------------------------------------------------
----------------                      CHECK RAM                 -------------------------
-----------------------------------------------------------------------------------------

if left(CAST(SERVERPROPERTY(''ProductVersion'')AS sysname),5) = ''10.50''  
OR left(CAST(SERVERPROPERTY(''ProductVersion'')AS sysname),5) = ''10.0.'' 
BEGIN
	SET @exec = N''SELECT @totalram = (SELECT CEILING(physical_memory_in_bytes/1048576.0) FROM sys.dm_os_sys_info)''
	EXEC sp_executesql @exec, N''@totalram nvarchar(100) out'', @totalram out
	SET @availableram = (SELECT CEILING(available_physical_memory_kb/1024.0) FROM sys.dm_os_sys_memory)
END
ELSE
BEGIN
	SET @exec = N''SELECT @totalram = (SELECT CEILING(physical_memory_kb/1024.0) FROM sys.dm_os_sys_info)''
	EXEC sp_executesql @exec, N''@totalram nvarchar(100) out'', @totalram out
	SET @availableram = (SELECT CEILING(available_physical_memory_kb/1024.0) FROM sys.dm_os_sys_memory)
END

 
IF OBJECT_ID(''tempdb..#perfmon_counters'') is not null DROP TABLE #perfmon_counters 
SELECT * INTO #perfmon_counters FROM sys.dm_os_performance_counters
SET @bufferpool = (SELECT cntr_value/1024.0 FROM #perfmon_counters WHERE counter_name = ''Total Server Memory (KB)'' )


SET @exec = N''SELECT @maxmemory = (SELECT value FROM sys.configurations WHERE name like ''''max server memory (MB)'''')''
EXEC sp_executesql @exec, N''@maxmemory sql_variant out'', @maxmemory out


-----------------------------------------------------------------------------------------
----------------                      CHECK CPU                 -------------------------
-----------------------------------------------------------------------------------------



SELECT @ts_now = cpu_ticks / (cpu_ticks / ms_ticks)
FROM sys.dm_os_sys_info;

INSERT INTO 
	@Results
(	
	record_ID
	,EventTime
	,SQLProcessUtilization
	,SystemIdle
	,OtherProcessUtilization
)  
SELECT
    record_id
   ,DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS EventTime
   ,SQLProcessUtilization
   ,SystemIdle
   ,100 - SystemIdle - SQLProcessUtilization AS OtherProcessUtilization
FROM
    (
     SELECT
        record.value(''(./Record/@id)[1]'', ''int'') AS record_id
       ,record.value(''(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]'',
                     ''int'') AS SystemIdle
       ,record.value(''(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]'',
                     ''int'') AS SQLProcessUtilization
       ,TIMESTAMP
     FROM
        (
         SELECT
            TIMESTAMP
           ,CONVERT(XML, record) AS record
         FROM
            sys.dm_os_ring_buffers
         WHERE
            ring_buffer_type = N''RING_BUFFER_SCHEDULER_MONITOR''
            AND record LIKE ''% %''
			AND DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) BETWEEN @StartTime AND @EndTime
        ) AS x
    ) AS y

-----------------------------------------------------------------------------------------
----------------               CHECK FREE SPACE DISK            -------------------------
-----------------------------------------------------------------------------------------

CREATE TABLE #drives (drive char(1) PRIMARY KEY, FreeSpace int NULL,
TotalSize int NULL) INSERT #drives(drive,FreeSpace) EXEC
master.dbo.xp_fixeddrives EXEC @hr=sp_OACreate
''Scripting.FileSystemObject'',@fso OUT IF @hr <> 0 EXEC sp_OAGetErrorInfo
@fso
DECLARE dcur CURSOR LOCAL FAST_FORWARD
FOR SELECT drive from #drives ORDER by drive
OPEN dcur FETCH NEXT FROM dcur INTO @drive
WHILE @@FETCH_STATUS=0
BEGIN
EXEC @hr = sp_OAMethod @fso,''GetDrive'', @odrive OUT, @drive
IF @hr <> 0 EXEC sp_OAGetErrorInfo @fso EXEC @hr =
sp_OAGetProperty
@odrive,''TotalSize'', @TotalSize OUT IF @hr <> 0 EXEC sp_OAGetErrorInfo
@odrive UPDATE #drives SET TotalSize=@TotalSize/@MB WHERE
drive=@drive FETCH NEXT FROM dcur INTO @drive
End
Close dcur
DEALLOCATE dcur
EXEC @hr=sp_OADestroy @fso IF @hr <> 0 EXEC sp_OAGetErrorInfo @fso


-----------------------------------------------------------------------------------------
----------------                   RESULTAT                     -------------------------
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
----------------           Alimentation base SQLAlerts          -------------------------
-----------------------------------------------------------------------------------------


SELECT ''Buffer cache hit ratio'' as Info, @hitratio as Value
UNION 
SELECT ''Page Life Expectancy'', @pagelife
UNION
SELECT ''Free Pages'', @freepages
UNION
SELECT ''Available Server RAM_MB'', @availableram
UNION
SELECT ''Total Server RAM_MB'', @totalram
UNION
SELECT ''Buffer Pool Size'', @bufferpool
UNION
SELECT ''Maximum Memory Size allowed_MB'', @maxmemory 
UNION
SELECT ''AVG_SQLProcessUtilization%'', AVG(SQLProcessUtilization) FROM @Results WHERE EventTime BETWEEN (select dateadd(hh,-1,getdate())) AND GETDATE()	
UNION
SELECT ''AVG_SystemIdle%'', AVG(SystemIdle) FROM @Results WHERE EventTime BETWEEN (select dateadd(hh,-1,getdate())) AND GETDATE()	
UNION
SELECT ''AVG_OtherProcessUtilization%'', AVG(OtherProcessUtilization) FROM @Results WHERE EventTime BETWEEN (select dateadd(hh,-1,getdate())) AND GETDATE()
UNION
SELECT ''Total Drive Size_MB '' + drive, TotalSIze FROM #drives
UNION
SELECT ''Free Drive Size_MB '' + drive, FreeSpace FROM #drives



DROP TABLE #drives 


-----------------------------------------------------------------------------------------
----------------      Réinitialisation des options initiales    -------------------------
-----------------------------------------------------------------------------------------

EXEC sp_configure ''OLE Automation Procedures'', @oap;
EXEC sp_configure ''show advanced options'', @sao;', 
		@database_name=N'master', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Vérification Performance', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150220, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'b517e92a-1ad3-4c10-8a93-e5c0ed4bd03b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


