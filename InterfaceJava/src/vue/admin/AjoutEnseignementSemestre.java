package vue.admin;

import modele.Modele;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.*;
import java.awt.event.*;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Ajout d'un enseignement au semestre
 */
public class AjoutEnseignementSemestre extends JDialog implements ActionListener, DocumentListener{

    /* CONSTANTES */
    private Dimension TEXT_SIZE = new Dimension(200,25);
    private Dimension TEXT_SIZE_ERREUR = new Dimension(400,25);



    /* ATTRIBUTS */
    private int id_semestre;
    private Modele modele;
    private JDialog parent;
    private int nb_max, nb_actuel;
    private JButton bouton_validation_nombre_enseingements, valid, annuler;
    private JTextField nombre_enseingnements, field_coef;
    private JLabel erreur, erreurGlobale, erreur_coef, erreur_nomMatiere, erreur_professeur;
    private JComboBox<String> listeProf, listeMatieres;
    private boolean vProf, vMatiere, vCoef;




    /* CONSTRUCTEURS */
    public AjoutEnseignementSemestre(JDialog parent,Modele modele, int id_semestre){
        super(parent, "Ajouter des enseignements", true);
        this.parent = parent;

        this.id_semestre = id_semestre;
        this.modele=modele;
        this.setMinimumSize(new Dimension(800,100));
        EmptyBorder marge = new EmptyBorder(5,10,10,10);


        this.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        Container cp = this.getContentPane();
        cp.setLayout(new BorderLayout());

        JPanel def_nombre = new JPanel();

        JLabel labelNombreEnseingnements = new JLabel("Nombre d'enseingnements à ajouter :");
        labelNombreEnseingnements.setPreferredSize(new Dimension(300,25));
        labelNombreEnseingnements.setBorder(marge);
        this.nombre_enseingnements = new JTextField();
        this.nombre_enseingnements.setPreferredSize(new Dimension(150, 25));
        this.nombre_enseingnements.setBorder(marge);
        this.bouton_validation_nombre_enseingements = new JButton("Valider");
        this.bouton_validation_nombre_enseingements.setPreferredSize(new Dimension(100, 25));
        this.bouton_validation_nombre_enseingements.addActionListener(this);
        this.erreur = new JLabel("Merci de saisir un entier positif");
        this.erreur.setVisible(false);
        this.erreur.setForeground(Color.red);






        def_nombre.add(labelNombreEnseingnements, BorderLayout.LINE_START);
        def_nombre.add(nombre_enseingnements, BorderLayout.CENTER);
        def_nombre.add(bouton_validation_nombre_enseingements, BorderLayout.LINE_END);
        def_nombre.add(erreur, BorderLayout.SOUTH);

        cp.add(def_nombre);

        this.setLocationRelativeTo(null);
        this.pack();
        this.setVisible(true);

    }

