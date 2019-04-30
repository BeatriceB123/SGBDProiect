import java.sql.*;

public class CustomerController {
    public void create(String firstName, String lastName, String city, String email, String phoneNumber, String dateOfBirth, String accountType, int accountValue) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call new_customer(?,?,?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
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
    }

    public void update(int id, String firstName, String lastName, String city, String email, String phoneNumber) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call update_customer(?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, id);
        statement.setString(3, firstName);
        statement.setString(4, lastName);
        statement.setString(5, city);
        statement.setString(6, email);
        statement.setString(7, phoneNumber);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
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
}
