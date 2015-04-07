# A IMPLEMENTER



## IDEE GENERALES
#####Trouver comment gérer une CONSTRAINT CHECK en java lorsqu'elle se déclenche
- ou alors gérer directement ca en JAVA, comme si la BDD=PHP et JAVA=JavaScript



#####Trouver comment gérer les execptions lancées par PL/SQL en java

#####Trouver comment gérer le blocage d'un insert or update et afficher le pourquoi du comment en java



#####Penser à gérer la rentrée d'une note losque l'élève a été absent et qu'il rattrape l'interro
- genre récap pour le prof qui lui donne tous les élèves absents et en attente
	- section absences non justifiées
	- section absences justifiées
- bouton "saisir note" qui mettra du coup tous les booléens "absents..." à false et saisira la note de l'élève à cette interro











## A implémemnter en Java

##### Gérer l'insertion ou pas dans la table notes
- Si le semestre n'est pas encore ouvert (n'a pas encore commencé)
	- Personne ne peut insérer de notes
- Si le semestre est ouvert et non fermé
	- "Tout le monde" peut insérer des notes
- Si le semestre est fermé (terminé)
	- Seul le professeur responsable de la formation peut insérer ou modifier les notes
	
##### Gérer l'insertion ou pas dans la table etudiant
- Lors de l'ajout d'un utilisateur, calcul du login et du mail en JAVA et préparation de la requête d'insert














## TRIGGERS

##### Sur la table NOTES
- After INSERT for each row (trigger qui fera des insertions dans la table STATS_ENSEIGNEMENT_ETUDIANT)
	- si c'est une note de type CC
		- si c'est la première note, il n'y a pas de ligne correspondant à cet étudiant, ce groupe et cet enseignement dans la table STATS_ENSEIGNEMENT_ETUDIANT
			- initialisation de la moyenne_enseignement_CC avec cette note et "coeff_total" = coeff de la note
			- moyenne_enseignement_DS et moyenne_enseignement_total sont alors à NULL
		- si ce n'est pas la première note, il y a une ligne correspondant à cet étudiant, ce groupe et cet enseignement dans la table STATS_ENSEIGNEMENT_ETUDIANT
			- mise à jour de la moyenne et de l'attribut "coeff_total"
	- si c'est une note de type DS
		- copié collé de cette note dans l'attribut correspondant dans la table STATS_ENSEIGNEMENT_ETUDIANT (selon toute logique, la ligne correspondante existe car l'élève a déjà eu des notes de CC)

- After UPDATE of valeur_note, coef_note for each row (dans le cas d'une modification d'une note)
	- pas de calcul si on update autre chose que la note ou le coefficient de la note
	- si c'est une note de type CC
		- mise à jour de la moyenne (elle est forcément initialisée vu qu'on fait un update)
		- moyenne = ( moyenne - (:OLD.note\*:OLD.coef_note) + (:NEW.note\*:NEW.coef_note) ) / (coef_total - :OLD.coef_note + :NEW.coef_note) (pas sur de la formule)
	- si c'est une note de type DS
		- copié collé de cette note dans l'attribut correspondant dans la table STATS_ENSEIGNEMENT_ETUDIANT (on écrase l'ancienne note)

