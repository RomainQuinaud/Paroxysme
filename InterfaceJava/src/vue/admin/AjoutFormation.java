package vue.admin;

import modele.Date;
import modele.Modele;
import net.miginfocom.swing.MigLayout;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.time.LocalDateTime;
import java.util.ArrayList;


public class AjoutFormation extends JDialog {


    private JButton toutValider;
    private JFrame parent;
    private JLabel Lnomformation, Lsemestres, Ldate;
    private JTextArea Tnomformation;
    private JPanel formulaire, dateSemestre;
    private JScrollPane scrollPaneNom;
    private JComboBox Tdate, Tsemestres;
    private JButton validerFormation, annuler;
    private JPanel[] saisieDates;

    private Modele modele;

    private int idSemestre;


    public AjoutFormation(JFrame parent, Modele modele) {
        super(parent, "Ajouter une formation", true);
        this.modele = modele;
        this.parent = parent;
        initComponent();

    } // Fin constructeur

    private void initComponent() {
        this.setTitle("Création d'une formation");
        this.setPreferredSize(new Dimension(800, 950));
        this.setResizable(false);
        this.setLayout(new BorderLayout());
        this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);


        formulaire = new JPanel();


        formulaire.setLayout(new MigLayout("center", "[right]20[fill][]"));




         /* nom formation */

        Lnomformation = new JLabel("Nom de la formation:", JLabel.RIGHT);
        formulaire.add(Lnomformation, "cell 0 0 1");

        Tnomformation = new JTextArea(2, 20);
        Tnomformation.setWrapStyleWord(true);
        Tnomformation.setLineWrap(true);
        Tnomformation.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {

            }

