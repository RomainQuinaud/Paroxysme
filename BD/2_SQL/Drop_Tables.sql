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
drop table ADMIN;
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

