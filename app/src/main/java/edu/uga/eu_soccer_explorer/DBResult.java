package edu.uga.eu_soccer_explorer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Custom class that represents the database result
 * in a format that is easier to read by the client interface
 * @author Piyush Subedi
 */
public class DBResult {

    /**
     * size of the result from the query
     */
    private int size;

    /**
     * columns retrieved from the query
     */
    private List<String> cols;

    /**
     * tuples retrieved from the query
     */
    private List<List<Object>> rows;

    /**
     * {@link DBResult#size}
     */
    public int getSize() {
        return size;
    }

    /**
     * {@link DBResult#cols}
     */
    public List<String> getCols() {
        return cols;
    }

    /**
     * {@link DBResult#rows}
     */
    public List<List<Object>> getRows() {
        return rows;
    }

    public DBResult() {
        size = 0;
        cols = new ArrayList<>();
        rows = new ArrayList<>();
    }

    /**
     * Constructor
     * Unwraps the given java.sql.ResultSet result 
     * @param result
     * @throws SQLException
     * @author Piyush Subedi
     */
    public DBResult(ResultSet result) throws SQLException {

        // cols
        ResultSetMetaData resMd = result.getMetaData();

        cols = new ArrayList<>();
        for (int i = 1; i <= resMd.getColumnCount(); i++) {
            cols.add(resMd.getColumnLabel(i));
        }

        // rows
        rows = new ArrayList<>();

        List<Object> row = new ArrayList<>();
        while (result.next()) {

            row = new ArrayList<>();

            for (int i = 0 ; i < cols.size(); i++) {
                row.add(result.getObject(cols.get(i)));
            }

            rows.add(row);
        }

        // set size
        size = rows.size();
    }

}