--@Raphael
-- Procédure qui renvoi par le biais des paramètre la moyenne d'un élève à un semestre (moyenne CC, DS et total)
-- Package STATISTIQUES
CREATE OR REPLACE PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, idEns ENSEIGNEMENT.id_enseignement%TYPE, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT) IS
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
/


-- Test unitaire -- 


-- DECLARE
-- 	moyenneSemestreCC FLOAT := 0;
-- 	moyenneSemestreDS FLOAT := 0;
-- 	moyenneSemestreTotal FLOAT := 0;
-- BEGIN
-- 	calcul_moyenne_semestre (12, 1, moyenneSemestreCC, moyenneSemestreDS, moyenneSemestreTotal);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreCC (attentu = ?) : ' || moyenneSemestreCC);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreDS (attendu = ?) : ' || moyenneSemestreDS);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreTotal (attendu = ?) : ' || moyenneSemestreTotal);
--  END;




-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 






##### Supression d'une interrogation de contrôle continu de la part d'un professeur
--Scénario : 
--	- Professeur gère ses enseignement => il en sélectionne un (on a l'id_enseignement)
--	- Il sélectionne un des groupes qui suit cet enseignement (on a l'id_groupe)
--	- Il a alors la liste des interrogations
--		- Grâce à `CONSTRAINT UNIQUE_LIBELLE_INTERROGATION UNIQUE (id_groupe, libelle_interrogation, id_enseignement)`, 
--         on sait qu'il n'y aura pas deux même libelle_interrogation pour un groupe et un enseignement donné
--		- Il clique sur supprimer l'interrogation (on ne sait jamais, des fois qu'elle soit trop mauvaise ^^)
--			- Possibilité de ne proposer cette option que pour le prof responsable
--		- Pour chaque id_note qui match le libellé, le groupe et l'enseignement, supprimer la note

--@laurence
CREATE OR REPLACE PROCEDURE supprInterro (id_enseign INTEGER, id_group INTEGER, libelle VARCHAR) IS
	suppr INTEGER;

	CURSOR curseurInterro IS

	SELECT id_enseignement, id_group, libelle_interrogation, id_note
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
/

--test
-- DECLARE
--   ID_ENSEIGNEMENT NUMBER;
--   ID_GROUPE NUMBER;
--   LIBELLE_INTERROGATION VARCHAR2(200);
-- BEGIN
--   ID_ENSEIGNEMENT := 5;
--   ID_GROUPE := 1;
--   LIBELLE_INTERROGATION :="Interro d'architecture n°1";

--   SUPPRINTERRO(
--     ID_ENSEIGNEMENT,
--     ID_GROUPE,
--     LIBELLE_INTERROGATION
--   );
-- --rollback; 
-- END;




-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 


-- Procédure open_semester qui ouvre les semestres qui ont besoin d'être ouverts
--- Sélectionner tous les semestres qui ont semestre_ouvert à false
--	+ Si date_debut ≤ SYSDATE alors le mettre à vrai
--	+ Sinon ne rien faire

--@laurence
CREATE OR REPLACE PROCEDURE open_semester IS
	sem BOOLEAN;

	CURSOR curseurdate IS
		SELECT id_semestre, date_debut
		FROM semestre
		WHERE semestre_ouvert = 0
		FOR UPDATE;

	ligne curseurdate%ROWTYPE;

BEGIN
	FOR ligne IN curseurdate LOOP
		IF ligne.date_debut <= TO_DATE(SYSDATE, 'DD/MM/YY') THEN 
			UPDATE semestre SET semestre_ouvert = 1
			WHERE CURRENT OF curseurdate;
		END IF;
	END LOOP;
	COMMIT;
END open_semester;

--Test
-- BEGIN
--   OPEN_SEMESTER();
-- --rollback; 
-- END;






-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 


##### Procédure close_semester qui ferme les semestres qui ont besoin d'être fermés
--- Sélectionner tous les semestres qui ont semestre_termine à false
--	+ Si date_fin ≤ SYSDATE alors le mettre à vrai
--	+ Sinon ne rien faire

--@laurence
create or replace PROCEDURE close_semester IS
	sem BOOLEAN;

	CURSOR curseurdate IS
		SELECT id_semestre, date_fin
		FROM semestre
		WHERE semestre_termine = 0
		FOR UPDATE;

	ligne curseurdate%ROWTYPE;

BEGIN
	FOR ligne IN curseurdate LOOP
		IF ligne.date_fin <= TO_DATE(SYSDATE, 'DD/MM/YY') THEN 
			UPDATE semestre SET semestre_termine = 1
			WHERE CURRENT OF curseurdate;
		END IF;
	END LOOP;
	COMMIT;
END close_semester;
/

--Test
-- BEGIN
--   CLOSE_SEMESTER();
-- --rollback; 
-- END;














