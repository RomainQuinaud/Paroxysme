--@Jeanne
-- Trigger qui calcul la moyenne totale d'un enseignement lors de l'insertion ou modification de la moyenne de DS sur la table STATS_ENSEIGNEMENT_ETUDIANT
CREATE OR REPLACE TRIGGER moy_ens_total_when_update_DS
	AFTER UPDATE OF moy_etu_enseignement_DS ON stats_enseignement_etudiant
	FOR EACH ROW
DECLARE
	coef_CC number;
	coef_DS number;
BEGIN
	coef_CC := fonctions_utiles.getCoefTypeNote('CC');
	coef_DS := fonctions_utiles.getCoefTypeNote('DS');
	
	UPDATE stats_enseignement_etudiant
	SET moy_etu_enseignement_total = (moy_etu_enseignement_CC * coef_CC + :NEW.moy_etu_enseignement_DS * coef_DS) / (coef_CC+coef_DS)
	WHERE id_user = :NEW.id_user
	AND id_enseignement = :NEW.id_enseignement
	AND id_groupe = :NEW.id_groupe;
END;
/

--@Jeanne
-- Trigger qui se déclenche lorsque la moyenne du CC d'un enseignement est modifiée pou relancer le calcul de la moyenne générale lorsque la moyenne de DS n'est pas null
CREATE OR REPLACE TRIGGER moy_ens_total_when_update_CC
	AFTER UPDATE OF moy_etu_enseignement_CC ON stats_enseignement_etudiant
	FOR EACH ROW
	WHEN (NEW.moy_etu_enseignement_DS is not NULL)
DECLARE
	coef_CC number;
	coef_DS number;
BEGIN
	coef_CC := fonctions_utiles.getCoefTypeNote('CC');
	coef_DS := fonctions_utiles.getCoefTypeNote('DS');
	
	UPDATE stats_enseignement_etudiant
	SET moy_etu_enseignement_total = (:NEW.moy_etu_enseignement_CC * coef_CC + moy_etu_enseignement_DS * coef_DS) / (coef_CC+coef_DS)
	WHERE id_user = :NEW.id_user
	AND id_enseignement = :NEW.id_enseignement
	AND id_groupe = :NEW.id_groupe;
END;
