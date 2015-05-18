package vue.admin;

import modele.Modele;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.sql.SQLException;

/**
 * @Author raphael on 17/05/15.
 */
public class DialogCreationEleve extends JDialog implements DocumentListener, FocusListener {


    private Modele modele;
    private int idGroupe;

    private JLabel labelNom;
    private JTextField textFieldNom;
    private JLabel labelPrenom;
    private JTextField textFieldPrenom;
    private JLabel labelLogin;
    private JTextField textFieldLogin;
    private JLabel labelMail;
    private JTextField textFieldMail;
    private JButton annuler;
    private JButton testLogin;
    private JButton valider;


    /** ========================================== Constructors ========================================================= */

    public DialogCreationEleve (JFrame parent, Modele modele, int idGroupe) {
        super(parent, "Créer et ajouter un élève", true);
        this.idGroupe = idGroupe;
        this.modele = modele;

        this.getContentPane().setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));


        initPrenom();
        initNom();
        initLogin();
        initMail();
        initBoutons();

        this.setResizable(false);
        this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE); // il faut supprimer les inserts
        this.setSize(new Dimension(400, 400));
        this.setLocationRelativeTo(null);
        this.setVisible(true);

    }



    private void initNom () {
        JPanel pannelNom = new JPanel(new FlowLayout());
        labelNom = new JLabel("Nom : ");
        labelNom.setPreferredSize(new Dimension(100, 30));

        textFieldNom = new JTextField("");
        textFieldNom.setPreferredSize(new Dimension(200,30));
        textFieldNom.getDocument().addDocumentListener(this);
        textFieldNom.addFocusListener(this);
        pannelNom.add(labelNom);
        pannelNom.add(textFieldNom);
        this.getContentPane().add(pannelNom);
    }

    private void initPrenom () {
        JPanel pannelPrenom = new JPanel(new FlowLayout());
        labelPrenom = new JLabel("Prénom : ");
        labelPrenom.setPreferredSize(new Dimension(100, 30));

        textFieldPrenom = new JTextField("");
        textFieldPrenom.setPreferredSize(new Dimension(200, 30));
        textFieldPrenom.getDocument().addDocumentListener(this);
        textFieldPrenom.addFocusListener(this);
        pannelPrenom.add(labelPrenom);
        pannelPrenom.add(textFieldPrenom);
        this.getContentPane().add(pannelPrenom);
    }


    private void initLogin () {
        JPanel pannelLogin = new JPanel(new FlowLayout());
        labelLogin = new JLabel("Login : ");
        labelLogin.setPreferredSize(new Dimension(100, 30));

        textFieldLogin = new JTextField("");
        textFieldLogin.setEnabled(false);
        textFieldLogin.setPreferredSize(new Dimension(200, 30));
        pannelLogin.add(labelLogin);
        pannelLogin.add(textFieldLogin);
        this.getContentPane().add(pannelLogin);
    }


    private void initMail () {
        JPanel pannelMail = new JPanel(new FlowLayout());
        labelMail = new JLabel("Mail : ");
        labelMail.setPreferredSize(new Dimension(100, 30));

        textFieldMail = new JTextField("");
        textFieldMail.setEnabled(false);
        textFieldMail.setPreferredSize(new Dimension(200, 30));
        textFieldMail.setFont(new Font("Calibri", Font.PLAIN, 10));
        pannelMail.add(labelMail);
        pannelMail.add(textFieldMail);
        this.getContentPane().add(pannelMail);
    }


    private void initBoutons () {
        valider = new JButton("Valider");
        valider.setEnabled(false);
        testLogin = new JButton("Tester login");
        testLogin.setEnabled(false);
        annuler = new JButton("Annuler");
        annuler.setEnabled(true);

        JPanel panelButon = new JPanel(new FlowLayout());
        panelButon.add(annuler);
        panelButon.add(testLogin);
        panelButon.add(valider);


        annuler.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
            }
        });

        valider.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    String nom = textFieldNom.getText();
                    String prenom = textFieldPrenom.getText();
                    String mail = textFieldMail.getText();
                    String login = textFieldLogin.getText();

                    int idEtu = modele.insererNouvelEleve(nom, prenom, mail, login);
                    modele.insertEtudiantDansGroupe(idGroupe, idEtu);
                }
                catch (SQLException e2) {
                    System.err.println("bouton valider insertion nouvel etudiant -> "+e2.getMessage());
                }
                dispose();
            }
        });

        testLogin.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                checkMailLogin();
                valider.setEnabled(true);
            }
        });
        this.getContentPane().add(panelButon);
    }


    @Override
    public void changedUpdate(DocumentEvent e) {
        if (textFieldPrenom.getText().equals("")) {
            textFieldLogin.setText(textFieldNom.getText().toLowerCase());
        }
        else {
            String login = textFieldPrenom.getText().charAt(0) + textFieldNom.getText();
            login = login.toLowerCase();
            textFieldLogin.setText(login);
        }


        String mail = textFieldPrenom.getText().toLowerCase() + "." + textFieldNom.getText().toLowerCase() + "@u-psud.fr";

        textFieldMail.setText(mail);
        updateTestLogin();
    }

    @Override
    public void insertUpdate(DocumentEvent e) {
        if (textFieldPrenom.getText().equals("")) {
            textFieldLogin.setText(textFieldNom.getText().toLowerCase());
        }
        else {
            String login = textFieldPrenom.getText().charAt(0) + textFieldNom.getText();
            login = login.toLowerCase();
            textFieldLogin.setText(login);
        }

        String mail = textFieldPrenom.getText().toLowerCase() + "." + textFieldNom.getText().toLowerCase() + "@u-psud.fr";
        textFieldMail.setText(mail);
        updateTestLogin();
    }

    @Override
    public void removeUpdate(DocumentEvent e) {
        if (textFieldPrenom.getText().equals("")) {
            textFieldLogin.setText(textFieldNom.getText().toLowerCase());
        }
        else {
            String login = textFieldPrenom.getText().charAt(0) + textFieldNom.getText();
            login = login.toLowerCase();
            textFieldLogin.setText(login);
        }

        String mail = textFieldPrenom.getText().toLowerCase() + "." + textFieldNom.getText().toLowerCase() + "@u-psud.fr";
        textFieldMail.setText(mail);
        updateTestLogin();
    }

    @Override
    public void focusGained(FocusEvent e) {
        if (e.getSource() == textFieldNom) {
            checkMailLogin();
        }
        if (e.getSource() == valider) {
            checkMailLogin();
        }
    }

    @Override
    public void focusLost(FocusEvent e) {
        if (e.getSource() == textFieldNom) {
            checkMailLogin();
        }
        if (e.getSource() == valider) {
            checkMailLogin();
        }
    }

    private void checkMailLogin () {
        int i = 1;
        while (!modele.checkLoginDispo(textFieldLogin.getText())) {
            textFieldLogin.setText(textFieldLogin.getText() + i);
            i++;
        }

        int j=1;
        while (!modele.checkLMailDispo(textFieldMail.getText())) {
            textFieldMail.setText(textFieldPrenom.getText().toLowerCase() + "." + textFieldNom.getText().toLowerCase()+ j + "@u-psud.fr");
            j++;
        }
    }

    private void updateTestLogin () {
        if (textFieldNom.getText().equals("") || textFieldPrenom.getText().equals(""))
            testLogin.setEnabled(false);
        else
            testLogin.setEnabled(true);

        valider.setEnabled(false);
    }
    public static void main(String[] args) {
        new DialogCreationEleve(null, new Modele(), 1);
    }
}
