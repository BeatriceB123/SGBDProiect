package controllers;

import database.Database;
import entities.Customer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import sample.Datas;


public class CustomerController {
    public String create(String firstName, String lastName, String city, String email, String phoneNumber, String dateOfBirth, String accountType, int accountValue){
        Connection con = Database.getConnection();
        String call = "{ ? = call new_customer(?,?,?,?,?,?,?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setString(2, firstName);
            statement.setString(3, lastName);
            statement.setString(4, city);
            statement.setString(5, email);
            statement.setString(6, phoneNumber);
            statement.setString(7, dateOfBirth);
            statement.setString(8, accountType);
            statement.setInt(9, accountValue);
            statement.execute();
            String output = statement.getString(1);
            System.out.println(output);
        } catch (SQLException e) {
            String[] result = e.getMessage().split("\\R", 2);
            return result[0];
        }
        return "created";
    }

    public String update(String id, String firstName, String lastName, String city, String email, String phoneNumber){
        Connection con = Database.getConnection();
        String call = "{ ? = call update_customer(?,?,?,?,?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setString(2, id);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, city);
            statement.setString(6, email);
            statement.setString(7, phoneNumber);
            statement.execute();
            String output = statement.getString(1);
            System.out.println(output);
        } catch (SQLException e) {
            String[] result = e.getMessage().split("\\R", 2);
            return result[0];
        }
        return "updated";
    }

    public void findById(int id) throws SQLException{
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from CUSTOMER where id_customer = " + id + "")) {
            rs.next();
            System.out.println("Customer Id: " + rs.getString(1) + ", first name: " + rs.getString(2) + ", last name: " +
                    rs.getString(3) + ", city: " + rs.getString(4) + ", email: " + rs.getString(5) +
                    ", phone number: " + rs.getString(6) + ", date of birth: " + rs.getString(7) + ". It has been created at: " + rs.getString(8) +
                    " and has last been updated at " + rs.getString(9) + ".");
        }
    }

    public Object getCustomerById(String id){

        try {
            Double.parseDouble(id);
        } catch(NumberFormatException e){
            return "SQL injection?";
        }

        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from CUSTOMER where id_customer = " + id )) {
             System.out.println("Executat." + id);
             rs.next();
             return new Customer(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(1),
                       rs.getString(5), rs.getString(6), LocalDate.parse(rs.getString(7), Datas.formatter));
        } catch (SQLException e) {
            //e.printStackTrace();
        }
        return "No data found";
    }

    public static ArrayList<String> getCustomersIds(){
        ArrayList <String> result = new ArrayList<>();
        Connection con = Database.getConnection();
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery( "SELECT id_customer from CUSTOMER" );
            while(rs.next())
            {
                String row = rs.getString(1);
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public ArrayList<String> getCustomersIdsFromPage(String fromPage, int numberOfIds){
        ArrayList <String> result = new ArrayList<>();
        Connection con = Database.getConnection();
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery( "SELECT id_customer from (select id_customer from customer order by id_customer) where (id_customer/20) + 1 >= " + fromPage + " and rownum <= " +numberOfIds);
            while(rs.next())
            {
                String row = rs.getString(1);
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<String> getCustomersWithIdForDemonstratingSQLInjection(String id) {
        List<String> result = new ArrayList<>();

        Connection con = Database.getConnection();
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from CUSTOMER where id_customer = " + id );
            //ResultSetMetaData rsmd = rs.getMetaData();
            //int numberOfColumns = rsmd.getColumnCount();
            StringBuilder row;

            while(rs.next())
            {
                row = new StringBuilder();
                for(int i=1; i<=9; i++)
                {
                    row.append(rs.getString(i)).append('\n');
                }
                result.add(row.append('\n').toString());
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            System.err.println(e);
        }

        BufferedWriter writer = null;
        try {
            writer = new BufferedWriter(new FileWriter("sqlResult.txt"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            writer.write(result.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            try {
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }



        return result;
    }
}
