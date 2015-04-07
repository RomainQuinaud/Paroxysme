# TRAVAUX EN COURS



## LAURENCE

Procédure close_semester qui ferme les semestres qui ont besoin d'être fermés
Procédure open_semester qui ouvre les semestres qui ont besoin d'être ouverts
Procédure Supression d'une interrogation de contrôle continu de la part d'un professeur






## JEANNE

Trigger sur la table STATS_ENSEIGNEMENT_ETUDIANT

After UPDATE of moyenne_enseignement_CC (on each row ?)

si moyenne_enseignement_DS est NULL => ne rien faire
si moyenne_enseignement_DS n'est pas NULL
relancer le calcul de la moyenne_enseignement_total avec la nouvelle valeur de la moyenne_enseignement_CC (moyenne_enseignement_total = moyenne_enseignement_CC*0,4 + moyenne_enseignement_DS*0,6)

After INSERT or UPDATE of moyenne_enseignement_DS (on each row ?)

lancer le calcul de la moyenne_enseignement_total avec la nouvelle valeur de la moyenne_enseignement_DS (moyenne_enseignement_total = moyenne_enseignement_CC*0,4 + moyenne_enseignement_DS*0,6)






## ROMAIN



- Implémentation de l'interface.
Je passe par un petit logiciel qui s'appelle "Scene Builder" qui me permet de mettre en forme l'interface en plaçant les text area, les text field, les bouttons.
Le code derrière se fait par la gestion des évènements comme "onAction, onClick" etc dans un fichier java. C'est en fait une classe que l'on appelle eventHandlingController.java dans laquelle sera écrite la gestion des différents évènements. Le traitement des informations et des éléments de l'interface se fait comme en HTML en précisant un ID et en travaillant sur cet ID. 
Par exemple si je créée un boutton, je lui attribue un id : "fx:id="login_button"" qui me permet après de faire : "login_button.onAction(...) etc..."







## THOMAS



Résolution du problème côté configuration du serveur






## RAPHAEL













