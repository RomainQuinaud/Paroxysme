import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;

/**
 * Created by Romain QUINAUD on 30/04/2015.
 */
public class GestionNotes extends JFrame {

        String login;

    public GestionNotes(String login){

        this.login=login;
        setTitle("Paroxysme");
        setSize(500, 500);
         setLayout(new BorderLayout());
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        JLabel toto=new JLabel(login);
        toto.setFont(new Font("Arial", Font.PLAIN, 20));
        toto.setBorder(new EmptyBorder(0,0,0,10));
        toto.setHorizontalAlignment(SwingConstants.RIGHT);
        this.add(toto,BorderLayout.NORTH);
        TabbedPaneDemo pane=new TabbedPaneDemo();
        this.add(pane,BorderLayout.CENTER);
        this.pack();

        this.setVisible(true);
        Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
        this.setLocation(dim.width / 2 - this.getWidth() / 2, dim.height / 2 - this.getHeight() / 2);

    }


}
