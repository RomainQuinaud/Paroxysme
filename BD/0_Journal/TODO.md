# A IMPLEMENTER



## IDEE GENERALES
- trouver comment gérer une CONSTRAINT CHECK en java lorsqu'elle se déclenche
	- ou alors gérer directement ca en JAVA, comme si la BDD=PHP et JAVA=JavaScript

- trouver comment gérer les execptions lancées par PL/SQL en java

- trouver comment gérer le blocage d'un insert or update et afficher le pourquoi du comment en java

- Penser à gérer la rentrée d'une note losque l'élève a été absent et qu'il rattrape l'interro
	- genre récap pour le prof qui lui donne tous les élèves absents et en attente
		- section absences non justifiées
		- section absences justifiées
	- bouton "saisir note" qui mettra du coup tous les booléens "absents..." à false et saisira la note de l'élève à cette interro










## TRIGGERS


- Trigger MOYENNE ETUDIANT ENSEIGNEMENT after each row sur la table NOTES
	- mise à jour de la moyenne de l'enseignement en CC avec la nouvelle note entrée (table STATS_ENSEIGNEMENT_ETUDIANT)
	- mise à jour de la moyenne de l'enseignement en DS si la note entrée est de type DS (copié collé de la note en fait)
	- mise à jour de la moyenne générale de l'enseignement lorsque la note de DS est entrée

- Trigger MOYENNE GROUPE ENSEIGNEMENT
	- pour les attributs de moyennes dans la table GROUPE_SUIT_ENSEIGNEMENT



- Trigger CONTROLE DES NOTES before insert or update sur la table NOTES
	- empêche l'insertion ou l'update de la table NOTES si les semestre_ouvert=false ou semestre_termine=true
	- option pour ne pas tenir compte de ce trigger si c'est le professeur responsable de la formation qui rentre ou modifie des notes
		- trigger lancant une fonction qui renvoie vrai ou faux selon l'ID de l'user
		- si prof responsable renvoi vrai et donc trigger ne fait rien
		- si autre, renvoi faux et trigger empêche insert ou update 



- Trigger sur la table STATS_ENSEIGNEMENT_ETUDIANT qui calculera la moyenne de l'étudiant au semestre et l'inserera dans la table STATS_SEMESTRE_ETUDIANT
	- after insert de la moyenne générale d'un enseignement ?
	- une fois que la date du semestre est passée (ou option booléen semestre_termine) ? (cad que le semestre est finit)
		- calcul de la moyenne du semestre grâce à toutes les moyennes par enseignement (et les coefs propres aux enseignements)













## PACKAGES

- Package Stats
	- contient fonctions et procédures utilisées pour le calcul des différentes moyennes et appelées dans les différents triggers ??










## PROCEDURES















## FONCTIONS













