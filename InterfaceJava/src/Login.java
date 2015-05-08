
import net.miginfocom.swing.MigLayout;

import javax.swing.*;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by Romain QUINAUD on 14/04/2015.
 */
public class Login extends JFrame{

    static Connection conn;
    private JPanel form;
    private JLabel login;
    private JTextField in_login;
    private JLabel mdp;
    private JPasswordField in_mdp;
    private JButton connect;
    private JLabel title;
    private JPanel panel;
    private JLabel ERR_MSG;

    public Login()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setTitle("Paroxysme");
        setLayout(new FlowLayout());

        this.initComponents();
        this.setVisible(true);
        this.pack();
        Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
        this.setLocation(dim.width/2 - this.getWidth()/2, dim.height/2 - this.getHeight()/2);
    }




    private void initComponents()
    {
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

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                } catch (ClassNotFoundException c) {
                    ERR_MSG.setText("Erreur interne de pilote");

                }
                String log = in_login.getText();
                String mdp = in_mdp.getText();
                String url = "jdbc:oracle:thin:";

                url += log + "/" + mdp + "@178.32.163.231:1521:xe";
                conn = null;
                try {
                    conn = DriverManager.getConnection(url);

                    dispose();
                    new GestionNotes(log);

                } catch (SQLException s) {
                    if (s.getErrorCode() == 1017) {
                        ERR_MSG.setText("Couple login / mot de passe incorrect.");

                    } else {
                        ERR_MSG.setText("Erreur interne de connexion : " + s.getErrorCode());

                    }
                }

                ERR_MSG.setForeground(new Color(178, 34, 34));
                ERR_MSG.setVisible(true);


            }
        });

        panel.add(form, BorderLayout.CENTER);
        this.add(panel);


    }


    public static void main(String[] args) {

        new Login();

    }

}

