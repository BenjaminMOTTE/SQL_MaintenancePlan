--------------------------------------------------------------------------------------
---------------------              UPDATE                 ----------------------------
---------------------    Plan de Maintenance EVOLUCARE    ----------------------------
---------             Compatible SQL 2008R2 - 2012 - 2014                   ----------
--------------------------------------------------------------------------------------
---------                         DESCRIPTIF                          ----------------
--------------------------------------------------------------------------------------

--Cette mise � jour applique une correction am�liorant la stabilit� de la configuration

--Le script d�ploy� � sur le serveur FTP SQLAlertsVX.sql est � jour
--et ne necessite pas l'application de cette mise � jour.

--Les copies du script SQLAlerts.sql doivent �tre d�truites car elles
--ne contiennent pas la correction.

--le script ne s'execute qu'une seule fois.
--/!\ VERIFIER QUE LE SERVICE AGENT SQL SERVER est bien d�marr� /!\

--------------------------------------------------------------------------------------
---------       R�cup�ration des anciens param�tres actuels          -----------------
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
---------              Nettoyage et mise � jour de la table          -----------------
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
		('retention_bak',	@retbak,	'nombre de jours de r�tention fichiers de sauvegarde .BAK'),
		('retention_trn',	@rettrn,	'nombre de jours de r�tention fichiers journal de sauvegarde .TRN'),
		('retention_his',	@rethis,	'nombre de jours de r�tention de l''historique conserv�e au sein de SQLAlerts et des journaux dans SQL SERVER')
		--,('version',	   '1.2.25022015',	'Version du logiciel')
		;
		PRINT @retbak
		PRINT @retbak
		PRINT @retbak
	END
END
GO	

--------------------------------------------------------------------------------------
---------          Suppression de la t�che de reconstruction         -----------------
--------------------------------------------------------------------------------------
USE msdb
go

EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (vTSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v2TSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v3TSQL).Reconstruction des index';
EXEC sp_delete_job	@job_name = N'Plan de maintenance Evolucare (v4TSQL).Reconstruction des index';

