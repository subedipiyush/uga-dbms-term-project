package edu.uga.eu_soccer_explorer;

import java.sql.*;
import java.util.NoSuchElementException;


/**
 * Class handles all database related operations for the server
 * Note: This is a singleton class
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

    // since this is a singleton class, we will re-use this instance
    private static DBEngine instance;

    /**
     * Constructor/ Not exposed(Private)
     */
    private DBEngine() {
        con = null;
        credMgr = new DBCredentialsManager();
    }

    /**
     * Creates a new instance if no instance of this class exists
     */
    public static DBEngine getInstance() {
        if (instance == null) {
            instance = new DBEngine();
        }

        return instance;
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
            Class.forName(JDBC_DRIVER);
            con = DriverManager.getConnection(credMgr.getUrl(), credMgr.getUsername(), credMgr.getPassword());
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

    	Connection conn = getConnection();
        Statement st = conn.createStatement();
        
        System.out.println("Query request " + query);

        // execute the query, and get a java resultset
        ResultSet rs = st.executeQuery(query);
        
        return new DBResult(rs);
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


