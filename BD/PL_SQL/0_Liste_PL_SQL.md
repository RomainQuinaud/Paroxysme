#Triggers, Packages, Fonctions et Procédures à implémenter



=================================	A FAIRE    		====================================


- trouver comment gérer une CONSTRAINT CHECK en java lorsqu'elle se déclenche
	- ou alors gérer directement ca en JAVA, comme si la BDD=PHP et JAVA=JavaScript



- trouver comment gérer les execptions lancées par PL/SQL en java



- trouver comment gérer le blocage d'un insert or update et afficher le pourquoi du comment en java


















====================================	MODIFICATIONS POSSIBLES 	====================================



- GERER le début et la fin des semestres
		- calculées cachées qui seraient "date_debut_reelle" et "date_fin_reelle"
				- trigger (after update or insert on each row) qui calcule une date de type JJ/MM/YYYY grâce à l'année de formation et le nom du semestre
		- booléens "semestre_ouvert" (default = false) et "semestre_termine" (default = false)
				- si semestre_ouvert est à false, inserer des notes pour un enseignement correspondant à ce semestre est impossible
				- si seul le booléen semestre_termine est à true, insérer des notes est impossible, sauf pour le professeur responsable de la formation (erreurs de saisies à rectifier, ...)
				- si semestre_termine=false AND semestre_ouver=true alors l'insertion dans NOTES est possible
		- ces booléens doivent être calculés
				- heure fixe tous les jours ?
				- action du professeur responsable d'une formation qui envoi une requête mise à jour des semestres ?



- 	Faut-il rajouter un booléen "abscence_justifiee" dans la table NOTES en plus du booléen "abstent" ?
		- si l'absence justifiée n'est pas cochée (et donc mise à true) par le prof, la note de l'élève passe à 0 à la fin du semestre
		- sinon cette note n'est pas prise en compte pour le calcul de la moyenne de l'élève (car absence justifiée)



-	Penser à gérer la rentrée d'une note losque l'élève a été absent et qu'il rattrape l'interro
		- genre récap pour le prof qui lui donne tous les élèves absents et en attente
			- section absences non justifiées
			- section absences justifiées
		- bouton "saisir note" qui mettra du coup tous les booléens "absents..." à false et saisira la note de l'élève à cette interro










================================	 TRIGGERS 		==============================================


Trigger after each row sur la table NOTES
	- mise à jour de la moyenne de l'enseignement en CC avec la nouvelle note entrée (table STATS_ENSEIGNEMENT_ETUDIANT)
	- mise à jour de la moyenne de l'enseignement en DS si la note entrée est de type DS (copié collé de la note en fait)
	- mise à jour de la moyenne générale de l'enseignement lorsque la note de DS est entrée

	- idem pour les attributs de moyennes dans la table GROUPE_SUIT_ENSEIGNEMENT



Trigger before insert or update sur la table NOTES
	- empêche l'insertion ou l'update de la table NOTES si les semestre_ouvert=false ou semestre_termine=true
	- option pour ne pas tenir compte de ce trigger si c'est le professeur responsable de la formation qui rentre ou modifie des notes
		- trigger lancant une fonction qui renvoie vrai ou faux selon l'ID de l'user
		- si prof responsable renvoi vrai et donc trigger ne fait rien
		- si autre, renvoi faux et trigger empêche insert ou update 



Trigger sur la table STATS_ENSEIGNEMENT_ETUDIANT qui calculera la moyenne de l'étudiant au semestre et l'inserera dans la table STATS_SEMESTRE_ETUDIANT
	- after insert de la moyenne générale d'un enseignement ?
	- une fois que la date du semestre est passée (ou option booléen semestre_termine) ? (cad que le semestre est finit)
		- calcul de la moyenne du semestre grâce à toutes les moyennes par enseignement (et les coefs propres aux enseignements)













=================================	 PACKAGES 		==============================================

Package Stats
	- contient fonctions et procédures utilisées pour le calcul des différentes moyennes et appelées dans les différents triggers










==================================	 PROCEDURES 		===============================================















==================================	 FONCTIONS	================================================


Fonction isResponsable(idUser, xxx) return boolean
	-- renvoie vrai si l'idUser est celle du professeur responsable de la formation
	-- xxx à voir ce que c'est, si c'est id_semestre, id_enseignement, ... 
			-- peut être id_enseignement vu que ca sera utilisé pour accepter ou non la modification ou l'insertion dans NOTES pour une formation donnée et que un professeur peut être responsable d'une formation mais pas d'une autre











