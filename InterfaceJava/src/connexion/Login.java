package connexion;


import modele.Modele;
import net.miginfocom.swing.MigLayout;
import vue.eleve.VueEleve;
import vue.professeur.VueProfesseur;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;


public class Login extends JFrame {


    private Modele modele;
    private JPanel form;
    private JLabel login;
    private JTextField in_login;
    private JLabel mdp;
    private JPasswordField in_mdp;
    private JButton connect;
    private JLabel title;
    private JPanel panel;
    private JLabel ERR_MSG;

    public Login() {
        this.modele = new Modele();
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setTitle("Paroxysme");
        setLayout(new FlowLayout());


        this.initComponents();

        this.pack();
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }




    private void initComponents() {
        panel=new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 50, 50, 50));

        panel.add(title = new JLabel("Bienvenue sur Paroxysme"), BorderLayout.NORTH);
        title.setFont(new Font("Gabriola", Font.PLAIN, 40));

        form = new JPanel(new MigLayout("fill","right"));

        form.add(login = new JLabel("Login: "), "cell 0 0");
        login.setFont(new Font("Cambria", Font.PLAIN, 15));

        form.add(in_login = new JTextField(15), "span 2");

        form.add(mdp = new JLabel("Mot de Passe: "), "cell 0 1");
        mdp.setFont(new Font("Cambria", Font.PLAIN, 15));
        form.add(in_mdp = new JPasswordField(15), "span 2");

        panel.add(ERR_MSG = new JLabel(),BorderLayout.SOUTH);
        ERR_MSG.setHorizontalAlignment(SwingConstants.RIGHT);
        ERR_MSG.setVisible(false);

        form.add(connect = new JButton("Se connecter"), "cell 2 3");

        connect.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String login = in_login.getText();
                String mdp = String.copyValueOf(in_mdp.getPassword());

                try {
                    if (login.equals("") || mdp.equals("")) {
                        ERR_MSG.setText("Un ou plusieurs champs manquants");
                        ERR_MSG.setForeground(new Color(178, 34, 34));
                        ERR_MSG.setVisible(true);
                    }
                    else if (modele.checkConnectLogin(login, mdp) == 0) {
                        ERR_MSG.setText("Mot de passe ou login incorrect");
                        ERR_MSG.setForeground(new Color(178, 34, 34));
                        ERR_MSG.setVisible(true);
                    }
                    else {
                        int user = modele.checkConnectLogin(login, mdp);
                        if (user == 1) { // prof tout court
                            lancerProf(modele, modele.getIDLogin(login));
                        }
                        else if (user == 3) { // admin et prof
                            dispose();
                            new ChoixAdminProf(getJFrame(), modele, modele.getIDLogin(login));
                        }
                        else { // émève
                            lancerEleve(modele, modele.getIDLogin(login));
                        }

                    }
                }
                catch (SQLException exp) {
                    System.err.println("action listener pour bouton login -> " + exp.getMessage());
                }
            }
        });

        panel.add(form, BorderLayout.CENTER);
        this.add(panel);


    }


    private void lancerEleve (Modele modele, int idUser) {
        this.dispose();
        new VueEleve(modele, idUser);
    }

    private void lancerProf (Modele modele, int idUser) {
        this.dispose();
        new VueProfesseur(modele, idUser);
    }


    private JFrame getJFrame () {
        return this;
    }

    public static void main(String[] args) {
    /* SET THE STYLE OF THE APPLICATION */
        try {
            for(UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                if("Nimbus".equals(info.getName())) {
                    UIManager.setLookAndFeel(info.getClassName());
                    UIManager.getLookAndFeelDefaults().put("nimbusOrange", (new Color(42, 204, 50)));
                    UIManager.getLookAndFeelDefaults().put("List[Selected].textBackground", new Color(57, 105, 138));
                    UIManager.getLookAndFeelDefaults().put("List[Selected].textForeground", Color.WHITE);
                    break;
                }
            }
        }
        catch(Exception e) {
            System.err.println("Unable to set the selected Look'n'Feel :\n" + e.getMessage());
        }

        new Login();

    }

}


/** ========================================== Constructors ========================================================= */


/** ==========================================   Getters    ========================================================= */


/** ==========================================   Setters    ========================================================= */


/** ==========================================  Implements  ========================================================= */


/** =======================================  Fonctions Utiles  ========================================================= */



