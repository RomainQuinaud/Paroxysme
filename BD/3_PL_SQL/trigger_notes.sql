--@Jeanne
-- Trigger qui met à jour les statistiques sur les moyennes de l'étudiant après insertion d'une note
CREATE OR REPLACE TRIGGER moyenne_etudiant_enseignement
	AFTER INSERT ON notes
	FOR EACH ROW
DECLARE
	nbNotes number;
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