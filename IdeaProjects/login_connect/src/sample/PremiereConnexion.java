package sample;

import java.sql.*;

/**
 * Created by Romain QUINAUD on 21/03/2015.
 */
public class PremiereConnexion {
    public static void main(String[] args)
            throws SQLException{
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }
        catch (ClassNotFoundException e){
            System.out.println("Erreur pilote");
            System.exit(1);
        }
        String url = "jdbc:oracle:thin:";
        url+="rquinau/Romain7@oracle.iut-orsay.fr:1521:etudom";
        Connection conn = null;
        try{
            conn = DriverManager.getConnection(url);
        }
        catch (SQLException e){
            System.out.println("err connection à l’url : "+url);
            System.exit(1);
        }

        Statement stm = conn.createStatement();
        String req = "select * from tablebonus";
        ResultSet res = stm.executeQuery(req);
        while(res.next()){
            String login=res.getString(1);
            double bonus=res.getDouble(2);
            System.out.print(login + "\t" + bonus + "\n");
        }
        res.close();

        String req2 = "select * from tablebonus";
        req2 += " where bonus=?";
        PreparedStatement stm2=conn.prepareStatement(req2);
        stm2.setDouble(1,0.1);
        ResultSet monRes = stm2.executeQuery();
        while(monRes.next()){
            String login=monRes.getString(1);
            double bonus=monRes.getDouble(2);
            System.out.print(login + "\t" + bonus + "\n");
        }
        monRes.close();
        stm.close();
        conn.close();


    }

}

