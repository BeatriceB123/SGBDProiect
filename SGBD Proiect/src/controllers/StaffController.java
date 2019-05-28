package controllers;

import database.Database;

import java.sql.*;

public class StaffController {
    public void create(int idBank, String firstName, String lastName, String city, String email, String phoneNumber, String dateOfBirth, String jobPosition, int salary) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call new_staff(?,?,?,?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idBank);
        statement.setString(3, firstName);
        statement.setString(4, lastName);
        statement.setString(5, city);
        statement.setString(6, email);
        statement.setString(7, phoneNumber);
        statement.setString(8, dateOfBirth);
        statement.setString(9, jobPosition);
        statement.setInt(10, salary);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void update(int idStaff, int idBank, String firstName, String lastName, String city, String email, String phoneNumber, String jobPosition) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call update_staff(?,?,?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idStaff);
        statement.setInt(3, idBank);
        statement.setString(4, firstName);
        statement.setString(5, lastName);
        statement.setString(6, city);
        statement.setString(7, email);
        statement.setString(8, phoneNumber);
        statement.setString(9, jobPosition);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public String salaryIncrease(int id, int raiseValue){
        Connection con = Database.getConnection();
        String call = "{ ? = call salary_increase(?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setInt(2, id);
            statement.setInt(3, raiseValue);
            statement.execute();
            return statement.getString(1);
        } catch (SQLException e) {
            return e.getMessage();
        }
    }

    public String employeeOfTheMonth(int monthNr, int yearNr, int raiseValue){
        Connection con = Database.getConnection();
        String call = "{ ? = call employee_of_the_month(?,?,?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setInt(2, monthNr);
            statement.setInt(3, yearNr);
            statement.setInt(4, raiseValue);
            statement.execute();
            return statement.getString(1);

        } catch (SQLException e) {
            return e.getMessage();
        }
    }

    public String findById(int id){
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from STAFF where id_staff = " + id + "")) {
            rs.next();
            return ("Staff Id: " + rs.getString(1) + " bank Id: " + rs.getString(2) + ", first name: " + rs.getString(3) + ", last name: " +
                    rs.getString(4) + "\nCity: " + rs.getString(5) + ", email: " + rs.getString(6) +
                    ", phone number: " + rs.getString(7) + "\nDate of birth: " + rs.getString(8)  + "\nJob position: " + rs.getString(9) +
                    " salary: " + rs.getString(10) + "\nIt has been created at: " + rs.getString(11) +
                    " and has last been updated at " + rs.getString(12) + ".");
        } catch (SQLException e) {
            //return e.getMessage();
            return "no data";
        }
    }

    public String getStaffTotalAmountInTime(int id){
        Connection con = Database.getConnection();
        String call = "{ ? = call get_staff_total_amount(?) }";
        CallableStatement statement = null;
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.setInt(2, id);
            statement.execute();
            return statement.getString(1);
        } catch (SQLException e) {
            return e.getMessage();
        }
    }
}
