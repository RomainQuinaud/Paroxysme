import javax.swing.*;
import java.awt.*;

/**
 * Created by Romain QUINAUD on 14/04/2015.
 */
public class Suite {

    JLabel test;
    JFrame fenetre;

    public Suite()
    {
        fenetre=new JFrame("suite");
        fenetre.setResizable(true);
        fenetre.getContentPane().setLayout(new FlowLayout());
        fenetre.setSize(600,400);






        test=new JLabel("suite");
        fenetre.add(test);

        fenetre.setVisible(true);

    }
}
