package vue.professeur;

import modele.Modele;
import vue.admin.VueAdmin;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;


public class VueProfesseur extends JFrame {

    private Modele modele;
    private int idProf;

    private JPanel panelHaut;
    private JPanel panelBas;


    private JPanel panelFormations;
    private JComboBox<String> choixFormation;


    private JPanel panelListeSemestre;
    private JLabel labelPanelListeSemestre;
    private JList<String> jListPanelListeSemestre;


    private JPanel panelListeEnseignements;
    private JLabel labelPanelListeEnseignements;
    private JList<String> jListPanelListeEnseignements;

    private JPanel panelListeGroupesUnEnseignement;
    private JLabel labelGroupesUnEnseignement;
    private JList<String> jListGroupesUnEnseignement;


    private JPanel panelListeInterrosUnGroupe;
    private JLabel labelListeInterrosUnGroupe;
    private JList<String> jListInterrosUnGroupe;



    private JPanel panelListeNotesUneInterro;
    private JScrollPane scrollNotes;
    private JLabel labelListeNotesUneInterro;
    private JPanel panelBoutons;
    private JButton nouvelleInterro;
    private JButton modifierInterro;


    private AjoutControle dialog_ajout_controle;
    private JDialog_Message dialog_message;

    private int[] tabIDSemestres;
    private int[] tabIDEnseignements;
    private int[] tabIDGroupes;




    /** ========================================== Constructors ========================================================= */

