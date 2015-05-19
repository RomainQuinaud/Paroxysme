package vue.professeur;


import modele.Modele;

import javax.swing.*;
import javax.swing.border.BevelBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class AjoutNotesControle extends JDialog {


    /** ========================================== Constructors ========================================================= */

    private Modele modele;
    private int idGroupe;
    private int idEnseignement;
    private String libelleInterro;
    private String ancienLibelle;
    private String dateInterro;
    private String typeNote;
    private float coef;
    private int mode;
    private int nbEleves;
    private int[] idEleves;
    private JPanel[] tabJpanelUneNote;
    private JLabel[] tabJLabelsID;
    private JTextField[] tabJTextFieldNote;
    private JCheckBox[] tabCheckBoxesABS;
    private JCheckBox[] tabCheckBoxesABSJ;



    private JLabel labelTitre;
    private JButton annuler;
    private JButton valider;


    public AjoutNotesControle (JFrame parent, Modele modele, int idEnseignement, int idGroupe, int mode, String ancienLibelle, String libelleInterro, String dateInterro, float coef, String typeNote) {
        super(parent, "Rentrer les notes", true);
        this.setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));
        this.modele = modele;
        this.idGroupe = idGroupe;
        this.idEnseignement = idEnseignement;
        this.mode = mode;
        this.libelleInterro = libelleInterro;
        this.ancienLibelle = ancienLibelle;
        this.typeNote = typeNote;
        this.dateInterro = dateInterro;
        this.coef = coef;
        try {
            this.idEleves = this.modele.getNbElevesUnGroupe(idGroupe);
            this.nbEleves = idEleves.length;
        }
        catch (SQLException exp) {
            System.err.println("constructeur AjoutNotesControle fct° getNbElevesUnGroupe -> " + exp.getMessage());
        }



        JPanel panelTitre = new JPanel(new FlowLayout());
        panelTitre.setPreferredSize(new Dimension(480, 100));

        this.labelTitre = new JLabel();
        labelTitre.setText("<html><h2>Veuillez maintenant entrer les notes pour chacun des élèves de votre groupe.</h2>");
        labelTitre.setPreferredSize(new Dimension(475, 98));
        panelTitre.add(labelTitre);
        this.add(panelTitre);


        JPanel panelNotes = new JPanel();
        panelNotes.setLayout(new BoxLayout(panelNotes, BoxLayout.Y_AXIS));

        tabJpanelUneNote = new JPanel[nbEleves];
        tabJLabelsID = new JLabel[nbEleves];
        tabJTextFieldNote = new JTextField[nbEleves];
        tabCheckBoxesABS = new JCheckBox[nbEleves];
        tabCheckBoxesABSJ = new JCheckBox[nbEleves];



        for (int i=0; i<nbEleves; i++) {
            tabJpanelUneNote[i] = new JPanel(new FlowLayout());
            tabJpanelUneNote[i].setName("panel" + i);
            tabJpanelUneNote[i].setPreferredSize(new Dimension(480, 50));
            tabJpanelUneNote[i].setMaximumSize(new Dimension(480, 50));
            tabJpanelUneNote[i].setAlignmentX(Component.CENTER_ALIGNMENT);

            JLabel unLabel = new JLabel();
            unLabel.setName("label" + i);

            unLabel.setPreferredSize(new Dimension(200, 20));
            try {
                unLabel.setText(modele.getNameUtilisateurFromID(idEleves[i])); // nom de l'élève
            }
            catch (SQLException exp1) {
                System.err.println("Constructeur jdialog saisie notes appel fonction getNameUtilisateurFromID -> " + exp1.getMessage());
            }

            tabJTextFieldNote[i] = new JTextField();
            tabJTextFieldNote[i].setName("note" + i);
            tabJTextFieldNote[i].setPreferredSize(new Dimension(60, 35));
            tabJTextFieldNote[i].setHorizontalAlignment(SwingConstants.RIGHT);

            tabCheckBoxesABS[i] = new JCheckBox("ABS");
            tabCheckBoxesABS[i].setSelected(false);
            tabCheckBoxesABSJ[i] = new JCheckBox("ABS J.");
            tabCheckBoxesABSJ[i].setSelected(false);




            if (mode == 1) { // on modifie une interro
                try {
                    if (modele.eleveABSInterro(ancienLibelle, idGroupe, idEnseignement, idEleves[i])==1) {
                        if (modele.eleveABSJustifieInterro(ancienLibelle, idGroupe, idEnseignement, idEleves[i])==1) {
                            tabJTextFieldNote[i].setEnabled(false);
                            tabCheckBoxesABS[i].setSelected(false);
                            tabCheckBoxesABS[i].setEnabled(false);
                            tabCheckBoxesABSJ[i].setSelected(true);
                            // abscence justifiée
                        }
                        else {
                            tabJTextFieldNote[i].setEnabled(false);
                            tabCheckBoxesABS[i].setSelected(true);
                            tabCheckBoxesABS[i].setEnabled(true);
                            tabCheckBoxesABSJ[i].setSelected(false);
                            tabCheckBoxesABSJ[i].setEnabled(false);
                            // absence
                        }
                    }
                    else {
                        tabJTextFieldNote[i].setText("" + modele.getNoteForIDEleve(ancienLibelle, idGroupe, idEnseignement, idEleves[i]));
                        tabCheckBoxesABS[i].setSelected(false);
                        tabCheckBoxesABS[i].setEnabled(false);
                        tabCheckBoxesABSJ[i].setSelected(false);
                        tabCheckBoxesABSJ[i].setEnabled(false);
                    }
                }
                catch (SQLException exp) {
                    System.err.println("Set text note dans tabJTextFieldNote appel getNoteForIDEleve -> "+exp.getMessage());
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }


            tabJTextFieldNote[i].getDocument().addDocumentListener(new DocumentListener() {
                @Override
                public void insertUpdate(DocumentEvent e) {
                    updateBoutonValider();
                }

                @Override
                public void removeUpdate(DocumentEvent e) {
                    updateBoutonValider();
                }

                @Override
                public void changedUpdate(DocumentEvent e) {
                    updateBoutonValider();
                }
            });


            tabCheckBoxesABS[i].addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    updateCheckBox();
                    updateBoutonValider();
                }
            });
            tabCheckBoxesABSJ[i].addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    updateCheckBox();
                    updateBoutonValider();
                }
            });



            tabJLabelsID[i] = new JLabel();
            tabJLabelsID[i].setName(""+idEleves[i]); // id de l'élève

            tabJpanelUneNote[i].add(unLabel);
            tabJpanelUneNote[i].add(tabJTextFieldNote[i]);
            tabJpanelUneNote[i].add(tabCheckBoxesABS[i]);
            tabJpanelUneNote[i].add(tabCheckBoxesABSJ[i]);

            panelNotes.add(tabJpanelUneNote[i]);
        }
        JScrollPane scrollNotes = new JScrollPane(panelNotes, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollNotes.setPreferredSize(new Dimension(500, 600));
        scrollNotes.setBorder(BorderFactory.createBevelBorder(BevelBorder.LOWERED));


        this.add(scrollNotes);









        JPanel panelButtons = new JPanel(new FlowLayout());
        panelButtons.setPreferredSize(new Dimension(400, 50));
        annuler = new JButton("Annuler");
        annuler.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
            }
        });
        panelButtons.add(annuler);


        valider = new JButton("Valider");
        valider.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (getMode()==1) {
                    updateInterro(); // on change les infos de l'interro avant de mettre à jour les notes
                }
                for (int i=0; i<idEleves.length; i++) {
                    insererLesNotes(i); // suivant que le mode est à 1 ou 0, on fait des updates ou des inserts
                }

            }
        });

        panelButtons.add(valider);
        this.add(panelButtons);




        updateBoutonValider();
        this.setResizable(false);
        this.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        this.setSize(new Dimension(500, 750));
        this.setLocationRelativeTo(null);
        this.setVisible(true);

    }


    private boolean noteCorrecte (String note) {
        try {
            if (note.equals("")) {
                return false;
            } else if (Float.parseFloat(note) < 0 || Float.parseFloat(note) > 20) {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
        return true;
    }


    private boolean validerOK () {
        boolean test = false;
        for (int i=0; i<tabJTextFieldNote.length; i++) {
            if (noteCorrecte(tabJTextFieldNote[i].getText())) {
                if (!tabCheckBoxesABS[i].isSelected() && !tabCheckBoxesABSJ[i].isSelected()) // note correcte aucune checkbox
                    test = true;
            }
            else if (!noteCorrecte(tabJTextFieldNote[i].getText()) && (tabCheckBoxesABS[i].isSelected() || tabCheckBoxesABSJ[i].isSelected())) {
                test = true;
            }
            else {
                test = false;
            }
        }
        return test;
    }


    private void updateCheckBox () {
        for (int i=0; i<tabJTextFieldNote.length; i++) {
            if (tabCheckBoxesABS[i].isSelected()) {
                tabCheckBoxesABSJ[i].setSelected(false);
                tabCheckBoxesABSJ[i].setEnabled(false);
                tabJTextFieldNote[i].setEnabled(false);
                tabJTextFieldNote[i].setText("");

            }
            else if (tabCheckBoxesABSJ[i].isSelected()) {
                tabCheckBoxesABS[i].setEnabled(false);
                tabCheckBoxesABS[i].setSelected(false);
                tabJTextFieldNote[i].setEnabled(false);
                tabJTextFieldNote[i].setText("");
            }
            else if (!tabCheckBoxesABS[i].isSelected()) {
                tabCheckBoxesABS[i].setEnabled(true);
                tabCheckBoxesABSJ[i].setEnabled(true);
                tabJTextFieldNote[i].setEnabled(true);
            }

            else if (!tabCheckBoxesABSJ[i].isSelected()) {
                tabCheckBoxesABS[i].setEnabled(true);
                tabCheckBoxesABSJ[i].setEnabled(true);
                tabCheckBoxesABSJ[i].setSelected(false);
                tabJTextFieldNote[i].setEnabled(true);
            }
        }
    }

    private void updateBoutonValider () {
        if (validerOK())
            valider.setEnabled(true);
        else
            valider.setEnabled(false);
    }

    private int getMode () {
        return mode;
    }

    private void updateInterro () {
        try {
            modele.updateInterro(ancienLibelle, idGroupe, idEnseignement, libelleInterro, typeNote, dateInterro, coef);
        }
        catch (SQLException e) {
            System.err.println("fonction updateInterro appel a modele.updateInterro -> " + e.getMessage());
        }
    }

    private void insererLesNotes (int i) {
        if (mode == 1) {// updates
            try {
                modele.updateNote(Float.parseFloat(tabJTextFieldNote[i].getText()), idEleves[i], idGroupe, idEnseignement, libelleInterro, getAbsent(i), getAbsentJustifie(i));
                dispose();
            }
            catch (SQLException e) {
                System.err.println("insererLesNotes appel a updateNote -> "+e.getMessage());
            }
        }
        else {
            try {
                if (getAbsent(i)==0 && getAbsentJustifie(i)==0) {
                    modele.insertNouvelleInterro(idEleves[i], idGroupe, idEnseignement, libelleInterro, dateInterro, Float.parseFloat(tabJTextFieldNote[i].getText()), coef, getAbsent(i), getAbsentJustifie(i), typeNote);
                }
                else {
                    modele.insertNouvelleInterro(idEleves[i], idGroupe, idEnseignement, libelleInterro, dateInterro, 0, coef, getAbsent(i), getAbsentJustifie(i), typeNote);
                }
                dispose();
            }
            catch (SQLException e) {
                System.err.println("insererLesNotes appel a insertNouvelleInterro -> "+e.getMessage());
            }
        }
    }

    private int getAbsent (int i) {
        if (tabCheckBoxesABS[i].isSelected()) {
            return 1;
        }
        else {
            return 0;
        }
    }

    private int getAbsentJustifie (int i) {
        if (tabCheckBoxesABSJ[i].isSelected()) {
            return 1;
        }
        else {
            return 0;
        }
    }


    public static void main(String[] args) {
        new AjoutNotesControle(null, new Modele(), 1, 1, 0, "", "test", "10/12/2012", 2, "CC");
    }
}
