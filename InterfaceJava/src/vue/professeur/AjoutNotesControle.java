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

            if (mode == 1) { // on modifie une interro
                try {
                    tabJTextFieldNote[i].setText(""+modele.getNoteForIDEleve(ancienLibelle, idGroupe, idEnseignement, idEleves[i]));
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


            tabJLabelsID[i] = new JLabel();
            tabJLabelsID[i].setName(""+idEleves[i]); // id de l'élève

            tabJpanelUneNote[i].add(unLabel);
            tabJpanelUneNote[i].add(tabJTextFieldNote[i]);
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




    private boolean validerOK () {
        for (int i=0; i<tabJTextFieldNote.length; i++) {
            try {
                String note = tabJTextFieldNote[i].getText();
                if (note.equals("")) {
                    return false;
                } else if (Float.parseFloat(note) < 0 || Float.parseFloat(note) > 20) {
                    return false;
                }
            }
            catch (Exception e) {
                return false;
            }
        }
        return true;
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
                modele.updateNote(Float.parseFloat(tabJTextFieldNote[i].getText()), idEleves[i], idGroupe, idEnseignement, libelleInterro);
                dispose();
            }
            catch (SQLException e) {
                System.err.println("insererLesNotes appel a updateNote -> "+e.getMessage());
            }
        }
        else {
            try {
                modele.insertNouvelleInterro(idEleves[i], idGroupe, idEnseignement, libelleInterro, dateInterro, Float.parseFloat(tabJTextFieldNote[i].getText()), coef, 0, 0, typeNote);
                dispose();
            }
            catch (SQLException e) {
                System.err.println("insererLesNotes appel a insertNouvelleInterro -> "+e.getMessage());
            }
        }
    }


}
