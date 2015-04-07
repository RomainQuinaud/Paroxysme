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












