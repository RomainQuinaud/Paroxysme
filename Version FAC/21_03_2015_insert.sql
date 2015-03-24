-- Les accents ne passent pas en important le fichier, si c'est un problème d'encodage je ne sais pas lequel utiliser
-- tout marche en faisant un copier coller
-- J'ai fait l'erreur de vouloir mettre toutes les matières, ducoup beaucoup de groupes... Je n'ai pas eu le courage de mettre des interros pour tous

-- FORMATIONS
INSERT INTO formation VALUES('DUT informatique');

-- UTILISATEURS/PROFESSEURS : id de 1 à 11
create sequence id;
INSERT INTO utilisateur VALUES(id.nextval, 'cdupuis', 'charlie91','Dupuis','Charlie','ch.dupuis@limsi.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'calyre', 'rosewood67','Allyre','Clément','clement.allyre@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'tamelin', '78yer27','Amelin','Thibault','amelinTh78@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'landreone', 'Per78900','Andreone','Luc','lucAnd@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'yantoine', 'ab060381','Antoine','Yoann','antoine.yoann@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'raublanc', '2812se','Aublanc','Romain','aublancR@hotmail.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'aauzolie', 'auzol687','Auzolie','Arthur','auzolarthur@yahoo.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'cblanchard', 'blck56','Blanchard','Clément','clemblanchard@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'pboiron', '45boiron','Boiron','Pierre','boironPierre@upmc.fr');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'agratton', 'gr675','Gratton','alexandre','alex.gratton@gmail.com');
INSERT INTO professeur VALUES(id.currval);
INSERT INTO utilisateur VALUES(id.nextval, 'mgrenier', 'Fer54030','Grenier','Maxime','maximegrenier@u-psud.fr');
INSERT INTO professeur VALUES(id.currval);


-- UTILISATEURS/ETUDIANTS : id de 12 à 37
create sequence num start with 211000;

INSERT INTO utilisateur VALUES(id.nextval, 'abouaziz', 'ziz974','Bouaziz','alexandra','alexandra.bouaziz56@live.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'sbouguila', 'bougy333','Bouguila','Selma','selmaBouguila@u-p8.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'abrand', 'Zer34012','Brand','Alexis','brand-Alex@gmail.com');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'mcamara', 'cra2809','Camara','Moussa','moussC@live.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'cchaux', 'Ch190794','Chaux','christine','chris.chaux@yahoo.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'econin', 'zar7644','Conin','Elisa','conin.Elisa91@gmail.com');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'jcorvisard', '56iuh9','Corvisard','Julie','julie.corvisard@u-p8.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'adesjardins', 'oi789d','Desjardins','Alexandra','alexandra.desjardins@u-psud.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'jdianas', 'poi87000','Dianas','Julien','dianajuju@gmail.com');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'ndinouel', '45ftg6','Dinouel','Natha','didiNatha78@wanadoo.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'rdonckers', 'donky7640','Donckers','Rémi','donckers.remi@upmc.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'meuphrosine', '3467uyt','Euphrosine','Mélissa','euphrosine.melissa@upmc.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'cfleury', '0104fc','Fleury','Cédric','cedric.quentin@u-psud.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'tgaerel', '067ghj','Gaerel','Théo','theoG@live.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'sgato', 'gat7478','Gato','Steven','gato.steven@u-psud.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'rgautier', 'jiuy65','Gautier','Romain','romaingautier@sfr.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'agestas', '876dkfy','Gestas','Amanda','gestasA@upmc.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'dgounot', 'gounot45','Gounot','Damien','damien.gounot@upmc.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'mgueguen', 'Her56789','Gueguen','Matthieu','mat.guegen@yahoo.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'ahamlat', 'hamlat23','Hamlat','Adeline','hamlat.adeline@u-p8.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'thenry', '45gh678','Henry','Théodore', 'theoH78@yahoo.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'ahuet', 'Gez5634','Huet','Augustin','huet.augustin@u-p8.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'mlandi', 'min89043','Landi','Maximin','landimax@u-p8.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'hjonvel', '87bos3','Jonvel','Hugo','hugjonvel@u-psud.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'lkabrai', 'Jon65400','Kabrai','Ludivine','ludi.kabrai@sfr.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');
INSERT INTO utilisateur VALUES(id.nextval, 'pkadre', '67gerty','Kadre','Peter','kadre-peter@sfr.fr');
INSERT INTO etudiant VALUES(id.currval, num.nextval, 'DUT informatique');

