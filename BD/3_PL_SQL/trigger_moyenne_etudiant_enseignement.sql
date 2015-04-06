
-- Procédure qui renvoie vrai s'il existe une ligne dans la table stats_enseignement_etudiant pour un étudiant, un enseignement et un groupe donné.
CREATE OR REPLACE FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
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
END;
/



-- Trigger qui met à jour les statistiques sur les moyennes de l'étudiant après insertion d'une note
CREATE OR REPLACE TRIGGER moyenne_etudiant_enseignement
	AFTER INSERT ON notes
	FOR EACH ROW
DECLARE
	nbNotes number;
	coef_CC number;
	coef_DS number;
BEGIN
	IF(:NEW.type_note = 'CC')
	THEN
		-- Si l'étudiant a déjà une moyenne de calulée, elle est mise à jour
		IF(is_stat_etu(:NEW.id_user, :NEW.id_enseignement, :NEW.id_groupe))
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
		
		-- Mise à jour de la moyenne totale (qui était NULL)
		SELECT coef_general INTO coef_CC
		FROM type_note
		WHERE type_note = 'CC';
		SELECT coef_general INTO coef_DS
		FROM type_note
		WHERE type_note = 'DS';
		
		UPDATE stats_enseignement_etudiant
		SET moy_etu_enseignement_total = (moy_etu_enseignement_CC * coef_CC + moy_etu_enseignement_DS * coef_DS) / (coef_CC+coef_DS)
		WHERE id_user = :NEW.id_user
		AND id_enseignement = :NEW.id_enseignement
		AND id_groupe = :NEW.id_groupe;
	END IF;
END;

/*
Rapport d'erreur -
ORA-00603: ORACLE server session terminated by fatal error
ORA-00600: internal error code, arguments: [kqlidchg1], [], [], [], [], [], [], [], [], [], [], []
ORA-00604: error occurred at recursive SQL level 1
ORA-00001: unique constraint (SYS.I_PLSCOPE_SIG_IDENTIFIER$) violated
00603. 00000 -  "ORACLE server session terminated by fatal error"
*Cause:    An Oracle server session was in an unrecoverable state.
*Action:   Log in to Oracle again so a new server session will be created
           automatically.  Examine the session trace file for more
           information.
*/