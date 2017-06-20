--------------------------------------------------------------------------------------
---------------------              UPDATE                 ----------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------                         DESCRIPTIF                          ----------------
--------------------------------------------------------------------------------------

--Cette mise à jour applique une correction améliorant la stabilité de la configuration

--Le script déployé à sur le serveur FTP SQLAlertsVX.sql est à jour
--et ne necessite pas l'application de cette mise à jour.

--Les copies du script SQLAlerts.sql doivent être détruites car elles
--ne contiennent pas la correction.

--le script ne s'execute qu'une seule fois.
--/!\ VERIFIER QUE LE SERVICE AGENT SQL SERVER est bien démarré /!\

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

