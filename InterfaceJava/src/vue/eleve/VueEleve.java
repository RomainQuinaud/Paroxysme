package vue.eleve;

import modele.Modele;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;


public class VueEleve extends JFrame {

    private Modele modele;
    private int idEleve;

    private JPanel panelFormations;
    private JComboBox<String> choixFormation;


    private JPanel panelListeSemestre;
    private JLabel labelPanelListeSemestre;
    private JList<String> jListPanelListeSemestre;
    private JPanel panelBasSemestre;


    private JPanel panelListeEnseignements;
    private JLabel labelPanelListeEnseignements;
    private JList<String> jListPanelListeEnseignements;
    private JLabel statsEleveSemestre;

    private JPanel panelNotesUnEnseignement;
    private JLabel labelTitreNotesUnEnseignement;
    private JLabel labelListeNotesUnEnseignement;
    private JLabel statEleveEnseignement;




    private int[] tabIDSemestres;
    private int[] tabIDEnseignements;



    /** ========================================== Constructors ========================================================= */

    public VueEleve (Modele modele, int idEleve) {
        super();
        this.modele = modele;
        this.idEleve = idEleve;
        try {
            this.setTitle("Bienvenue " + this.modele.getPrenomNomFromID(this.idEleve));
        }
        catch (SQLException exp) {
            System.err.println("constructeur VueEleve fct° getPrenomNomFromID -> "+exp.getMessage());
        }


        this.setSize(new Dimension(1000, 900));
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setLayout(new BorderLayout());







        initFormations();
        initPanelSemestres();
        initPanelEnseignements();
        initPanelNotes();

        this.getRootPane().setBorder(BorderFactory.createEmptyBorder(25,25,25,25));
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }




/** ==========================================   Init    ========================================================= */


    /** =========================================================================== */
    /** =====================   Init du panel des formations   ==================== */
    /** =========================================================================== */


