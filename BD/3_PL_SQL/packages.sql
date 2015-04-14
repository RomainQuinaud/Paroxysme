CREATE OR REPLACE PACKAGE FONCTIONS_UTILES IS
	FUNCTION isResponsable(idU utilisateur.id_user%TYPE, id_ens enseignement.id_enseignement%TYPE) RETURN BOOLEAN;
	FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT;
	FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER;
	FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean;
	FUNCTION is_stat_sem_etu (id_etu IN etudiant.id_user%type, id_sem IN semestre.id_semestre%type, id_gr IN groupe.id_groupe%type) RETURN boolean;
	FUNCTION getCoefTypeNote (unType TYPE_NOTE.type_note%TYPE) RETURN FLOAT;
	PROCEDURE supprInterro (id_enseign ENSEIGNEMENT.id_enseignement%TYPE, id_group GROUPE.id_groupe%TYPE, libelle NOTES.libelle_interrogation%TYPE);
	PROCEDURE open_semester;
	PROCEDURE close_semester;
	PROCEDURE updateMoyEnsGenerale (idUser UTILISATEUR.id_user%TYPE, idEns ENSEIGNEMENT.id_enseignement%TYPE, idGroupe GROUPE.id_groupe%TYPE, newMoy FLOAT);
END FONCTIONS_UTILES;
/


