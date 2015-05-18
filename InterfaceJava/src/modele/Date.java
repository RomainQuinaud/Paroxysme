package modele;



public class Date implements Comparable<Date> {

    public int getJour() {
        return jour;
    }

    private int jour;

    public int getMois() {
        return mois;
    }

    public int getAnnee() {
        return annee;
    }

    private int mois;
    private int annee;

    public void setJour(int jour) {
        this.jour = jour;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    /* ========================================== Constructors ========================================================= */

    /**
     * Construit une Date avec les valeurs jour, mois et annee
     * @param jour int
     * @param mois int
     * @param annee int
     */
    public Date(int jour, int mois, int annee) {
        this.jour = jour;
        this.mois = mois;
        this.annee = annee;
    }

    public Date (String dateFormatUS) {
        String data [] = dateFormatUS.split("-");
        this.jour = Integer.parseInt(data[2]);
        this.mois = Integer.parseInt(data[1]);
        this.annee = Integer.parseInt(data[0]);
    }

    public Date() {
        this.jour = 0;
        this.mois = 0;
        this.annee = 0;
    }



/* ==========================================  Implements  ========================================================= */
    /**
     * Fonction qui ecrit une date et override la fonction toString
     * @return le format Date JJ/MM/YYYY
     */
    @Override
    public String toString() {
        return jour + "/" + mois + "/" + annee;
    }

/* =======================================  Fonctions Utiles  ========================================================= */

    /**
     * Fonction qui verifie si deux Dates son egales
     * @param uneDate Date que l'on compare a la cible
     * @return vrai si la Date passee en parametre est egale a la Date cible
     */
    protected boolean dateEgales (Date uneDate) {
        return (this.annee == uneDate.annee && this.mois == uneDate.mois && this.jour == uneDate.jour);
    }

    /**
     * Fonction qui verifie si une date est anterieure a une autre
     * @param uneDate Date que l'on compare a la cible
     * @return vrai si la Date cible est anterieure a la Date passee en parametre
     */
    protected boolean anterieure (Date uneDate) {
        if (this.annee < uneDate.annee) {
            return true;
        }

        else if (this.annee == uneDate.annee) {
            if (this.mois < uneDate.mois) {
                return true;
            }
            else if (this.mois == uneDate.mois) {
                if (this.jour < uneDate.jour) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }

        else {
            return false;
        }
    }


    /**
     * Override de la fonction compareTo qui utilise les fonctions dateEgales(Date une Date) et anterieure(Date uneDate)
     * @param uneDate Date a laquelle on compare la cible
     * @return 0 si les dates sont egales, -1 si la cible est anterieure a la Date passee en parametre et 1 sinon
     */
    @Override
    public int compareTo(Date uneDate ) {
        if (this.dateEgales(uneDate))
            return 0;
        else if (this.anterieure(uneDate))
            return -1;
        else
            return 1;
    }



    /* Romain */

    public String toBase() {
        return annee + "-" + mois + "-" + jour;
    }
}