            @Override
            public void focusLost(FocusEvent e) {

                activateSemestre();
            }
        });

        scrollPaneNom = new JScrollPane(Tnomformation, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);

        formulaire.add(scrollPaneNom, "cell 1 0 2");

         /* DATE */
        Ldate = new JLabel("Année de Formation:", JLabel.RIGHT);
        formulaire.add(Ldate, "cell 0 1 1");
        Tdate = new JComboBox();

        for (int i = LocalDateTime.now().getYear(); i < LocalDateTime.now().getYear() + 50; i++)
            Tdate.addItem(i);

        Tdate.setRenderer(new MyComboBoxRenderer("Indiquez l'année de début de la formation"));
        Tdate.setSelectedIndex(-1);

        formulaire.add(Tdate, "cell 1 1 2");
        Tdate.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                activateSemestre();

            }
        });





       /* nombre de semestres */

        Lsemestres = new JLabel("Nombre de semestres:", JLabel.RIGHT);
        formulaire.add(Lsemestres, "cell 0 2 1");


        Tsemestres = new JComboBox();

        for (int i = 2; i <= 8; i++)
            Tsemestres.addItem(i);
            Tsemestres.setRenderer(new MyComboBoxRenderer("Veuillez choisir le nombre de semestres"));
            Tsemestres.setSelectedIndex(-1);
            Tsemestres.addItemListener(new ItemListener() {
                                       @Override
                                       public void itemStateChanged(ItemEvent e) {

                                           if (Tsemestres.getSelectedIndex() != -1)
                                               validerFormation.setEnabled(true);

                                           else
                                               validerFormation.setEnabled(false);
                                       }


                                   }
        );
        formulaire.add(Tsemestres, "cell 1 2 2");
        Tsemestres.setEnabled(false);


        /* Validation formation */

        validerFormation = new JButton("Valider Formation");
        validerFormation.setEnabled(false);
        formulaire.add(validerFormation, "cell 2 3");

        annuler = new JButton("Annuler");

        formulaire.add(annuler, "cell 2 3");

        toutValider = new JButton("Tout valider");
        formulaire.add(toutValider, "cell 2 3");
        toutValider.setEnabled(false);
        toutValider.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
            }
        });

        annuler.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                dispose();
                if (!Tnomformation.getText().equals("") && (int) Tdate.getSelectedIndex() != -1) {


                    modele.supprimeSemestre(Tnomformation.getText(), (int) Tdate.getSelectedItem());
                    modele.supprimeFormation(Tnomformation.getText(), (int) Tdate.getSelectedItem());
                }


            }
        });

        validerFormation.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {


                if (!Tnomformation.getText().equals("")) {

                    modele.ajoutFormation(Tnomformation.getText(), (int) Tdate.getSelectedItem());
                    validerFormation.setEnabled(false);
                    Tsemestres.setEnabled(false);
                    Tdate.setEnabled(false);
                    Tnomformation.setEnabled(false);
                    toutValider.setEnabled(true);
                    ArrayList<Date> s_deb = new ArrayList<Date>();
                    ArrayList<Date> s_fin = new ArrayList<Date>();

                    ArrayList<JComboBox> a_jour_deb = new ArrayList<JComboBox>();
                    ArrayList<JComboBox> a_mois_deb = new ArrayList<JComboBox>();
                    ArrayList<JComboBox> a_annee_deb = new ArrayList<JComboBox>();

                    ArrayList<JComboBox> a_jour_fin = new ArrayList<JComboBox>();
                    ArrayList<JComboBox> a_mois_fin = new ArrayList<JComboBox>();
                    ArrayList<JComboBox> a_annee_fin = new ArrayList<JComboBox>();

                    saisieDates = new JPanel[(int) Tsemestres.getSelectedItem()];
                    for (int i = 0; i < (int) Tsemestres.getSelectedItem(); i++) {
                        saisieDates[i] = new JPanel(new MigLayout("", "[right]"));

                        saisieDates[i].setSize(new Dimension(680, 80));
                        saisieDates[i].setPreferredSize(new Dimension(680, 80));
                        saisieDates[i].setMaximumSize(new Dimension(680, 80));

                        saisieDates[i].setName("S" + i);

                        saisieDates[i].add(new JLabel("S" + (i + 1)), "north");
                        saisieDates[i].setBackground(Color.lightGray);


                        JLabel debut = new JLabel("Date de début | ");
                        JLabel fin = new JLabel("Date de fin | ");

                        JLabel Ljour = new JLabel("Jour:");
                        JComboBox Tjour = new JComboBox();
                        for (int j = 1; j <= 31; j++)
                            Tjour.addItem(j);
                        a_jour_deb.add(Tjour);


                        JLabel Lmois = new JLabel("Mois:");
                        JLabel LmoisFIN = new JLabel("Mois:");
                        JComboBox Tmois = new JComboBox();
                        JComboBox TmoisFIN = new JComboBox();
                        if (i % 2 == 0) {
                            for (int k = 9; k <= 12; k++) {
                                Tmois.addItem(k);
                                TmoisFIN.addItem(k);
                            }
                            a_mois_deb.add(Tmois);
                            a_mois_fin.add(TmoisFIN);
                        } else {
                            for (int k = 1; k <= 7; k++) {
                                Tmois.addItem(k);
                                TmoisFIN.addItem(k);
                            }
                            a_mois_deb.add(Tmois);
                            a_mois_fin.add(TmoisFIN);
                        }


                        JLabel Lannee = new JLabel("Année:");
                        JComboBox Tannee = new JComboBox();
                        Tannee.addItem((int) Tdate.getSelectedItem() + (i / 2) + (i % 2));
                        a_annee_deb.add(Tannee);


                        JLabel LjourFIN = new JLabel("Jour:");
                        JComboBox TjourFIN = new JComboBox();
                        for (int j = 1; j <= 31; j++)
                            TjourFIN.addItem(j);
                        a_jour_fin.add(TjourFIN);


                        JLabel LanneeFIN = new JLabel("Année:");
                        JComboBox TanneeFIN = new JComboBox();
                        TanneeFIN.addItem((int) Tdate.getSelectedItem() + (i / 2) + (i % 2));
                        a_annee_fin.add(TanneeFIN);


                        s_deb.add(new Date());
                        s_fin.add(new Date());
                        JButton ajouterEnseignements = new JButton("Ajouter des enseignements au semestre " + (i + 1));
                        ajouterEnseignements.setEnabled(false);

                        ajouterEnseignements.addActionListener(new ActionListener() {
                            @Override
                            public void actionPerformed(ActionEvent e) {
                                new AjoutEnseignementSemestre(getThidJDialog(), modele, getIdSemestre());
                            }
                        });
                        saisieDates[i].add(ajouterEnseignements, "cell 7 1");


                        JButton validerSemestre = new JButton("Valider Semestre");
                        validerSemestre.setActionCommand(""+(i + 1));
                        validerSemestre.addActionListener(new ActionListener() {
                            @Override
                            public void actionPerformed(ActionEvent e) {
                                int j = Integer.parseInt(e.getActionCommand());
                                s_deb.get(j - 1).setAnnee((int) a_annee_deb.get(j - 1).getSelectedItem());
                                s_deb.get(j - 1).setMois((int) a_mois_deb.get(j - 1).getSelectedItem());
                                s_deb.get(j - 1).setJour((int) a_jour_deb.get(j - 1).getSelectedItem());
                                s_fin.get(j - 1).setAnnee((int) a_annee_fin.get(j - 1).getSelectedItem());
                                s_fin.get(j - 1).setMois((int) a_mois_fin.get(j - 1).getSelectedItem());
                                s_fin.get(j - 1).setJour((int) a_jour_fin.get(j - 1).getSelectedItem());
                                int a;
                                if (s_deb.get(j - 1).compareTo(s_fin.get(j - 1)) == -1) {

                                    if ((a = modele.ajoutSemestre("S" + j, Tnomformation.getText().replaceAll("[\n\r\t]", ""), (int) Tdate.getSelectedItem(), s_deb.get(j - 1).toBase(), s_fin.get(j - 1).toBase())) != -1) {
                                        validerSemestre.setEnabled(false);
                                        ajouterEnseignements.setEnabled(true);
                                        setIdSemestre(a);
                                    } else
                                        JOptionPane.showMessageDialog(null, "Erreur lors de l'insertion du semestre dans la base de donnée", "Erreur Insertion Semestre", JOptionPane.ERROR_MESSAGE);
                                } else
                                    JOptionPane.showMessageDialog(null, "Merci saisir une date de début du semestre antèrieure à la date de fin du semestre", "Date incohérentes", JOptionPane.ERROR_MESSAGE);


                            }
                        });
                        saisieDates[i].add(validerSemestre, "cell 7 2");


                        saisieDates[i].add(debut, "cell 0 1");
                        saisieDates[i].add(fin, "cell 0 2");

                        saisieDates[i].add(Ljour, "cell 1 1");
                        saisieDates[i].add(Tjour, "cell 2 1");
                        saisieDates[i].add(Lmois, "cell 3 1");
                        saisieDates[i].add(Tmois, "cell 4 1");
                        saisieDates[i].add(Lannee, "cell 5 1");
                        saisieDates[i].add(Tannee, "cell 6 1");


                        saisieDates[i].add(LjourFIN, "cell 1 2");
                        saisieDates[i].add(TjourFIN, "cell 2 2");
                        saisieDates[i].add(LmoisFIN, "cell 3 2");
                        saisieDates[i].add(TmoisFIN, "cell 4 2");
                        saisieDates[i].add(LanneeFIN, "cell 5 2");
                        saisieDates[i].add(TanneeFIN, "cell 6 2");


                        saisieDates[i].setVisible(true);
                        dateSemestre.add(saisieDates[i]);
                        dateSemestre.setVisible(true);
                        dialogMAJ();
                    }
                    validerFormation.setEnabled(false);


                } else
                    JOptionPane.showMessageDialog(null, "Vous devez saisir le nom de la formation", "Champ nom de la formation vide", JOptionPane.ERROR_MESSAGE);
            }
        });


        formulaire.setVisible(true);


        this.getContentPane().add(formulaire, BorderLayout.PAGE_START);

        dateSemestre = new JPanel();
        dateSemestre.setLayout(new FlowLayout());
        dateSemestre.setPreferredSize(new Dimension(600, 600));
        dateSemestre.setMaximumSize(new Dimension(600, 600));
        dateSemestre.setSize(new Dimension(600, 600));


        dateSemestre.setVisible(true);
        this.getContentPane().add(dateSemestre, BorderLayout.CENTER);


        this.pack();
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }

    private JDialog getThidJDialog () {
        return this;
    }

    private void activateSemestre() {

        if (Tdate.getSelectedIndex() != -1 && !Tnomformation.getText().equals("")) {
            if (modele.checkFormationDispo(Tnomformation.getText().replaceAll("[\n\r\t]", ""), (int) Tdate.getSelectedItem()))
                Tsemestres.setEnabled(true);
            else
                Tsemestres.setEnabled(false);
        }
    }


    private void dialogMAJ() {
        this.setVisible(true);
    }

    private int getIdSemestre() {
        return idSemestre;
    }

    private void setIdSemestre(int idSemestre) {
        this.idSemestre = idSemestre;
    }

    class MyComboBoxRenderer extends JLabel implements ListCellRenderer {
        private String _title;

        public MyComboBoxRenderer(String title) {
            _title = title;
        }

        @Override
        public Component getListCellRendererComponent(JList list, Object value,
                                                      int index, boolean isSelected, boolean hasFocus) {
            if (index == -1 && value == null) setText(_title);
            else setText(value.toString());
            return this;
        }
    }
}
