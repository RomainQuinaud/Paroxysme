

CREATE TABLE UTILISATEUR (
	id_user INTEGER NOT NULL,
	login VARCHAR2(30),
	nom_user VARCHAR2(30),
	prenom_user VARCHAR2(30),
	mail_user VARCHAR2(100),
	password_user VARCHAR2(100),
	CONSTRAINT PK_USER PRIMARY KEY (id_user), 
	CONSTRAINT UNIQUE_UTILISATEUR_LOGIN UNIQUE(login)
	);


CREATE TABLE ADMIN (
	id_user INTEGER,
	CONSTRAINT PK_ADMIN PRIMARY KEY (id_user),
	CONSTRAINT FK_ADMIN_USER FOREIGN KEY (id_user) REFERENCES UTILISATEUR(id_user)
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
	nom_groupe VARCHAR2(40),
	CONSTRAINT UNIQUE_GROUPE UNIQUE(nom_groupe),
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

