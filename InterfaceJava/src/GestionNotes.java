import javax.swing.*;
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
         setLayout(new FlowLayout());
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        TabbedPaneDemo pane=new TabbedPaneDemo();
        this.add(pane);
        this.pack();

        this.setVisible(true);
        Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
        this.setLocation(dim.width / 2 - this.getWidth() / 2, dim.height / 2 - this.getHeight() / 2);

    }


}
