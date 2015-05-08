import net.miginfocom.swing.MigLayout;

import javax.swing.*;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Date;

/**
 * Created by Jeanne on 05/05/2015.
 */
public class AjoutControle extends JPanel implements ActionListener{
    private int enseignement;
    private int groupe;
    private Font police;
    private JTextField libelle_interro;
    private JTextField date_interro;
    private JTextField coefficient;
    private JRadioButton cc;
    private JRadioButton ds;
    private JButton valider;
    private JLabel ERR_MSG;

    public AjoutControle(int enseignement, int groupe){
        this.enseignement = enseignement;
        this.groupe = groupe;
        setLayout(new MigLayout("insets n 30 n 30", "[]20[]", "[]10[]"));
        police = new Font("Cambria", Font.PLAIN, 15);

        JLabel intro = new JLabel("Veuillez saisir les informations concernant le contrôle :");
        intro.setFont(new Font("Cambria", Font.PLAIN, 20));
        add(intro, "dock north, gap 30 30 30 30");

        JLabel typeCtrl = new JLabel("Type de contrôle");
        typeCtrl.setFont(police);
        add(typeCtrl,"align right");

        ButtonGroup btnGroup = new ButtonGroup();
        cc = new JRadioButton("contrôle continu");
        cc.setFont(police);
        //cc.addActionListener(this);
        ds = new JRadioButton("examen final");
        ds.setFont(police);
        //ds.addActionListener(this);
        btnGroup.add(cc);
        btnGroup.add(ds);
        add(cc, "split 2");
        add(ds, "wrap");

        JLabel intitule = new JLabel("Intitulé du contrôle");
        intitule.setFont(police);
        add(intitule, "align right");
        libelle_interro = new JTextField(20);
        add(libelle_interro, "wrap");

        JLabel date = new JLabel("Date du contrôle (yyyy-mm-dd)");
        date.setFont(police);
        add(date, "align right");
        date_interro = new JTextField(20);
        add(date_interro, "wrap");

        JLabel coef = new JLabel("Coefficient (ex: 0.5)");
        coef.setFont(police);
        add(coef, "align right");
        coefficient = new JTextField(20);
        add(coefficient, "wrap 20px");

        valider = new JButton("Valider");
        valider.addActionListener(this);
        add(valider, "cell 1 4, wrap 20px");

        ERR_MSG = new JLabel();
        ERR_MSG.setVisible(false);
        add(ERR_MSG);
    }

    //Vérifie si les données sont correctes
    private boolean check(){
        if(!cc.isSelected() && !ds.isSelected())
            return false;
        if(libelle_interro.getText().equals("") || date_interro.getText().equals("") || coefficient.getText().equals(""))
            return false;
        else
            try{
                float coef = Float.valueOf(coefficient.getText());
                if(coef<0) return false;
                Date.valueOf(date_interro.getText());
                return true;
            }
            catch(Exception e){
                return false;
            }
    }

    public void actionPerformed(ActionEvent e) {
        if(e.getSource() == valider){
            if(check()){
                ERR_MSG.setText("Correct.");
                ERR_MSG.setForeground(new Color(23, 178, 48));
                ERR_MSG.setVisible(true);
            }
            else{
                ERR_MSG.setText("Erreur.");
                ERR_MSG.setForeground(new Color(178, 34, 34));
                ERR_MSG.setVisible(true);
            }
        }
    }

}