# JOURNAL DES MODIFICATIONS AU NIVEAU DE LA BASE DE DONNEES (SQL & PL/SQL)



## MARDI 31 MARS 2015


#### Modification du script de création de la base de données


#####Ajout de deux booléens "semestre_ouvert" et "semestre_termine" dans la table SEMESTRE

- Permet de gérer les insertions et les updates dans la table NOTES
	- si semestre_ouvert est à false, inserer des notes pour un enseignement correspondant à ce semestre est impossible
	- si seul le booléen semestre_termine est à true, insérer des notes est impossible, sauf pour le professeur responsable de la formation (erreurs de saisies à rectifier, ...)
	- si semestre_termine=false AND semestre_ouver=true alors l'insertion dans NOTES est possible
- Ces booléens sont calculés tous les jours à heure fixe (OOh01 par exemple)
	- Trouver une facon de réduire le montant de données à calculer (on ne va pas tout recalculer tous les jours pour toutes les formations et les semestres existant)




#####Ajout d'un booléen "absence_justifiee" (DEFAULT = 0) dans la table NOTES

- Associé au booléen "absent", cela permet de gérer les étudiants qui sont absent à une interrogation mais qui justifient cette absence par la suite
- A la fin d'un semestre (par exemple), un élève qui a des absences non justifiées aura 0 aux interrogations correspondantes, tandis qu'un élève dont les absences sont justifiées aura soit une note de remplacement (il a rattrapé l'interrogation) soit cette interrogation où il est absent ne sera pas comptée dans sa moyenne



#####Ajout d'une attribut "coef_total_CC" dans la table STATS_ENSEIGNEMENT_ETUDIANT

- Cela permet d'éviter de recalculer la moyenne d'un étudiant à un enseignemant à chaque fois
	- Lorsqu'une nouvelle note est rentrée, le calcul de la moyenne sera le suivant : `moy_etu_enseignement_CC = (moy_etu_enseignement_CC + (nouvelleNote*coefNouvelleNote))/(coef_total_CC+coefNouvelleNote)`
	- Penser dans le trigger de calcul de moyenne à gérer le cas où la moyenne est NULL (premiere note)








## VENDREDI 03 AVRIL 2015


#### Modification du script de création de la base de données


##### Supression des attributs dans GROUPE_SUIT_ENSEIGNEMENT
```SQL
moy_groupe_enseignement_CC REAL
moy_groupe_enseignement_DS REAL
moy_groupe_enseignement_total REAL
```
- Attributs au final inutiles
- Au départ, je pensais celà utile pour avoir une idée du classement de l'élève
	- Mais pour avoir la position d'un élève dans un semestre, il suffit de trier par ordre décroissant dans la table STATS_SEMESTRE_ETUDIANT pour un semestre donné
- Pas de modifications à faire dans les Inserts