    public VueProfesseur(Modele modele, int idProf) {
        super();
        this.modele = modele;
        this.idProf = idProf;
        try {
            this.setTitle("Bienvenue " + this.modele.getPrenomNomFromID(this.idProf));
        }
        catch (SQLException exp) {
            System.err.println("constructeur VueProfesseur fct° getPrenomNomFromID -> "+exp.getMessage());
        }


        this.setSize(new Dimension(1000, 900));
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setLayout(new BorderLayout());





        panelHaut = new JPanel(new BorderLayout());
        panelHaut.setPreferredSize(new Dimension(980, 430));
        panelHaut.setBorder(BorderFactory.createEmptyBorder(25,25,25,25));
        panelBas = new JPanel(new BorderLayout());
        panelBas.setPreferredSize(new Dimension(980, 430));
        panelBas.setBorder(BorderFactory.createEmptyBorder(25,25,25,25));


        initFormations();
        initPanelSemestres();
        initPanelEnseignements();
        initPanelGroupe();
        initPanelInterro();
        initPanelNotesUneInterro();



        this.getContentPane().add(panelHaut, BorderLayout.PAGE_START);
        this.getContentPane().add(panelBas, BorderLayout.PAGE_END);
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
        panelFormations.setLayout(new BorderLayout());
        panelFormations.setPreferredSize(new Dimension(900, 30));




        choixFormation = new JComboBox<String>();
        choixFormation.addItem("Choississez votre formation");
        ArrayList<String> lesFormations = new ArrayList<String>();
        try {
            lesFormations = modele.getSesFormationsProf(idProf);
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
                if (choixFormation.getSelectedIndex()>0) {
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
                    hidePanelGroupe();
                    hidePanelInterros();
                    hidePanelNotes();
                }
            }
        });



        JButton swichAdmin = new JButton("Interface Administrateur");
        swichAdmin.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                swichtAdmin();
            }
        });

        try {
            if (!modele.isAdmin(idProf))
                swichAdmin.setVisible(false);
        }
        catch (SQLException e) {
            System.err.println("Appel fonction isAdmin ->" + e.getMessage());
        }
        panelFormations.add(choixFormation, BorderLayout.WEST);
        panelFormations.add(swichAdmin, BorderLayout.EAST);

        panelHaut.add(panelFormations, BorderLayout.PAGE_START);
    }



    /** =========================================================================== */
    /** =====================   Init du panel des semestres    ==================== */
    /** =========================================================================== */



    private void initPanelSemestres () {
        panelListeSemestre = new JPanel(new BorderLayout());
        panelListeSemestre.setPreferredSize(new Dimension(200, 400));
        panelListeSemestre.setMaximumSize(new Dimension(200, 400));


        labelPanelListeSemestre = new JLabel("Liste des semestres : ");


        jListPanelListeSemestre = new JList<String>();
        jListPanelListeSemestre.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListPanelListeSemestre.getSelectedIndex() == - 1) {
                    hidePanelEnseignements();
                    hidePanelGroupe();
                    hidePanelInterros();
                    hidePanelNotes();
                }
                else {
                    initListeEnseignementUnSemestre(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()]);
                    showPanelEnseignements();
                }
            }
        });





        panelListeSemestre.add(labelPanelListeSemestre, BorderLayout.NORTH);
        panelListeSemestre.add(jListPanelListeSemestre, BorderLayout.CENTER);
        hidePanelSemestre();
        panelHaut.add(panelListeSemestre, BorderLayout.LINE_START);
    }

                        /* ************  */



    private void initListeSemestres (String nomFormation, int anneeFormation) {
        ArrayList<Integer> listeSemestres = new ArrayList<Integer>();
        try {
            listeSemestres = modele.getIDSemestresUneFormationUnProfesseur(nomFormation, anneeFormation, idProf);
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
        panelListeEnseignements.setPreferredSize(new Dimension(200, 400));
        panelListeEnseignements.setMaximumSize(new Dimension(200, 400));

        labelPanelListeEnseignements = new JLabel("Liste de vos enseignements");
        jListPanelListeEnseignements = new JList<String>();
        jListPanelListeEnseignements.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListPanelListeEnseignements.getSelectedIndex() == -1) {
                    hidePanelGroupe();
                    hidePanelInterros();
                    hidePanelNotes();
                }
                else {
                    initJListGroupe(tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
                    showPanelGroupe();
                }
            }
        });




        panelListeEnseignements.add(labelPanelListeEnseignements, BorderLayout.PAGE_START);
        panelListeEnseignements.add(jListPanelListeEnseignements, BorderLayout.CENTER);
        hidePanelEnseignements();
        panelListeEnseignements.setBorder(BorderFactory.createEmptyBorder(0, 25, 0, 0));
        panelHaut.add(panelListeEnseignements, BorderLayout.CENTER);
    }


    private void initListeEnseignementUnSemestre (int idSemestre) {
        ArrayList<String> listeEnseignements = new ArrayList<String>();
        try {
            listeEnseignements = modele.getSesEnseignementsProf(idSemestre, idProf);
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




    private void hidePanelEnseignements () {
        labelPanelListeEnseignements.setVisible(false);
        jListPanelListeEnseignements.setVisible(false);
    }


    private void showPanelEnseignements () {
        labelPanelListeEnseignements.setVisible(true);
        jListPanelListeEnseignements.setVisible(true);
    }




    /** =========================================================================== */
    /** =====================   Init du panel des groupes      ==================== */
    /** =========================================================================== */


    private void initPanelGroupe () {
        panelListeGroupesUnEnseignement = new JPanel();
        panelListeGroupesUnEnseignement.setLayout(new BorderLayout());
        panelListeGroupesUnEnseignement.setPreferredSize(new Dimension(300, 400));
        panelListeGroupesUnEnseignement.setMaximumSize(new Dimension(300, 400));

        labelGroupesUnEnseignement = new JLabel("Liste de vos groupes");


        jListGroupesUnEnseignement = new JList<String>();
        jListGroupesUnEnseignement.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListGroupesUnEnseignement.getSelectedIndex() == -1) {
                    hidePanelInterros();
                    hidePanelNotes();

                }
                else {
                    initJListInterros(tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
                    showPanelInterros();
                    nouvelleInterro.setVisible(true);
                }
            }
        });





        panelListeGroupesUnEnseignement.add(labelGroupesUnEnseignement, BorderLayout.PAGE_START);
        panelListeGroupesUnEnseignement.add(jListGroupesUnEnseignement, BorderLayout.CENTER);
        hidePanelGroupe();
        panelListeGroupesUnEnseignement.setBorder(BorderFactory.createEmptyBorder(0,25,0,0));
        panelHaut.add(panelListeGroupesUnEnseignement, BorderLayout.LINE_END);
    }


    private void initJListGroupe (int idEnseignement) {
        ArrayList<String> listeGroupes = new ArrayList<String>();
        try {
            listeGroupes = modele.getSesGroupeUnEnseignement(idEnseignement);
        }
        catch (SQLException e) {
            System.err.println("initJListGroupe -> " + e.getMessage());
        }

        String [] dataForJList = new String[listeGroupes.size()];
        tabIDGroupes = new int[listeGroupes.size()];
        for (int i=0; i<listeGroupes.size(); i++) {
            String [] data = listeGroupes.get(i).split("---");
            dataForJList[i] = data[0];
            tabIDGroupes[i] = Integer.parseInt(data[1]);
        }
        jListGroupesUnEnseignement.setListData(dataForJList);
    }




    private void hidePanelGroupe () {
        labelGroupesUnEnseignement.setVisible(false);
        jListGroupesUnEnseignement.setVisible(false);
    }

    private void showPanelGroupe () {
        labelGroupesUnEnseignement.setVisible(true);
        jListGroupesUnEnseignement.setVisible(true);
    }





    /** =========================================================================== */
    /** =====================   Init du panel des interros     ==================== */
    /** =========================================================================== */



    private void initPanelInterro () {
        panelListeInterrosUnGroupe = new JPanel();
        panelListeInterrosUnGroupe.setLayout(new BorderLayout());
        panelListeInterrosUnGroupe.setPreferredSize(new Dimension(350, 400));
        panelListeInterrosUnGroupe.setMaximumSize(new Dimension(350, 400));

        labelListeInterrosUnGroupe = new JLabel("Liste de vos interrogations : ");


        jListInterrosUnGroupe = new JList<String>();
        jListInterrosUnGroupe.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (jListInterrosUnGroupe.getSelectedIndex() != -1) {
                    String data [];
                    data = jListInterrosUnGroupe.getSelectedValue().split("  -  ");
                    initLabelListeNotesUneInterro(data[0], tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
                    modifierInterro.setEnabled(true);
                    showPanelNotes();
                }
                else {
                    modifierInterro.setEnabled(false);
                    hidePanelNotes();
                }
            }
        });


        panelListeInterrosUnGroupe.add(labelListeInterrosUnGroupe, BorderLayout.PAGE_START);
        panelListeInterrosUnGroupe.add(jListInterrosUnGroupe, BorderLayout.CENTER);
        hidePanelInterros();
        panelBas.add(panelListeInterrosUnGroupe, BorderLayout.WEST);
    }


    private void initJListInterros (int idGroupe, int idEnseignement) {
        ArrayList<String> listeInterros = new ArrayList<String>();
        try {
            listeInterros = modele.getLibellesInterrosUnEnseignement(idGroupe, idEnseignement);
        }
        catch (SQLException e) {
            System.err.println("initJListInterros -> " + e.getMessage());
        }

        String [] dataForJList = new String[listeInterros.size()];
        for (int i=0; i<listeInterros.size(); i++) {
            dataForJList[i] = listeInterros.get(i);
        }

        jListInterrosUnGroupe.setListData(dataForJList);
    }


    private void hidePanelInterros () {
        labelListeInterrosUnGroupe.setVisible(false);
        jListInterrosUnGroupe.setVisible(false);
    }

    private void showPanelInterros () {
        labelListeInterrosUnGroupe.setVisible(true);
        jListInterrosUnGroupe.setVisible(true);
    }




    /** =========================================================================== */
    /** ==============   Init du panel des notes pour une interro   =============== */
    /** =========================================================================== */



    private void initPanelNotesUneInterro () {
        panelListeNotesUneInterro = new JPanel(new BorderLayout());
        panelListeInterrosUnGroupe.setPreferredSize(new Dimension(350, 400));
        panelListeInterrosUnGroupe.setMaximumSize(new Dimension(350, 400));


        labelListeNotesUneInterro = new JLabel();
        labelListeNotesUneInterro.setVerticalAlignment(SwingConstants.TOP);

        panelBoutons = new JPanel(new FlowLayout());
        modifierInterro = new JButton("Modifier l'interrogation");
        modifierInterro.setActionCommand("modifierInterro");
        modifierInterro.setEnabled(false);
        modifierInterro.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String data [] = ((String)choixFormation.getSelectedItem()).split("---");
                String nomFormation = data[0];
                int anneeFormation = Integer.parseInt(data[1]);
                String dataInterro [];
                dataInterro = jListInterrosUnGroupe.getSelectedValue().split("  -  ");
                try {
                    if (modele.isSemestreOuvert(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()])) {
                        //int idEnseignement = tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()];
                        try {
                            if (modele.isSemestreFerme(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()])) {
                                try {
                                    if (modele.isResponsable(nomFormation, anneeFormation, idProf)) {
                                        dialog_ajout_controle = new AjoutControle(getJFrame(), modele, tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()], tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], 1, dataInterro[0]);
                                    } else {
                                        dialog_message = new JDialog_Message(getJFrame(), "<html><p>Le semestre est fermé et vous n'êtes pas responsable de la formation.<br/>Seul ce dernier peut modifier une interrogation d'un semestre terminé.</p></html>");
                                    }
                                }
                                catch (SQLException exp2) {
                                    System.err.println("actionPerformed on modifierInterro \"modele.isResponsable\" -> " + exp2.getMessage());
                                }
                            }
                            else {
                                dialog_ajout_controle = new AjoutControle(getJFrame(), modele, tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()], tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], 1, dataInterro[0]);
                            }
                        }
                        catch (SQLException exp) {
                            System.err.println("actionPerformed on modifierInterro \"isSemestreFerme\" -> " + exp.getMessage());
                        }
                    }
                    else {
                        dialog_message = new JDialog_Message(getJFrame(), "<html><p>Vous ne devez normalement pas avoir d'interrogations car le semestre n'est pas ouvert.<br/>Surement un problème dans la base de données.</p></html>");
                    }
                }
                catch (SQLException exp1) {
                    System.err.println("actionPerformed on modifierInterro pour semestreOuvert -> " + exp1.getMessage());
                }
                String data1 [];
                data1 = jListInterrosUnGroupe.getSelectedValue().split("  -  ");
                initLabelListeNotesUneInterro(data1[0],tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
            }
        });


        nouvelleInterro = new JButton("Ajouter une interrogation");
        nouvelleInterro.setActionCommand("nouvelleInterro");
        nouvelleInterro.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String data [] = ((String)choixFormation.getSelectedItem()).split("---");
                String nomFormation = data[0];
                int anneeFormation = Integer.parseInt(data[1]);
                try {
                    if (modele.isSemestreOuvert(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()])) {
                        //int idEnseignement = tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()];
                        try {
                            if (modele.isSemestreFerme(tabIDSemestres[jListPanelListeSemestre.getSelectedIndex()])) {
                                try {
                                    if (modele.isResponsable(nomFormation, anneeFormation, idProf)) {
                                        new AjoutControle(getJFrame(), modele, tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()], tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], 0, "");
                                    } else {
                                        new JDialog_Message(getJFrame(), "<html><p>Le semestre est fermé et vous n'êtes pas responsable de la formation.<br/>Seul ce dernier peut ajouter une interrogation d'un semestre terminé.</p></html>");
                                    }
                                }
                                catch (SQLException exp2) {
                                    System.err.println("actionPerformed on modifierInterro \"modele.isResponsable\" -> " + exp2.getMessage());
                                }
                            }
                            else {
                                new AjoutControle(getJFrame(), modele, tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()], tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], 0, "");
                            }
                        }
                        catch (SQLException exp) {
                            System.err.println("actionPerformed on modifierInterro \"isSemestreFerme\" -> " + exp.getMessage());
                        }
                    }
                    else {
                        new JDialog_Message(getJFrame(), "<html><p>Vous ne devez normalement pas avoir d'interrogations car le semestre n'est pas ouvert.<br/>Surement un problème dans la base de données.</p></html>");
                    }
                }
                catch (SQLException exp1) {
                    System.err.println("actionPerformed on modifierInterro pour semestreOuvert -> " + exp1.getMessage());
                }

                initJListInterros(tabIDGroupes[jListGroupesUnEnseignement.getSelectedIndex()], tabIDEnseignements[jListPanelListeEnseignements.getSelectedIndex()]);
            }
        });

        panelBoutons.add(modifierInterro);
        panelBoutons.add(nouvelleInterro);




        scrollNotes = new JScrollPane(labelListeNotesUneInterro, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollNotes.setBorder(BorderFactory.createMatteBorder(0, 25, 0, 25, panelBas.getBackground()));

        panelListeNotesUneInterro.add(new JLabel("  "), BorderLayout.PAGE_START);
        panelListeNotesUneInterro.add(scrollNotes, BorderLayout.CENTER);
        panelListeNotesUneInterro.add(panelBoutons, BorderLayout.PAGE_END);
        hidePanelNotes();
        panelBas.add(panelListeNotesUneInterro, BorderLayout.CENTER);

    }


    private void initLabelListeNotesUneInterro (String libelleInterro, int idGroupe, int idEnseignement) {
        try {
            labelListeNotesUneInterro.setText(modele.getInfoHTMLListeNotesUnGroupe(libelleInterro, idGroupe, idEnseignement));
        }
        catch (SQLException e) {
            System.err.println("initLabelListeNotesUneInterro -> " + e.getMessage());
        }
    }


    private void hidePanelNotes() {
        hidePanelBoutons();
        scrollNotes.setVisible(false);
        labelListeNotesUneInterro.setVisible(false);
    }

    private void showPanelNotes () {
        showPanelBoutons();
        scrollNotes.setVisible(true);
        labelListeNotesUneInterro.setVisible(true);
    }

    private void hidePanelBoutons () {
        nouvelleInterro.setVisible(false);
        modifierInterro.setVisible(false);
    }
    private void showPanelBoutons () {
        nouvelleInterro.setVisible(true);
        modifierInterro.setVisible(true);
    }

    private void swichtAdmin () {
        this.dispose();
        new VueAdmin(modele, idProf);
    }

    private JFrame getJFrame () {
        return this;
    }

    public static void main(String[] args) {
        Modele modeleTest = new Modele();
        VueProfesseur test = new VueProfesseur(modeleTest, 2);
    }

}
