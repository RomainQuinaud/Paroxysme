package vue.professeur;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class JDialog_Message extends JDialog {


    /** ========================================== Constructors ========================================================= */

    JDialog_Message (JFrame parent, String message) {
        super(parent, "Oups", false);
        this.setSize(new Dimension(400, 200));
        this.setLayout(new BorderLayout());
        this.setResizable(false);
        this.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);


        JLabel mess = new JLabel(message);
        mess.setVerticalAlignment(SwingConstants.TOP);
        mess.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));
        this.getContentPane().add(mess, BorderLayout.CENTER);
        JButton annuler = new JButton("Fermer");
        annuler.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dispose();
            }
        });
        this.getContentPane().add(annuler, BorderLayout.PAGE_END);
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }








}
