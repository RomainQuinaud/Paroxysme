package vue.admin;

import modele.Modele;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import net.miginfocom.swing.MigLayout;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class AjoutGroupeEnseignement extends JDialog implements ActionListener, ChangeListener{
    private JDialog parent;
    private Modele modele;
    private int idEnseignement;
    private int idSemestre;
    private int nb_actuel;
    private int nb_max;
    private ArrayList<String> listeGroupes;
    private ArrayList<JCheckBox> checkBoxes;
    private JPanel panelHaut;
    private JPanel panelCentre;
    private JPanel panelBas;
    private JButton valider;
    private JButton annuler;

    public AjoutGroupeEnseignement(Modele modele, JDialog parent, int idEnseignement, int nb_actuel, int nb_max) {
        super(parent, "Ajouter des groupes à un enseignement");
        this.modele = modele;
        this.parent = parent;
        this.idEnseignement = idEnseignement;
        this.nb_actuel = nb_actuel;
        this.nb_max = nb_max;
        try{
            idSemestre = modele.getIDSemestreFromEnseignement(idEnseignement);

            setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
            setSize(600, 550);
            setBackground(Color.darkGray);
            setResizable(false);
            setLocationRelativeTo(parent); // positionné au milieu de la fenêtre parente
            setVisible(true);

            setLayout(new BorderLayout());

            panelHaut = new JPanel();
            panelCentre = new JPanel();
            panelBas = new JPanel();
            add(panelHaut, BorderLayout.NORTH);
            add(panelCentre, BorderLayout.CENTER);
            add(panelBas, BorderLayout.SOUTH);

            checkBoxes = new ArrayList<JCheckBox>();
            listeGroupes = modele.getGroupesHorsEnseign(idEnseignement);
            initComponents();
        }
        catch(SQLException e){
            System.err.println("AjoutGroupeEnseignement -> "+e.getMessage());
        }

    }

    private void initComponents() throws SQLException{
        //******** PANEL HAUT ************
        panelHaut.setLayout(new GridLayout(5,1,0,10));
        panelHaut.setBorder(BorderFactory.createEmptyBorder(10,20,20,0));
        panelHaut.add(new JLabel("<html><u>Enseignement</u> :</html>"));

        ArrayList<String> infosEnseign = modele.getInfosEnseignement(idEnseignement);
        panelHaut.add(new JLabel("Formation : "+infosEnseign.get(0)));
        panelHaut.add(new JLabel("Semestre : "+infosEnseign.get(1)));
        panelHaut.add(new JLabel("Matière : "+infosEnseign.get(2)));
        panelHaut.add(new JLabel("Professeur : "+infosEnseign.get(3)));

        panelHaut.repaint();
        panelHaut.validate();

        //******** PANEL CENTRE **********

        int nbGroupes = listeGroupes.size();
        JPanel checkGroupes = new JPanel(new MigLayout());
        for(int i=0; i<nbGroupes; i++){
            JCheckBox box = new JCheckBox(listeGroupes.get(i));
            box.setName(listeGroupes.get(i));
            box.addChangeListener(this);
            checkBoxes.add(box);
            checkGroupes.add(box, "wrap 10");
        }

        JScrollPane scroll = new JScrollPane(checkGroupes, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scroll.setPreferredSize(new Dimension(200,290));
        panelCentre.add(scroll);
        panelCentre.repaint();
        panelCentre.validate();

        //********* PANEL BAS ************
        valider = new JButton("Valider");
        valider.setEnabled(false);
        annuler = new JButton("Annuler");
        valider.addActionListener(this);
        annuler.addActionListener(this);
        panelBas.add(annuler);
        panelBas.add(valider);


        repaint();
        validate();
    }

    public void actionPerformed(ActionEvent ev) {
        if(ev.getSource()==valider){
            for(JCheckBox cb : checkBoxes){
                if(cb.isSelected()){
                    try{
                        modele.ajouterGroupeEnseignement(cb.getName(), idEnseignement);
                    }
                    catch(SQLException ex){
                        System.err.println("ajoutGroupeEnseignement : "+ex.getMessage());
                    }
                }
            }
            if(nb_actuel < nb_max){
                dispose();
                new AjoutEnseignementSemestre(modele, parent, idSemestre, nb_max, nb_actuel+1);
            }
            else{
                dispose();
            }
        }
        else if(ev.getSource()==annuler){
            dispose();
            try {
                modele.deleteEnseignement(idEnseignement);
            }
            catch (SQLException ex1) {
                System.err.println("annuler dans AjoutGroupeEnseignement fonction deleteEnseignement -> "+ex1.getMessage());
            }
            new AjoutEnseignementSemestre(modele, parent, idSemestre, nb_max, nb_actuel);
        }

    }

    public void stateChanged(ChangeEvent ev) {
        boolean check = false;
        int i=0;
        int nbBox = checkBoxes.size();
        while (!check && i<nbBox){
            if(checkBoxes.get(i).isSelected())
                check = true;
            i++;
        }
        if(check)
            valider.setEnabled(true);
        else
            valider.setEnabled(false);
    }


}