- After DELETE for each row (dans le cas d'une suppression)
	- Exemple : un professeur veut supprimer une interrogation => cela supprimera les notes de tous les élèves du groupe pour cette interrogation là
	- si c'est une note de type CC
		- mise à jour de la moyenne (elle est forcément initialisée vu qu'on fait un delete)
			- si "coeff_total" = ":OLD.coef_note"
				- cela veut dire que la moyenne n'est calculée qu'à partir d'une seule note donc il va juste falloir la mettre à NULL (pas de division par zéro)
			- sinon, calcul de la nouvelle moyenne
				- moyenne = ( moyenne - :OLD.note \*  :OLD.coef_note ) / ( coef_total - :OLD.coef_note )
	- si c'est une note de type DS
		- illogique de supprimer un DS donc gérer ca en java ou en trigger, mais empêcher la suppression d'une note de DS (seulement modifiable)

***


##### Sur la table STATS_ENSEIGNEMENT_ETUDIANT
- After UPDATE of moyenne_enseignement_CC (on each row ?)
	- si moyenne_enseignement_DS est NULL => ne rien faire
	- si moyenne_enseignement_DS n'est pas NULL
		- relancer le calcul de la moyenne_enseignement_total avec la nouvelle valeur de la moyenne_enseignement_CC (moyenne_enseignement_total = moyenne_enseignement_CC\*0,4 + moyenne_enseignement_DS\*0,6)

- After INSERT or UPDATE of moyenne_enseignement_DS (on each row ?)
	- lancer le calcul de la moyenne_enseignement_total avec la nouvelle valeur de la moyenne_enseignement_DS (moyenne_enseignement_total = moyenne_enseignement_CC\*0,4 + moyenne_enseignement_DS\*0,6)

- After INSERT or UPDATE of moyenne_enseignement_total (on each row ?)
	- lancer l'initialisation ou la mise à jour des moyennes de l'étudiant au semestre (un enseignement correspond à un seul semestre)
		- After INSERT or UPDATE of moyenne_enseignement_total car on sait alors que l'élève a normalement une moyenne_CC et une moyenne_DS par enseignement
		- Calcul complet à chaque fois, sinon il faudrait rajouter des attributs coef_total un peu partout
		- Pas un calcul énorme, seulement une trentaine d'opérations...
	- s'il n'y a pas de ligne correspondant à cet étudiant et au semestre correspondant à l'enseignement alors il faut INSERT
		- appel d'une fonction qui renvoie la moyenne de CC du semestre pour cet étudiant
			- trouver tous les enseignements pour cet id_user et cet id_groupe dans la table STATS_ENSEIGNEMENT_ETUDIANT
			- pour chaque enseignement de son groupe, moyenne_semestre_CC = (somme des moyenne_enseignement_CC \* coef_enseignement) / (somme des coef_enseignement)
				- penser à tester des valeurs à NULL (ca peut arriver, auquel cas on n'en tient pas compte dans le calcul)
		- appel d'une fonction qui renvoie la moyenne de DS du semestre pour cet étudiant
			- trouver tous les enseignements pour cet id_user et cet id_groupe dans la table STATS_ENSEIGNEMENT_ETUDIANT
			- pour chaque enseignement de son groupe, moyenne_semestre_DS = (somme des moyenne_enseignement_DS \* coef_enseignement) / (somme des coef_enseignement)
				- penser à tester des valeurs à NULL (ca peut arriver, auquel cas on n'en tient pas compte dans le calcul)
		- appel d'une fonction qui renvoie la moyenne totale du semestre pour cet étudiant
			- trouver tous les enseignements pour cet id_user et cet id_groupe dans la table STATS_ENSEIGNEMENT_ETUDIANT
			- pour chaque enseignement de son groupe, moyenne_semestre_total = (somme des moyenne_enseignement_total \* coef_enseignement) / (somme des coef_enseignement)
				- penser à tester des valeurs à NULL (ca peut arriver, auquel cas on n'en tient pas compte dans le calcul)
		- possibilité de tout faire en une seule procédure qui renvoie ces informations par le biais de ses paramètres (en référence)
	- si une ligne existe pour cet étudiant et le semestre correspondant à l'enseignement, alors il faut update
		- appel des mêmes fonctions que précédement, sauf que le Trigger fait un update au lieu d'un Insert








***






##### Sur la table SEMESTRE pour les booléens semestre_ouvert et semestre_termine
######Se déclenche tous les jours à OOhO1
- lance une procédure pour ouvrir les semestres qui ont besoin d'être ouverts
- lance une procédure pour fermer les semestres qui ont besoint d'être fermés

###### Mise en place avec [DBMS_SCHELUDER](http://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_sched.htm)
- Ce ne sera pas vraiment un trigger mais plutôt un évènement qui sera enregistré et qui lancera des procédures
- Disons par exemple que ces procédures sont dans le package Fonctions_Utiles
- Voilà la procédure à suivre (code pas forcément correct pour l'instant)
```SQL
begin
  dbms_scheduler.create_job (
    job_name = 'DEL_EXP_RESERVATIONS',  -- Choose some name. 
    job_type = 'PLSQL_BLOCK',
    job_action = 'begin Fonctions_Utiles.open_semester; Fonctions_Utiles.close_semester; end;',
    start_date = SYSDATE,
    repeat_interval = 'FREQ=DAILY',
    enabled = TRUE,
    comments = 'Daily update of semesters'
    );
end;
/
```









## PACKAGES

- Package Stats
	- contient fonctions et procédures utilisées pour le calcul des différentes moyennes et appelées dans les différents triggers


- Pachage Fonctions_Utiles
	- contient fonctions et procédures du genre de celle qui renvoie vrai ou faux selon que le professeur actuellement connecté est responsable de la formation ou pas

















## PROCEDURES


##### Supression d'une interrogation de contrôle continu de la part d'un professeur
- Scénario : 
	- Professeur gère ses enseignement => il en sélectionne un (on a l'id_enseignement)
	- Il sélectionne un des groupes qui suit cet enseignement (on a l'id_groupe)
	- Il a alors la liste des interrogations
		- Grâce à `CONSTRAINT UNIQUE_LIBELLE_INTERROGATION UNIQUE (id_groupe, libelle_interrogation, id_enseignement, id_user)`, on sait qu'il n'y aura pas deux même libelle_interrogation pour un groupe et un enseignement donné
		- Il clique sur supprimer l'interrogation (on ne sait jamais, des fois qu'elle soit trop mauvaise ^^)
			- Possibilité de ne proposer cette option que pour le prof responsable
		- Pour chaque id_note qui match le libellé, le groupe et l'enseignement, supprimer la note

***


##### Procédure open_semester qui ouvre les semestres qui ont besoin d'être ouverts
- Sélectionner tous les semestres qui ont semestre_ouvert à false
	+ Si date_debut ≤ SYSDATE alors le mettre à vrai
	+ Sinon ne rien faire

***


##### Procédure close_semester qui ferme les semestres qui ont besoin d'être fermés
- Sélectionner tous les semestres qui ont semestre_termine à false
	+ Si date_fin ≤ SYSDATE alors le mettre à vrai
	+ Sinon ne rien faire









## FONCTIONS


##### Fonction professeur responsable (à remplir par Romain)








