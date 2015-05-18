package vue.professeur;

import modele.Modele;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class AjoutControle extends JDialog implements ActionListener{
    private JFrame parent;
    private int mode; // 0 = ajouter, 1 = modifier
    private int idEnseignement;
    private int idGroupe;
    private String libelleInterro; // dans le cas d'une modification
    private String[] infosInterro;
    private Modele modele;
    private Font police;
    private JTextField libelle_interro;
    private JTextField date_interro;
    private JTextField coefficient;
    private JRadioButton cc;
    private JRadioButton ds;
    private JButton annuler;
    private JButton valider;
    private JLabel ERR_MSG;

    public AjoutControle(JFrame parent, Modele modele, int enseignement, int groupe, int mode, String libelleInterro){
        super(parent, "Ajouter une interrogation", true);
        this.parent = parent;
        this.setResizable(false);
        this.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        this.modele = modele;
        this.mode = mode;

        this.libelleInterro = libelleInterro;
        this.setSize(new Dimension(600, 400));

        this.idEnseignement = enseignement;
        this.idGroupe = groupe;

        if (this.mode == 1) {
            try {
                this.infosInterro = this.modele.getInfosInterro(idGroupe, idEnseignement, this.libelleInterro);
            }
            catch (SQLException e) {
                System.err.println("constructeur de ajoutControle appel de modele.getInfosInterro -> " + e.getMessage());
            }
        }
        setLayout(new MigLayout("insets n 30 n 30", "[]20[]", "[]10[]"));
        police = new Font("Cambria", Font.PLAIN, 15);

        JLabel intro = new JLabel("Veuillez saisir les informations concernant le contrôle :");
        intro.setFont(new Font("Cambria", Font.PLAIN, 20));
        add(intro, "dock north, gap 30 30 30 30");

        JLabel typeCtrl = new JLabel("Type de contrôle");
        typeCtrl.setFont(police);
        add(typeCtrl,"align right");

        ButtonGroup btnGroup = new ButtonGroup();
        cc = new JRadioButton("contrôle continu");
        cc.setFont(police);
        //cc.addActionListener(this);
        ds = new JRadioButton("examen final");
        ds.setFont(police);
        //ds.addActionListener(this);
        btnGroup.add(cc);
        btnGroup.add(ds);
        add(cc, "split 2");
        add(ds, "wrap");

        JLabel intitule = new JLabel("Intitulé du contrôle");
        intitule.setFont(police);
        add(intitule, "align right");
        libelle_interro = new JTextField(20);

        add(libelle_interro, "wrap");

        JLabel date = new JLabel("Date du contrôle (JJ/MM/AAAA)");
        date.setFont(police);
        add(date, "align right");
        date_interro = new JTextField(20);
        add(date_interro, "wrap");

        JLabel coef = new JLabel("Coefficient (ex: 0.5)");
        coef.setFont(police);
        add(coef, "align right");
        coefficient = new JTextField(20);
        add(coefficient, "wrap 20px");

        annuler = new JButton("Annuler");
        annuler.setActionCommand("annuler");
        annuler.addActionListener(this);
        add(annuler, "cell 1 4, wrap 20px");
        valider = new JButton("Suite");
        valider.addActionListener(this);
        add(valider, "cell 1 4, wrap 20px");

        ERR_MSG = new JLabel();
        ERR_MSG.setVisible(false);
        add(ERR_MSG, "span");


        if (mode == 1) { // on veux changer l'interrogation

            libelle_interro.setText(libelleInterro);
            if (infosInterro[0].equals("CC"))
                cc.setSelected(true);
            else
                ds.setSelected(true);

            date_interro.setText(infosInterro[1]);
            coefficient.setText(infosInterro[2]);
        }
        else {
            libelle_interro.setText("");
            cc.setSelected(false);
            ds.setSelected(false);
            date_interro.setText("");
            coefficient.setText("");
        }
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }

    //Vérifie si les données sont correctes
    private boolean check(){
        if(!cc.isSelected() && !ds.isSelected()) {
            ERR_MSG.setText("Vous devez selectionner un type de note CC ou DS");
            return false;
        }
        if(libelle_interro.getText().equals("") || date_interro.getText().equals("") || coefficient.getText().equals("")) {
            ERR_MSG.setText("Vous devez remplir les champs");
            return false;
        }
        else {
            try {
                try {
                    float coef = Float.parseFloat(coefficient.getText());
                    if (coef < 0) {
                        ERR_MSG.setText("Vous devez entrer un coefficient supérieur à 0");
                        return false;
                    }
                }
                catch (NumberFormatException nfe) {
                    ERR_MSG.setText("Le coefficient doit être un nombre");
                    return false;
                }

                if (mode == 0) { // on check que le nom ne soit pas prit que si on créé une nouvelle interro
                    if (!modele.libelleInterroLibre(idGroupe, idEnseignement, libelle_interro.getText())) {
                        ERR_MSG.setText("Le nom de cette interrogation est déjà prit");
                        return false;
                    }
                }
                String dateNonFormatee = date_interro.getText();
                try {
                    String data[] = dateNonFormatee.split("/");
                    if (data[2].length() != 4 || data[1].length() != 2 || data[1].length() != 2) {
                        ERR_MSG.setText("La date doit être au format JJ/MM/AAAA");
                        return false;
                    }
                    else if (Integer.parseInt(data[1]) < 1 || Integer.parseInt(data[1]) > 12 || Integer.parseInt(data[0]) < 1 || Integer.parseInt(data[0]) > 31) {
                        ERR_MSG.setText("Les mois doivent être comprit entre 1 et 12 et les jours entre 1 et 31");
                        return false;
                    }
                }
                catch (NullPointerException e) {
                    ERR_MSG.setText("La date doit être au format JJ/MM/AAAA");
                    return false;
                }
                catch (Exception e1) {
                    ERR_MSG.setText("La date doit être au format JJ/MM/AAAA");
                    return false;
                }
                if (!modele.dateInterroCoherente(idEnseignement, date_interro.getText().replace("/", "-"))) {
                    ERR_MSG.setText("La date doit être comprise entre le début et la fin du semestre");
                    return false;
                }
                return true;
            }
            catch (SQLException e) {
                System.err.println("check nouvelle interro -> " + e.getMessage());
                return false;
            }
            catch (Exception e1) {
                ERR_MSG.setText("La date doit être au bon format et séparée par des \"/\"");
                return false;
            }
        }
    }

    public void actionPerformed(ActionEvent e) {
        if(e.getSource() == valider){
            if(check()){
                ERR_MSG.setVisible(false);
                if (mode == 0) { // ajout d'une interro
                    dispose();
                    if (cc.isSelected())
                        new AjoutNotesControle(parent, modele, idEnseignement, idGroupe, 0, libelleInterro, libelle_interro.getText(), date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()), "CC");
                    else
                        new AjoutNotesControle(parent, modele, idEnseignement, idGroupe, 0, libelleInterro, libelle_interro.getText(), date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()), "DS");
                }
                else { // modif d'une interro
                    dispose();
                    if (cc.isSelected()) {
                        //modele.updateInterro(libelleInterro, idGroupe, idEnseignement, libelle_interro.getText(), "CC", date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()));
                        new AjoutNotesControle(parent, modele, idEnseignement, idGroupe, 1, libelleInterro, libelle_interro.getText(), date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()), "CC");
                    }
                    else {
                        //modele.updateInterro(libelleInterro, idGroupe, idEnseignement, libelle_interro.getText(), "DS", date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()));
                        new AjoutNotesControle(parent, modele, idEnseignement, idGroupe, 1, libelleInterro, libelle_interro.getText(), date_interro.getText().replace("/", "-"), Float.parseFloat(coefficient.getText()), "DS");
                    }
                }
            }
            else {
                ERR_MSG.setForeground(new Color(178, 34, 34));
                ERR_MSG.setVisible(true);
            }
        }
        else if (e.getSource() == annuler) {
            dispose();
        }
    }


    //public static void main(String[] args) {
    //  AjoutControle test = new AjoutControle(new JFrame(), new Modele(), 3, 1, 0, "Partiel de Programmations");
    // }
}