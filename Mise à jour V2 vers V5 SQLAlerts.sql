--------------------------------------------------------------------------------------
---------------------              UPDATE                 ----------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------                         DESCRIPTIF                          ----------------
--------------------------------------------------------------------------------------

--Cette mise à jour applique une correction améliorant la stabilité des sauvegardes
--Cette mise à jour est critique et doit être appliquée chez tous nos clients

--Le script déployé à sur le serveur FTP Procedure MAIN - SQLAlerts.sql est à jour
--et ne necessite pas l'application de cette mise à jour.

--Les copies du script Procedure MAIN - SQLAlerts.sql doivent être détruites car elles
--ne contiennent pas la correction.

--le script ne s'execute qu'une seule fois.
--/!\ VERIFIER QUE LE SERVICE AGENT SQL SERVER est bien démarré /!\

--------------------------------------------------------------------------------------
---------       Récupération des anciens paramètres actuels          -----------------
--------------------------------------------------------------------------------------



USE msdb
Go

DECLARE @sche_id VARCHAR(50)
DECLARE @Startime VARCHAR(50)
DECLARE @fq_type VARCHAR(50)
DECLARE @fq_interval VARCHAR(50)
DECLARE @fq_subday_type VARCHAR(50)
DECLARE @fq_subday_interval VARCHAR(50)
DECLARE @fq_relative_interval VARCHAR(50)
DECLARE @fq_recurrence_factor VARCHAR(50)

DECLARE @procSQL nvarchar(MAX)
	SET @procSQL = N'
		SELECT 	schedule_id, active_start_time, freq_type, freq_interval, freq_subday_type, freq_subday_interval, freq_relative_interval, freq_recurrence_factor
		FROM dbo.sysschedules
		WHERE schedule_id = ( 
			SELECT schedule_id FROM dbo.sysjobschedules WHERE job_id = ( 
				SELECT job_id
				FROM dbo.sysjobs
				WHERE dbo.sysjobs.Name = ''Plan de maintenance Evolucare (v2TSQL).Sauvegarde des BDD''
			)
		)'
	

IF EXISTS
(
	SELECT	*
	FROM	INFORMATION_SCHEMA.TABLES
	WHERE	TABLE_SCHEMA = 'dbo'
	AND	TABLE_NAME = 'majjob'
)
BEGIN
	DROP TABLE dbo.majjob
END
ELSE
BEGIN
	CREATE TABLE dbo.majjob
		([sche_id] VARCHAR(50) NOT NULL,
		[Startime] VARCHAR(50) NOT NULL ,
		[fq_type] VARCHAR(50) NOT NULL ,
		[fq_interval] VARCHAR(50) NOT NULL ,
		[fq_subday_type] VARCHAR(50) NOT NULL ,
		[fq_subday_interval] VARCHAR(50) NOT NULL ,
		[fq_relative_interval] VARCHAR(50) NOT NULL ,
		[fq_recurrence_factor] VARCHAR(50) NOT NULL)
	
	INSERT INTO dbo.majjob
		([sche_id],
		[Startime],
		[fq_type],
		[fq_interval],
		[fq_subday_type],
		[fq_subday_interval],
		[fq_relative_interval],
		[fq_recurrence_factor])
		EXEC (@procSQL);
END

SET @sche_id = (SELECT sche_id FROM dbo.majjob)
SET @Startime = (SELECT Startime FROM dbo.majjob)
SET @fq_type = (SELECT fq_type FROM dbo.majjob)
SET @fq_interval = (SELECT fq_interval FROM dbo.majjob)
SET @fq_subday_type = (SELECT fq_subday_type FROM dbo.majjob)
SET @fq_subday_interval = (SELECT fq_subday_interval FROM dbo.majjob)
SET @fq_relative_interval = (SELECT fq_relative_interval FROM dbo.majjob)
SET @fq_recurrence_factor = (SELECT fq_recurrence_factor FROM dbo.majjob)

GO

--------------------------------------------------------------------------------------
------------                 Supression du code buggé                -----------------
--------------------------------------------------------------------------------------

EXEC sp_delete_job
	@job_name = N'Plan de maintenance Evolucare (v2TSQL).Sauvegarde des BDD';

--------------------------------------------------------------------------------------
------------                 Mise à jour du JOB                      -----------------
--------------------------------------------------------------------------------------


