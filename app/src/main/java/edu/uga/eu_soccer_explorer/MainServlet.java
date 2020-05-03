package edu.uga.eu_soccer_explorer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.NoSuchElementException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Entry point of the servlet Handles all server side requests
 * 
 * @author Piyush Subedi
 * @extended-by Andrew
 */
@WebServlet(name = "MainServlet", urlPatterns = { "/" }, loadOnStartup = 1)
public class MainServlet extends HttpServlet {

    /**
     * Serialization identifier
     */
    private static final long serialVersionUID = 1L;

    private DBEngine engine = null;

    @Override
    public void init() throws ServletException {
        super.init();

        engine = new DBEngine();
    }

    /**
     * Handles initial page load request Directs the user to index.jsp after setting
     * up the necessary bootstrap parameters
     * 
     * @author Andrew
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TODO:
        // provide the index page with all the initial data it might need
        // see src/main/webapp/index_page_mock_ui.html for reference
    	String query = "select * country";
		
        // add them as request parameter
    	try {
    		
    		DBResult temp = engine.executeQuery(query);
    		
    		List<String> r3 = temp.getCols();
    		List<List<Object>> r2 = temp.getRows();
    		
    		request.setAttribute("listCountries", r3);
    		
		
        } catch (SQLException | ClassNotFoundException | NoSuchElementException e) {
        	request.setAttribute("error", e.getMessage());
        }
    	String path = "index.jsp";
        request.getRequestDispatcher(path).forward(request, response);
    }

    /**
     * Method handles post request (search) from the server
     * 
     * @author Andrew
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TODO : Add code to get all filters from the page
        // construct your SQL query based on those filters

        String query = null;

        System.out.println("Running query : " + query);

        try {

            request.setAttribute("result", engine.executeQuery(query));
	        request.setAttribute("success_msg", "Query execution successful");
		
        } catch (SQLException | ClassNotFoundException | NoSuchElementException e) {
            
            request.setAttribute("error", e.getMessage());
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}