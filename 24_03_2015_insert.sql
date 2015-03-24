-- UTILISATEURS/PROFESSEURS : id de 1 à 11
create sequence id;
INSERT INTO utilisateur VALUES(id.nextval, 'cdupuis','Dupuis','Charlie','ch.dupuis@limsi.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'calyre', 'Allyre','Clément','clement.allyre@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'tamelin', 'Amelin','Thibault','amelinTh78@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'landreone', 'Andreone','Luc','lucAnd@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'yantoine', 'Antoine','Yoann','antoine.yoann@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'raublanc', 'Aublanc','Romain','aublancR@hotmail.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'aauzolie', 'Auzolie','Arthur','auzolarthur@yahoo.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'cblanchard', 'Blanchard','Clément','clemblanchard@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'pboiron', 'Boiron','Pierre','boironPierre@upmc.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'agratton', 'Gratton','alexandre','alex.gratton@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'mgrenier', 'Grenier','Maxime','maximegrenier@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);

-- FORMATIONS
INSERT INTO formation VALUES('DUT informatique', 2014, 2);

-- SEMESTRES
create sequence sem;

INSERT INTO semestre VALUES(sem.nextval, 'S1', 'DUT informatique', 2014, to_date('09-01', 'MM-DD'), to_date('01-10', 'MM-DD'));
INSERT INTO semestre VALUES(sem.nextval, 'S2', 'DUT informatique', 2014, to_date('01-12', 'MM-DD'), to_date('06-17', 'MM-DD'));

drop sequence sem;

-- TYPE NOTE
INSERT INTO type_note VALUES ('CC', 0.4);
INSERT INTO type_note VALUES ('CF', 0.6);


-- MATIERES
INSERT INTO matiere VALUES('Algorithmique');
INSERT INTO matiere VALUES('Programmation OO');
INSERT INTO matiere VALUES('Architecture');
INSERT INTO matiere VALUES('Système et Réseaux');
INSERT INTO matiere VALUES('ACSI');
INSERT INTO matiere VALUES('Bases de données');
INSERT INTO matiere VALUES('Mathématiques');
INSERT INTO matiere VALUES('Gestion');
INSERT INTO matiere VALUES('Economie');
INSERT INTO matiere VALUES('Communication');
INSERT INTO matiere VALUES('Anglais');
INSERT INTO matiere VALUES('Programmation Web');


-- GROUPES/UTILISATEURS/ETUDIANTS : id de 12 à 25
-- etudiant_dans_groupe VALUES
create sequence num start with 211000;
create sequence gr;

INSERT INTO groupe VALUES(gr.nextval, 'Info 2014');
	INSERT INTO utilisateur VALUES(id.nextval, 'abouaziz', 'Bouaziz','alexandra','alexandra.bouaziz56@live.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'sbouguila', 'Bouguila','Selma','selmaBouguila@u-p8.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'abrand', 'Brand','Alexis','brand-Alex@gmail.com');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'mcamara', 'Camara','Moussa','moussC@live.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'cchaux', 'Chaux','christine','chris.chaux@yahoo.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'econin', 'Conin','Elisa','conin.Elisa91@gmail.com');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'jcorvisard', 'Corvisard','Julie','julie.corvisard@u-p8.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'adesjardins', 'Desjardins','Alexandra','alexandra.desjardins@u-psud.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'jdianas', 'Dianas','Julien','dianajuju@gmail.com');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'ndinouel', 'Dinouel','Natha','didiNatha78@wanadoo.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'rdonckers', 'Donckers','Rémi','donckers.remi@upmc.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'meuphrosine', 'Euphrosine','Mélissa','euphrosine.melissa@upmc.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);
	INSERT INTO utilisateur VALUES(id.nextval, 'cfleury', 'Fleury','Cédric','cedric.quentin@u-psud.fr');
	INSERT INTO etudiant VALUES(id.currval, num.nextval);
		INSERT INTO etudiant_dans_groupe VALUES(id.currval, gr.currval);

drop sequence num;
drop sequence id;


-- ENSEIGNEMENTS/GROUPE_SUIT_ENSEIGNEMENT/NOTES
create sequence ens;
create sequence etu START WITH 12 MINVALUE 12 MAXVALUE 24 CYCLE CACHE 10; --id_user des étudiants
create sequence note;

-- Algo S1
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Algorithmique',1, 3);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
		-- notes de chaque élève pour cet enseignement
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 12, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 13, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 17, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 9, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 10, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 15, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 7.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 13.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 14, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 16, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 15.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 12, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 13, 1, 'CC');
		
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 15, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 12.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 8.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 8, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 16, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 18, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 14, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 14.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 12, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 11.5, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 11, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 15, 1, 'CC');
		INSERT INTO notes(id_note, id_user, id_groupe, id_enseignement, libelle_interrogation, date_interrogation, valeur_note, coef_note, type_note) VALUES
		(note.nextval, etu.nextval,1, ens.currval, 'Interro d''Algorithmique n°2', to_date('2014-11-28', 'YYYY-MM-DD'), 10, 1, 'CC');
		
-- Algo S2
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Algorithmique',2, 3);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);

INSERT INTO enseignement VALUES(ens.nextval,1 , 'Programmation OO',2, 3);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);

INSERT INTO enseignement VALUES(ens.nextval,2 , 'Programmation OO',2, 3);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Architecture',3, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Système et Réseaux',4, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Système et Réseaux',4, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'ACSI',5, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'ACSI',6, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Bases de données',5, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Bases de données',5, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Mathématiques',7, 5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Mathématiques',7, 5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Gestion',8, 3);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Gestion',8, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Economie',8, 2);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 ,'Communication',9, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Communication',9, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,1 , 'Anglais',10, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);
	
INSERT INTO enseignement VALUES(ens.nextval,2 , 'Anglais',10, 2.5);
	INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES (gr.currval, ens.currval);

drop sequence gr;
drop sequence etu;
drop sequence ens;
drop sequence note;

