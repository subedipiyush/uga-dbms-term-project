package edu.uga.eu_soccer_explorer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.NoSuchElementException;

/**
 * Interface between DB and Servlet to query EU Soccer DB
 * 
 * @author Piyush Subedi
 */
public class SoccerDB {

    public static DBResult searchMatches(Map<String, String[]> parameters)
            throws ClassNotFoundException, NoSuchElementException, SQLException {

        // base query
        String query = "SELECT (SELECT name FROM country WHERE id = eu_soccer.Match.country_id) as country, (SELECT name FROM league WHERE id = eu_soccer.Match.league_id) as league, (SELECT team_long_name FROM Team WHERE team_api_id = eu_soccer.Match.home_team_api_id) as home_team, (SELECT team_long_name FROM Team WHERE team_api_id = eu_soccer.Match.away_team_api_id) as away_team, date {dynamic-field-list} FROM eu_soccer.Match WHERE 1=1";

        // construct dynamic field list
        List<String> selectFields = new ArrayList<>();
        addAsSelectField(selectFields, "home_team_goal", parameters.get("goals"));
        addAsSelectField(selectFields, "away_team_goal", parameters.get("goals"));
        addAsSelectField(selectFields, "possession", parameters.get("possession"));
        addAsSelectField(selectFields, "shoton as shots_on_target", parameters.get("shots_on_target"));
        addAsSelectField(selectFields, "shotoff as shots_off_target", parameters.get("shots_off_target"));
        addAsSelectField(selectFields, "corner", parameters.get("corner"));
        addAsSelectField(selectFields, "foulcommit as fouls_committed", parameters.get("fouls_committed"));

        if (selectFields.size() > 0) {
            query = query.replace("{dynamic-field-list}", "," + String.join(",", selectFields));
        } else {
            query = query.replace("{dynamic-field-list}", "");
        }

        // apply filters
        query = applyFilter(query, "country_id", parameters.get("country"), "{0} = '{1}' ");
        query = applyFilter(query, "league_id", parameters.get("league"), "{0} = '{1}' ");

        query = applyFilter(query, "home_team_api_id", parameters.get("team1"), "({0} IN (SELECT team_api_id FROM Team WHERE Id = '{1}' ) OR away_team_api_id IN (SELECT team_api_id FROM Team WHERE Id = '{1}' ))");
        query = applyFilter(query, "home_team_api_id", parameters.get("team2"), "({0} IN (SELECT team_api_id FROM Team WHERE Id = '{1}' ) OR away_team_api_id IN (SELECT team_api_id FROM Team WHERE Id = '{1}' ))");

        query = applyFilter(query, "date", parameters.get("from_date"), "{0} >= '{1}' ");
        query = applyFilter(query, "date", parameters.get("to_date"), "{0} <= '{1}' ");

        if (parameters.get("won") == null || parameters.get("won").length == 0 || parameters.get("won")[0].equals("false")) {
            query = applyFilter(query, "home_team_goal", new String[] { "away_team_goal" }, "{0} <= '{1}' ");
        }
        if (parameters.get("lost") == null || parameters.get("lost").length == 0 ||  parameters.get("lost")[0].equals("false")) {
            query = applyFilter(query, "home_team_goal", new String[] { "away_team_goal" }, "{0} > '{1}' ");
        }
        if (parameters.get("draw") == null || parameters.get("draw").length == 0 ||  parameters.get("draw")[0].equals("false")) {
            query = applyFilter(query, "home_team_goal", new String[] { "away_team_goal" }, "{0} = '{1}' ");
        }

        return DBEngine.getInstance().executeQuery(query);
    }

    private static void addAsSelectField(List<String> selectFields, String fieldToAdd, String[] pValues) {
        if (pValues != null && pValues.length > 0 && pValues[0].equalsIgnoreCase("true")) {
            selectFields.add(fieldToAdd);
        }
    }


    private static String applyFilter(String query, String colName, String[] pValues, String filterString) {

        if (pValues != null && pValues.length > 0 && !pValues[0].isBlank()) {
            query += " AND {filter-string} ".replace("{filter-string}", filterString);
            query = query.replaceAll("\\{0\\}", colName).replaceAll("\\{1\\}", pValues[0]);
        }

        return query;
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

        if (parameters.containsKey("team1_id") && parameters.containsKey("team2_id")) {
            String queryToExecute = Queries.PREDICTION_QUERY.replace("{0}", parameters.get("team1_id")[0]).replace("'{1}' ", parameters.get("team2_id")[0]);

            return DBEngine.getInstance().executeQuery(queryToExecute);
        }

        return null;

    }

} 