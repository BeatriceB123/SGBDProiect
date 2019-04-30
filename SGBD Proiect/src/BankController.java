import java.sql.*;

public class BankController {
    public void create(String city, String address, String name) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call new_bank(?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setString(2, city);
        statement.setString(3, address);
        statement.setString(4, name);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void update(int id, String city, String address, String name) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call update_bank(?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, id);
        statement.setString(3, city);
        statement.setString(4, address);
        statement.setString(5, name);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void findById(int id) throws SQLException{
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from BANK where id_bank = " + id + "")) {
            rs.next();
            System.out.println("Bank Id: " + rs.getString(1) + ", city: " + rs.getString(2) + ", address: " +
                    rs.getString(3) + ", name: " + rs.getString(4) + ". It has been created at: " + rs.getString(5) +
                    " and has last been updated at " + rs.getString(6) + ".");
        }
    }
}
