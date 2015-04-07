--@Jeanne
-- Trigger qui met à jour les statistiques sur les moyennes de l'étudiant après insertion d'une note
CREATE OR REPLACE TRIGGER moyenne_etudiant_enseignement
	AFTER INSERT ON notes
	FOR EACH ROW
BEGIN
	IF(:NEW.type_note = 'CC')
	THEN
		-- Si l'étudiant a déjà une moyenne de calulée, elle est mise à jour
		IF(fonctions_utiles.is_stat_etu(:NEW.id_user, :NEW.id_enseignement, :NEW.id_groupe))
		THEN
			-- Mise à jour du coefficient total du CC
			UPDATE stats_enseignement_etudiant
			SET coef_total_CC = coef_total_CC + :NEW.coef_note
			WHERE id_user = :NEW.id_user
			AND id_enseignement = :NEW.id_enseignement
			AND id_groupe = :NEW.id_groupe;
			-- Mise à jour de la moyenne du CC
			UPDATE stats_enseignement_etudiant
			SET moy_etu_enseignement_CC = (moy_etu_enseignement_CC + (:NEW.valeur_note * :NEW.coef_note)) / (coef_total_CC)
			WHERE id_user = :NEW.id_user
			AND id_enseignement = :NEW.id_enseignement
			AND id_groupe = :NEW.id_groupe;
		
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
		WHERE id_user = :NEW.id_user
		AND id_enseignement = :NEW.id_enseignement
		AND id_groupe = :NEW.id_groupe;
	END IF;
END;









-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 














-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 




--@Raphael
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
BEGIN
	SELECT coef_total_CC INTO coefTotalTemp
	FROM STATS_ENSEIGNEMENT_ETUDIANT
	WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;

	IF(:OLD.type_note = 'CC') THEN
		IF (coefTotalTemp = :OLD.coef_note) THEN
			UPDATE STATS_ENSEIGNEMENT_ETUDIANT
			SET moy_etu_enseignement_CC = NULL, coef_total_CC=0
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
		ELSE
			UPDATE STATS_ENSEIGNEMENT_ETUDIANT
			SET moy_etu_enseignement_CC = (moy_etu_enseignement_CC*coefTotalTemp - :OLD.valeur_note*:OLD.coef_note) / (coefTotalTemp - :OLD.coef_note), coef_total_CC = coef_total_CC-:OLD.coef_note
			WHERE id_enseignement = :OLD.id_enseignement AND id_groupe=:OLD.id_groupe AND id_user = :OLD.id_user;
		END IF;
	END IF;
	-- Pas de ELSE car on ne fait rien si c'est une note de DS supprimée (une note de DS n'est pas sencée être supprimée)
END;


-- Test
--delete from notes where id_note = 14;
	-- (note d'un id_user=12 dans id_enseignement=1 et id_semestre=1)
	-- Il a deux notes, 12 et 15, et on supprime le 15, sa moyenne passe de 13,5 à 12 donc ok
--delete from notes where id_note = 1;
	-- On supprime sa deuxième note pour cette matière et ce semestre
	-- Normalement sa moyenne passe à NULL et son coef total à 0
	-- Ca marche















