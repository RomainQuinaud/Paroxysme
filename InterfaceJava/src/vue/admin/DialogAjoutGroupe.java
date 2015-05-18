package vue.admin;

import modele.Modele;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;


public class DialogAjoutGroupe extends JDialog {

    private Modele modele;
    private int idNouveauGroupe;
    private JFrame parent;
    private int boutonAjouterGroupeClick = 0;

    private JPanel panelNomGroupe;
    private JLabel labelNomGroupe;
    private JTextField textFieldNomGroupe;
    private JButton validerNom;

    private JPanel panelCenter;
    private JLabel labelListeEtudiants;
    private JPanel panelDesListesEtudiants;
    private JScrollPane scrollPaneListeEtudiantsPasDansGroupe;
    private JList<String> listeEtudiantsPasDansGroupe;
    private JScrollPane scrollPaneListeEtudiantsDansGroupe;
    private JList<String> listeEtudiantsDansGroupe;
    private int [] idEtudiantsPasDansGroupe;
    private int [] idEtudiantsDansGroupe;
    private JPanel panelBoutonsBottom;
    private JButton btnSupprimerEtudiant;
    private JButton btnAjouterNouvelEtudiant;
    private JButton btnAjouterCetEtudiant;
    private JButton btnTerminerCreationGroupe;
    private JButton btnAnnulerTout;


    /** ========================================== Constructors ========================================================= */

