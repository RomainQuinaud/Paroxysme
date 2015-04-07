/*
									PROJET DE BASE DE DONNÉE
								Configuration du serveur ORACLE
					
					
	Le présent fichier présente la configuration du serveur Oracle utilisé pour le projet. Il donne
	des brides d'instruction et n'est, à ce titre, pas exécutable.
	
	This file presents the configuration of the Oracle Database server used for this project. It only
	gives parts of instruction and so can't be executed directly.

*/


-- FORCE THE USER LOGOUT
/*
SELECT SID, SERIAL#, USERNAME, STATUS  FROM V$SESSION; -- Displays the connection information
ALTER SYSTEM DISCONNECT SESSION  '$SID,$SERIAL'  IMMEDIATE ; -- close the session
*/


--###########################################################################################
--										TABLESPACES
--###########################################################################################
-- Creation of the tablespace in order to have a dedicated one for our system.
-- Size of 500M
CREATE TABLESPACE paroxysme 
	DATAFILE 'paroxysme.dat' 
	SIZE 500M;

--###########################################################################################
--											USERS
--###########################################################################################

 
	CREATE PROFILE developpeur LIMIT 
		SESSIONS_PER_USER 1
		CPU_PER_SESSION UNLIMITED
		CPU_PER_CALL UNLIMITED
		CONNECT_TIME UNLIMITED;
		
	CREATE PROFILE etudiant LIMIT
		SESSIONS_PER_USER 1
		CPU_PER_SESSION 3600
		CPU_PER_CALL 3600
		CONNECT_TIME UNLIMITED
		IDLE_TIME 5;
		
	CREATE PROFILE professeur LIMIT
		SESSIONS_PER_USER 1
		CPU_PER_SESSION 3600
		CPU_PER_CALL 3600
		CONNECT_TIME UNLIMITED
		IDLE_TIME 5;
		
	CREATE PROFILE administrateur LIMIT
		SESSIONS_PER_USER 1
		CPU_PER_SESSION UNLIMITED
		CPU_PER_CALL UNLIMITED
		CONNECT_TIME UNLIMITED
		IDLE_TIME UNLIMITED;

-- Users for tests
	CREATE USER paroxysme -- useful for tests : hosts the database
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;
		
	-- One user per person in the group
	-- Once again, only for the tests
	CREATE USER jeanne
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;
		
	CREATE USER laurence
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;
		
	CREATE USER raphael
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;

	CREATE USER romain
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;
		
	CREATE USER thomas
		IDENTIFIED BY as20142015
		QUOTA UNLIMITED ON paroxysme
		DEFAULT TABLESPACE paroxysme
		PROFILE developpeur;

-- Final users : modelisation of our class

	CREATE USER administrateur
	IDENTIFIED BY admin
	DEFAULT TABLESPACE paroxysme
	PROFILE administrateur;
	
