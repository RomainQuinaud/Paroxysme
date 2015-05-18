package modele;

import modele.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


public class Modele {

    private Connection conn;



    /** ========================================== Constructors ========================================================= */

    public Modele () {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }
        catch (ClassNotFoundException c) {
            System.err.println("Erreur interne de pilote");
        }
        String log = "raphael";
        String mdp = "as20142015";
        String url = "jdbc:oracle:thin:";

        url += log + "/" + mdp + "@178.32.163.231:1521:xe";
        conn = null;
        try {
            conn = DriverManager.getConnection(url);

        }
        catch (SQLException s) {
            if (s.getErrorCode() == 1017)
                System.err.println("Couple login / mot de passe incorrect.");
            else
                System.err.println("Erreur interne de connexion : " + s.getErrorCode());
        }
    }




    /** =======================================  Fonction pour la connexion  ==================================== */

    public int checkConnectLogin (String login, String password) throws SQLException {
        int retour=0;
        String requete = "SELECT * FROM UTILISATEUR NATURAL JOIN PROFESSEUR WHERE LOGIN=? AND PASSWORD_USER=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, login);
        stm.setString(2, password);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            String requete2 = "SELECT * FROM UTILISATEUR NATURAL JOIN ADMIN WHERE LOGIN=? AND PASSWORD_USER=?";
            PreparedStatement stm2 = conn.prepareStatement(requete2);
            stm2.setString(1, login);
            stm2.setString(2, password);
            ResultSet result2 = stm2.executeQuery();
            if (result2.next())
                retour = 3; // 3 = prof et admin
            else
                retour = 1; // 1 = prof tout court
            result2.close();
            stm2.close();
        }
        result.close();
        stm.close();


        String requete2 = "SELECT * FROM UTILISATEUR NATURAL JOIN ETUDIANT WHERE LOGIN=? AND PASSWORD_USER=?";
        PreparedStatement stm2 = conn.prepareStatement(requete2);
        stm2.setString(1, login);
        stm2.setString(2, password);
        ResultSet result2 = stm2.executeQuery();
        if (result2.next())
            retour = 2; // 2 = étudiant
        result2.close();
        stm2.close();

        return retour;
    }


    public boolean isAdmin (int idUser) throws SQLException {
        boolean retour;
        String requete2 = "SELECT * FROM UTILISATEUR NATURAL JOIN ADMIN WHERE ID_USER=?";
        PreparedStatement stm2 = conn.prepareStatement(requete2);
        stm2.setInt(1, idUser);
        ResultSet result2 = stm2.executeQuery();
        if (result2.next())
            retour = true;
        else
            retour = false;
        result2.close();
        stm2.close();
        return retour;
    }




    /** =======================================  Fonctions Pour Administrateur        ==================================== */

    public boolean checkFormationDispo(String nom,int annee)
    {
        Boolean dispo=false;
        String requete = "SELECT COUNT(*) FROM FORMATION WHERE NOM_FORMATION=? AND ANNEE_FORMATION=?";
        PreparedStatement stm = null;
        try {

            stm = conn.prepareStatement(requete);
            stm.setString(1, nom);
            stm.setInt(2, annee);
            ResultSet result = null;
            result = stm.executeQuery();
            result.next();
            if(result.getInt(1)==0) dispo=true;
            else dispo=false;
            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return dispo;

    }


    public boolean checkGroupeDispo(String nom)
    {
        Boolean dispo=false;
        String requete = "SELECT COUNT(*) FROM GROUPE WHERE NOM_GROUPE=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(requete);
            stm.setString(1, nom);
            ResultSet result = null;
            result = stm.executeQuery();
            result.next();
            if(result.getInt(1)==0)
                dispo=true;
            else
                dispo=false;
            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return dispo;
    }



    public boolean checkLoginDispo(String login)
    {
        Boolean dispo=false;
        String requete = "SELECT COUNT(*) FROM UTILISATEUR WHERE LOGIN=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(requete);
            stm.setString(1, login);
            ResultSet result = null;
            result = stm.executeQuery();
            result.next();
            if(result.getInt(1)==0)
                dispo=true;
            else
                dispo=false;
            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return dispo;
    }

    public boolean checkLMailDispo(String mail)
    {
        Boolean dispo=false;
        String requete = "SELECT COUNT(*) FROM UTILISATEUR WHERE MAIL_USER=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(requete);
            stm.setString(1, mail);
            ResultSet result = null;
            result = stm.executeQuery();
            result.next();
            if(result.getInt(1)==0)
                dispo=true;
            else
                dispo=false;
            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return dispo;
    }


    public void ajoutFormation(String nom,int annee)
    {

        String requete = "INSERT INTO FORMATION (NOM_FORMATION,ANNEE_FORMATION) VALUES (?,?)";
        PreparedStatement stm = null;
        try {

            stm = conn.prepareStatement(requete);
            stm.setString(1, nom);
            stm.setInt(2, annee);
            ResultSet result = null;
            result = stm.executeQuery();
            conn.commit();

            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    public int ajoutSemestre(String nomsemestre,String nom,int annee,String datedebut,String datefin)
    {

        String requete = "INSERT INTO SEMESTRE (ID_SEMESTRE,NOM_SEMESTRE,NOM_FORMATION,ANNEE_FORMATION,DATE_DEBUT,DATE_FIN,SEMESTRE_OUVERT,SEMESTRE_TERMINE) VALUES (SEM.nextval,?,?,?,to_date(?, 'YYYY-MM-DD'),to_date(?, 'YYYY-MM-DD'),0,0)";
        PreparedStatement stm = null;
        int last_inserted_id=-1;
        try {

            stm = conn.prepareStatement(requete,Statement.RETURN_GENERATED_KEYS);

            stm.setString(1, nomsemestre);
            stm.setString(2, nom);
            stm.setInt(3, annee);
            stm.setString(4, datedebut);
            stm.setString(5, datefin);

            stm.executeUpdate();
            conn.commit();

            stm.close();
            Statement stmt=null;
            stmt = conn.createStatement();
            String requete2 = "select SEM.currval from dual";
            ResultSet rs = stmt.executeQuery(requete2);
            while (rs.next()) {
                last_inserted_id=rs.getInt(1);
            }




        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return last_inserted_id;
    }


    public void supprimeFormation(String nom,int annee)
    {

        String requete = "DELETE FROM FORMATION WHERE NOM_FORMATION=? and ANNEE_FORMATION=?";
        PreparedStatement stm = null;
        try {

            stm = conn.prepareStatement(requete);
            stm.setString(1, nom);
            stm.setInt(2, annee);
            ResultSet result = null;
            result = stm.executeQuery();
            conn.commit();

            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }

    public void supprimeSemestre(String nom,int annee)
    {


        /** Suppression dans groupe suit enseignement et enseignement where idEnseignement=? */

        String requete0 = "SELECT ID_ENSEIGNEMENT FROM SEMESTRE NATURAL JOIN ENSEIGNEMENT WHERE NOM_FORMATION=? and ANNEE_FORMATION=?";
        PreparedStatement stm1 = null;
        try {

            stm1 = conn.prepareStatement(requete0);
            stm1.setString(1, nom);
            stm1.setInt(2, annee);
            ResultSet res = stm1.executeQuery();
            while(res.next()){
                int idEnseignement = res.getInt("ID_ENSEIGNEMENT");
                deleteGroupeEnseignement(idEnseignement);
                deleteEnseignement(idEnseignement);
            }
            res.close();
            stm1.close();
        }
        catch(SQLException e1)
        {
            e1.printStackTrace();
        }





        /** Supression des semestres */
        String requete = "DELETE FROM SEMESTRE WHERE NOM_FORMATION=? and ANNEE_FORMATION=?";
        PreparedStatement stm = null;
        try {

            stm = conn.prepareStatement(requete);
            stm.setString(1, nom);
            stm.setInt(2, annee);
            ResultSet result = null;
            result = stm.executeQuery();
            conn.commit();

            result.close();
            stm.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }

    public void deleteEnseignement (int idEnseignement) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM ENSEIGNEMENT WHERE ID_ENSEIGNEMENT=?");
        ps.setInt(1, idEnseignement);
        ps.executeUpdate();
        ps.close();
    }

    public void deleteGroupeEnseignement (int idEnseignement) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM GROUPE_SUIT_ENSEIGNEMENT WHERE ID_ENSEIGNEMENT=?");
        ps.setInt(1, idEnseignement);
        ps.executeUpdate();
        ps.close();
    }

    /**
     * Retourne tous les groupes ne suivant pas l'enseignement donné en paramètre
     */
    public ArrayList<String> getGroupesHorsEnseign(int idEnseignement) throws SQLException {
        ArrayList<String> liste = new ArrayList<String>();
        String req = "SELECT distinct nom_groupe FROM groupe WHERE nom_groupe not in (SELECT nom_groupe FROM groupe NATURAL JOIN groupe_suit_enseignement WHERE id_enseignement=?)";
        PreparedStatement stm = conn.prepareStatement(req);
        stm.setInt(1, idEnseignement);
        ResultSet res = stm.executeQuery();
        while(res.next()){
            liste.add(res.getString("nom_groupe"));
        }
        res.close();
        stm.close();
        return liste;
    }
    /**
     * Retourne le nom de la formation, le nom du semestre, le nom de la matière et le nom prénom du professeur dans une ArrayList<String>
     */
    public ArrayList<String> getInfosEnseignement(int idEnseignement) throws SQLException{
        ArrayList<String> infos = new ArrayList<String>();

        PreparedStatement stm = conn.prepareStatement("SELECT id_semestre, nom_matiere, id_professeur FROM enseignement WHERE id_enseignement=?");
        stm.setInt(1, idEnseignement);
        ResultSet result = stm.executeQuery();
        result.next();
        int idSem = result.getInt("id_semestre");
        String nomMatiere = result.getString("nom_matiere");
        int idProf = result.getInt("id_professeur");
        result.close();
        stm.close();

        PreparedStatement stm2 = conn.prepareStatement("SELECT nom_formation FROM semestre WHERE id_semestre=?");
        stm2.setInt(1, idSem);
        ResultSet result2 = stm2.executeQuery();
        result2.next();

        infos.add(result2.getString("nom_formation"));
        infos.add(getNameSemestreFromID(idSem));
        infos.add(nomMatiere);
        infos.add(getPrenomNomFromID(idProf));
        result2.close();
        stm2.close();

        return infos;
    }
    public int getIDSemestreFromEnseignement(int idEnseignement) throws SQLException{
        PreparedStatement stm = conn.prepareStatement("SELECT id_semestre FROM enseignement WHERE id_enseignement=?");
        stm.setInt(1, idEnseignement);
        ResultSet result = stm.executeQuery();
        result.next();
        int idSem = result.getInt("id_semestre");
        result.close();
        stm.close();

        return idSem;
    }

    public void ajouterGroupeEnseignement(String nomGroupe, int idEnseignement) throws SQLException{
        PreparedStatement stm = conn.prepareStatement("SELECT id_groupe FROM groupe WHERE nom_groupe=?");
        stm.setString(1, nomGroupe);
        ResultSet result = stm.executeQuery();
        result.next();
        int idGroupe = result.getInt("id_groupe");
        stm.close();
        result.close();

        PreparedStatement stm2 = conn.prepareStatement("INSERT INTO groupe_suit_enseignement(id_groupe, id_enseignement) VALUES(?,?)");
        stm2.setInt(1, idGroupe);
        stm2.setInt(2, idEnseignement);
        stm2.executeQuery();
        stm2.close();
    }


    public ArrayList<Integer> getListeProfesseurs (){
        try {
            String requete = "SELECT ID_USER FROM PROFESSEUR";
            PreparedStatement stm = conn.prepareStatement(requete);
            ResultSet result = stm.executeQuery();
            ArrayList<Integer> liste = new ArrayList<Integer>();
            while (result.next()) {
                liste.add(result.getInt("ID_USER"));
            }
            result.close();
            stm.close();
            return liste;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return new ArrayList<Integer>();
    }

    public ArrayList<String> getListeMatieres (){
        try {
            String requete = "SELECT NOM_MATIERE FROM MATIERE";
            PreparedStatement stm = conn.prepareStatement(requete);
            ResultSet result = stm.executeQuery();
            ArrayList<String> liste = new ArrayList<String>();
            while (result.next()) {
                liste.add(result.getString("NOM_MATIERE"));
            }
            result.close();
            stm.close();
            return liste;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return new ArrayList<String>();
    }



    public int insertionEnseignementSemestre (int idSemestre, String nomMatiere, int idProf, float coef) throws SQLException {
        try{
            PreparedStatement ps = conn.prepareStatement("INSERT INTO ENSEIGNEMENT (ID_ENSEIGNEMENT, ID_SEMESTRE, NOM_MATIERE, ID_PROFESSEUR, COEF_ENSEIGNEMENT) VALUES (ens.nextval,?, ?, ?, ?)");
            ps.setInt(1, idSemestre);
            ps.setString(2, nomMatiere);
            ps.setInt(3, idProf);
            ps.setFloat(4, coef);
            ps.execute();
            ps.close();
            System.out.println("done");
            PreparedStatement ps2 = conn.prepareStatement("SELECT ID_ENSEIGNEMENT FROM ENSEIGNEMENT WHERE ID_SEMESTRE=? AND NOM_MATIERE = ?");
            ps2.setInt(1, idSemestre);
            ps2.setString(2, nomMatiere);
            ResultSet result = ps2.executeQuery();
            result.next();

            int idEnseignementTmp =  result.getInt("ID_ENSEIGNEMENT");
            result.close();
            ps2.close();
            return idEnseignementTmp;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return -1;

    }

    public ArrayList<String> getListeMatieresLibres (int semestre){
        try {
            String requete = "SELECT NOM_MATIERE FROM MATIERE WHERE NOM_MATIERE NOT IN( SELECT NOM_MATIERE FROM ENSEIGNEMENT WHERE ID_SEMESTRE = ?)";
            PreparedStatement stm = conn.prepareStatement(requete);
            stm.setInt(1, semestre);
            ResultSet result = stm.executeQuery();
            ArrayList<String> liste = new ArrayList<String>();
            while (result.next()) {
                liste.add(result.getString("NOM_MATIERE"));
            }
            result.close();
            stm.close();
            return liste;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return new ArrayList<String>();
    }

    public int maxMatiereSemestre(int semestre){
        try {
            String requete = "SELECT COUNT(NOM_MATIERE) AS NB FROM MATIERE WHERE NOM_MATIERE NOT IN( SELECT NOM_MATIERE FROM ENSEIGNEMENT WHERE ID_SEMESTRE = ?)";
            PreparedStatement stm = conn.prepareStatement(requete);
            stm.setInt(1, semestre);
            ResultSet result = stm.executeQuery();
            result.next();
            int toReturn =  result.getInt("NB");
            result.close();
            stm.close();
            return toReturn;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return -1;
    }





    public ArrayList<String[]> getEtudiantsPasDansGroupe (int idGroupe) throws SQLException{
        ArrayList<String[]> liste = new ArrayList<String[]>();

        String requete = "SELECT NOM_USER, PRENOM_USER, ID_USER FROM ETUDIANT NATURAL JOIN UTILISATEUR WHERE ID_USER NOT IN (SELECT ID_USER FROM ETUDIANT_DANS_GROUPE WHERE ID_GROUPE=?) ORDER BY NOM_USER ASC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            String data [] = new String[2];
            data [0] = result.getString("NOM_USER") + " " +result.getString("PRENOM_USER");
            data [1] = ""+result.getInt("ID_USER");
            liste.add(data);
        }
        result.close();
        stm.close();
        return liste;
    }



    public ArrayList<String[]> getEtudiantsDansGroupe (int idGroupe) throws SQLException{
        ArrayList<String[]> liste = new ArrayList<String[]>();

        String requete = "SELECT NOM_USER, PRENOM_USER, ID_USER FROM ETUDIANT_DANS_GROUPE NATURAL JOIN ETUDIANT NATURAL JOIN UTILISATEUR WHERE ID_GROUPE=? ORDER BY NOM_USER ASC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            String data [] = new String[2];
            data [0] = result.getString("NOM_USER") + " " +result.getString("PRENOM_USER");
            data [1] = ""+result.getInt("ID_USER");
            liste.add(data);
        }
        result.close();
        stm.close();
        return liste;
    }


    public int insererNouveauGroupe (String nomGroupe) throws SQLException {

        int idGroupe = -1; // pour voir s'il y a une erreur
        try {
            String sqlIdentifier = "SELECT gr.nextval FROM DUAL";
            PreparedStatement pst = conn.prepareStatement(sqlIdentifier);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                idGroupe = rs.getInt(1);
            }
        }
        catch (SQLException e) {
            System.err.println("probleme pour avoir la sequence groupe -> " + e.getMessage());
        }


        PreparedStatement ps = conn.prepareStatement("INSERT INTO GROUPE (ID_GROUPE, NOM_GROUPE) VALUES (?,?)");
        ps.setInt(1, idGroupe);
        ps.setString(2, nomGroupe);
        ps.executeUpdate();
        ps.close();
        return idGroupe;
    }


    public int insererNouvelEleve (String nom, String prenom, String mail, String login) throws SQLException {

        int idUser = -1; // pour voir s'il y a une erreur
        try {
            String sqlIdentifier = "SELECT ID.nextval FROM DUAL";
            PreparedStatement pst = conn.prepareStatement(sqlIdentifier);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                idUser = rs.getInt(1);
            }
        }
        catch (SQLException e) {
            System.err.println("probleme pour avoir la sequence ID -> " + e.getMessage());
        }


        PreparedStatement ps = conn.prepareStatement("INSERT INTO UTILISATEUR (ID_USER, LOGIN, NOM_USER, PRENOM_USER, MAIL_USER, PASSWORD_USER)  VALUES (?,?, ?, ?, ?, ?)");
        ps.setInt(1, idUser);
        ps.setString(2, login);
        ps.setString(3, nom);
        ps.setString(4, prenom);
        ps.setString(5, mail);
        ps.setString(6, "password");

        ps.executeUpdate();
        ps.close();





        int numEtu = -1; // pour voir s'il y a une erreur
        try {
            String sqlIdentifier = "SELECT NUM.nextval FROM DUAL";
            PreparedStatement pst = conn.prepareStatement(sqlIdentifier);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                numEtu = rs.getInt(1);
            }
        }
        catch (SQLException e) {
            System.err.println("probleme pour avoir la sequence ID -> " + e.getMessage());
        }


        PreparedStatement ps1 = conn.prepareStatement("INSERT INTO ETUDIANT (ID_USER, NUM_ETUDIANT) VALUES (?,?)");
        ps1.setInt(1, idUser);
        ps1.setInt(2, numEtu);


        ps1.executeUpdate();
        ps1.close();

        return idUser;
    }



    public void insertEtudiantDansGroupe (int idGroupe, int idEtudiant) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("INSERT INTO ETUDIANT_DANS_GROUPE (ID_USER, ID_GROUPE)  VALUES (?,?)");
        ps.setInt(1, idEtudiant);
        ps.setInt(2, idGroupe);
        ps.executeUpdate();
        ps.close();
    }


    public void deleteEtudiantDansGroupe (int idGroupe, int idEtudiant) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM ETUDIANT_DANS_GROUPE WHERE ID_USER=? AND ID_GROUPE=?");
        ps.setInt(1, idEtudiant);
        ps.setInt(2, idGroupe);
        ps.executeUpdate();
        ps.close();
    }


    public void deleteGroupe (int idGroupe) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM GROUPE WHERE ID_GROUPE=?");
        ps.setInt(1, idGroupe);
        ps.executeUpdate();
        ps.close();
    }


    /** =======================================  Fonctions Pour tous les Utilisateurs  ==================================== */



    public String getPrenomNomFromID (int idUser) throws SQLException {
        String prenomNom="";
        String requete = "SELECT PRENOM_USER, NOM_USER FROM UTILISATEUR WHERE ID_USER=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        ResultSet result = stm.executeQuery();
        if (result.next()) // renvoi vrai si il trouve une ligne, et ici on veut une seule ligne
            prenomNom = result.getString("PRENOM_USER") + " " + result.getString("NOM_USER");
        else
            prenomNom = "Nom inconnu";
        result.close();
        stm.close();
        return prenomNom;
    }




    public int getIDLogin (String unLogin) throws SQLException {

        int id;
        String requete = "SELECT ID_USER FROM UTILISATEUR WHERE LOGIN=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, unLogin);
        ResultSet result = stm.executeQuery();
        if (result.next()) // renvoi vrai si il trouve une ligne, et ici on veut une seule ligne
            id = result.getInt("ID_USER");
        else
            id = -1; // tester sur la valeur de -1
        result.close();
        stm.close();
        return id;
    }






    public ArrayList<Integer> getIDSemestresUneFormation (String nomFormation, int anneeFormation) throws SQLException{
        ArrayList<Integer> idSemestres = new ArrayList<Integer>();

        String requete = "SELECT ID_SEMESTRE FROM SEMESTRE WHERE NOM_FORMATION=? AND ANNEE_FORMATION=? ORDER BY NOM_SEMESTRE";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, nomFormation);
        stm.setInt(2, anneeFormation);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            idSemestres.add(result.getInt("ID_SEMESTRE"));
        }
        result.close();
        stm.close();
        return idSemestres;
    }


    public String getNameSemestreFromID (Integer id) throws SQLException {

        String s="";
        String requete = "SELECT NOM_SEMESTRE FROM SEMESTRE WHERE ID_SEMESTRE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, id);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            s += result.getString("NOM_SEMESTRE");
            result.close();
            stm.close();
        }
        else {
            result.close();
            stm.close();
            s += "Nom non trouvé";
        }
        return s;
    }

    public ArrayList<String> getEnseignementsUnSemestre (int idSemestre) throws SQLException {
        String requete = "SELECT NOM_MATIERE, ID_ENSEIGNEMENT FROM ENSEIGNEMENT WHERE ID_SEMESTRE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idSemestre);
        ResultSet result = stm.executeQuery();
        ArrayList<String> listeEnseignements = new ArrayList<String>();
        while (result.next()) {
            listeEnseignements.add(result.getString("NOM_MATIERE") + "---" + Integer.toString(result.getInt("ID_ENSEIGNEMENT")));
        }
        result.close();
        stm.close();
        return listeEnseignements;
    }






    /** =======================================  Fonctions Pour les Professeurs  ============================================ */


    public void updateInterro (String ancienLibelle, int idGroupe, int idEnseignement, String nouveauLibelle, String typeNote, String date, float coef) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("UPDATE NOTES SET LIBELLE_INTERROGATION = ?, TYPE_NOTE=?, DATE_INTERROGATION=?, COEF_NOTE=? WHERE ID_GROUPE = ? AND ID_ENSEIGNEMENT = ? AND LIBELLE_INTERROGATION=?");
        ps.setString(1,nouveauLibelle);
        ps.setString(2,typeNote);
        ps.setString(3,date);
        ps.setFloat(4, coef);
        ps.setInt(5,idGroupe);
        ps.setInt(6, idEnseignement);
        ps.setString(7,ancienLibelle);
        ps.executeUpdate();
        ps.close();
    }

    public void updateNote (float nouvelleNote, int idUser, int idGroupe, int idEnseignement, String libelle) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("UPDATE NOTES SET VALEUR_NOTE = ? WHERE ID_USER=? AND ID_GROUPE = ? AND ID_ENSEIGNEMENT = ? AND LIBELLE_INTERROGATION=?");
        ps.setFloat(1, nouvelleNote);
        ps.setInt(2,idUser);
        ps.setInt(3,idGroupe);
        ps.setInt(4, idEnseignement);
        ps.setString(5,libelle);
        ps.executeUpdate();
        ps.close();
    }


    public void insertNouvelleInterro (int idUser, int idGroupe, int idEnseignement, String libelle, String date, float note, float coefNote, int absent, int absenceJustifiee, String typeNote) throws SQLException {
        long idNote = -1;
        try {
            String sqlIdentifier = "SELECT note.nextval FROM DUAL";
            PreparedStatement pst = conn.prepareStatement(sqlIdentifier);
            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                idNote = rs.getLong(1);
            }
        }
        catch (SQLException e) {
            System.err.println("probleme pour avoir la sequence note -> " + e.getMessage());
        }



        PreparedStatement ps = conn.prepareStatement("INSERT INTO NOTES (ID_NOTE, ID_USER, ID_GROUPE, ID_ENSEIGNEMENT, LIBELLE_INTERROGATION, DATE_INTERROGATION, VALEUR_NOTE, COEF_NOTE, ABSENT, ABSENCE_JUSTIFIEE, TYPE_NOTE) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setLong(1, idNote);
        ps.setInt(2, idUser);
        ps.setInt(3,idGroupe);
        ps.setInt(4, idEnseignement);
        ps.setString(5, libelle);
        ps.setString(6, date);
        ps.setFloat(7, note);
        ps.setFloat(8, coefNote);
        ps.setInt(9, absent);
        ps.setInt(10, absenceJustifiee);
        ps.setString(11, typeNote);
        ps.executeUpdate();
        ps.close();
    }


    public float getNoteForIDEleve (String libelle, int idGroupe, int idEnseignement, int idEleve) throws SQLException {
        String requete = "SELECT VALEUR_NOTE FROM NOTES WHERE LIBELLE_INTERROGATION=? AND ID_GROUPE=? AND ID_ENSEIGNEMENT=? AND ID_USER=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, libelle);
        stm.setInt(2, idGroupe);
        stm.setInt(3, idEnseignement);
        stm.setInt(4, idEleve);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            float note = result.getFloat("VALEUR_NOTE");
            result.close();
            stm.close();
            return note;
        }
        else {
            result.close();
            stm.close();
            return -1;
        }
    }

    public boolean isSemestreOuvert (int idSemestre) throws SQLException {
        String requete = "SELECT SEMESTRE_OUVERT FROM SEMESTRE WHERE ID_SEMESTRE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idSemestre);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            if (result.getInt("SEMESTRE_OUVERT") == 1) {
                result.close();
                stm.close();
                return true;
            }
            else {
                result.close();
                stm.close();
                return false;
            }
        }
        else {
            result.close();
            stm.close();
            return false;
        }
    }


    public boolean isSemestreFerme (int idSemestre) throws SQLException {
        String requete = "SELECT SEMESTRE_TERMINE FROM SEMESTRE WHERE ID_SEMESTRE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idSemestre);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            if (result.getInt("SEMESTRE_TERMINE") == 1) {
                result.close();
                stm.close();
                return true;
            }
            else {
                result.close();
                stm.close();
                return false;
            }
        }
        else {
            result.close();
            stm.close();
            return false;
        }
    }

    public boolean isResponsable (String nomFormation, int anneeFormation, int idProf) throws SQLException {
        String requete = "SELECT ID_PROF_RESPONSABLE FROM FORMATION WHERE NOM_FORMATION=? AND ANNEE_FORMATION=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, nomFormation);
        stm.setInt(2, anneeFormation);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            if (result.getInt("ID_PROF_RESPONSABLE") == idProf)
                return true;
            else
                return false;
        }
        else
            return false;
    }




    public ArrayList<String> getSesFormationsProf (int idUser) throws SQLException {
        ArrayList<String> listeFormations = new ArrayList<String>();

        String requete = "SELECT DISTINCT NOM_FORMATION, ANNEE_FORMATION FROM ENSEIGNEMENT NATURAL JOIN SEMESTRE NATURAL JOIN FORMATION WHERE ID_PROFESSEUR=? ORDER BY ANNEE_FORMATION DESC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            String nomFormation = result.getString("NOM_FORMATION");
            String anneeFormation = result.getInt("ANNEE_FORMATION")+"";
            listeFormations.add(nomFormation + "---" + anneeFormation); // on utilisera le split sur "---"
        }
        result.close();
        stm.close();
        return listeFormations;
    }


    public ArrayList<String> getSesEnseignementsProf (int idSemestre, int idUser) throws SQLException {
        String requete = "SELECT NOM_MATIERE, ID_ENSEIGNEMENT FROM ENSEIGNEMENT WHERE ID_SEMESTRE=? AND ID_PROFESSEUR=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idSemestre);
        stm.setInt(2, idUser);
        ResultSet result = stm.executeQuery();
        ArrayList<String> listeEnseignements = new ArrayList<String>();
        while (result.next()) {
            listeEnseignements.add(result.getString("NOM_MATIERE") + "---" + Integer.toString(result.getInt("ID_ENSEIGNEMENT")));
        }
        result.close();
        stm.close();
        return listeEnseignements;
    }


    public ArrayList<String> getSesGroupeUnEnseignement (int idEnseignement) throws SQLException {
        String requete = "SELECT NOM_GROUPE, ID_GROUPE FROM GROUPE NATURAL JOIN GROUPE_SUIT_ENSEIGNEMENT WHERE ID_ENSEIGNEMENT=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idEnseignement);
        ResultSet result = stm.executeQuery();
        ArrayList<String> listeGroupes = new ArrayList<String>();
        while (result.next()) {
            listeGroupes.add(result.getString("NOM_GROUPE") + "---" + Integer.toString(result.getInt("ID_GROUPE")));
        }
        result.close();
        stm.close();
        return listeGroupes;
    }


    public ArrayList<Integer> getIDSemestresUneFormationUnProfesseur (String nomFormation, int anneeFormation, int idProf) throws SQLException{
        ArrayList<Integer> idSemestres = new ArrayList<Integer>();

        String requete = "SELECT DISTINCT ID_SEMESTRE, NOM_SEMESTRE FROM ENSEIGNEMENT NATURAL JOIN SEMESTRE WHERE NOM_FORMATION=? AND ANNEE_FORMATION=? AND ID_PROFESSEUR=? ORDER BY NOM_SEMESTRE";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, nomFormation);
        stm.setInt(2, anneeFormation);
        stm.setInt(3, idProf);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            idSemestres.add(result.getInt("ID_SEMESTRE"));
        }
        result.close();
        stm.close();
        return idSemestres;
    }


    public boolean libelleInterroLibre (int idGroupe, int idEnseignement, String libelle) throws SQLException {
        String requete = "SELECT DISTINCT LIBELLE_INTERROGATION FROM NOTES WHERE ID_GROUPE=? AND ID_ENSEIGNEMENT=? AND LIBELLE_INTERROGATION=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        stm.setInt(2, idEnseignement);
        stm.setString(3, libelle);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            result.close();
            stm.close();
            return false;
        }
        else {
            result.close();
            stm.close();
            return true;
        }
    }


    public int [] getNbElevesUnGroupe (int idGroupe) throws SQLException {
        String requete = "SELECT COUNT(ID_USER) AS NB FROM ETUDIANT_DANS_GROUPE WHERE ID_GROUPE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        ResultSet result = stm.executeQuery();
        int nb;
        if (result.next()) {
            nb = result.getInt("NB");
            result.close();
            stm.close();
        }
        else {
            result.close();
            stm.close();
            nb = -1;
        }

        if (nb != -1) {
            int tab [] = new int[nb];
            String requete2 = "SELECT ID_USER FROM ETUDIANT_DANS_GROUPE NATURAL JOIN ETUDIANT NATURAL JOIN UTILISATEUR WHERE ID_GROUPE=? ORDER BY NOM_USER ASC";

            PreparedStatement stm2 = conn.prepareStatement(requete2);
            stm2.setInt(1, idGroupe);
            ResultSet result2 = stm2.executeQuery();
            int i=0;
            while (result2.next()) {
                tab[i++] = result2.getInt("ID_USER");
            }
            result2.close();
            stm2.close();
            return tab;
        }
        else
            return null;
    }


    public String getNameUtilisateurFromID (int idEleve) throws SQLException {
        String requete = "SELECT NOM_USER, PRENOM_USER FROM UTILISATEUR WHERE ID_USER=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idEleve);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            String s = result.getString("NOM_USER") + " " + result.getString("PRENOM_USER");
            result.close();
            stm.close();
            return s;
        }
        else {
            result.close();
            stm.close();
            return "ID d'utilisateur non trouvée";
        }
    }

    public String[] getInfosInterro (int idGroupe, int idEnseignement, String libelle) throws SQLException {
        String [] data = new String[3];
        String requete = "SELECT DISTINCT TYPE_NOTE, DATE_INTERROGATION, COEF_NOTE FROM NOTES WHERE ID_GROUPE=? AND ID_ENSEIGNEMENT=? AND LIBELLE_INTERROGATION=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        stm.setInt(2, idEnseignement);
        stm.setString(3, libelle);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            data[0] = result.getString("TYPE_NOTE");
            String tmp [] = result.getString("DATE_INTERROGATION").split(" ");
            String tmp2[] = tmp[0].split("-");
            data[1] = tmp2[2] + "/" + tmp2[1] + "/" + tmp2[0];
            data[2] = ""+result.getDouble("COEF_NOTE");
            result.close();
            stm.close();
            return data;
        }
        else {
            result.close();
            stm.close();
            return data;
        }
    }



    public boolean dateInterroCoherente (int idEnseignement, String dateFormatFR) throws SQLException {
        String requete = "SELECT DATE_DEBUT, DATE_FIN FROM ENSEIGNEMENT NATURAL JOIN SEMESTRE WHERE ID_ENSEIGNEMENT =?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idEnseignement);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            try {
                String [] data = dateFormatFR.split("-");
                String dateFormatUS = data[2] + "-" + data[1] + "-" + data[0];
                Date dateDebut = new Date(getDateFromDateFormatee(result.getString("DATE_DEBUT")));
                Date dateFin = new Date(getDateFromDateFormatee(result.getString("DATE_FIN")));
                Date dateInterro = new Date(dateFormatUS);
                if ( (dateInterro.anterieure(dateFin) || dateInterro.dateEgales(dateFin)) && (!dateInterro.anterieure(dateDebut) || dateInterro.dateEgales(dateDebut))) {
                    result.close();
                    stm.close();
                    return true;
                }
                else {
                    result.close();
                    stm.close();
                    return false;
                }
            }
            catch (Exception e) {
                System.err.println("dateInterroCoherente -> " + e.getMessage());
                result.close();
                stm.close();
                return false;
            }
        }
        else {
            result.close();
            stm.close();
            return false;
        }
    }

    private String getDateFromDateFormatee (String date) {
        String preData [] = date.split(" ");
        return preData[0];
    }

    public ArrayList<String> getLibellesInterrosUnEnseignement (int idGroupe, int idEnseignement) throws SQLException {
        ArrayList<String> listeInterro = new ArrayList<String>();
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

        String requete = "SELECT DISTINCT LIBELLE_INTERROGATION, DATE_INTERROGATION, TYPE_NOTE FROM NOTES WHERE ID_GROUPE=? AND ID_ENSEIGNEMENT=? ORDER BY DATE_INTERROGATION ASC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idGroupe);
        stm.setInt(2, idEnseignement);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            listeInterro.add(result.getString("LIBELLE_INTERROGATION") + "  -  " + df.format(result.getDate("DATE_INTERROGATION")) + "  -  " + result.getString("TYPE_NOTE"));
        }
        result.close();
        stm.close();
        return listeInterro;
    }


    public String getInfoHTMLListeNotesUnGroupe (String libelleInterro, int idGroupe, int idEnseignement) throws SQLException{
        String requete = "SELECT * FROM NOTES NATURAL JOIN ETUDIANT NATURAL JOIN UTILISATEUR WHERE LIBELLE_INTERROGATION=? AND ID_GROUPE=? AND ID_ENSEIGNEMENT=? ORDER BY NOM_USER ASC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setString(1, libelleInterro);
        stm.setInt(2, idGroupe);
        stm.setInt(3, idEnseignement);
        ResultSet result = stm.executeQuery();
        String infos = "<html><h2>Notes</h2><table>";
        infos += "<tr><th style=\"width: 100px\">Nom</th><th style=\"width: 100px\">Prénom</th><th style=\"width: 50px\">Note</th><th style=\"width: 50px\">Coef</th></tr>";
        while (result.next()) {
            infos += "<tr>";
            infos += "<td style=\"text-align: center\">"+result.getString("NOM_USER")+"</td>";
            infos += "<td style=\"text-align: center\">"+result.getString("PRENOM_USER")+"</td>";
            if (result.getInt("ABSENT") == 1) { // elève absent pour l'interro
                if (result.getInt("ABSENCE_JUSTIFIEE") == 1)
                    infos += "<td style=\"text-align: center\">Absence justifiée</td>";
                else
                    infos += "<td style=\"text-align: center\">Absence non justifiée</td>";
            }
            else {
                infos += "<td style=\"text-align: center\">" + result.getDouble("VALEUR_NOTE") + "</td>";
            }
            infos += "<td style=\"text-align: center\">"+result.getDouble("COEF_NOTE")+"</td>";
            infos += "</tr>";
        }

        infos += "</table>";
        result.close();
        stm.close();
        return infos;
    }




    /** =======================================  Fonctions Pour les Eleves  ============================================ */



    public String getInfoHTMLStatsSemestreEtudiant (int idUser, int idSemestre) throws SQLException {
        String requete = "SELECT MOY_ETU_SEMESTRE_CC, MOY_ETU_SEMESTRE_DS, MOY_ETU_SEMESTRE_TOTAL FROM STATS_SEMESTRE_ETUDIANT WHERE ID_USER=? AND ID_SEMESTRE=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        stm.setInt(2, idSemestre);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            String s = "";
            s += "<html><h3>Vos statistiques pour ce semestre : </h3><p>";
            s += "<strong>Moyenne semestre CC : </strong>" + result.getDouble("MOY_ETU_SEMESTRE_CC") + "<br/>";
            s += "<strong>Moyenne semestre DS : </strong>" + result.getDouble("MOY_ETU_SEMESTRE_DS") + "<br/>";
            s += "<strong>Moyenne totale semestre : </strong>" + result.getDouble("MOY_ETU_SEMESTRE_TOTAL");
            s += "</p></html>";
            result.close();
            stm.close();
            return s;
        }
        else {
            result.close();
            stm.close();
            return "Statistiques non disponibles";
        }

    }


    public ArrayList<String> getSesFormationsEleve (int idUser) throws SQLException {
        ArrayList<String> listeFormations = new ArrayList<String>();

        String requete = "SELECT DISTINCT NOM_FORMATION, ANNEE_FORMATION FROM ETUDIANT_DANS_GROUPE NATURAL JOIN GROUPE NATURAL JOIN GROUPE_SUIT_ENSEIGNEMENT NATURAL JOIN ENSEIGNEMENT NATURAL JOIN SEMESTRE NATURAL JOIN FORMATION WHERE ID_USER=? ORDER BY ANNEE_FORMATION DESC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        ResultSet result = stm.executeQuery();
        while (result.next()) {
            String nomFormation = result.getString("NOM_FORMATION");
            String anneeFormation = result.getInt("ANNEE_FORMATION")+"";
            listeFormations.add(nomFormation + "---" + anneeFormation); // on utilisera le split sur "---"
        }
        result.close();
        stm.close();
        return listeFormations;
    }



    public String getInfoHTMLStatsEnseignementEtudiant (int idUser, int idEnseignement) throws SQLException {
        String requete = "SELECT MOY_ETU_ENSEIGNEMENT_CC, MOY_ETU_ENSEIGNEMENT_DS, MOY_ETU_ENSEIGNEMENT_TOTAL FROM STATS_ENSEIGNEMENT_ETUDIANT WHERE ID_USER=? AND ID_ENSEIGNEMENT=?";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        stm.setInt(2, idEnseignement);
        ResultSet result = stm.executeQuery();
        if (result.next()) {
            String s = "";
            s += "<html><h3>Vos statistiques pour cet enseignement : </h3><p>";
            s += "<strong>Moyenne en CC : </strong>" + result.getDouble("MOY_ETU_ENSEIGNEMENT_CC") + "<br/>";
            s += "<strong>Moyenne en DS : </strong>" + result.getDouble("MOY_ETU_ENSEIGNEMENT_DS") + "<br/>";
            s += "<strong>Moyenne totale : </strong>" + result.getDouble("MOY_ETU_ENSEIGNEMENT_TOTAL");
            s += "</p></html>";
            result.close();
            stm.close();
            return s;
        }
        else {
            result.close();
            stm.close();
            return "Statistiques non disponibles";
        }

    }


    public String getInfoHTMLListeNotesUnEnseignement (int idUser, int idEnseignement) throws SQLException{
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        String requete = "SELECT * FROM NOTES WHERE ID_USER=? AND ID_ENSEIGNEMENT=? AND TYPE_NOTE='CC' ORDER BY DATE_INTERROGATION ASC";
        PreparedStatement stm = conn.prepareStatement(requete);
        stm.setInt(1, idUser);
        stm.setInt(2, idEnseignement);
        ResultSet result = stm.executeQuery();
        String infos = "<html><br/><br/><h2>Notes de Controle Continu</h2><table>";
        infos += "<tr><th style=\"width: 250px\">Nom de l'interrogation</th><th style=\"width: 50px\">Note</th><th style=\"width: 50px\">Coef</th><th style=\"width: 150px\">Date</th></tr>";
        while (result.next()) {
            infos += "<tr>";
            infos += "<td style=\"text-align: center\">"+result.getString("LIBELLE_INTERROGATION")+"</td>";
            if (result.getInt("ABSENT") == 1) { // elève absent pour l'interro
                if (result.getInt("ABSENCE_JUSTIFIEE") == 1)
                    infos += "<td style=\"text-align: center\">Absence justifiée</td>";
                else
                    infos += "<td style=\"text-align: center\">Absence non justifiée</td>";
            }
            else {
                infos += "<td style=\"text-align: center\">" + result.getDouble("VALEUR_NOTE") + "</td>";
            }
            infos += "<td style=\"text-align: center\">"+result.getDouble("COEF_NOTE")+"</td>";
            infos += "<td style=\"text-align: center\">"+df.format(result.getDate("DATE_INTERROGATION"))+"</td>";
            infos += "</tr>";
        }

        infos += "</table>";
        result.close();
        stm.close();


        String requete2 = "SELECT * FROM NOTES WHERE ID_USER=? AND ID_ENSEIGNEMENT=? AND TYPE_NOTE='DS' ORDER BY DATE_INTERROGATION ASC";
        PreparedStatement stm2 = conn.prepareStatement(requete2);
        stm2.setInt(1, idUser);
        stm2.setInt(2, idEnseignement);
        ResultSet result2 = stm2.executeQuery();
        infos += "<br/><br/><h2>Notes de Partiel</h2><table>";
        infos += "<tr><th style=\"width: 250px\">Nom de l'interrogation</th><th style=\"width: 50px\">Note</th><th style=\"width: 150px\">Date</th></tr>";
        while (result2.next()) {
            infos += "<tr>";
            infos += "<td style=\"text-align: center\">"+result2.getString("LIBELLE_INTERROGATION")+"</td>";
            if (result2.getInt("ABSENT") == 1) { // elève absent pour l'interro
                if (result2.getInt("ABSENCE_JUSTIFIEE") == 1)
                    infos += "<td style=\"text-align: center\">ABS J.</td>";
                else
                    infos += "<td style=\"text-align: center\">ABS</td>";
            }
            else {
                infos += "<td style=\"text-align: center\">" + result2.getDouble("VALEUR_NOTE") + "</td>";
            }
            infos += "<td style=\"text-align: center\">"+result2.getDate("DATE_INTERROGATION")+"</td>";
            infos += "</tr>";
        }

        infos += "</table></html>";
        result2.close();
        stm2.close();


        return infos;
    }





}
