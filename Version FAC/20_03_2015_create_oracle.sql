

CREATE TABLE UTILISATEUR (
	id_user INTEGER NOT NULL,
	login VARCHAR2(30),
	password VARCHAR2(30),
	nom_user VARCHAR2(30),
	prenom_user VARCHAR2(30),
	mail_user VARCHAR2(100),
	CONSTRAINT PK_USER PRIMARY KEY (id_user), 
	CONSTRAINT UNIQUE_UTILISATEUR_LOGIN UNIQUE(login)
	);


CREATE TABLE FORMATION (
	nom_formation VARCHAR2(30),
	CONSTRAINT PK_FORMATION PRIMARY KEY (nom_formation)
	);

CREATE TABLE SEMESTRE (
	id_semestre INTEGER NOT NULL, -- on est sur qu'un semestre est unique (il peut y avoir deux S1 dans la table pour deux formations différentes)
	nom_semestre VARCHAR2(10),	
	nom_formation VARCHAR2(30),	
	CONSTRAINT PK_SEMESTRE PRIMARY KEY (id_semestre),
	CONSTRAINT UNIQUE_SEMESTRE UNIQUE (nom_semestre, nom_formation), -- pas de redondance de données (pas deux S1 pour la même formation)
	CONSTRAINT FK_SEMESTRE_FORMATION FOREIGN KEY (nom_formation) REFERENCES FORMATION(nom_formation)
	);

CREATE TABLE MATIERE (
	id_matiere INTEGER NOT NULL, -- en auto incrément
	id_semestre INTEGER,
	nom_matiere VARCHAR2(30),
	coef_matiere REAL,
	CONSTRAINT PK_MATIERE PRIMARY KEY (id_matiere), -- on est sur qu'une matière est unique, pour une formation et un semestre donnés
	CONSTRAINT UNIQUE_MATIERE UNIQUE(nom_matiere, id_semestre), -- pas de redondance de données
	CONSTRAINT FK_MATIERE_SEMESTRE FOREIGN KEY (id_semestre) REFERENCES SEMESTRE(id_semestre)
	);



CREATE TABLE PROFESSEUR (
	id_user INTEGER,
	CONSTRAINT PK_PROFESSEUR PRIMARY KEY (id_user),
	CONSTRAINT FK_PROF_USER FOREIGN KEY (id_user) REFERENCES UTILISATEUR(id_user)
	);



CREATE TABLE GROUPE (
	id_groupe INTEGER NOT NULL,
	id_matiere INTEGER,
	nom_groupe VARCHAR2(10),
	id_professeur INTEGER, -- professeur gérant le groupe, pas de "id_user" car un join avec la table ETUDIANT_CHOISIT_GROUPE donnerai une réponse erronée
	date_formation VARCHAR2(15), -- du type "2014-2015", pour chercher un élève/groupe/notes par année de formation
	moyenne_groupe_CC REAL, -- calculée donnant la moyenne du groupe à l'ensemble des notes de CC
	moyenne_groupe_partiel REAL, -- calculée donnant la moyenne du groupe au partiel
	moyenne_groupe_matiere REAL, -- calculée donnant la moyenne générale du groupe à la matière pour ce semestre
	CONSTRAINT PK_GROUPE PRIMARY KEY (id_groupe), -- chaque groupe est unique (on peut avoir différents groupes sur la même matière). Ca fait des "archives" en quelque sorte. Un groupe (et ses données) n'est jamais détruits, on en recrée des nouveaux
	CONSTRAINT UNIQUE_GROUPE UNIQUE(nom_groupe, id_matiere, date_formation), -- on ne veut pas deux mêmes noms de groupe pour une même matière lors d'une même année universitaire
	CONSTRAINT FK_GROUPE_MATIERE FOREIGN KEY (id_matiere) REFERENCES MATIERE(id_matiere),
	CONSTRAINT FK_GROUPE_PROFESSEUR FOREIGN KEY (id_professeur) REFERENCES PROFESSEUR(id_user)
	);



