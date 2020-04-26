package edu.uga.eu_soccer_explorer;

import java.sql.*;
import java.util.NoSuchElementException;


/**
 * Class handles all database related operations for the server
 * 
 * @author Piyush
 * @extended-by Farah
 */
public class DBEngine {

    // JDBC driver name
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";

    // SQL Connection
    private Connection con;

    // db credentials manager instance
    private DBCredentialsManager credMgr;

    /**
     * Constructor
     */
    public DBEngine() {
        con = null;
        credMgr = new DBCredentialsManager();
    }

    /**
     * Returns the established connection instance if the connection has not been
     * established yet, it tries to establish one
     * 
     * @return java.sql.Connection instance
     * @author Piyush Subedi
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws NoSuchElementException
     */
    private Connection getConnection() throws ClassNotFoundException, SQLException {

        if (null == con) {

            // TODO:
            // load the JDBC driver (use Class.forName)
            // then call DriverManager.getConnection to set the 'con'
            // use 'credMgr' to retrieve the url, username and password

        }

        return con;
    }


    /**
     * Executes the given query
     * 
     * @param query
     * @author Piyush Subedi
     * @throws NoSuchElementException
     * @throws ClassNotFoundException
     */
    public DBResult executeQuery(String query) throws SQLException, ClassNotFoundException, NoSuchElementException {

        // TODO:
        // use getConnection() to create statement and hence execute the query
        // note that the return type is expected to be DBResult

        return null;
    }


    /**
     * Release all the resources
     */
    @Override
    protected void finalize() throws Throwable {
        if (null != con) {
            con.close();
        }
    }
}


