package nazmul;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

 /**
  * JDBC connection helper used by DAO classes.
  *
  * <p>This application uses direct JDBC (no ORM). All SQL access goes through
  * {@code UserDAO} and {@code CourseDAO}, which obtain connections using this
  * utility.
  *
  * <p><strong>Note:</strong> credentials are currently hardcoded for local
  * development/demo purposes.
  */
public class DatabaseUtil {
     /** JDBC URL for the MySQL schema used by the application. */
    private static final String URL = "jdbc:mysql://localhost:3306/Academia";

     /** Database username. */
    private static final String USER = "root";

     /** Database password (change this to your local MySQL password). */
    private static final String PASSWORD = "R@tul235"; // Change to your MySQL password
    
     /**
      * Creates and returns a new JDBC {@link Connection}.
      *
      * @return a live JDBC connection to the configured MySQL database
      * @throws SQLException if the JDBC driver is missing or the connection fails
      */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }
}