    public DialogAjoutGroupe (JFrame parent, Modele modele) {
        super(parent, "Ajouter des Groupes", true);
        this.parent = parent;
        this.modele = modele;
        this.setLayout(new BorderLayout());


        initPanelNomGroupe();
        initPalelListeEleves();
        initPanelBoutons();




        this.setResizable(false);
        this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE); // il faut supprimer les inserts
        this.setSize(new Dimension(550, 700));
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }




    private void initPanelNomGroupe() {
        panelNomGroupe = new JPanel(new FlowLayout());

        labelNomGroupe = new JLabel("Nom du groupe");

        textFieldNomGroupe = new JTextField();
        textFieldNomGroupe.setText("");
        textFieldNomGroupe.setPreferredSize(new Dimension(200, 30));
        textFieldNomGroupe.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void insertUpdate(DocumentEvent e) {
                if (textFieldNomGroupe.getText().equals("") || !modele.checkGroupeDispo(textFieldNomGroupe.getText()))
                    validerNom.setEnabled(false);
                else
                    validerNom.setEnabled(true);
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                if (textFieldNomGroupe.getText().equals("") || !modele.checkGroupeDispo(textFieldNomGroupe.getText()))
                    validerNom.setEnabled(false);
                else
                    validerNom.setEnabled(true);
            }

            @Override
            public void changedUpdate(DocumentEvent e) {
                if (textFieldNomGroupe.getText().equals("") || !modele.checkGroupeDispo(textFieldNomGroupe.getText()))
                    validerNom.setEnabled(false);
                else
                    validerNom.setEnabled(true);
            }
        });

        validerNom = new JButton("Valider le nom");
        validerNom.setEnabled(false);
        validerNom.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    idNouveauGroupe = modele.insererNouveauGroupe(textFieldNomGroupe.getText());

                }
                catch (SQLException exp) {
                    System.err.println("probleme insérer groupe modele.insererNouveauGroupe -> " + exp.getMessage());
                }

                validerNom.setEnabled(false);
                textFieldNomGroupe.setEnabled(false);
                initListeEtudiantsDansGroupe();
                initListeEtudiantsPasDansGroupe();
                btnAjouterNouvelEtudiant.setEnabled(true); // le groupe est créé on peut ajouter un nouvel étudiant
                boutonAjouterGroupeClick = 1;
                updateBoutonTerminer();
            }
        });

        panelNomGroupe.add(labelNomGroupe);
        panelNomGroupe.add(textFieldNomGroupe);
        panelNomGroupe.add(validerNom);
        panelNomGroupe.setBorder(BorderFactory.createEmptyBorder(5,5,15,5));

        this.getContentPane().add(panelNomGroupe, BorderLayout.PAGE_START);

    }



    private void initPalelListeEleves () {

        panelCenter = new JPanel(new BorderLayout());
        panelCenter.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));

        labelListeEtudiants = new JLabel("<html><p>Vous trouverez à gauche la liste des étudiants qui existent et à droite la liste des étudiants du groupe nouvellement créé</p></html>");
        panelCenter.add(labelListeEtudiants, BorderLayout.PAGE_START);


        panelDesListesEtudiants = new JPanel(new BorderLayout());

        /** Liste des étudiants pas dans le groupe */
        listeEtudiantsPasDansGroupe = new JList<String>();
        listeEtudiantsPasDansGroupe.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (listeEtudiantsPasDansGroupe.getSelectedIndex() != -1) {
                    btnAjouterCetEtudiant.setEnabled(true);
                }
                else {
                    btnAjouterCetEtudiant.setEnabled(false);
                }
            }
        });



        /** Liste des étudiants dans le groupe */
        listeEtudiantsDansGroupe = new JList<String>();
        listeEtudiantsDansGroupe.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (listeEtudiantsDansGroupe.getSelectedIndex() != -1) {
                    btnSupprimerEtudiant.setEnabled(true);
                }
                else {
                    btnSupprimerEtudiant.setEnabled(false);
                }
            }
        });

        scrollPaneListeEtudiantsPasDansGroupe = new JScrollPane(listeEtudiantsPasDansGroupe, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollPaneListeEtudiantsDansGroupe = new JScrollPane(listeEtudiantsDansGroupe, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        panelDesListesEtudiants.add(scrollPaneListeEtudiantsPasDansGroupe, BorderLayout.WEST);
        panelDesListesEtudiants.add(scrollPaneListeEtudiantsDansGroupe, BorderLayout.EAST);


        panelCenter.add(panelDesListesEtudiants, BorderLayout.CENTER);
        JPanel boutonsCenter = new JPanel(new FlowLayout());
        btnAjouterCetEtudiant = new JButton("Ajouter cet étudiant");
        btnAjouterCetEtudiant.setEnabled(false);
        btnSupprimerEtudiant = new JButton("Supprimer cet étudiant");
        btnSupprimerEtudiant.setEnabled(false);


        btnAjouterCetEtudiant.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int savedIndex = listeEtudiantsPasDansGroupe.getSelectedIndex();
                    int idEtudiant = idEtudiantsPasDansGroupe[savedIndex];
                    modele.insertEtudiantDansGroupe(idNouveauGroupe, idEtudiant);

                    if (savedIndex == 0) {
                        listeEtudiantsPasDansGroupe.clearSelection();
                        initListeEtudiantsPasDansGroupe();
                        if (listeEtudiantsPasDansGroupe.getModel().getSize() > 0) {
                            listeEtudiantsPasDansGroupe.setSelectedIndex(0);
                        }
                    } else {
                        initListeEtudiantsPasDansGroupe();
                        listeEtudiantsPasDansGroupe.setSelectedIndex(savedIndex - 1);
                    }


                    initListeEtudiantsDansGroupe();

                }
                catch (SQLException exe) {
                    System.err.println("actionListener btnAjouterCetEtudiant modele.insertEtudiantDansGroupe -> " + exe.getMessage());
                }

            }
        });

        btnSupprimerEtudiant.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int savedIndex = listeEtudiantsDansGroupe.getSelectedIndex();
                    int idEtudiant = idEtudiantsDansGroupe[savedIndex];
                    modele.deleteEtudiantDansGroupe(idNouveauGroupe, idEtudiant);

                    if (savedIndex == 0) {
                        listeEtudiantsDansGroupe.clearSelection();
                        initListeEtudiantsDansGroupe();
                        if (listeEtudiantsDansGroupe.getModel().getSize() > 0) {
                            listeEtudiantsDansGroupe.setSelectedIndex(0);
                        }
                    } else {
                        initListeEtudiantsDansGroupe();
                        listeEtudiantsDansGroupe.setSelectedIndex(savedIndex - 1);
                    }

                    initListeEtudiantsPasDansGroupe();

                }
                catch (SQLException exe1) {
                    System.err.println("actionListener btnSupprimerEtudiant modele.deleteEtudiantDansGroupe -> " + exe1.getMessage());
                }
            }
        });





        boutonsCenter.add(btnAjouterCetEtudiant);
        boutonsCenter.add(btnSupprimerEtudiant);
        panelCenter.add(boutonsCenter, BorderLayout.PAGE_END);

        this.getContentPane().add(panelCenter, BorderLayout.CENTER);
    }






    private void initPanelBoutons() {
        panelBoutonsBottom = new JPanel(new FlowLayout());

        btnAjouterNouvelEtudiant = new JButton("Ajouter un nouvel étudiant");
        btnAjouterNouvelEtudiant.setEnabled(false);

        btnAnnulerTout = new JButton("Tout annuler");
        btnTerminerCreationGroupe = new JButton("Terminer la création");
        btnTerminerCreationGroupe.setEnabled(false);


        panelBoutonsBottom.add(btnAjouterNouvelEtudiant);
        panelBoutonsBottom.add(btnAnnulerTout);
        panelBoutonsBottom.add(btnTerminerCreationGroupe);



        btnAjouterNouvelEtudiant.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new DialogCreationEleve(parent, modele, idNouveauGroupe);
                initListeEtudiantsDansGroupe();
            }
        });

        btnAnnulerTout.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (boutonAjouterGroupeClick == 0) { // on a rien inséré
                    dispose();
                }
                else {
                    if (idEtudiantsDansGroupe.length > 0) { // on supprime tous les étudiants ajoutés
                        for (int i=0; i<idEtudiantsDansGroupe.length; i++) {
                            try {
                                modele.deleteEtudiantDansGroupe(idNouveauGroupe, idEtudiantsDansGroupe[i]);
                            }
                            catch (SQLException exe1) {
                                System.err.println("actionListener btnAnnulerTout modele.deleteEtudiantDansGroupe -> " + exe1.getMessage());
                            }
                        }
                    }


                    try {
                        modele.deleteGroupe(idNouveauGroupe);
                    }
                    catch (SQLException exe1) {
                        System.err.println("actionListener btnAnnulerTout modele.deleteGroupe -> " + exe1.getMessage());
                    }
                    dispose();
                }
            }
        });

        btnTerminerCreationGroupe.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
            }
        });


        this.getContentPane().add(panelBoutonsBottom, BorderLayout.PAGE_END);
    }





    private void initListeEtudiantsPasDansGroupe () {
        ArrayList<String[]> liste = new ArrayList<String[]>();

        try {
            liste = modele.getEtudiantsPasDansGroupe(idNouveauGroupe);
        }
        catch (SQLException e) {
            System.err.println("initListeEtudiantsPasDansGroupe : Appel a getEtudiantsPasDansGroupe -> " +e.getMessage());
        }

        String [] dataJList = new String[liste.size()];
        idEtudiantsPasDansGroupe = new int[liste.size()];
        if (liste.size() > 0) {
            for (int i = 0; i < liste.size(); i++) {
                dataJList[i] = liste.get(i)[0];
                idEtudiantsPasDansGroupe[i] = Integer.parseInt(liste.get(i)[1]);
            }

            listeEtudiantsPasDansGroupe.setListData(dataJList);
        }
        else {
            String temp [] = new String[0];
            listeEtudiantsPasDansGroupe.setListData(temp);
        }
    }


    private void initListeEtudiantsDansGroupe () {
        ArrayList<String[]> liste = new ArrayList<String[]>();

        try {
            liste = modele.getEtudiantsDansGroupe(idNouveauGroupe);
        }
        catch (SQLException e) {
            System.err.println("initListeEtudiantsDansGroupe : Appel a getEtudiantsDansGroupe -> " +e.getMessage());
        }

        String [] dataJList = new String[liste.size()];
        idEtudiantsDansGroupe = new int[liste.size()];
        if (liste.size() > 0) {
            for (int i = 0; i < liste.size(); i++) {
                dataJList[i] = liste.get(i)[0];
                idEtudiantsDansGroupe[i] = Integer.parseInt(liste.get(i)[1]);
            }

            listeEtudiantsDansGroupe.setListData(dataJList);
        }
        else {
            String temp [] = new String[0];
            listeEtudiantsDansGroupe.setListData(temp);
        }
    }





    private void updateBoutonTerminer () {
        if (listeEtudiantsDansGroupe.getComponentCount() == 0) {
            btnTerminerCreationGroupe.setEnabled(false);
        }
        else
            btnTerminerCreationGroupe.setEnabled(true);
    }





}
