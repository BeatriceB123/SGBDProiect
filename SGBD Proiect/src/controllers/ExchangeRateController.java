package controllers;

import database.Database;

import java.sql.*;

public class ExchangeRateController {
    public void create(float gbpToEur, float gbpToRon, float gbpToRub, float eurToGbp, float eurToRon, float eurToRub,
                       float ronToGbp, float ronToEur, float ronToRub, float rubToGbp, float rubToEur, float rubToRon) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call add_exchange_rate(?,?,?,?,?,?,?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setFloat(2, gbpToEur);
        statement.setFloat(3, gbpToRon);
        statement.setFloat(4, gbpToRub);
        statement.setFloat(5, eurToGbp);
        statement.setFloat(6, eurToRon);
        statement.setFloat(7, eurToRub);
        statement.setFloat(8, ronToGbp);
        statement.setFloat(9, ronToEur);
        statement.setFloat(10, ronToRub);
        statement.setFloat(11, rubToGbp);
        statement.setFloat(12, rubToEur);
        statement.setFloat(13, rubToRon);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void findById(int id) throws SQLException{
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from EXCHANGE_RATE where id_rate = " + id + "")) {
            rs.next();
            System.out.println("Exchange rate Id: " + rs.getString(1) + ", currency type: " + rs.getString(2) + ", exchange rate to GBP: " +
                    rs.getString(3) + ", exchange rate to EUR: " + rs.getString(4) + ", exchange rate to RON: " + rs.getString(5) +
                    ", exchange rate to RUB: " + rs.getString(6) + ". It has been created at: " + rs.getString(7) +
                    " and has last been updated at " + rs.getString(8) + ".");
        }
    }
}
