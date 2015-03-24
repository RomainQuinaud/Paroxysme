/*package melordi;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Melordi extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        primaryStage.setTitle("Hello World");
        primaryStage.setScene(new Scene(root, 300, 275));
        primaryStage.show();
    }


    public static void main(String[] args) {
        launch(args);
    }
}*/


package melordi;
        import javafx.application.Application;
        import javafx.scene.Group;
        import javafx.scene.Scene;
        import javafx.scene.paint.Color;
        import javafx.stage.Stage;
public class Melordi extends Application {
    public static void main(String[] args) {
        Application.launch(Melordi.class, args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Melordi");
        Group root = new Group();
        Scene scene = new Scene(root, 500, 500, Color.WHITE);
        Instru mon_instru=new Instru();
        Clavier mon_clavier = new Clavier(mon_instru);//on créé un objet clavier
        root.getChildren().add(mon_clavier);//on l'ajoute à notre groupe root
        primaryStage.setScene(scene);
        primaryStage.show();
        mon_clavier.requestFocus();
    }
}