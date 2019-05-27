package controllers;

import database.Database;
import entities.ExchangeRate;

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
                    ", exchange rate to RUB: " + rs.getString(6) + ". " +
                    "It has been created at: " + rs.getString(7) +
                    " and has last been updated at " + rs.getString(8) + ".");
        }
    }

    public void createReal(){
        Connection con = Database.getConnection();
        String call = "{ ? = call add_real_exchange_rate }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.execute();
            String output = statement.getString(1);
            System.out.println(output);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ExchangeRate getLastExchangeRate(){
        int id = getLastId();
        ExchangeRate exchangeRate = new ExchangeRate();
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
              ResultSet rs1 = stmt.executeQuery(("select * from EXCHANGE_RATE where id_rate = " + (id - 3)))) {
            rs1.next();
            exchangeRate.setGbpToEur((float) Double.parseDouble(rs1.getString(4)));
            exchangeRate.setGbpToRon((float) Double.parseDouble(rs1.getString(5)));
            exchangeRate.setGbpToRub((float) Double.parseDouble(rs1.getString(6)));
            try (
                 ResultSet rs2 = stmt.executeQuery(("select * from EXCHANGE_RATE where id_rate = " + (id - 2)))) {
                rs2.next();
                exchangeRate.setEurToGbp((float) Double.parseDouble(rs2.getString(3)));
                exchangeRate.setEurToRon((float) Double.parseDouble(rs2.getString(5)));
                exchangeRate.setEurToRub((float) Double.parseDouble(rs2.getString(6)));
                try (
                        ResultSet rs3 = stmt.executeQuery(("select * from EXCHANGE_RATE where id_rate = " + (id - 1)))) {
                    rs3.next();
                    exchangeRate.setRonToGbp((float) Double.parseDouble(rs3.getString(3)));
                    exchangeRate.setRonToEur((float) Double.parseDouble(rs3.getString(4)));
                    exchangeRate.setRonToRub((float) Double.parseDouble(rs3.getString(6)));
                    try (
                            ResultSet rs4 = stmt.executeQuery(("select * from EXCHANGE_RATE where id_rate = " + id ))) {
                        rs4.next();
                        exchangeRate.setRubToGbp((float) Double.parseDouble(rs4.getString(3)));
                        exchangeRate.setRubToEur((float) Double.parseDouble(rs4.getString(4)));
                        exchangeRate.setRubToRon((float) Double.parseDouble(rs4.getString(5)));
                    }
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return exchangeRate;
    }

    public int getLastId()
    {
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select count(*) from EXCHANGE_RATE ")) {
             rs.next();
            return  Integer.parseInt(rs.getString(1));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