    private void initFormations () {

        panelFormations = new JPanel();
        panelFormations.setLayout(new FlowLayout());
        panelFormations.setPreferredSize(new Dimension(900, 70));




        choixFormation = new JComboBox<String>();
        choixFormation.addItem("Choississez votre formation");
        ArrayList<String> lesFormations = new ArrayList<String>();
        try {
            lesFormations = modele.getSesFormationsEleve(idEleve);
        }
        catch (SQLException e) {
            System.err.println("initListeFormation -> " + e.getMessage());
        }
        for (String aFormation : lesFormations) {
            choixFormation.addItem(aFormation);
        }
        choixFormation.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (choixFormation.getSelectedIndex()!=0) {
                    String choix = ((String) choixFormation.getSelectedItem());
                    String[] data = choix.split("---");
                    String nomFormation = data[0];
                    int anneeFormation = Integer.parseInt(data[1]);
                    initListeSemestres(nomFormation, anneeFormation);
                    showPanelSemestre();
                }
                else {
                    hidePanelSemestre();
                    hidePanelEnseignements();
                    hidePanelNote();
                }
            }
        });


        panelFormations.add(choixFormation);

        this.getContentPane().add(panelFormations, BorderLayout.PAGE_START);
    }



    /** =========================================================================== */
    /** =====================   Init du panel des semestres    ==================== */
    /** =========================================================================== */



    private void initPanelSemestres () {
        panelListeSemestre = new JPanel(new BorderLayout());
        panelListeSemestre.setPreferredSize(new Dimension(200, 800));
        panelListeSemestre.setMaximumSize(new Dimension(200, 800));


        labelPanelListeSemestre = new JLabel("Liste des semestres : ");


        jListPanelListeSemestre = new JList<String>();
        jListPanelListeSemestre.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListPanelListeSemestre.getSelectedIndex() == - 1) {
                    hidePanelEnseignements();
                    hidePanelNote();
                }
                else {
                    initListeEnseignementUnSemestre(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()]);
                    initStatUnSemestre(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()]);
                    panelListeEnseignements.setVisible(true);
                    showPanelEnseignements();
                }
            }
        });

        panelBasSemestre = new JPanel();
        panelBasSemestre.setPreferredSize(new Dimension(200, 500));




        panelListeSemestre.add(labelPanelListeSemestre, BorderLayout.NORTH);
        panelListeSemestre.add(jListPanelListeSemestre, BorderLayout.CENTER);
        panelListeSemestre.add(panelBasSemestre, BorderLayout.SOUTH);
        hidePanelSemestre();
        this.getContentPane().add(panelListeSemestre, BorderLayout.LINE_START);
    }

                        /* ************  */



    private void initListeSemestres (String nomFormation, int anneeFormation) {
        ArrayList<Integer> listeSemestres = new ArrayList<Integer>();
        try {
            listeSemestres = modele.getIDSemestresUneFormation(nomFormation, anneeFormation);
        }
        catch (SQLException e) {
            System.err.println("initListeSemestres -> " + e.getMessage());
        }
        String [] nomsSemestres = new String[listeSemestres.size()];
        tabIDSemestres = new int[listeSemestres.size()];
        for (int i=0; i<listeSemestres.size(); i++) {
            try {
                nomsSemestres[i] = modele.getNameSemestreFromID(listeSemestres.get(i));
                tabIDSemestres[i] = listeSemestres.get(i); // quand on aura le indexOf de la jlist, il suffira de regarder à la case de cet indexOf pour avoir l'ID du semestre
            }
            catch (SQLException e) {
                System.err.println("Remplissage des noms de semestre dans initListeSemestres -> " + e.getMessage());
            }
        }
        jListPanelListeSemestre.setListData(nomsSemestres);
    }


    private void hidePanelSemestre () {
        labelPanelListeSemestre.setVisible(false);
        jListPanelListeSemestre.setVisible(false);
    }

    private void showPanelSemestre () {
        labelPanelListeSemestre.setVisible(true);
        jListPanelListeSemestre.setVisible(true);
    }


    /** =========================================================================== */
    /** =====================   Init du panel des enseignement ==================== */
    /** =========================================================================== */


    private void initPanelEnseignements () {
        panelListeEnseignements = new JPanel();
        panelListeEnseignements.setLayout(new BorderLayout());
        panelListeEnseignements.setPreferredSize(new Dimension(200, 800));
        panelListeEnseignements.setMaximumSize(new Dimension(200, 800));

        labelPanelListeEnseignements = new JLabel("Liste de vos enseignements");
        jListPanelListeEnseignements = new JList<String>();
        jListPanelListeEnseignements.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListPanelListeEnseignements.getSelectedIndex() == -1) {
                    hidePanelNote();
                }
                else {
                    initLabelListeInterrogations(tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
                    initStatUnEnseignement(tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
                    panelNotesUnEnseignement.setVisible(true);
                    showPanelNote();
                }
            }
        });

        statsEleveSemestre = new JLabel();
        statsEleveSemestre.setPreferredSize(new Dimension(200, 150));




        panelListeEnseignements.add(labelPanelListeEnseignements, BorderLayout.PAGE_START);
        panelListeEnseignements.add(jListPanelListeEnseignements, BorderLayout.CENTER);
        panelListeEnseignements.add(statsEleveSemestre, BorderLayout.PAGE_END);
        hidePanelEnseignements();
        panelListeEnseignements.setBorder(BorderFactory.createEmptyBorder(0, 25, 0, 0));
        this.getContentPane().add(panelListeEnseignements, BorderLayout.CENTER);
    }


    private void initListeEnseignementUnSemestre (int idSemestre) {
        ArrayList<String> listeEnseignements = new ArrayList<String>();
        try {
            listeEnseignements = modele.getEnseignementsUnSemestre(idSemestre);
        }
        catch (SQLException e) {
            System.err.println("initListeEnseignementUnSemestre -> " + e.getMessage());
        }

        String [] dataForJList = new String[listeEnseignements.size()];
        tabIDEnseignements = new int[listeEnseignements.size()];
        for (int i=0; i<listeEnseignements.size(); i++) {
            String [] data = listeEnseignements.get(i).split("---");
            dataForJList[i] = data[0];
            tabIDEnseignements[i] = Integer.parseInt(data[1]);
        }
        jListPanelListeEnseignements.setListData(dataForJList);
    }


    private void initStatUnSemestre (int idSemestre) {
        try {
            statsEleveSemestre.setText(modele.getInfoHTMLStatsSemestreEtudiant(idEleve, idSemestre));
        }
        catch (SQLException e) {
            System.err.println("initStatUnSemestre -> " + e.getMessage());
        }
    }

    private void hidePanelEnseignements () {
        labelPanelListeEnseignements.setVisible(false);
        jListPanelListeEnseignements.setVisible(false);
        statsEleveSemestre.setVisible(false);
    }


    private void showPanelEnseignements () {
        labelPanelListeEnseignements.setVisible(true);
        jListPanelListeEnseignements.setVisible(true);
        statsEleveSemestre.setVisible(true);
    }




    /** =========================================================================== */
    /** =====================   Init du panel des notes        ==================== */
    /** =========================================================================== */


    private void initPanelNotes () {
        panelNotesUnEnseignement = new JPanel();
        panelNotesUnEnseignement.setLayout(new BorderLayout());
        panelNotesUnEnseignement.setPreferredSize(new Dimension(500, 800));
        panelNotesUnEnseignement.setMaximumSize(new Dimension(500, 800));

        labelTitreNotesUnEnseignement = new JLabel("Liste de vos notes");

        labelListeNotesUnEnseignement = new JLabel();
        labelListeNotesUnEnseignement.setVerticalAlignment(SwingConstants.TOP);

        statEleveEnseignement = new JLabel();
        statEleveEnseignement.setPreferredSize(new Dimension(200, 150));




        panelNotesUnEnseignement.add(labelTitreNotesUnEnseignement, BorderLayout.PAGE_START);
        panelNotesUnEnseignement.add(labelListeNotesUnEnseignement, BorderLayout.CENTER);
        panelNotesUnEnseignement.add(statEleveEnseignement, BorderLayout.PAGE_END);
        hidePanelNote();
        panelNotesUnEnseignement.setVisible(true);
        panelNotesUnEnseignement.setBorder(BorderFactory.createEmptyBorder(0,25,0,25));
        this.getContentPane().add(panelNotesUnEnseignement,BorderLayout.LINE_END);
    }


    private void initLabelListeInterrogations (int idEnseignement) {
        try {
            labelListeNotesUnEnseignement.setText(modele.getInfoHTMLListeNotesUnEnseignement(idEleve, idEnseignement));
        }
        catch (SQLException e) {
            System.err.println("initLabelListeInterrogations -> " + e.getMessage());
        }
    }

    private void initStatUnEnseignement (int idEnseignement) {
        try {
            statEleveEnseignement.setText(modele.getInfoHTMLStatsEnseignementEtudiant(idEleve, idEnseignement));
        }
        catch (SQLException e) {
            System.err.println("initStatUnEnseignement -> " + e.getMessage());
        }
    }

    private void hidePanelNote () {
        labelTitreNotesUnEnseignement.setVisible(false);
        labelListeNotesUnEnseignement.setVisible(false);
        statEleveEnseignement.setText("");
    }

    private void showPanelNote () {
        labelTitreNotesUnEnseignement.setVisible(true);
        labelListeNotesUnEnseignement.setVisible(true);
        statEleveEnseignement.setVisible(true);
    }








/** ==========================================  Implements  ========================================================= */


    /** =======================================  Fonctions Utiles  ========================================================= */


    public static void main(String[] args) {
        Modele modeleTest = new Modele();
        VueEleve test = new VueEleve(modeleTest, 16);
    }

}
