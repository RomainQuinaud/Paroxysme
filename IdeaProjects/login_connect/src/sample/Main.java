package sample;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Group;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.sql.*;


public class Main extends Application {

    @Override
    public void start(final Stage primaryStage) throws Exception,SQLException {
        //Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        final Group root=new Group();
        primaryStage.setTitle("Paroxysme");
        final GridPane grid=new GridPane();
        grid.setAlignment(Pos.CENTER);
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(25,25,25,25));

        Text scenetitle=new Text("PAROXYSME®");
        scenetitle.setFont(Font.font("Tahoma", FontWeight.NORMAL,20));
        grid.add(scenetitle,0,0,2,1);

        Label userName=new Label("User Name:");
        grid.add(userName,0,2);

        final TextField userTextField=new TextField();
        grid.add(userTextField,1,2);

        Label pw=new Label("Password:");
        grid.add(pw,0,3);

        final PasswordField pwBox=new PasswordField();
        grid.add(pwBox,1,3);

        Button submit=new Button("Se connecter");
        HBox hbButton=new HBox(10);
        hbButton.setAlignment(Pos.BOTTOM_RIGHT);
        hbButton.getChildren().add(submit);
        grid.add(hbButton,1,4);

        final Text actiontarget = new Text();
        grid.add(actiontarget, 0, 5, 2, 5);












        submit.setOnAction(new EventHandler<ActionEvent>(){
            @Override
        public void handle(ActionEvent e){

                try{
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                }
                catch (ClassNotFoundException c){
                    actiontarget.setText("Erreur interne de pilote");

                }
                String log=userTextField.getText();
                String mdp=pwBox.getText();
                String url = "jdbc:oracle:thin:";

                url+=log+"/"+mdp+"@178.32.163.231:1521:xe";
                Connection conn = null;
                try{
                    conn = DriverManager.getConnection(url);
                    actiontarget.setText("Connexion successfull");
                }
                catch (SQLException s){
                    if(s.getErrorCode()==1017){
                        actiontarget.setText("Couple login / mot de passe incorrect.");
                    }
                    else {
                        actiontarget.setText("Erreur interne de connexion : " + s.getErrorCode());
                    }
                }

                actiontarget.setFill(Color.FIREBRICK);
            }

                           });



        Scene scene=new Scene(grid,400,375);
      //grid.setGridLinesVisible(true);
        primaryStage.setScene(scene);
        primaryStage.show();
    }


    public static void main(String[] args) {
        launch(args);
    }
}
