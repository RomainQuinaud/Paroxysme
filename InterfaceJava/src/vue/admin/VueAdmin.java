package vue.admin;


import modele.Modele;
import vue.professeur.VueProfesseur;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class VueAdmin extends JFrame {

    private int idAdmin;
    private Modele modele;

    /** ========================================== Constructors ========================================================= */


    public VueAdmin (final Modele modele, final int idAdmin) {
        super();

        this.modele = modele;
        this.idAdmin = idAdmin;

        try {
            this.setTitle("Bienvenue " + this.modele.getPrenomNomFromID(this.idAdmin));
        }
        catch (SQLException exp) {
            System.err.println("constructeur VueProfesseur fct° getPrenomNomFromID -> "+exp.getMessage());
        }


        this.setSize(new Dimension(600, 300));
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setLayout(new BorderLayout());


        JLabel textIntro = new JLabel();
        String s = "<html>";
        s += "<h2>Bienvenue sur l'interface Administrateur</h2>";
        s += "<p>Vous pouvez ici créer des formations ou des groupes.</p>";
        s += "<p>En créant une formation, vous pourrez en déterminer le nombre de semestres ainsi que les enseignements pour ces semestres et les groupes inscrits à ces enseignements.</p>";
        s += "<p>En créant un groupe, vous serez invités à lui donner un nom et à y insérer de nouveaux élèves ou des élèves existants.</p>";
        textIntro.setText(s);


        JPanel panelBoutons = new JPanel(new FlowLayout());

        JButton creerFormation = new JButton("Créer une formation");
        creerFormation.setFont(new Font("Gabriola", Font.PLAIN, 25));
        creerFormation.setHorizontalTextPosition(SwingConstants.CENTER);
        creerFormation.setVerticalTextPosition(SwingConstants.BOTTOM);
        creerFormation.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new AjoutFormation(getJFrame(), getModele());
            }
        });
        panelBoutons.add(creerFormation);



        JButton creerGroupe = new JButton("Créer un groupe");
        creerGroupe.setFont(new Font("Gabriola", Font.PLAIN, 25));
        creerGroupe.setHorizontalTextPosition(SwingConstants.CENTER);
        creerGroupe.setVerticalTextPosition(SwingConstants.CENTER);
        creerGroupe.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new DialogAjoutGroupe(getJFrame(), getModele());
            }
        });
        panelBoutons.add(creerGroupe);

        this.getContentPane().add(textIntro, BorderLayout.PAGE_START);
        this.getContentPane().add(panelBoutons, BorderLayout.CENTER);

        JButton interfaceProf = new JButton("Aller à l'interface enseignant");
        interfaceProf.setFont(new Font("Gabriola", Font.PLAIN, 20));
        interfaceProf.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
                new VueProfesseur(getModele(), getIDAdmin());
            }
        });
        this.getContentPane().add(interfaceProf, BorderLayout.PAGE_END);

        this.getRootPane().setBorder(BorderFactory.createEmptyBorder(25,25,25,25));
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }

    private int getIDAdmin () {
        return idAdmin;
    }

    private Modele getModele () {
        return modele;
    }
    private JFrame getJFrame () {
        return this;
    }

    public static void main(String[] args) {
        new VueAdmin(new Modele(), 2);
    }


}
