import javax.swing.*;
import java.awt.*;

/**
 * Created by Romain QUINAUD on 05/05/2015.
 */
public class Enseignement extends JPanel{


    public Enseignement()
    {
        Object[][] donnees = {
                {"Johnathan", "Sykes", Color.red, true, ""},
                {"Nicolas", "Van de Kampf", Color.black, true, ""},
                {"Damien", "Cuthbert", Color.cyan, true, ""},
                {"Corinne", "Valance", Color.blue, false, ""},
                {"Emilie", "Schrödinger", Color.magenta, false, ""},
                {"Delphine", "Duke", Color.yellow, false, ""},
                {"Eric", "Trump", Color.pink, true, ""},
        };

        String[] entetes = {"Prénom", "Nom", "Couleur favorite", "Homme", "Sport"};

        JTable tableau = new JTable(donnees, entetes);
        tableau.setEnabled(false);

        this.add(tableau);
    }
}
