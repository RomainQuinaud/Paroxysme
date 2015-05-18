package connexion;

import modele.Modele;
import vue.admin.VueAdmin;
import vue.professeur.VueProfesseur;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class ChoixAdminProf extends JDialog {

    private int idUser;
    private Modele modele;

    /** ========================================== Constructors ========================================================= */

    ChoixAdminProf (JFrame parent, Modele modele, int idUser) {
        super(parent, "Choix d'interface", false);
        this.modele = modele;
        this.idUser = idUser;
        this.setSize(new Dimension(400, 200));
        this.setLayout(new BorderLayout());
        this.setResizable(false);
        this.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);


        JLabel mess = new JLabel("<html><p>Bonjour, veuillez choisir une interface</p></html>");
        mess.setVerticalAlignment(SwingConstants.TOP);
        mess.setBorder(BorderFactory.createEmptyBorder(5,5,30,5));
        mess.setFont(new Font("Gabriola", Font.PLAIN, 25));
        this.getContentPane().add(mess, BorderLayout.PAGE_START);


        JPanel panelButton = new JPanel(new FlowLayout());

        JButton enseignant = new JButton("Enseignant");
        enseignant.setFont(new Font("Gabriola", Font.PLAIN, 25));
        enseignant.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                lancerProf();
            }
        });
        panelButton.add(enseignant);


        JButton administrateur = new JButton("Administrateur");
        administrateur.setFont(new Font("Gabriola", Font.PLAIN, 25));
        administrateur.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                lancerAdmin();
            }
        });
        panelButton.add(administrateur);

        this.getContentPane().add(panelButton, BorderLayout.CENTER);

        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }




    public void lancerProf () {
        this.dispose();
        new VueProfesseur(modele, idUser);
    }

    public void lancerAdmin () {
        this.dispose();
        new VueAdmin(modele, idUser);
    }

}
