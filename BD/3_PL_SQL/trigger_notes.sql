--@Jeanne & Laurence
-- Trigger qui met à jour les statistiques sur les moyennes de l'étudiant après insertion d'une note
CREATE OR REPLACE TRIGGER moyenne_etudiant_enseignement
	AFTER INSERT ON notes
	FOR EACH ROW
DECLARE
	coef_CC number;
	coef_DS number;
	moyenneTotalTemp float;
	moyenneCC float;
	moyenneDS float;
BEGIN
	IF(:NEW.type_note = 'CC')
	THEN
		-- Si l'étudiant a déjà une moyenne de calulée, elle est mise à jour
		IF(fonctions_utiles.is_stat_etu(:NEW.id_user, :NEW.id_enseignement, :NEW.id_groupe))
		THEN
			
			-- Mise à jour de la moyenne du CC
			UPDATE stats_enseignement_etudiant
			SET moy_etu_enseignement_CC = (moy_etu_enseignement_CC * coef_total_CC + (:NEW.valeur_note * :NEW.coef_note)) / (coef_total_CC + :NEW.coef_note)
			WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement	AND id_groupe = :NEW.id_groupe;
			
			-- Mise à jour du coefficient total du CC
			UPDATE stats_enseignement_etudiant
			SET coef_total_CC = coef_total_CC + :NEW.coef_note
			WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
			
			-- Mise à jour de la moyenne totale (si l'étudiant a déjà une note de DS)
			SELECT moy_etu_enseignement_DS INTO moyenneDS
			FROM stats_enseignement_etudiant
			WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
			
			IF(moyenneDS is not null)
			THEN
				coef_CC := fonctions_utiles.getCoefTypeNote('CC');
				coef_DS := fonctions_utiles.getCoefTypeNote('DS');
				
				SELECT moy_etu_enseignement_CC INTO moyenneCC
				FROM stats_enseignement_etudiant
				WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
				moyenneTotalTemp := (moyenneCC * coef_CC + moyenneDS * coef_DS) / (coef_CC+coef_DS);
				UPDATE stats_enseignement_etudiant
				SET moy_etu_enseignement_total = moyenneTotalTemp
				WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
			END IF;
		
		ELSE -- Si l'étudiant n'a pas encore de moyenne, elle est créée à partir de la nouvelle note
			INSERT INTO stats_enseignement_etudiant
			VALUES(:NEW.id_user, :NEW.id_groupe, :NEW.id_enseignement, :NEW.valeur_note, :NEW.coef_note, NULL, NULL);
		END IF;
	END IF;
	
	IF(:NEW.type_note = 'DS')
	-- On concidère que si l'étudiant a une note de DS c'est qu'il a déjà eu des notes de CC, et donc qu'il est déjà présent dans la table de stats pour cet enseignement
	THEN
		-- Mise à jour de la moyenne DS (qui était NULL)
		UPDATE stats_enseignement_etudiant
		SET moy_etu_enseignement_DS = :NEW.valeur_note
		WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
		
		-- Calcul de la moyenne totale
		coef_CC := fonctions_utiles.getCoefTypeNote('CC');
		coef_DS := fonctions_utiles.getCoefTypeNote('DS');
		
		SELECT moy_etu_enseignement_CC INTO moyenneCC
		FROM stats_enseignement_etudiant
		WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
		moyenneTotalTemp := (moyenneCC * coef_CC + :NEW.valeur_note * coef_DS) / (coef_CC+coef_DS);
		UPDATE stats_enseignement_etudiant
		SET moy_etu_enseignement_total = moyenneTotalTemp
		WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
	END IF;
END;
/
-- Test
-- les INSERT de base crééent bien une ligne par enseignement et par élève
-- INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
-- 		(note.nextval, 12,1, 1, 'Interro n°x', to_date('2014-10-03', 'YYYY-MM-DD'), 20, 1, 'CC');
-- La moyenne CC de l'étudiant 12 pour l'enseignement 1 augmente -> ok
-- INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
-- (note.nextval, 20,1, 1, 'Interro n°ff', to_date('2014-10-03', 'YYYY-MM-DD'), 15, 1, 'DS');
-- Insertion de la moyenne DS et le la moyenne totale dans stats_enseignement_etudiant







-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 




--After UPDATE of valeur_note, coef_note for each row (dans le cas d'une modification d'une note)

--pas de calcul si on update autre chose que la note ou le coefficient de la note
--si c'est une note de type CC
--mise à jour de la moyenne (elle est forcément initialisée vu qu'on fait un update)
--moyenne = ( moyenne - (:OLD.note*:OLD.coef_note) + (:NEW.note*:NEW.coef_note) ) / (coef_total - :OLD.coef_note + :NEW.coef_note) (pas sur de la formule)
--si c'est une note de type DS
--copié collé de cette note dans l'attribut correspondant dans la table STATS_ENSEIGNEMENT_ETUDIANT (on écrase l'ancienne note)


--@Laurence
CREATE OR REPLACE TRIGGER calcul_moy_etu_ens_when_update BEFORE UPDATE OF valeur_note, coef_note ON NOTES FOR EACH ROW

DECLARE
	moyenneCC FLOAT;
	coeftotal FLOAT;
	moyenneDS float;
	coef_CC number;
	coef_DS number;
	moyenneTotalTemp float;
BEGIN

	SELECT coef_total_CC, moy_etu_enseignement_CC INTO coeftotal, moyenneCC
	FROM  STATS_ENSEIGNEMENT_ETUDIANT
	WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;

	IF(:NEW.type_note = 'CC') THEN
		moyenneCC :=(moyenneCC * coeftotal - (:OLD.valeur_note*:OLD.coef_note) + (:NEW.valeur_note*:NEW.coef_note))/ (coeftotal - :OLD.coef_note + :NEW.coef_note);
		coeftotal := coeftotal - :OLD.coef_note + :NEW.coef_note;
		UPDATE STATS_ENSEIGNEMENT_ETUDIANT 
		SET moy_etu_enseignement_CC = moyenneCC, coef_total_CC = coeftotal
		WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;
		
		-- Mise à jour de la moyenne totale (si l'étudiant a déjà une note de DS)
			SELECT moy_etu_enseignement_DS INTO moyenneDS
			FROM stats_enseignement_etudiant
			WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
			
			IF(moyenneDS is not null)
			THEN
				coef_CC := fonctions_utiles.getCoefTypeNote('CC');
				coef_DS := fonctions_utiles.getCoefTypeNote('DS');
				moyenneTotalTemp := (moyenneCC * coef_CC + moyenneDS * coef_DS) / (coef_CC+coef_DS);
				UPDATE stats_enseignement_etudiant
				SET moy_etu_enseignement_total = moyenneTotalTemp
				WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
			END IF;
	ELSE
		UPDATE STATS_ENSEIGNEMENT_ETUDIANT
		SET moy_etu_enseignement_DS = :NEW.valeur_note
		WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;
		
		-- Calcul de la moyenne totale
		coef_CC := fonctions_utiles.getCoefTypeNote('CC');
		coef_DS := fonctions_utiles.getCoefTypeNote('DS');
		
		SELECT moy_etu_enseignement_CC INTO moyenneCC
		FROM stats_enseignement_etudiant
		WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
		moyenneTotalTemp := (moyenneCC * coef_CC + :NEW.valeur_note * coef_DS) / (coef_CC+coef_DS);
		UPDATE stats_enseignement_etudiant
		SET moy_etu_enseignement_total = moyenneTotalTemp
		WHERE id_user = :NEW.id_user AND id_enseignement = :NEW.id_enseignement AND id_groupe = :NEW.id_groupe;
	END IF;

END;
/
-- Tests Unitaires
-- test sur les notes de id_user = 12 and id_groupe=1 and id_enseignement=1
-- test pour update d'une note de CC
-- on remplace une note de 12 par 15 (nouvelle moyenne = 15 car deux notes à 15)
-- update NOTES
-- set valeur_note = 15
-- where id_note=1;

-- -- on remplace une note de 15 par 10 coef 2 (nouvelle moyenne = 11,66 car 15 coef 1 et 10 coef 2)
-- update NOTES
-- set valeur_note = 10, coef_note=2
-- where id_note=1;

-- -- test pour update d'une note DS
-- update NOTES
-- set valeur_note = 15
-- where id_note = 27;










-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 




--@Raphael & Jeanne & Laurence
-- After DELETE for each row (dans le cas d'une suppression)

-- Exemple : un professeur veut supprimer une interrogation => cela supprimera les notes de tous les élèves du groupe pour cette interrogation là
	-- si c'est une note de type CC
		-- mise à jour de la moyenne (elle est forcément initialisée vu qu'on fait un delete)
		-- si "coeff_total" = ":OLD.coef_note"
			-- cela veut dire que la moyenne n'est calculée qu'à partir d'une seule note donc il va juste falloir la mettre à NULL (pas de division par zéro)
		-- sinon, calcul de la nouvelle moyenne
			-- moyenne = ( moyenne*coef_total - :OLD.note * :OLD.coef_note ) / ( coef_total - :OLD.coef_note )
	-- si c'est une note de type DS
		-- illogique de supprimer un DS donc gérer ca en java ou en trigger, mais empêcher la suppression d'une note de DS (seulement modifiable)


CREATE OR REPLACE TRIGGER calcul_moy_etu_ens_when_delete AFTER DELETE ON NOTES FOR EACH ROW
DECLARE
	coefTotalTemp FLOAT;
	moyenneDS float;
	moyenneCC float;
	coef_CC number;
	coef_DS number;
BEGIN
	SELECT coef_total_CC INTO coefTotalTemp
	FROM STATS_ENSEIGNEMENT_ETUDIANT
	WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;

	IF(:OLD.type_note = 'CC') THEN
		IF (coefTotalTemp = :OLD.coef_note) THEN
			UPDATE STATS_ENSEIGNEMENT_ETUDIANT
			SET moy_etu_enseignement_CC = NULL, coef_total_CC=0
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			
			-- S'il y avait une note de DS, la moyenne générale devient la note de DS
			SELECT moy_etu_enseignement_DS INTO moyenneDS
			FROM stats_enseignement_etudiant
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			IF(moyenneDS is not null)
			THEN
				UPDATE STATS_ENSEIGNEMENT_ETUDIANT
				SET moy_etu_enseignement_total = moyenneDS
				WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			END IF;
			
		ELSE
			SELECT moy_etu_enseignement_CC INTO moyenneCC
			FROM  STATS_ENSEIGNEMENT_ETUDIANT
			WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;
			moyenneCC := (moyenneCC*coefTotalTemp - :OLD.valeur_note*:OLD.coef_note) / (coefTotalTemp - :OLD.coef_note);
			UPDATE STATS_ENSEIGNEMENT_ETUDIANT
			SET moy_etu_enseignement_CC = moyenneCC, coef_total_CC = coef_total_CC-:OLD.coef_note
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			
			-- Mise à jour de la moyenne totale (si l'étudiant a une note de DS)
			SELECT moy_etu_enseignement_DS INTO moyenneDS
			FROM stats_enseignement_etudiant
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			IF(moyenneDS is not null)
			THEN
				coef_CC := fonctions_utiles.getCoefTypeNote('CC');
				coef_DS := fonctions_utiles.getCoefTypeNote('DS');
				UPDATE STATS_ENSEIGNEMENT_ETUDIANT
				SET moy_etu_enseignement_total = (moyenneCC*coef_CC+moyenneDS*coef_DS)/(coef_CC+coef_DS)
				WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
			END IF;
			
		END IF;
	-- Si c'est une note de DS, il faut mettre à null la moyenne DS et la moyenne totale dans stats_enseignement_etudiant
	ELSE
		UPDATE stats_enseignement_etudiant
		SET moy_etu_enseignement_DS = null, moy_etu_enseignement_total = null
		WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
	END IF;
END;
/

-- Test
--delete from notes where id_note = 14;
	-- (note d'un id_user=12 dans id_enseignement=1 et id_semestre=1)
	-- Il a deux notes, 12 et 15, et on supprime le 15, sa moyenne passe de 13,5 à 12 donc ok
--delete from notes where id_note = 1;
	-- On supprime sa deuxième note pour cette matière et ce semestre
	-- Normalement sa moyenne passe à NULL et son coef total à 0
	-- Ca marche















