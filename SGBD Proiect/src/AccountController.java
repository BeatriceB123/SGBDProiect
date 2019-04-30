import java.sql.*;

public class AccountController {
    public void create(int idCustomer, String accountType, int value) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call new_account(?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idCustomer);
        statement.setString(3, accountType);
        statement.setInt(4, value);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void update(int idAccount, String accountType, int value) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call update_account(?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idAccount);
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

    public void check(int idAccount) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call account_check(?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idAccount);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
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
}
