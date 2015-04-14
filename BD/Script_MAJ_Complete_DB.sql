

drop table STATS_SEMESTRE_ETUDIANT;
drop table STATS_ENSEIGNEMENT_ETUDIANT;
drop table NOTES;
drop table TYPE_NOTE;
drop table ETUDIANT_DANS_GROUPE;
drop table ETUDIANT;
drop table GROUPE_SUIT_ENSEIGNEMENT;
drop table GROUPE;
drop table ENSEIGNEMENT;
drop table MATIERE;
drop table SEMESTRE;
drop table FORMATION;
drop table PROFESSEUR;
drop table UTILISATEUR;


drop sequence sem;
drop sequence num;
drop sequence id;
drop sequence gr;
drop sequence etu;
drop sequence ens;
drop sequence note;



-- Astuce vraiment pratique pour connaître l'ordre des drop tables sans regarder le schéma :

-- select 'drop table '||table_name||' cascade constraints;' from user_tables;
-- Cela donne la liste des tables dans l'ordre des deletes, il y a plus qu'à copier coller

-- Même systeme pour les sequences : 
-- select 'drop sequence '||sequence_name||' ;' from user_sequences;










CREATE TABLE UTILISATEUR (
	id_user INTEGER NOT NULL,
	login VARCHAR2(30),
	nom_user VARCHAR2(30),
	prenom_user VARCHAR2(30),
	mail_user VARCHAR2(100),
	CONSTRAINT PK_USER PRIMARY KEY (id_user), 
	CONSTRAINT UNIQUE_UTILISATEUR_LOGIN UNIQUE(login)
	);


CREATE TABLE PROFESSEUR (
	id_user INTEGER,
	CONSTRAINT PK_PROFESSEUR PRIMARY KEY (id_user),
	CONSTRAINT FK_PROF_USER FOREIGN KEY (id_user) REFERENCES UTILISATEUR(id_user)
	);



CREATE TABLE FORMATION (
	nom_formation VARCHAR2(30),
	annee_formation INTEGER,
	id_prof_responsable INTEGER,
	CONSTRAINT PK_FORMATION PRIMARY KEY (nom_formation, annee_formation),
	CONSTRAINT FK_FORMATION_PROFESSEUR FOREIGN KEY (id_prof_responsable) REFERENCES PROFESSEUR(id_user)
	);



CREATE TABLE SEMESTRE (
	id_semestre INTEGER NOT NULL, -- on est sur qu'un semestre est unique (il peut y avoir deux S1 dans la table pour deux formations différentes)
	nom_semestre VARCHAR2(10), -- nom automatique S1, S2, S3, S4 en fonction du nombre de semestres, nombre que choisit le professeur responsable de la formation sur l'interface java
	nom_formation VARCHAR2(30),
	annee_formation INTEGER,
	date_debut DATE, -- le professeur responsable de la formation choisit la date en type JJ/MM/AAAA et une vérification est faite que les semestres sont bien dans l'odre chronologique (que le S2 ne commence pas avant le S1 par exemple)
	date_fin DATE, -- le professeur responsable de la formation choisit la date en type JJ/MM/AAAA et une vérification est faite que les semestres sont bien dans l'odre chronologique (que le S2 ne commence pas avant le S1 par exemple)
	semestre_ouvert INTEGER DEFAULT 0, -- semestre fermé par défault
	semestre_termine INTEGER DEFAULT 0, -- le semestre n'est pas terminé
	CONSTRAINT PK_SEMESTRE PRIMARY KEY (id_semestre),
	CONSTRAINT UNIQUE_SEMESTRE UNIQUE (nom_semestre, nom_formation, annee_formation), -- pas de redondance de données (pas deux S1 pour la même formation)
	CONSTRAINT FK_SEMESTRE_FORMATION FOREIGN KEY (nom_formation, annee_formation) REFERENCES FORMATION(nom_formation, annee_formation)
	);




CREATE TABLE MATIERE (
	nom_matiere VARCHAR2(30),
	CONSTRAINT PK_MATIERE PRIMARY KEY (nom_matiere) -- on est sur qu'une matière est unique, pour une formation et un semestre donnés
	);




