import java.sql.*;

public class TransactionController {
    public void create(int idBank, int idStaff, int idAccFrom, int idAccTo, String currency, String transactionType, int value) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call add_transaction(?,?,?,?,?,?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, idBank);
        statement.setInt(3, idStaff);
        statement.setInt(4, idAccFrom);
        statement.setInt(5, idAccTo);
        statement.setString(6, currency);
        statement.setString(7, transactionType);
        statement.setInt(8, value);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void mostActiveDay(int monthNr, int yearNr) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call most_active_day(?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, monthNr);
        statement.setInt(3, yearNr);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void monthlyMoneySum(int monthNr, int yearNr) throws SQLException {
        Connection con = Database.getConnection();
        String call = "{ ? = call monthly_money_sum(?,?) }";
        CallableStatement statement = con.prepareCall(call);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, monthNr);
        statement.setInt(3, yearNr);
        statement.execute();
        String output = statement.getString(1);
        System.out.println(output);
    }

    public void findById(int id) throws SQLException{
        Connection con = Database.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("select * from TRANSACTION_HISTORY where id_transaction = " + id + "")) {
            rs.next();
            System.out.println("Transaction Id: " + rs.getString(1) + ", bank Id: " + rs.getString(2) + ", staff Id: " +
                    rs.getString(3) + ", account from Id: " + rs.getString(4) + ", account to Id " + rs.getString(5) +
                    ", rate Id: " + rs.getString(6) + ", transaction type: " + rs.getString(7) +
                    ", transaction date: " + rs.getString(8) + ", transaction hour: " + rs.getString(9) +
                    ", transaction value: " + rs.getString(10));
        }
    }
}
