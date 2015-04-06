CREATE OR REPLACE PACKAGE FONCTIONS_UTILES IS
	FUNCTION isResponsable(idU utilisateur.id_user%TYPE, id_ens enseignement.id_enseignement%TYPE) RETURN BOOLEAN;
	FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT;
	FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER;
	FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean;
END FONCTIONS_UTILES;
/


CREATE OR REPLACE PACKAGE BODY FONCTIONS_UTILES IS

	-- Foncion qui prend en paramètre un id_user et un id_enseignement
		-- Renvoi vrai si l'id_user correspond à celle du professeur responsable de la formation correspondant à l'enseignement
		-- Renvoi faux sinon
	FUNCTION isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	 resp boolean; -- pas d'initialisation ?
	 id_prof formation.id_prof_responsable%type;
	BEGIN
	  SELECT id_prof_responsable into id_prof
	  FROM formation natural join semestre natural join enseignement
	  WHERE id_ens=enseignement.id_enseignement;

		IF id_prof=idU THEN
			resp:=true;
		END IF;

	  RETURN resp; -- booléen initialisé directement à false ? Parce que si on ne passe pas dans le if, il n'est initialisé ni dans le bloc BEGIN ni dans le DECLARE
	END isResponsable;


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi le coef (en float) d'un enseignement passé en paramètre
	FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT AS
		coef FLOAT := 0;
	BEGIN
		SELECT coef_enseignement INTO coef
		FROM ENSEIGNEMENT
		WHERE id_enseignement = id_ens;

		RETURN coef;
	END getCoefEnseignement;


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi l'id_semestre d'un enseignement donné
	FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER AS
		idSemmestre INTEGER;
	BEGIN
		SELECT id_semestre INTO idSemmestre
		FROM ENSEIGNEMENT
		WHERE id_enseignement = id_ens;

		RETURN idSemmestre;
	END getIDSemestre;
	


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




	--@Jeanne
	-- Procédure qui renvoie vrai s'il existe une ligne dans la table stats_enseignement_etudiant pour un étudiant, un enseignement et un groupe donné.
	FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
		bool_exists NUMBER(1);
	BEGIN
		SELECT CASE
			WHEN EXISTS (
				SELECT id_user
				FROM stats_enseignement_etudiant
				WHERE id_user = id_etu
				AND id_enseignement = id_ens
				AND id_groupe = id_gr
				)
				THEN 1
				ELSE 0
			END INTO bool_exists
		FROM dual;
		IF (bool_exists = 1) 
		THEN RETURN true;
		ELSE RETURN false;
		END IF;
	END is_stat_etu;
	




END FONCTIONS_UTILES;
/









-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 









CREATE OR REPLACE PACKAGE STATISTIQUES IS
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT);
END STATISTIQUES;
/


CREATE OR REPLACE PACKAGE BODY STATISTIQUES IS

	-- Procédure qui renvoi par le biais des paramètre la moyenne d'un élève à un semestre (id_user et id_groupe passés en paramètre) (moyenne CC, DS et total)
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT) IS
		coefTotalCC FLOAT := 0;
		coefTotalDS FLOAT := 0;
		coefTempEnseignement FLOAT := 0;

		CURSOR sesStatsEnseignement IS
			SELECT *
			FROM STATS_ENSEIGNEMENT_ETUDIANT
			WHERE id_user = idEleve AND id_groupe = sonGroupe;

		ligne_sesStatsEnseignement sesStatsEnseignement%ROWTYPE;

	BEGIN

		moyenneSemestreCC := 0;
		moyenneSemestreDS := 0;
		moyenneSemestreTotal := 0;


		FOR ligne_sesStatsEnseignement IN sesStatsEnseignement
		LOOP
			coefTempEnseignement := FONCTIONS_UTILES.getCoefEnseignement(ligne_sesStatsEnseignement.id_enseignement);
			IF ligne_sesStatsEnseignement.moy_etu_enseignement_CC IS NOT NULL THEN-- on ne tient pas compte d'une moyenne si elle n'est pas encore rentrée
				moyenneSemestreCC := moyenneSemestreCC + ligne_sesStatsEnseignement.moy_etu_enseignement_CC*coefTempEnseignement;
				coefTotalCC := coefTotalCC + coefTempEnseignement;
			END IF;

			IF ligne_sesStatsEnseignement.moy_etu_enseignement_DS IS NOT NULL THEN-- on ne tient pas compte d'une moyenne si elle n'est pas encore rentrée
				moyenneSemestreDS := moyenneSemestreDS + ligne_sesStatsEnseignement.moy_etu_enseignement_DS*coefTempEnseignement;
				coefTotalDS := coefTotalDS + coefTempEnseignement;
			END IF;
		END LOOP;

		moyenneSemestreCC := moyenneSemestreCC / coefTotalCC;
		moyenneSemestreDS := moyenneSemestreDS / coefTotalDS;
		moyenneSemestreTotal := (moyenneSemestreCC*0.4) + (moyenneSemestreDS*0.6);
	END calcul_moyenne_semestre;
	

				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


END STATISTIQUES;
/



