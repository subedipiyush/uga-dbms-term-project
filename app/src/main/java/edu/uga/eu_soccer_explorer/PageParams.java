package edu.uga.eu_soccer_explorer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

/**
 * Class represents all page params for JSP
 * @author Piyush Subedi
 */
public class PageParams {


    /**
     * Represents each param
     */
    public class Param {
        private String id;
        private String name;
        private String parent;

        public Param (String id, String name) {
            this(id, name, null);
        }

        public Param (String id, String name, String parent) {
            this.id = id;
            this.name = name;
            this.parent = parent;
        }

        public String getId() {
            return this.id;
        }

        public String getName() {
            return this.name;
        }

        public String getParent() {
            return this.parent;
        }
    }


    //  list of country names
    private List<Param> countries;

    // league mapped with their countries 
    private List<Param> leagues;

    // teams mapped with their leagues
    private List<Param> teams;

    private DBEngine engine;

    private boolean fetched;

    public List<Param> getCountries() {
        return this.countries;
    }

    public List<Param> getLeagues() {
        return this.leagues;
    }

    public List<Param> getTeams() {
        return this.teams;
    }

    public PageParams() {

        this.fetched = false;
        this.countries = new ArrayList<>();
        this.leagues = new ArrayList<>();
        this.teams = new ArrayList<>(); 

        this.engine = DBEngine.getInstance();
    }

    /**
     * Fetches the data from the database and stores them in the params
     * 
     * @throws SQLException
     * @throws NoSuchElementException
     * @throws ClassNotFoundException
     */
    public void fetch() throws ClassNotFoundException, NoSuchElementException, SQLException {
        
        if (fetched) {
            return;
        }
        
        // query        
        DBResult resultMix = this.engine.executeQuery(Queries.COUNTRIES_LEAGUES_TEAMS_ALL);

        // expected cols : country_id, country_name, league_id, league_name, team_id, team_name

        for (List<Object> row : resultMix.getRows()) {

            this.add_to_set(this.countries, new Param(row.get(0).toString(), row.get(1).toString()));

            this.add_to_set(this.leagues, new Param(row.get(2).toString(), row.get(3).toString(), row.get(0).toString()));
            
            this.add_to_set(this.teams, new Param(row.get(4).toString(), row.get(5).toString(), row.get(2).toString()));
        }

        this.fetched = true;
    }

    private void add_to_set(List<Param> l, Param o) {
        for (Param p : l) {
            if (p.id.equals(o.id)) {
                return;
            }
        }

        l.add(o);
    }

}