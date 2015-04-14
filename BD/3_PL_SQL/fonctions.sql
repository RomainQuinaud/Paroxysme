



-- @Romain
-- Foncion qui prend en paramètre un id_user et un id_enseignement
	-- Renvoi vrai si l'id_user correspond à celle du professeur responsable de la formation correspondant à l'enseignement
	-- Renvoi faux sinon
	-- Package FONCTIONS_UTILES
create or replace function isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	resp boolean := false; 
	id_prof formation.id_prof_responsable%type;
BEGIN
	select id_prof_responsable into id_prof
	from formation natural join semestre natural join enseignement
	where enseignement.id_enseignement = id_ens;

	if id_prof=idU then
		resp:=true;
	end if;

	return resp;
END;
/
-- Fonctionne
-- BEGIN
-- if (isResponsable(2,1)) then DBMS_OUTPUT.PUT_LINE('toto');
-- end if;
-- end;


-- -- Ne fonctionne pas: tout va bien 
-- BEGIN
-- if (isResponsable(1,1)) then DBMS_OUTPUT.PUT_LINE('toto');
-- end if;
-- end;








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




-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 




--@Jeanne
-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_enseignement_etudiant pour un étudiant, un enseignement et un groupe donné.
-- Package FONCTIONS_UTILES
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
END is_stat_etu;
/


-- Test unitaire
-- BEGIN
--   IF(is_stat_etu(12,1,1))
--   THEN
--     DBMS_OUTPUT.PUT_LINE('oui');
--   ELSE
--     DBMS_OUTPUT.PUT_LINE('non');
--   END IF;
-- END;


-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
--@Jeanne
-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_semestre_etudiant pour un étudiant, un semestre et un groupe donné.
CREATE OR REPLACE FUNCTION is_stat_sem_etu (id_etu IN etudiant.id_user%type, id_sem IN semestre.id_semestre%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
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

-- Test unitaire
-- BEGIN
--   IF(is_stat_sem_etu(12,1,1))
--   THEN
--     DBMS_OUTPUT.PUT_LINE('oui');
--   ELSE
--     DBMS_OUTPUT.PUT_LINE('non');
--   END IF;
-- END;


-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 




--@Raphael
-- Fonction qui renvoi le coef général selon le type de note (DS ou CC)
-- Package FONCTIONS_UTILES
CREATE OR REPLACE FUNCTION getCoefTypeNote (unType TYPE_NOTE.type_note%TYPE) RETURN FLOAT IS
	coefGeneral FLOAT;
BEGIN
	SELECT coef_general INTO coefGeneral
	FROM TYPE_NOTE
	WHERE upper(type_note) = upper(unType);

	RETURN coefGeneral;
END getCoefTypeNote;
/

-- Test unitaire







-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 












