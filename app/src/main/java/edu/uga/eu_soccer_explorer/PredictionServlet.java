package edu.uga.eu_soccer_explorer;

import java.io.IOException;
import java.sql.SQLException;
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
@WebServlet(name = "PredictionServlet", urlPatterns = { "/predictor" }, loadOnStartup = 1)
public class PredictionServlet extends HttpServlet {

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
        // see src/main/webapp/prediction_page_mock_ui.html for reference
        // add them as request parameter

        request.getRequestDispatcher("index.jsp").forward(request, response);
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

        // TODO : Get the two teams from the request parameter

        // use the query (to be provided by other members) as the query to predict
        // replace the team names accordingly
        String query = null;

        System.out.println("Running query : " + query);

        try {

            DBResult result = engine.executeQuery(query);

            // parse the result to determine who the winner was 1 or 2

            // pass the result to the page
            // request.setAttribute("result", "1 or 2");
		
        } catch (SQLException | ClassNotFoundException | NoSuchElementException e) {
            
            request.setAttribute("error", e.getMessage());
        }

        request.getRequestDispatcher("predictor.jsp").forward(request, response);
    }

}