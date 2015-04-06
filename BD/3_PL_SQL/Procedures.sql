--@Raphael
-- Procédure qui renvoi par le biais des paramètre la moyenne d'un élève à un semestre (moyenne CC, DS et total)
-- Package STATISTIQUES
CREATE OR REPLACE PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT) IS
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
/


-- Test unitaire

-- INSERT INTO ENSEIGNEMENT VALUES(2, 1,'Mathématiques', 1, 2);
-- INSERT INTO GROUPE_SUIT_ENSEIGNEMENT VALUES (1,2);

-- INSERT INTO NOTES VALUES (300, 12, 1, 2, 'Interro1', SYSDATE, 14, 1, 0, 0, 'CC');
-- INSERT INTO NOTES VALUES (301, 12, 1, 2, 'Interro2', SYSDATE, 14, 1, 0, 0, 'CC');
-- INSERT INTO NOTES VALUES (302, 12, 1, 2, 'DS', SYSDATE, 10, 1, 0, 0, 'DS');



-- DECLARE
-- 	moyenneSemestreCC FLOAT := 0;
-- 	moyenneSemestreDS FLOAT := 0;
-- 	moyenneSemestreTotal FLOAT := 0;
-- BEGIN
-- 	calcul_moyenne_semestre (12, 1, moyenneSemestreCC, moyenneSemestreDS, moyenneSemestreTotal);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreCC (attentu = 13,7) : ' || moyenneSemestreCC);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreDS (attendu = 11,2) : ' || moyenneSemestreDS);
--  	DBMS_OUTPUT.PUT_LINE('moyenneSemestreTotal (attendu = 12,2) : ' || moyenneSemestreTotal);
--  END;
--  /





-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 












