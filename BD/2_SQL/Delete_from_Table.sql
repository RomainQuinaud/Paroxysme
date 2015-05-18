


drop sequence sem;
drop sequence num;
drop sequence id;
drop sequence gr;
drop sequence etu;
drop sequence ens;
drop sequence note;


delete from STATS_SEMESTRE_ETUDIANT;
delete from STATS_ENSEIGNEMENT_ETUDIANT;
delete from NOTES;
delete from TYPE_NOTE;
delete from ETUDIANT_DANS_GROUPE;
delete from ETUDIANT;
delete from GROUPE_SUIT_ENSEIGNEMENT;
delete from GROUPE;
delete from ENSEIGNEMENT;
delete from MATIERE;
delete from SEMESTRE;
delete from FORMATION;
delete from PROFESSEUR;
delete from ADMIN;
delete from UTILISATEUR;