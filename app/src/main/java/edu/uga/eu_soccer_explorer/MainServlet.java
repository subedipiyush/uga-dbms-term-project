package edu.uga.eu_soccer_explorer;

import java.io.IOException;
import java.sql.SQLException;
import java.util.NoSuchElementException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;


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

    private PageParams pageParams = null;

    final String MAIN_PAGE = "index.jsp"; 

    @Override
    public void init() throws ServletException {
        super.init();

        pageParams = new PageParams();
        try {
            pageParams.fetch();
        } catch (ClassNotFoundException | NoSuchElementException | SQLException e) {
            e.printStackTrace();
            super.destroy();
        }
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

        // send params as request parameter
        request.setAttribute("params", pageParams);

        request.getRequestDispatcher(MAIN_PAGE).forward(request, response);
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

        DBResult results = null;
        try {
            switch(request.getServletPath()) {
                case "/matches":
                    results = SoccerDB.searchMatches(request.getParameterMap());
                    break;
                case "/players":
                    results = SoccerDB.searchPlayers(request.getParameterMap());
                    break;
                case "/teams":
                    results = SoccerDB.searchTeams(request.getParameterMap());
                    break;
                default:
                    // unsupported endpoint
            }

            // request.setAttribute("results", results);
            // request.setAttribute("success_msg", "Query execution successful");

        } catch (SQLException | ClassNotFoundException | NoSuchElementException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }


        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //marshalling the data in JSON format
        String json = new ObjectMapper().writeValueAsString(results);
        response.getWriter().write(json);

        // request.getRequestDispatcher(MAIN_PAGE).forward(request, response);
    }

}