



-- @Romain
-- Que fait la fonction ?
-- Package FONCTIONS_UTILES
create or replace function isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	resp boolean; -- pas d'initialisation ?
	id_prof formation.id_prof_responsable%type;
BEGIN
	select id_prof_responsable into id_prof
	from formation natural join semestre natural join enseignement
	where id_ens=enseignement.id_enseignement;

	if id_prof=idU then
		resp:=true;
	end if;

	return resp; -- booléen initialisé directement à false ? Parce que si on ne passe pas dans le if, il n'est initialisé ni dans le bloc BEGIN ni dans le DECLARE
END;

-- Manque test unitaires :)






-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 








--@Raphael
-- Fonction qui renvoi le coef (en float) d'un enseignement passé en paramètre
-- Package FONCTIONS_UTILES
CREATE OR REPLACE FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT AS
	coef FLOAT := 0;
BEGIN
	SELECT coef_enseignement INTO coef
	FROM ENSEIGNEMENT
	WHERE id_enseignement = id_ens;

	RETURN coef;
END getCoefEnseignement;
/

-- Test unitaire
-- BEGIN
-- 	DBMS_OUTPUT.PUT_LINE('Coef retourné (normalement 3) : ' || getCoefEnseignement(1));
-- END;
-- /









-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 





--@Raphael
-- Fonction qui renvoi l'id_semestre d'un enseignement donné
-- Package FONCTIONS_UTILES
CREATE OR REPLACE FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER AS
	idSemmestre INTEGER;
BEGIN
	SELECT id_semestre INTO idSemmestre
	FROM ENSEIGNEMENT
	WHERE id_enseignement = id_ens;

	RETURN idSemmestre;
END getIDSemestre;
/

-- Test unitaire
-- BEGIN
-- 	DBMS_OUTPUT.PUT_LINE('ID semestre retourné (normalement 1) : ' || getIDSemestre(1));
-- END;
-- /