/****** Object:  Job [Plan de maintenance Evolucare (v5TSQL).Sauvegarde des BDD]    Script Date: 24/07/2015 14:12:49 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 24/07/2015 14:12:49 ******/
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
/****** Object:  Step [Sauvegarde et Nettoyage]    Script Date: 24/07/2015 14:12:50 ******/
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
/****** Object:  Step [Reorganisation]    Script Date: 24/07/2015 14:12:50 ******/
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
/****** Object:  Step [Mise à jour des Statistiques]    Script Date: 24/07/2015 14:12:50 ******/
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
------------                 Rétablissement des paramètres           -----------------
--------------------------------------------------------------------------------------

DECLARE @sche_id INT
DECLARE @Startime INT
DECLARE @fq_type VARCHAR(50)
DECLARE @fq_interval VARCHAR(50)
DECLARE @fq_subday_type VARCHAR(50)
DECLARE @fq_subday_interval VARCHAR(50)
DECLARE @fq_relative_interval VARCHAR(50)
DECLARE @fq_recurrence_factor VARCHAR(50)

SET @sche_id = (SELECT sche_id FROM dbo.majjob)
SET @Startime = (SELECT Startime FROM dbo.majjob)
SET @fq_type = (SELECT fq_type FROM dbo.majjob)
SET @fq_interval = (SELECT fq_interval FROM dbo.majjob)
SET @fq_subday_type = (SELECT fq_subday_type FROM dbo.majjob)
SET @fq_subday_interval = (SELECT fq_subday_interval FROM dbo.majjob)
SET @fq_relative_interval = (SELECT fq_relative_interval FROM dbo.majjob)
SET @fq_recurrence_factor = (SELECT fq_recurrence_factor FROM dbo.majjob)

Exec msdb.dbo.sp_update_schedule
 --@schedule_id = @sche_id,
 @name = 'Sauvegarde des BDD - Reorg - UpdteStats',
 @freq_type = @fq_type,
 @freq_interval = @fq_interval,
 @active_start_time = @Startime,
 @freq_subday_type = @fq_subday_type,
 @freq_subday_interval = @fq_subday_interval,
 @freq_relative_interval = @fq_relative_interval,
 @freq_recurrence_factor = @fq_recurrence_factor;

DROP TABLE dbo.majjob



--------------------------------------------------------------------------------------
---------       Récupération des anciens paramètres actuels          -----------------
--------------------------------------------------------------------------------------
USE SQLAlerts
Go

IF EXISTS
(
	
	SELECT	*
	FROM	INFORMATION_SCHEMA.TABLES
	WHERE	TABLE_SCHEMA = 'dbo'
	AND	TABLE_NAME = 'Configuration'
)
BEGIN

	DECLARE @retbak INT
	DECLARE @rettrn INT
	DECLARE @rethis INT

	SET @retbak = (SELECT TOP 1 parametre FROM dbo.Configuration WHERE libelle_parametre = 'retention_bak')
	SET @rettrn = (SELECT TOP 1 parametre FROM dbo.Configuration WHERE libelle_parametre = 'retention_trn')
	SET @rethis = (SELECT TOP 1 parametre FROM dbo.Configuration WHERE libelle_parametre = 'retention_his')

	DECLARE @countline INT
	SET @countline = (SELECT COUNT(*) FROM dbo.Configuration)

--------------------------------------------------------------------------------------
---------              Nettoyage et mise à jour de la table          -----------------
--------------------------------------------------------------------------------------

	IF @countline > 3
	BEGIN
		DELETE FROM dbo.Configuration

		INSERT INTO [dbo].[Configuration](
		[libelle_parametre]
		,[parametre]
		,[info]
		)
		VALUES 
		('retention_bak',	@retbak,	'nombre de jours de rétention fichiers de sauvegarde .BAK'),
		('retention_trn',	@rettrn,	'nombre de jours de rétention fichiers journal de sauvegarde .TRN'),
		('retention_his',	@rethis,	'nombre de jours de rétention de l''historique conservée au sein de SQLAlerts et des journaux dans SQL SERVER')
		--,('version',	   '1.2.25022015',	'Version du logiciel')
		;
		PRINT @retbak
		PRINT @retbak
		PRINT @retbak
	END
END
GO	

--------------------------------------------------------------------------------------
---------          Suppression de la tâche de reconstruction         -----------------
--------------------------------------------------------------------------------------
USE msdb
go

EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (vTSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v2TSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v3TSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v4TSQL).Reconstruction des index';

