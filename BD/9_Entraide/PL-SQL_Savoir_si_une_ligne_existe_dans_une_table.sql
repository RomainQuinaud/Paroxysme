
-- 4) Blocs PL/SQL : créer un bloc PL/SQL qui accorde un bonus à chaque client en fonction du 
--		nombre de locations effectuées:

-- a. Créer une table tableBonus (login, bonus, nbrExLoues).
--		L’attribut bonus est de type real et l’attribut nbrExLoues est de type integer.

--=============================================================--
--	CREATE TABLE TABLEBONUS (
--		login VARCHAR2(30) NOT NULL,
--  	bonus REAL,
--  	nbExLoues INTEGER,
--  	CONSTRAINT PK_TABLEBONUS PRIMARY KEY (login),
--  	CONSTRAINT FK_TABLEBONUS_CLIENT FOREIGN KEY (login) REFERENCES CLIENT(login)
--	);
--=============================================================--



-- b. Pour Remplir la table tableBonus sans calculer le bonus.
--		Les tables client et location donnent les informations pour les logins et le nombre de locations correspondant.

-- c. Etant donnés deux nombres entiers positifs constant n1=4 et n2=8, mettre à jour la table tableBonus telle que :
-- 				- si 0 < nbrExLoues < n1 on accorde un bonus de 0.1 ;
--				- si n1 ≤ nbrExLoues < n2 on accorde un bonus de 0.2 ;
--				- si n2 ≤ nbrExLoues on accorde un bonus de 0.4 ;
--				- si nbrExLoues est NULL on n’accorde pas de bonus.




--===================== VERSION AVEC FOR ligne IN cursor ==================--
--==================== Pas besoin de OPEN ou CLOSE cursor ==================--



DECLARE
	n1 CONSTANT INTEGER := 4; -- en variable constante pour l'instant afin que les seuils de bonus ne soient pas modifiés sans qu'on le veuille
	n2 CONSTANT INTEGER := 8; -- en variable constante pour l'instant afin que les seuils de bonus ne soient pas modifiés sans qu'on le veuille
	bool_exists NUMBER(1);

  	CURSOR CountExemplaireLoues IS -- Déclaration du Curseur "CountExemplaireLoues"
	    SELECT login, COUNT(numLoc) AS NB_EXEMPLAIRES_LOUES
	    FROM LOCATION
	    GROUP BY login;

  	CURSOR UpdateBonus IS -- Déclaration du Curseur "UpdateBonus" avec la spécification FOR UPDATE
      	SELECT *
      	FROM TABLEBONUS
      	FOR UPDATE;

	ligne_CountExemplaireLoues CountExemplaireLoues%ROWTYPE; -- Variable de type dérivée qui correspond à une ligne du curseur CountExemplaireLoues
	ligne_UpdateBonus UpdateBonus%ROWTYPE; -- Variable de type dérivée qui correspond à une ligne du curseur UpdateBonus


BEGIN
	-- Ouverture et fermeture implicite avec une boucle FOR "variable" IN curseur donc pas d'OPEN ou de CLOSE Cursor
	FOR ligne_CountExemplaireLoues IN CountExemplaireLoues -- pour chaque ligne de la requête contenue dans le Curseur
	LOOP -- Début de la boucle

		-- Procédure de création d'un booléen de type numérique 0 ou 1
		SELECT CASE -- permet de faire un THEN ELSE selon le cas obtenu dans le WHEN
			WHEN EXISTS ( -- si l'on a un résultat, alors le login de la table LOCATION existe déjà dans la table TABLEBONUS (le client à déjà loué des films).
				SELECT DISTINCT login
				FROM LOCATION
				WHERE login = ligne_CountExemplaireLoues.login AND login IN (
					SELECT login
					FROM TABLEBONUS
					)
				)
				THEN 1 -- On initialisera alors bool_exists à 1
				ELSE 0 -- Initialisation à 0 car la requête EXISTS n'a pas renvoyé de résultats donc c'est un client qui n'existe pas dans la table bonus (il faudra le créer avec un INSERT INTO)
				END INTO bool_exists
		FROM dual; -- Permet de spécifier une table "fictive" afin de respecter la syntaxe SQL



		IF bool_exists = 0 THEN -- Client non présent dans TABLEBONUS donc il faut faire un INSERT INTO
			INSERT INTO TABLEBONUS (login, nbExLoues)
			VALUES (ligne_CountExemplaireLoues.login, ligne_CountExemplaireLoues.NB_EXEMPLAIRES_LOUES);
		ELSE -- Client existe donc il faut faire un UPDATE (remplacement de l'ancienne valeur par la nouvelle, donc pas de "nbExLoues = nbExLoues + xxxxxx" )
			UPDATE TABLEBONUS
			SET nbExLoues = ligne_CountExemplaireLoues.NB_EXEMPLAIRES_LOUES
			WHERE login = ligne_CountExemplaireLoues.login;
		END IF;
	END LOOP;



	-- Ouverture et fermeture implicite avec une boucle FOR "variable" IN curseur donc pas d'OPEN ou de CLOSE Cursor
	FOR ligne_UpdateBonus IN UpdateBonus
	LOOP
		IF ligne_UpdateBonus.nbExLoues > 0 AND ligne_UpdateBonus.nbExLoues < n1 THEN
			UPDATE TABLEBONUS
			SET bonus = 0.1
			WHERE CURRENT OF UpdateBonus;
		ELSIF ligne_UpdateBonus.nbExLoues >= n1 AND ligne_UpdateBonus.nbExLoues < n2 THEN
			UPDATE TABLEBONUS
			SET bonus = 0.2
			WHERE CURRENT OF UpdateBonus;
		ELSIF ligne_UpdateBonus.nbExLoues >= n2 THEN
			UPDATE TABLEBONUS
			SET bonus = 0.4
			WHERE CURRENT OF UpdateBonus;
		ELSE
			UPDATE TABLEBONUS
			SET bonus = 0
			WHERE CURRENT OF UpdateBonus;
		END IF;
	END LOOP;


	COMMIT; -- Obligatoire quand on fait un UPDATE avec CURSEUR et avec VERROU (la table est bloquée jusqu'à l'exécution d'un COMMIT)
END;
/