/* DO NOT WORK : '.' means a relation of ower / own --> usage of shorter logins	
	-- students
	CREATE USER benjamin.bailly 
	IDENTIFIED BY benjamin 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER radu catalin.horeanu 
	IDENTIFIED BY radu catalin 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER thomas.cottin 
	IDENTIFIED BY thomas 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER gaetan.cousin 
	IDENTIFIED BY gaetan 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER charles.duplatre 
	IDENTIFIED BY charles 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER titouan.galopin 
	IDENTIFIED BY titouan 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER jeanne.gamain 
	IDENTIFIED BY jeanne 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER laurence.gandois 
	IDENTIFIED BY laurence 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER raphaël.hamonnais 
	IDENTIFIED BY raphaël 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER adrien.leveque 
	IDENTIFIED BY adrien 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER pierre-gilles.leymarie 
	IDENTIFIED BY pierre-gilles 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER yani.makouf 
	IDENTIFIED BY yani 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER felix.mensah 
	IDENTIFIED BY felix 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER romain.quinaud 
	IDENTIFIED BY romain 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER lucas.rosaz 
	IDENTIFIED BY lucas 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER aurore.thomas 
	IDENTIFIED BY aurore 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	CREATE USER philippe.vieira aleixo 
	IDENTIFIED BY philippe 
	DEFAULT TABLESPACE paroxysme 
	PROFILE etudiant;

	-- teachers
	CREATE USER frederic.crepel 
	IDENTIFIED BY crepel 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER cecile.balkanski 
	IDENTIFIED BY balkanski 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER elodie.leducq 
	IDENTIFIED BY leducq 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER yacine.belick 
	IDENTIFIED BY belick 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER helenne.meynard 
	IDENTIFIED BY meynard 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER amaria.dupin 
	IDENTIFIED BY dupin 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER gabriel.illouz 
	IDENTIFIED BY illouz 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER laurence.salvator 
	IDENTIFIED BY salvator 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER nicolas.ferey 
	IDENTIFIED BY ferey 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER patricia.fournier 
	IDENTIFIED BY fournier 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER johann.poignant 
	IDENTIFIED BY poignant 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER cedric.fournier 
	IDENTIFIED BY fournier 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER kim-thuat.nguyen 
	IDENTIFIED BY nguyen 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER caroline.fabre 
	IDENTIFIED BY fabre 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER anne.vilnat 
	IDENTIFIED BY vilnat 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

	CREATE USER roza.lemdani 
	IDENTIFIED BY lemdani 
	DEFAULT TABLESPACE paroxysme 
	PROFILE professeur;

*/
-- students
CREATE USER bbailly 
IDENTIFIED BY bailly 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER rhoreanu 
IDENTIFIED BY catalin horeanu 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER tcottin 
IDENTIFIED BY cottin 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER gcousin 
IDENTIFIED BY cousin 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER cduplatre 
IDENTIFIED BY duplatre 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER tgalopin 
IDENTIFIED BY galopin 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER jgamain 
IDENTIFIED BY gamain 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER lgandois 
IDENTIFIED BY gandois 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER rhamonnais 
IDENTIFIED BY hamonnais 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER aleveque 
IDENTIFIED BY leveque 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER pleymarie 
IDENTIFIED BY leymarie 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER ymakouf 
IDENTIFIED BY makouf 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER fmensah 
IDENTIFIED BY mensah 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER rquinaud 
IDENTIFIED BY quinaud 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER lrosaz 
IDENTIFIED BY rosaz 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER athomas 
IDENTIFIED BY thomas 
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;

CREATE USER pvieira 
IDENTIFIED BY vieira
DEFAULT TABLESPACE paroxysme 
PROFILE etudiant;


 -- techers
CREATE USER fcrepel 
IDENTIFIED BY crepel 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER cbalkanski 
IDENTIFIED BY balkanski 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER eleducq 
IDENTIFIED BY leducq 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER ybelick 
IDENTIFIED BY belick 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER hmeynard 
IDENTIFIED BY meynard 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER adupin 
IDENTIFIED BY dupin 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER gillouz 
IDENTIFIED BY illouz 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER lsalvator 
IDENTIFIED BY salvator 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER nferey 
IDENTIFIED BY ferey 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER pfournier 
IDENTIFIED BY fournier 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER jpoignant 
IDENTIFIED BY poignant 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER cfournier 
IDENTIFIED BY fournier 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER knguyen 
IDENTIFIED BY nguyen 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER cfabre 
IDENTIFIED BY fabre 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER avilnat 
IDENTIFIED BY vilnat 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;

CREATE USER rlemdani 
IDENTIFIED BY lemdani 
DEFAULT TABLESPACE paroxysme 
PROFILE professeur;



	
--###########################################################################################
--										ROLES AND PRIVILEGES
--###########################################################################################