CREATE TABLE ENSEIGNEMENT (
	id_enseignement INTEGER NOT NULL,
	id_semestre INTEGER,
	nom_matiere VARCHAR2(30),
	id_professeur INTEGER,
	coef_enseignement REAL, -- exemple maths coef 4 et anglais coef 2 (peut varier selon les formations)
	CONSTRAINT PK_ENSEIGNEMENT PRIMARY KEY (id_enseignement),
	CONSTRAINT FK_ENSEIGNEMENT_SEMESTRE FOREIGN KEY (id_semestre) REFERENCES SEMESTRE(id_semestre),
	CONSTRAINT FK_ENSEIGNEMENT_MATIERE FOREIGN KEY (nom_matiere) REFERENCES MATIERE(nom_matiere),
	CONSTRAINT FK_ENSEIGNEMENT_PROFESSEUR FOREIGN KEY (id_professeur) REFERENCES PROFESSEUR(id_user),
	CONSTRAINT UNIQUE_ENSEIGNEMENT UNIQUE (id_semestre, nom_matiere) -- pas deux fois la même matière pour un semestre 
	);




CREATE TABLE GROUPE (
	id_groupe INTEGER NOT NULL,
	nom_groupe VARCHAR2(10),
	CONSTRAINT PK_GROUPE PRIMARY KEY (id_groupe) -- il y aura plein de groupe de nom "AS" par exemple (un par an en fait) mais avec une id différente et donc suivant des enseignements d'id différents
	);





CREATE TABLE GROUPE_SUIT_ENSEIGNEMENT (
	id_groupe INTEGER,
	id_enseignement INTEGER,
	CONSTRAINT PK_GROUPE_SUIT_ENSEIGNEMENT PRIMARY KEY (id_groupe, id_enseignement),
	CONSTRAINT FK_GP_ENSEIGN_TO_GROUPE FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe),
	CONSTRAINT FK_GP_ENSEIGN_TO_ENSEIGN FOREIGN KEY (id_enseignement) REFERENCES ENSEIGNEMENT(id_enseignement)
	);






CREATE TABLE ETUDIANT (
	id_user INTEGER,
	num_etudiant INTEGER,
	CONSTRAINT PK_ELEVE PRIMARY KEY (id_user),
	CONSTRAINT FK_ELEVE_USER FOREIGN KEY (id_user) REFERENCES UTILISATEUR(id_user),
	CONSTRAINT UNIQUE_ELEVE_NUMETUDIANT UNIQUE (num_etudiant)
	);


CREATE TABLE ETUDIANT_DANS_GROUPE (
	id_user INTEGER,
	id_groupe INTEGER,
	CONSTRAINT PK_ETUDIANT_DANS_GROUPE PRIMARY KEY (id_user, id_groupe),
	CONSTRAINT FK_ETUD_DANS_GP_VERS_ETU FOREIGN KEY (id_user) REFERENCES ETUDIANT(id_user),
	CONSTRAINT FK_ETUD_DANS_GP_VERS_GROUPE FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe)
	);



CREATE TABLE TYPE_NOTE (
	type_note VARCHAR2(2),
	coef_general REAL,
	CONSTRAINT PK_TYPE_NOTE PRIMARY KEY (type_note)
	);