CREATE TABLE ETUDIANT (
	id_user INTEGER,
	num_etudiant INTEGER,
	nom_formation VARCHAR2(30), 
	-- on pourait retrouver le nom de formation pour un élève donné en passant par les groupes puis matières puis semestre puis formation grace aux ID des différentes tables
	-- Ici ca fait office de racourci mais aussi de limitateur : un élève ne peut suivre qu'une formation.
	-- A voir si on garde ca comme ca ou pas, faire en sorte qu'un eleve suive plusieurs formations n'est pas compliqué
	-- D'ailleurs rien ne l'empêche de s'inscrire à différents groupes issus de plusieurs formations différentes donc un peu inutile à mon avis
	CONSTRAINT PK_ELEVE PRIMARY KEY (id_user),
	CONSTRAINT FK_ELEVE_USER FOREIGN KEY (id_user) REFERENCES UTILISATEUR(id_user),
	CONSTRAINT FK_ELEVE_FORMATION FOREIGN KEY (nom_formation) REFERENCES FORMATION(nom_formation),
	CONSTRAINT UNIQUE_ELEVE_NUMETUDIANT UNIQUE (num_etudiant)
	);


CREATE TABLE ETUDIANT_CHOISIT_GROUPE (
	id_user INTEGER,
	id_groupe INTEGER,
	moyenne_CC REAL, -- calculée donnant la moyenne de l'élève à l'ensemble des interros du controle continu
	moyenne_matiere REAL, -- calculée donnant la moyenne de l'élève à la matière (un groupe correspond à une matière)
	position_matiere INTEGER,
	CONSTRAINT PK_ETUDIANT_CHOISIT_GROUPE PRIMARY KEY (id_user, id_groupe),
	CONSTRAINT FK_ETUD_CHOISIT_GP_VERS_ETU FOREIGN KEY (id_user) REFERENCES ETUDIANT(id_user),
	CONSTRAINT FK_ETUD_CHOISIT_GP_VERS_GROUPE FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe)
	);


CREATE TABLE INTERROS_CC (
	id_note INTEGER NOT NULL,
	id_user INTEGER,
	id_groupe INTEGER,
	libelle_interrogation VARCHAR2(50),
	date_interrogation DATE,
	valeur_note REAL,
	coef_note REAL,
	CONSTRAINT PK_NOTES PRIMARY KEY (id_note),
	CONSTRAINT FK_INTERROS_CC_ETU_CHOI_GROUP FOREIGN KEY (id_user, id_groupe) REFERENCES ETUDIANT_CHOISIT_GROUPE(id_user, id_groupe),
	CONSTRAINT UNIQUE_INTERROS_CC UNIQUE (id_user, id_groupe, libelle_interrogation),
	CONSTRAINT CHECK_INTERROS_CC CHECK (valeur_note BETWEEN 0 AND 20)
	);


CREATE TABLE PARTIEL (
	id_user INTEGER,
	id_groupe INTEGER,
	libelle_partiel VARCHAR2(50),
	date_partiel DATE,
	valeur_note_partiel REAL,
	coef_note_partiel REAL,
	CONSTRAINT PK_PARTIEL PRIMARY KEY (id_user, id_groupe), -- une seule note au partiel par élève
	CONSTRAINT FK_PARTIEL_ETU_CHOI_GROUP FOREIGN KEY (id_user, id_groupe) REFERENCES ETUDIANT_CHOISIT_GROUPE(id_user, id_groupe),
	CONSTRAINT CHECK_PARTIEL CHECK (valeur_note_partiel BETWEEN 0 AND 20)
	);

CREATE TABLE ALERTE (
	id_note INTEGER,
	date_alerte DATE,
	message_alerte VARCHAR2(200),
	CONSTRAINT FK_ALERTE_NOTES FOREIGN KEY (id_note) REFERENCES INTERROS_CC(id_note)
	);



-- drop table ALERTE;
-- drop table INTERROS_CC;
-- drop table PARTIEL;
-- drop table ETUDIANT_CHOISIT_GROUPE;
-- drop table ETUDIANT;
-- drop table GROUPE;
-- drop table PROFESSEUR;
-- drop table MATIERE;
-- drop table SEMESTRE;
-- drop table FORMATION;
-- drop table UTILISATEUR;