    public AjoutEnseignementSemestre(Modele modele, JDialog parent, int id_semestre, int nb_max, int nb_actuel){
        super(parent, "Ajouter des enseignements", true);
        this.parent = parent;
        this.id_semestre = id_semestre;
        this.modele=modele;
        this.nb_max=nb_max;
        this.nb_actuel=nb_actuel;

        this.setMinimumSize(new Dimension(500,500));

        EmptyBorder marge = new EmptyBorder(5,10,10,10);
        Container cp = this.getContentPane();
        cp.setLayout(new GridLayout(7, 1));


        JLabel titre = new JLabel("Ajout d'enseignement : "+nb_actuel+"/"+nb_max);
        cp.add(titre);

        /*
        MATIERE
         */

        JPanel matiere = new JPanel();

        JLabel label_nomMatiere = new JLabel("Nom de la matière :");
        label_nomMatiere.setBorder(marge);
        label_nomMatiere.setPreferredSize(TEXT_SIZE);
        label_nomMatiere.setVerticalAlignment(SwingConstants.CENTER);
        label_nomMatiere.setHorizontalAlignment(SwingConstants.CENTER);
        matiere.add(label_nomMatiere);

        listeMatieres = new JComboBox<String>();


        ArrayList<String> nomMatiere = modele.getListeMatieresLibres(this.id_semestre);
        listeMatieres.addItem("");
        for (String s : nomMatiere) {
            listeMatieres.addItem(s);
        }

        listeMatieres.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (listeMatieres.getSelectedItem().equals("")) {
                    vMatiere = false;
                    erreur_nomMatiere.setVisible(true);
                } else {
                    vMatiere = true;
                    erreur_nomMatiere.setVisible(false);
                }
                verifOk();
            }
        });
        matiere.add(listeMatieres);

        erreur_nomMatiere = new JLabel("Merci de faire un choix");
        erreur_nomMatiere.setVisible(false);
        erreur_nomMatiere.setBorder(marge);
        erreur_nomMatiere.setPreferredSize(TEXT_SIZE_ERREUR);
        erreur_nomMatiere.setForeground(Color.RED);
        matiere.add(erreur_nomMatiere);

        cp.add(matiere);

        /*
        PROF
         */

        JPanel professeur = new JPanel();

        JLabel label_professeur = new JLabel("Professeur :");
        label_professeur.setBorder(marge);
        label_professeur.setPreferredSize(TEXT_SIZE);
        label_professeur.setHorizontalAlignment(SwingConstants.CENTER);
        label_professeur.setVerticalAlignment(SwingConstants.CENTER);
        professeur.add(label_professeur);

        listeProf = new JComboBox<String>();

        try {
            ArrayList<Integer> idProfs = modele.getListeProfesseurs();
            listeProf.addItem("");
            for (int i : idProfs) {
                listeProf.addItem(i + ":" + modele.getPrenomNomFromID(i));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        listeProf.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (listeProf.getSelectedItem().equals("")){
                    vProf=false;
                    erreur_professeur.setVisible(true);
                } else{
                    vProf=true;
                    erreur_professeur.setVisible(false);
                }
                verifOk();
            }
        });
        professeur.add(listeProf);

        erreur_professeur = new JLabel("Merci de sélectionner un professeur");
        erreur_professeur.setVisible(false);
        erreur_professeur.setBorder(marge);
        erreur_professeur.setPreferredSize(TEXT_SIZE_ERREUR);
        erreur_professeur.setForeground(Color.RED);
        professeur.add(erreur_professeur);

        cp.add(professeur);

                /*
        COEFF
         */

        JPanel coef = new JPanel();

        JLabel label_coef = new JLabel("Coefficient :");
        label_coef.setBorder(marge);
        label_coef.setPreferredSize(TEXT_SIZE);
        label_coef.setHorizontalAlignment(SwingConstants.CENTER);
        label_coef.setVerticalAlignment(SwingConstants.CENTER);
        coef.add(label_coef);

        field_coef = new JTextField();
        field_coef.setBorder(marge);
        field_coef.setPreferredSize(TEXT_SIZE);
        field_coef.getDocument().addDocumentListener(this);
        coef.add(field_coef);

        erreur_coef = new JLabel("Merci de saisir un coefficient entier");
        erreur_coef.setVisible(false);
        erreur_coef.setBorder(marge);
        erreur_coef.setForeground(Color.RED);
        erreur_coef.setPreferredSize(TEXT_SIZE_ERREUR);
        coef.add(erreur_coef);

        cp.add(coef);

        /*
        BOUTONS
         */
        JPanel boutons = new JPanel();

        annuler = new JButton("Annuler");
        annuler.addActionListener(this);
        boutons.add(annuler);

        valid = new JButton("");
        valid.setText("Suivant");
        valid.setEnabled(false);
        valid.addActionListener(this);
        boutons.add(valid);

        cp.add(boutons);

        erreurGlobale = new JLabel("Une erreur est survenue à l'insertion.");
        erreurGlobale.setForeground(Color.RED);
        erreurGlobale.setBorder(marge);
        erreurGlobale.setVisible(false);
        cp.add(erreurGlobale);

        cp.add(boutons);




        this.setLocationRelativeTo(null);
        this.pack();
        this.setVisible(true);

    }

    private void erreur(boolean b, String message){
        this.erreur.setText(message);
        this.erreur.setVisible(b);
    }


    @Override
    public void actionPerformed(ActionEvent e) {

        if (e.getSource()==this.bouton_validation_nombre_enseingements){
            try {
                int nb = Integer.parseInt(this.nombre_enseingnements.getText());
                int j = modele.maxMatiereSemestre(id_semestre);
                if(nb<0){
                    this.erreur(true,"Merci de saisir un entier positif.");
                }
                else if(nb > j){
                    this.erreur(true,"Il reste "+j+" matières sans professeur pour ce semestre.");
                }
                else {
                    this.erreur(false,"");
                    this.dispose();
                    new AjoutEnseignementSemestre(this.modele,parent,this.id_semestre,nb,1);
                }
            } catch (NumberFormatException n){
                //n.printStackTrace();
                erreur(true,"Meci de saisir un entier positif");
            }
        }
        else if(e.getSource()==this.valid){
            String nomMatiere = this.listeMatieres.getSelectedItem().toString();
            int idProf = getIdProfListe(this.listeProf.getSelectedItem().toString());
            float coef = Integer.parseInt(this.field_coef.getText());
            try {
                int a = this.modele.insertionEnseignementSemestre(this.id_semestre, nomMatiere, idProf, coef);
                if(e.getActionCommand().equals("Suivant")){
                    this.dispose();

                    /* LANCEMENT DU CONSTRUCTEUR DE JEANNE */

                    new AjoutGroupeEnseignement(this.modele,parent,a,nb_actuel,nb_max);
                }
                else this.dispose();
            }
            catch (SQLException sqle){
                sqle.printStackTrace();
                this.erreurGlobale.setVisible(true);
            }


        }
        else if (e.getSource()==this.annuler){
            this.dispose();
        }
    }

    private void verifOk(){
        valid.setEnabled(vCoef && vMatiere && vProf);
    }


    private static int getIdProfListe(String item){
        String[] s = item.split(":");
        String id = s[0].replaceAll(" ","");
        return Integer.parseInt(id);
    }

    @Override
    public void insertUpdate(DocumentEvent e) {
        this.changedUpdate(e);
    }

    @Override
    public void removeUpdate(DocumentEvent e) {
        this.changedUpdate(e);
    }

    @Override
    public void changedUpdate(DocumentEvent e) {
        try{
            float f = Float.parseFloat(this.field_coef.getText());
            this.erreur_coef.setVisible(false);
            vCoef = true;
        }
        catch (NumberFormatException e2){
            System.out.println("erreur");
            this.erreur_coef.setVisible(true);
            vCoef = false;
        }
        this.verifOk();
    }






}
