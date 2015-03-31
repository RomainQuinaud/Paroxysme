# JOURNAL DES MODIFICATIONS AU NIVEAU DE LA BASE DE DONNEES (SQL & PL/SQL)

## MARDI 31 MARS 2015

### Modification du script de création de la base de données

####Ajout de deux booléens "semestre_ouvert" et "semestre_termine" dans la table SEMESTRE
	- Permet de gérer les insertions et les updates dans la table NOTES
		- si semestre_ouvert est à false, inserer des notes pour un enseignement correspondant à ce semestre est impossible
		- si seul le booléen semestre_termine est à true, insérer des notes est impossible, sauf pour le professeur responsable de la formation (erreurs de saisies à rectifier, ...)
		- si semestre_termine=false AND semestre_ouver=true alors l'insertion dans NOTES est possible
	- Ces booléens sont calculés tous les jours à heure fixe (OOh01 par exemple)
		- Trouver une facon de réduire le montant de données à calculer (on ne va pas tout recalculer tous les jours pour toutes les formations et les semestres existant)
####Ajout d'un booléen "absence_justifiee" (DEFAULT = 0) dans la table NOTES
	- Associé au booléen "absent", cela permet de gérer les étudiants qui sont absent à une interrogation mais qui justifient cette absence par la suite
	- A la fin d'un semestre (par exemple), un élève qui a des absences non justifiées aura 0 aux interrogations correspondantes, tandis qu'un élève dont les absences sont justifiées aura soit une note de remplacement (il a rattrapé l'interrogation) soit cette interrogation où il est absent ne sera pas comptée dans sa moyenne