CREATE TABLE NOTES (
	id_note INTEGER NOT NULL,
	id_user INTEGER,
	id_groupe INTEGER,
	id_enseignement INTEGER,
	libelle_interrogation VARCHAR2(50),
	date_interrogation DATE,
	valeur_note REAL,
	coef_note REAL,
	absent INTEGER DEFAULT 0, -- pas de BOOLEAN en SQL (mais il y en a en PL/SQL)
	absence_justifiee INTEGER DEFAULT 0,
	type_note VARCHAR2(2),
	CONSTRAINT PK_NOTES PRIMARY KEY (id_note),
	CONSTRAINT FK_NOTES_GP_SUIT_ENSEIGNEMENT FOREIGN KEY (id_groupe, id_enseignement) REFERENCES GROUPE_SUIT_ENSEIGNEMENT(id_groupe, id_enseignement),
	CONSTRAINT FK_NOTES_ETUDIANT FOREIGN KEY (id_user) REFERENCES ETUDIANT(id_user),
	CONSTRAINT FK_NOTES_TYPE_NOTE FOREIGN KEY (type_note) REFERENCES TYPE_NOTE(type_note),
	CONSTRAINT UNIQUE_NOTES UNIQUE (id_user, id_enseignement, libelle_interrogation), -- pas deux notes pour une même interro
	CONSTRAINT UNIQUE_LIBELLE_INTERROGATION UNIQUE (id_groupe, libelle_interrogation, id_enseignement, id_user), -- un élève ne peut pas avoir deux "Interro n°1" dans un même enseignement pour un même groupe
	CONSTRAINT CHECK_NOTES CHECK (valeur_note BETWEEN 0 AND 20)
	-- plein de choses à faire ici
		-- pour un couple libelle_interrogation et id_enseignement, trouver le groupe auquel ca correspond (de par l'id_user de la note) et vérifier que pour ce couple libelle_interrogation et id_enseignement on a bien autant de lignes que d'élèves dans le groupe
	);


CREATE TABLE STATS_ENSEIGNEMENT_ETUDIANT (
	id_user INTEGER,
	id_groupe INTEGER,
	id_enseignement INTEGER,
	moy_etu_enseignement_CC REAL,
	coef_total_CC REAL,
	moy_etu_enseignement_DS REAL,
	moy_etu_enseignement_total REAL,
	CONSTRAINT PK_STATS_ENSEIGNEMENT_ETUDIANT PRIMARY KEY (id_user, id_groupe, id_enseignement),
	CONSTRAINT FK_STATS_ENS_ETU_TO_ETU FOREIGN KEY (id_user) REFERENCES ETUDIANT(id_user)
	-- pas de foreign key pour les autres, c'est des insert automatiques avec procédure qui trouvent elles mêmes le(s) groupe(s) et les enseignements de l'élève
	-- le but est juste de faire un natural join entre eleve et une table stat pour avoir des infos pratiques vites
	);



CREATE TABLE STATS_SEMESTRE_ETUDIANT (
	id_user INTEGER,
	id_groupe INTEGER,
	id_semestre INTEGER,
	moy_etu_semestre_CC REAL,
	moy_etu_semestre_DS REAL,
	moy_etu_semestre_total REAL,
	CONSTRAINT PK_STATS_SEMESTRE_ETUDIANT PRIMARY KEY (id_user, id_groupe, id_semestre),
	CONSTRAINT FK_STATS_SEMESTRE_ETU_TO_ETU FOREIGN KEY (id_user) REFERENCES ETUDIANT(id_user)
	-- pas de foreign key pour les autres, c'est des insert automatiques avec procédure qui trouvent elles mêmes le(s) groupe(s) et les semestres de l'élève
	-- le but est juste de faire un natural join entre eleve et une table stat pour avoir des infos pratiques vites
	);

-- drop table STATS_SEMESTRE_ETUDIANT;
-- drop table STATS_ENSEIGNEMENT_ETUDIANT;
-- drop table NOTES;
-- drop table TYPE_NOTE;
-- drop table ETUDIANT_DANS_GROUPE;
-- drop table ETUDIANT;
-- drop table GROUPE_SUIT_ENSEIGNEMENT;
-- drop table GROUPE;
-- drop table ENSEIGNEMENT;
-- drop table MATIERE;
-- drop table SEMESTRE;
-- drop table FORMATION;
-- drop table PROFESSEUR;
-- drop table UTILISATEUR;


CREATE OR REPLACE PACKAGE FONCTIONS_UTILES IS
	FUNCTION isResponsable(idU utilisateur.id_user%TYPE, id_ens enseignement.id_enseignement%TYPE) RETURN BOOLEAN;
	FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT;
	FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER;
	FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean;
	FUNCTION is_stat_sem_etu (id_etu IN etudiant.id_user%type, id_sem IN semestre.id_semestre%type, id_gr IN groupe.id_groupe%type) RETURN boolean;
	FUNCTION getCoefTypeNote (unType TYPE_NOTE.type_note%TYPE) RETURN FLOAT;
	PROCEDURE supprInterro (id_enseign ENSEIGNEMENT.id_enseignement%TYPE, id_group GROUPE.id_groupe%TYPE, libelle NOTES.libelle_interrogation%TYPE);
	PROCEDURE open_semester;
	PROCEDURE close_semester;
	PROCEDURE updateMoyEnsGenerale (idUser UTILISATEUR.id_user%TYPE, idEns ENSEIGNEMENT.id_enseignement%TYPE, idGroupe GROUPE.id_groupe%TYPE, newMoy FLOAT);
END FONCTIONS_UTILES;
/


CREATE OR REPLACE PACKAGE BODY FONCTIONS_UTILES IS

	-- Foncion qui prend en paramètre un id_user et un id_enseignement
		-- Renvoi vrai si l'id_user correspond à celle du professeur responsable de la formation correspondant à l'enseignement
		-- Renvoi faux sinon
	FUNCTION isResponsable(idU utilisateur.id_user%type,id_ens enseignement.id_enseignement%type) return boolean AS
	 resp boolean := false; 
	 id_prof formation.id_prof_responsable%type;
	BEGIN
	  SELECT id_prof_responsable into id_prof
	  FROM formation natural join semestre natural join enseignement
	  WHERE enseignement.id_enseignement = id_ens;

		IF id_prof=idU THEN
			resp:=true;
		END IF;

	  RETURN resp; 
	END isResponsable;


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi le coef (en float) d'un enseignement passé en paramètre
	FUNCTION getCoefEnseignement (id_ens enseignement.id_enseignement%type) RETURN FLOAT AS
		coef FLOAT := 0;
	BEGIN
		SELECT coef_enseignement INTO coef
		FROM ENSEIGNEMENT
		WHERE id_enseignement = id_ens;

		RETURN coef;
	END getCoefEnseignement;


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi l'id_semestre d'un enseignement donné
	FUNCTION getIDSemestre (id_ens enseignement.id_enseignement%type) RETURN INTEGER AS
		idSemmestre INTEGER;
	BEGIN
		SELECT id_semestre INTO idSemmestre
		FROM ENSEIGNEMENT
		WHERE id_enseignement = id_ens;

		RETURN idSemmestre;
	END getIDSemestre;
	


				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




	-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_enseignement_etudiant pour un étudiant, un enseignement et un groupe donné.
	FUNCTION is_stat_etu (id_etu IN etudiant.id_user%type, id_ens IN enseignement.id_enseignement%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
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
	
	
				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --
	
	--@Jeanne
	-- Fonction qui renvoie vrai s'il existe une ligne dans la table stats_semestre_etudiant pour un étudiant, un semestre et un groupe donné.
	FUNCTION is_stat_sem_etu (id_etu IN etudiant.id_user%type, id_sem IN semestre.id_semestre%type, id_gr IN groupe.id_groupe%type) RETURN boolean IS
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
	

				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


	-- Fonction qui renvoi le coef général selon le type de note (DS ou CC)
	FUNCTION getCoefTypeNote (unType TYPE_NOTE.type_note%TYPE) RETURN FLOAT IS
		coefGeneral FLOAT;
	BEGIN
		SELECT coef_general INTO coefGeneral
		FROM TYPE_NOTE
		WHERE upper(type_note) = upper(unType);

		RETURN coefGeneral;
	END getCoefTypeNote;



				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



	--##### Supression d'une interrogation de contrôle continu de la part d'un professeur
	--Scénario : 
	--	- Professeur gère ses enseignement => il en sélectionne un (on a l'id_enseignement)
	--	- Il sélectionne un des groupes qui suit cet enseignement (on a l'id_groupe)
	--	- Il a alors la liste des interrogations
	--		- Grâce à `CONSTRAINT UNIQUE_LIBELLE_INTERROGATION UNIQUE (id_groupe, libelle_interrogation, id_enseignement, id_user)`, 
	--         on sait qu'il n'y aura pas deux même libelle_interrogation pour un groupe et un enseignement donné
	--		- Il clique sur supprimer l'interrogation (on ne sait jamais, des fois qu'elle soit trop mauvaise ^^)
	--			- Possibilité de ne proposer cette option que pour le prof responsable ??
	--		- Pour chaque id_note qui match le libellé, le groupe et l'enseignement, supprimer la note

	--@laurence
	PROCEDURE supprInterro (id_enseign ENSEIGNEMENT.id_enseignement%TYPE, id_group GROUPE.id_groupe%TYPE, libelle NOTES.libelle_interrogation%TYPE) IS

		CURSOR curseurInterro IS
			SELECT id_enseignement, id_groupe, libelle_interrogation, id_note
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





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



	-- Procédure open_semester qui ouvre les semestres qui ont besoin d'être ouverts
	--- Sélectionner tous les semestres qui ont semestre_ouvert à false
	--	+ Si date_debut ≤ SYSDATE alors le mettre à vrai
	--	+ Sinon ne rien faire

	--@laurence
	PROCEDURE open_semester IS

		CURSOR curseurDateToOpen IS
			SELECT id_semestre, date_debut
			FROM semestre
			WHERE semestre_ouvert = 0
			FOR UPDATE;

		ligne curseurDateToOpen%ROWTYPE;

	BEGIN
		FOR ligne IN curseurDateToOpen LOOP
			IF ligne.date_debut <= TO_DATE(SYSDATE, 'DD/MM/YY') THEN 
				UPDATE semestre
				SET semestre_ouvert = 1
				WHERE CURRENT OF curseurDateToOpen;
			END IF;
		END LOOP;
		COMMIT;
	END open_semester;





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




	--##### Procédure close_semester qui ferme les semestres qui ont besoin d'être fermés
	--- Sélectionner tous les semestres qui ont semestre_termine à false
	--	+ Si date_fin ≤ SYSDATE alors le mettre à vrai
	--	+ Sinon ne rien faire

	--@laurence
	PROCEDURE close_semester IS

		CURSOR curseurDateToClose IS
			SELECT id_semestre, date_fin
			FROM semestre
			WHERE semestre_termine = 0
			FOR UPDATE;

		ligne curseurDateToClose%ROWTYPE;

	BEGIN
		FOR ligne IN curseurDateToClose LOOP
			IF ligne.date_fin <= TO_DATE(SYSDATE, 'DD/MM/YY') THEN 
				UPDATE semestre
				SET semestre_termine = 1
				WHERE CURRENT OF curseurDateToClose;
			END IF;
		END LOOP;
		COMMIT;
	END close_semester;







				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --



--##### Procedure d'update de la table STATS_ENSEIGNEMENT_ETUDIANT afin d'eviter une erreur de "mutating table" avec le trigger moy_ens_total_when_update_DS
--- Déclaration de la procédure avec "pragma autonomous_transaction" (attention aux boucles infinies !!)

--@Raphael

PROCEDURE updateMoyEnsGenerale (idUser UTILISATEUR.id_user%TYPE, idEns ENSEIGNEMENT.id_enseignement%TYPE, idGroupe GROUPE.id_groupe%TYPE, newMoy FLOAT) IS PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	UPDATE stats_enseignement_etudiant
	SET moy_etu_enseignement_total = newMoy
	WHERE id_user = idUser
	AND id_enseignement = idEns
	AND id_groupe = idGroupe;

	COMMIT;
END updateMoyEnsGenerale;





				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --




END FONCTIONS_UTILES;
/	









-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 
-- ===================================================================================================================== -- 









CREATE OR REPLACE PACKAGE STATISTIQUES IS
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, idEns ENSEIGNEMENT.id_enseignement%TYPE, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT);
END STATISTIQUES;
/


CREATE OR REPLACE PACKAGE BODY STATISTIQUES IS

	-- Procédure qui renvoi par le biais des paramètre la moyenne d'un élève à un semestre (id_user et id_groupe passés en paramètre) (moyenne CC, DS et total)
	PROCEDURE calcul_moyenne_semestre (idEleve UTILISATEUR.id_user%type, sonGroupe GROUPE.id_groupe%type, idEns ENSEIGNEMENT.id_enseignement%TYPE, moyenneSemestreCC OUT FLOAT, moyenneSemestreDS OUT FLOAT, moyenneSemestreTotal OUT FLOAT) IS
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

	

				-- ========================================================================== --
				-- ========================================================================== --
				-- ========================================================================== --


END STATISTIQUES;
/








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
/








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
	moyenne_temp FLOAT;
	coeftotal FLOAT;

BEGIN

	SELECT coef_total_CC, moy_etu_enseignement_CC INTO coeftotal, moyenne_temp
	FROM  STATS_ENSEIGNEMENT_ETUDIANT
	WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;

	IF(:NEW.type_note = 'CC') THEN
		moyenne_temp :=(moyenne_temp * coeftotal - (:OLD.valeur_note*:OLD.coef_note) + (:NEW.valeur_note*:NEW.coef_note))/ (coeftotal - :OLD.coef_note + :NEW.coef_note);
		coeftotal := coeftotal - :OLD.coef_note + :NEW.coef_note;
		UPDATE STATS_ENSEIGNEMENT_ETUDIANT 
		SET moy_etu_enseignement_CC = moyenne_temp, coef_total_CC = coeftotal
		WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;
	ELSE
		UPDATE STATS_ENSEIGNEMENT_ETUDIANT
		SET moy_etu_enseignement_DS = :NEW.valeur_note
		WHERE id_user = :OLD.id_user AND id_groupe = :OLD.id_groupe AND id_enseignement = :OLD.id_enseignement;
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
/

-- Test
--delete from notes where id_note = 14;
	-- (note d'un id_user=12 dans id_enseignement=1 et id_semestre=1)
	-- Il a deux notes, 12 et 15, et on supprime le 15, sa moyenne passe de 13,5 à 12 donc ok
--delete from notes where id_note = 1;
	-- On supprime sa deuxième note pour cette matière et ce semestre
	-- Normalement sa moyenne passe à NULL et son coef total à 0
	-- Ca marche















--@Jeanne
-- Trigger qui calcul la moyenne totale d'un enseignement lors de l'insertion ou modification de la moyenne de DS sur la table STATS_ENSEIGNEMENT_ETUDIANT
CREATE OR REPLACE TRIGGER moy_ens_total_when_update_DS
	AFTER UPDATE OF moy_etu_enseignement_DS ON stats_enseignement_etudiant
	FOR EACH ROW
DECLARE
	coef_CC number;
	coef_DS number;
	moyenneTotalTemp float;
BEGIN
	coef_CC := fonctions_utiles.getCoefTypeNote('CC');
	coef_DS := fonctions_utiles.getCoefTypeNote('DS');
	
	moyenneTotalTemp := (:NEW.moy_etu_enseignement_CC * coef_CC + :NEW.moy_etu_enseignement_DS * coef_DS) / (coef_CC+coef_DS);

	FONCTIONS_UTILES.updateMoyEnsGenerale(:NEW.id_user, :NEW.id_enseignement, :NEW.id_groupe, moyenneTotalTemp);


	-- UPDATE stats_enseignement_etudiant
	-- SET moy_etu_enseignement_total = (moy_etu_enseignement_CC * coef_CC + :NEW.moy_etu_enseignement_DS * coef_DS) / (coef_CC+coef_DS)
	-- WHERE id_user = :NEW.id_user
	-- AND id_enseignement = :NEW.id_enseignement
	-- AND id_groupe = :NEW.id_groupe;
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
/

--@Jeanne
-- Trigger qui met à jour la moyenne du semestre de l'étudiant lorsqu'une de ses moyennes générales d'enseignements est ajoutée ou modifiée
CREATE OR REPLACE TRIGGER moy_sem_when_update_moy_ens
	AFTER UPDATE OF moy_etu_enseignement_total ON stats_enseignement_etudiant
	FOR EACH ROW
DECLARE
	moyenneSemestreCC float;
	moyenneSemestreDS float;
	moyenneSemestreTotal float;
	id_sem INTEGER := FONCTIONS_UTILES.getIDSemestre(:NEW.id_enseignement);
BEGIN
	statistiques.calcul_moyenne_semestre(:NEW.id_user, :NEW.id_groupe, :NEW.id_enseignement, moyenneSemestreCC, moyenneSemestreDS, moyenneSemestreTotal);
	-- Si l'étudiant a déjà bénéficié d'un calcul de moyenne de semestre pour le semestre concerné par l'update -> mise à jour
	IF(fonctions_utiles.is_stat_sem_etu(:NEW.id_user, id_sem, :NEW.id_groupe))
	THEN
		UPDATE stats_semestre_etudiant
		SET moy_etu_semestre_CC = moyenneSemestreCC, moy_etu_semestre_DS = moyenneSemestreDS, moy_etu_semestre_total = moyenneSemestreTotal
		WHERE id_user = :NEW.id_user
		AND id_groupe = :NEW.id_groupe
		AND id_semestre = id_sem;	
	ELSE -- sinon -> insertion
		INSERT INTO stats_semestre_etudiant
		VALUES (:NEW.id_user, :NEW.id_groupe, id_sem, moyenneSemestreCC, moyenneSemestreDS, moyenneSemestreTotal);	
	END IF;
END;
/




