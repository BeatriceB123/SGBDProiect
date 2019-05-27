package controllers;

import database.Database;

import java.sql.*;

public class AccountController {
    public void create(int idCustomer, String accountType, int value){
        Connection con = Database.getConnection();
        String call = "{ ? = call new_account(?,?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setInt(2, idCustomer);
            statement.setString(3, accountType);
            statement.setInt(4, value);
            statement.execute();
            String output = statement.getString(1);
            System.out.println(output);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(String idAccount, String accountType, int value) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call update_account(?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setString(2, idAccount);
        statement.setString(3, accountType);
        statement.setInt(4, value);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void freeze(int idAccount) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call account_freeze(?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idAccount);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public String check(int idAccount){
        Connection con = Database.getConnection();
        String call = "{ call account_check(?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.setInt(1, idAccount);
            statement.registerOutParameter(2, Types.VARCHAR);
            statement.execute();
            return (statement.getString(2));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "no data for this id";
    }

    public void findById(int id) throws SQLException{
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from BANK_ACCOUNT where id_account = " + id + "")) {
            rs.next();
            System.out.println("Account Id: " + rs.getString(1) + ", customer Id: " + rs.getString(2) + ", account type: " +
                    rs.getString(3) + ", account value: " + rs.getString(4) + ". It has been created at: " + rs.getString(5) +
                    " and has last been updated at " + rs.getString(6) + ".");
        }
    }

    public String generateStatement(int idAccount){
        Connection con = Database.getConnection();
        String call = "{ ? = call generate_statement(?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setInt(2, idAccount);
            statement.execute();
            return statement.getString(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "no data for this id";
    }
}
