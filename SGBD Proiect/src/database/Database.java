package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "Asuna";
    private static final String PASSWORD = "ASUNA";
    private static Connection connection = null;

    public Database() {
    }

    /**
     * This method connects the application to the database if it does not already exist
     * @return the connection as an object.
     */
    public static Connection getConnection() {
        if (connection == null) {
            createConnection();
        }
        return connection;
    }

    /**
     * The creation of the connection. It loads the driver class and then connects to the database using
     * the URL, username and password. setAutoCommit(false) ensures that no changes are committed without
     * using the commit() method.
     */
    public static void createConnection() {
        try {
            //loading the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");
            //creating the connection object
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            connection.setAutoCommit(false);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     * Closes the connection.
     */
    public static void closeConnection() {
        try {
            connection.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * Commits all changes made prior to the call.
     */
    public static void commit() {
        try {
            connection.commit();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * Rolls back all changes.
     */
    public static void rollback() {
        try {
            connection.rollback();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}