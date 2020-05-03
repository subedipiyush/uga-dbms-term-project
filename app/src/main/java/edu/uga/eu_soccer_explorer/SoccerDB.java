package edu.uga.eu_soccer_explorer;

import java.sql.SQLException;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * Interface between DB and Servlet to query EU Soccer DB
 * 
 * @author Piyush Subedi
 */
public class SoccerDB {

    public static DBResult searchMatches(Map<String, String[]> parameters) {

        return null;
    }

    public static DBResult searchPlayers(Map<String, String[]> parameters)
            throws ClassNotFoundException, NoSuchElementException, SQLException {

        if (parameters.containsKey("player_name")) {
            String queryToExecute = Queries.PLAYERS_BY_NAME.replace("{0}", parameters.get("player_name")[0]);

            return DBEngine.getInstance().executeQuery(queryToExecute);
        }

        return null;
    }

    public static DBResult searchTeams(Map<String, String[]> parameters)
            throws ClassNotFoundException, NoSuchElementException, SQLException {

        if (parameters.containsKey("team_name")) {
            String queryToExecute = Queries.TEAMS_BY_NAME.replace("{0}", parameters.get("team_name")[0]);

            return DBEngine.getInstance().executeQuery(queryToExecute);
        }

        return null;
    }

    public static DBResult makePrediction(Map<String, String[]> parameters)
            throws ClassNotFoundException, NoSuchElementException, SQLException {

        if (parameters.containsKey("team1_name") && parameters.containsKey("team2_name")) {
            String queryToExecute = Queries.PREDICTION_QUERY.replace("{0}", parameters.get("team1_name")[0]).replace("{1}", parameters.get("team2_name")[0]);

            return DBEngine.getInstance().executeQuery(queryToExecute);
        }

        return null;

    }

} 