CREATE OR REPLACE PACKAGE BODY FONCTIONS_UTILES IS

	-- Foncion qui prend en paramètre un id_user et un id_enseignement
		-- Renvoi vrai si l'id_user correspond à celle du professeur responsable de la formation correspondant à l'enseignement
		-- Renvoi faux sinon
	FUNCTION isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	 resp boolean := false; 
	 id_prof formation.id_prof_responsable%type;
	BEGIN
	  SELECT id_prof_responsable into id_prof
	  FROM formation natural join semestre natural join enseignement
	  WHERE enseignement.id_enseignement = id_ens;

		IF id_prof=idU THEN
			resp:=true;
		END IF;

	  RETURN resp; 
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




	-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_enseignement_etudiant pour un étudiant, un enseignement et un groupe donné.
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
	
	
				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --
	
	--@Jeanne
	-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_semestre_etudiant pour un étudiant, un semestre et un groupe donné.
	FUNCTION is_stat_sem_etu (id_etu IN etudiant.id_user%type, id_sem IN semestre.id_semestre%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
	bool_exists NUMBER(1);
	BEGIN
		SELECT CASE
		WHEN EXISTS (
				SELECT id_user
				FROM stats_semestre_etudiant
				WHERE id_user = id_etu
				AND id_semestre = id_sem
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
	END is_stat_sem_etu;
	

				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi le coef général selon le type de note (DS ou CC)
	FUNCTION getCoefTypeNote (unType TYPE_NOTE.type_note%TYPE) RETURN FLOAT IS
		coefGeneral FLOAT;
	BEGIN
		SELECT coef_general INTO coefGeneral
		FROM TYPE_NOTE
		WHERE upper(type_note) = upper(unType);

		RETURN coefGeneral;
	END getCoefTypeNote;



				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



	--##### Supression d'une interrogation de contrôle continu de la part d'un professeur
	--Scénario : 
	--	- Professeur gère ses enseignement => il en sélectionne un (on a l'id_enseignement)
	--	- Il sélectionne un des groupes qui suit cet enseignement (on a l'id_groupe)
	--	- Il a alors la liste des interrogations
	--		- Grâce à `CONSTRAINT UNIQUE_LIBELLE_INTERROGATION UNIQUE (id_groupe, libelle_interrogation, id_enseignement, id_user)`, 
	--         on sait qu'il n'y aura pas deux même libelle_interrogation pour un groupe et un enseignement donné
	--		- Il clique sur supprimer l'interrogation (on ne sait jamais, des fois qu'elle soit trop mauvaise ^^)
	--			- Possibilité de ne proposer cette option que pour le prof responsable ??
	--		- Pour chaque id_note qui match le libellé, le groupe et l'enseignement, supprimer la note

	--@laurence
	PROCEDURE supprInterro (id_enseign ENSEIGNEMENT.id_enseignement%TYPE, id_group GROUPE.id_groupe%TYPE, libelle NOTES.libelle_interrogation%TYPE) IS

		CURSOR curseurInterro IS
			SELECT id_enseignement, id_groupe, libelle_interrogation, id_note
			FROM NOTES n
			WHERE n.id_enseignement = id_enseign AND n.id_groupe = id_group AND n.libelle_interrogation = libelle
			FOR UPDATE;

		ligne curseurInterro%ROWTYPE;

	BEGIN
		FOR ligne IN curseurInterro LOOP
			DELETE FROM NOTES WHERE id_note = ligne.id_note;
		END LOOP;
		COMMIT;
	END supprInterro;





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



	-- Procédure open_semester qui ouvre les semestres qui ont besoin d'être ouverts
	--- Sélectionner tous les semestres qui ont semestre_ouvert à false
	--	+ Si date_debut ≤ SYSDATE alors le mettre à vrai
	--	+ Sinon ne rien faire

	--@laurence
	PROCEDURE open_semester IS

		CURSOR curseurDateToOpen IS
			SELECT id_semestre, date_debut
			FROM semestre
			WHERE semestre_ouvert = 0
			FOR UPDATE;

		ligne curseurDateToOpen%ROWTYPE;

	BEGIN
		FOR ligne IN curseurDateToOpen LOOP
			IF ligne.date_debut <= TO_DATE(SYSDATE, 'YYYY-MM-DD') THEN 
				UPDATE semestre
				SET semestre_ouvert = 1
				WHERE CURRENT OF curseurDateToOpen;
			END IF;
		END LOOP;
		COMMIT;
	END open_semester;





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




	--##### Procédure close_semester qui ferme les semestres qui ont besoin d'être fermés
	--- Sélectionner tous les semestres qui ont semestre_termine à false
	--	+ Si date_fin ≤ SYSDATE alors le mettre à vrai
	--	+ Sinon ne rien faire

	--@laurence
	PROCEDURE close_semester IS

		CURSOR curseurDateToClose IS
			SELECT id_semestre, date_fin
			FROM semestre
			WHERE semestre_termine = 0
			FOR UPDATE;

		ligne curseurDateToClose%ROWTYPE;

	BEGIN
		FOR ligne IN curseurDateToClose LOOP
			IF ligne.date_fin <= TO_DATE(SYSDATE, 'YYYY-MM-DD') THEN 
				UPDATE semestre
				SET semestre_termine = 1
				WHERE CURRENT OF curseurDateToClose;
			END IF;
		END LOOP;
		COMMIT;
	END close_semester;







				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



--##### Procedure d'update de la table STATS_ENSEIGNEMENT_ETUDIANT afin d'eviter une erreur de "mutating table" avec le trigger moy_ens_total_when_update_DS
--- Déclaration de la procédure avec "pragma autonomous_transaction" (attention aux boucles infinies !!)

--@Raphael

PROCEDURE updateMoyEnsGenerale (idUser UTILISATEUR.id_user%TYPE, idEns ENSEIGNEMENT.id_enseignement%TYPE, idGroupe GROUPE.id_groupe%TYPE, newMoy FLOAT) IS PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	UPDATE stats_enseignement_etudiant
	SET moy_etu_enseignement_total = newMoy
	WHERE id_user = idUser
	AND id_enseignement = idEns
	AND id_groupe = idGroupe;

	COMMIT;
END updateMoyEnsGenerale;





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




END FONCTIONS_UTILES;
/	









-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 









CREATE OR REPLACE PACKAGE STATISTIQUES IS
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, idEns ENSEIGNEMENT.id_enseignement%TYPE, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT);
END STATISTIQUES;
/


CREATE OR REPLACE PACKAGE BODY STATISTIQUES IS

	-- Procédure qui renvoi par le biais des paramètre la moyenne d'un élève à un semestre (id_user et id_groupe passés en paramètre) (moyenne CC, DS et total)
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, idEns ENSEIGNEMENT.id_enseignement%TYPE, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT) IS
		coefTotalCC FLOAT := 0;
		coefTotalDS FLOAT := 0;
		coefTempEnseignement FLOAT := 0;
		idSemestre INTEGER := FONCTIONS_UTILES.getIDSemestre(idEns);

		CURSOR sesStatsEnseignement IS
			SELECT *
			FROM STATS_ENSEIGNEMENT_ETUDIANT natural join GROUPE_SUIT_ENSEIGNEMENT NATURAL JOIN ENSEIGNEMENT NATURAL JOIN SEMESTRE
			WHERE id_user = idEleve AND id_groupe = sonGroupe AND id_semestre = idSemestre; -- on ne veut ses stats que pour un semestre donné

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
		moyenneSemestreTotal := (moyenneSemestreCC*FONCTIONS_UTILES.getCoefTypeNote('CC')) + (moyenneSemestreDS*FONCTIONS_UTILES.getCoefTypeNote('DS'));
	END calcul_moyenne_semestre;

	

				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


END STATISTIQUES;
/