-- tests users
	-- Creation of a role utilisateur for the members of our group of developers
		CREATE ROLE utilisateur;
		GRANT CREATE TABLE, 
				CREATE SESSION,
				CREATE PROCEDURE,
				CREATE TRIGGER,
				CREATE VIEW,
				CREATE SEQUENCE,
				UNLIMITED TABLESPACE
				TO utilisateur;
		GRANT UNLIMITED TABLESPACE TO paroxysme;
		GRANT utilisateur TO jeanne, laurence, raphael, romain, thomas, paroxysme;
		/* Each user from utilisateur can create and edit any table in all the schemes. */
		GRANT 
			CREATE ANY TABLE,
			SELECT ANY TABLE, 
			INSERT ANY TABLE,
			DELETE ANY TABLE,
			UPDATE ANY TABLE,
			REFERENCES ANY TABLE,
			DROP ANY TABLE TO utilisateur;
		-- Each member executes this bloc in order to check its rights.
		DECLARE
			nomConnection VARCHAR2(30);
		BEGIN
			SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') INTO nomConnection
			FROM DUAL;
			EXECUTE IMMEDIATE 'CREATE TABLE paroxysme.'||nomConnection||' ( dateCreation DATE)';
			EXECUTE IMMEDIATE 'INSERT INTO paroxysme.'||nomConnection||' VALUES (sysdate)';
			EXECUTE IMMEDIATE 'SELECT * FROM paroxysme.'||nomConnection;
		END;

-- Function in order to apply roles : IMPOSSIBLE = cant work with functions or views on DBA_USERS
/*
CREATE VIEW usersViewParox AS
	SELECT USERNAME, PROFILE 
	FROM DBA_USERS
	WHERE DEFAULT_TABLESPACE='PAROXYSME'
WITH READ ONLY;
  
CREATE OR REPLACE PROCEDURE updatePrivilege IS
	login VARCHAR2(30);
	prof VARCHAR2(30);
	Cursor parcoursUtilisateur IS
		SELECT USERNAME, PROFILE
		FROM usersViewParox;
BEGIN
	OPEN parcoursUtilisateur;
	LOOP
		FETCH parcoursUtilisateur INTO login, prof;
		EXIT WHEN parcoursUtilisateur%NOTFOUND;
		IF (prof='DEFAULT') 
			--THEN RAISE pasProfile; -- we wont stop the execution, just display a message.
			THEN DBMS_OUTPUT.PUT_LINE('L''utilisateur '||login||' n''a aucun profil !');
		END IF;
		IF (prof="PROFESSEUR") 
			THEN EXECUTE IMMEDIATE 'GRANT teacher TO '||login;
			ELSE IF (prof="ETUDIANT") 
				THEN EXECUTE IMMEDIATE 'GRANT student TO '|| login;
			END IF;
		END IF;
	END LOOP;
	CLOSE parcoursUtilisateur;
END;*/

-- Role 'admin' : used for each admin

	CREATE ROLE adminDB;
	GRANT DBA to adminDB; -- the admin has all the privileges;
	
	GRANT adminDB TO administrateur;
	
	
	
-- Role 'student' : used for every student 

	CREATE ROLE student;
	
	GRANT CREATE SESSION TO student;
	GRANT SELECT TO student;
	
	GRANT student TO bbailly;
	GRANT student TO rhoreanu;
	GRANT student TO tcottin;
	GRANT student TO gcousin;
	GRANT student TO cduplatre;
	GRANT student TO tgalopin;
	GRANT student TO jgamain;
	GRANT student TO lgandois;
	GRANT student TO rhamonnais;
	GRANT student TO aleveque;
	GRANT student TO pleymarie;
	GRANT student TO ymakouf;
	GRANT student TO fmensah;
	GRANT student TO rquinaud;
	GRANT student TO lrosaz;
	GRANT student TO athomas;
	GRANT student TO pvieira;

-- Role 'teacher' : used for every teacher
	
	CREATE ROLE teacher;
	
	GRANT SELECT, INSERT, UPDATE TO teacher;
	
	GRANT teacher TO fcrepel;
	GRANT teacher TO cbalkanski;
	GRANT teacher TO eleducq;
	GRANT teacher TO ybelick;
	GRANT teacher TO hmeynard;
	GRANT teacher TO adupin;
	GRANT teacher TO gillouz;
	GRANT teacher TO lsalvator;
	GRANT teacher TO nferey;
	GRANT teacher TO pfournier;
	GRANT teacher TO jpoignant;
	GRANT teacher TO cfournier;
	GRANT teacher TO knguyen;
	GRANT teacher TO cfabre;
	GRANT teacher TO avilnat;
	GRANT teacher TO rlemdani;



-- Role 'responsible' : used for the responsibles of the section

	CREATE ROLE responsible;
	
	GRANT teacher TO responsible;
	

	