-- drop sequence num;
-- drop sequence id;



-- SEMESTRES/MATIERES/GROUPES/ETUDIANT_CHOISIT_GROUPE/INTERROS_CC
create sequence sem;
create sequence mat;
create sequence gr;
create sequence note;


INSERT INTO semestre VALUES(sem.nextval, 'Info-S1', 'DUT informatique');

-- les matières du semestres:
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Algorithmique', 3);
		-- les groupes de cette matière: id de 1 à 20
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 1, '2014-2015');
			-- les étudiants inscrits dans ce groupe:
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 12, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 12, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 13, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 18, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 14, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 15, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 15, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 10, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 16, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'),7, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 17, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 13, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 18, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 17, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 19, gr.currval, 'Interro d''algorithmique n°1', to_date('2014-11-06', 'YYYY-MM-DD'), 17.5, 1);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 1, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
			
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Programmation', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 1, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 2, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 17, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 12, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 18, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 7, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 19, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 15, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 23, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 16, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 24, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 10, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 25, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 9, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 26, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 8.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 27, gr.currval, 'Interro C++ n°1', to_date('2014-10-05', 'YYYY-MM-DD'), 13, 1);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Architecture', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 3, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 12, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 10, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 12, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 13, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 13, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 9, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 13, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 12, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 14, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 12, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 14, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 17, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 15, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 15, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 15, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 13, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 16, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 16, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 16, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 14.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 17, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 10, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 17, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 11, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 18, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 13, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 18, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 17, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 19, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 16, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 19, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 15.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 20, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 11, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 20, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 14, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 21, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 6, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 21, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 8, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 22, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 18, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 22, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 17, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 23, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 12, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 23, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 13.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 24, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 13, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 24, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 12.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 25, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 10.5, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 25, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 11, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 26, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 14, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 26, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 14.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 27, gr.currval, 'CC Architecture n°1', to_date('2014-10-03', 'YYYY-MM-DD'), 9, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 27, gr.currval, 'CC Architecture n°2', to_date('2014-11-17', 'YYYY-MM-DD'), 12.5, 1);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Système et Réseaux', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 4, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 4, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'ACSI', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 5, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 6, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Bases de données', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 6, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 6, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Mathématiques', 5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 7, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 7, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Gestion', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 8, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 8, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Communication', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 9, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 9, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Anglais', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 10, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(12, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 12, gr.currval, 'DM n°1', to_date('2014-10-28', 'YYYY-MM-DD'), 17, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 12, gr.currval, 'Interro Anglais n°1', to_date('2014-11-17', 'YYYY-MM-DD'), 12, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(13, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 13, gr.currval, 'DM n°1', to_date('2014-10-28', 'YYYY-MM-DD'), 15, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 13, gr.currval, 'Interro Anglais n°1', to_date('2014-11-17', 'YYYY-MM-DD'), 13, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(14, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 14, gr.currval, 'DM n°1', to_date('2014-10-28', 'YYYY-MM-DD'), 14, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 14, gr.currval, 'Interro Anglais n°1', to_date('2014-11-17', 'YYYY-MM-DD'), 13.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(15, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 15, gr.currval, 'DM n°1', to_date('2014-10-28', 'YYYY-MM-DD'), 14, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 15, gr.currval, 'Interro Anglais n°1', to_date('2014-11-17', 'YYYY-MM-DD'), 15, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(16, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 16, gr.currval, 'DM n°1', to_date('2014-10-28', 'YYYY-MM-DD'), 17, 0.5);
				INSERT INTO interros_cc VALUES(note.nextval, 16, gr.currval, 'Interro Anglais n°1', to_date('2014-11-17', 'YYYY-MM-DD'), 15.5, 1);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 10, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(17, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(18, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(19, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(21, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(22, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe C', 11, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(20, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 20, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 10, 0.5);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(24, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 24, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 15, 0.5);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(25, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 25, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 8, 0.5);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(23, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 23, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 11, 0.5);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(26, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 26, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 10.5, 0.5);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(27, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 27, gr.currval, 'Homework 1', to_date('2014-11-10', 'YYYY-MM-DD'), 12, 0.5);

				
				
-- S2 non commencé: pas d'étudiants inscrits aux groupes
INSERT INTO semestre VALUES(sem.nextval, 'Info-S2', 'DUT informatique');
-- id groupe de 21 à 41
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Algorithmique', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 1, '2014-2015');	
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 1, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Programmation', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 2, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 2, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Architecture', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 3, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Système et Réseaux', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 4, '2014-2015');			
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 4, '2014-2015');			
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'ACSI', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 5, '2014-2015');			
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 6, '2014-2015');			
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Bases de données', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 6, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 6, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Mathématiques', 5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 7, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 7, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Economie', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 8, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Gestion', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 8, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 8, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Communication', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 9, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 9, '2014-2015');
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Anglais', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 10, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 10, '2014-2015');
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe C', 11, '2014-2015');

		
		
		
INSERT INTO semestre VALUES(sem.nextval, 'Info-S3', 'DUT informatique');
-- id groupe de 42 à 58
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Algorithmique', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 2, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 2, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Programmation', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 3, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 28, gr.currval, 'Interro Java n°1', to_date('2014-10-23', 'YYYY-MM-DD'), 9, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 29, gr.currval, 'Interro Java n°1', to_date('2014-10-23', 'YYYY-MM-DD'), 12, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 30, gr.currval, 'Interro Java n°1', to_date('2014-10-23', 'YYYY-MM-DD'), 14, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 31, gr.currval, 'Interro Java n°1', to_date('2014-10-23', 'YYYY-MM-DD'), 13.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 32, gr.currval, 'Interro Java n°1', to_date('2014-10-23', 'YYYY-MM-DD'), 15.5, 1);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 2, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 33, gr.currval, 'Interro Java n°1', to_date('2014-10-20', 'YYYY-MM-DD'), 13, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 34, gr.currval, 'Interro Java n°1', to_date('2014-10-20', 'YYYY-MM-DD'), 14, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 35, gr.currval, 'Interro Java n°1', to_date('2014-10-20', 'YYYY-MM-DD'), 16, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 36, gr.currval, 'Interro Java n°1', to_date('2014-10-20', 'YYYY-MM-DD'), 10.5, 1);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
				INSERT INTO interros_cc VALUES(note.nextval, 37, gr.currval, 'Interro Java n°1', to_date('2014-10-20', 'YYYY-MM-DD'), 11, 1);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Programmation Web', 2);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 3, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 5, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Système et Réseaux', 1.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 4, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'ACSI', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 5, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Bases de données', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 6, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 6, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Mathématiques', 3);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 7, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Economie', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 8, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Gestion', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 8, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Communication', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 9, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 9, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);
	
	INSERT INTO matiere VALUES(mat.nextval, sem.currval, 'Anglais', 2.5);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe A', 11, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(28, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(29, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(30, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(33, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(34, gr.currval);
		INSERT INTO groupe(id_groupe, id_matiere, nom_groupe, id_professeur, date_formation) VALUES(gr.nextval, mat.currval, 'groupe B', 11, '2014-2015');
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(31, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(32, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(35, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(36, gr.currval);
			INSERT INTO etudiant_choisit_groupe(id_user, id_groupe) VALUES(37, gr.currval);

			
			
-- drop sequence sem;
-- drop sequence mat;
-- drop sequence gr;
-- drop sequence note;



