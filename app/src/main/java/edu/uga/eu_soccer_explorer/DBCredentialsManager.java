package edu.uga.eu_soccer_explorer;

import java.util.NoSuchElementException;

/**
 * Class reads and manages database credentials
 * 
 * @author Piyush
 * @extended-by Farah
 */
public class DBCredentialsManager {

    /**
     * database url
     */
    private String url;

    /**
     * database username
     */
    private String username;

    /**
     * database password
     */
    private String password;


    /* flag to check if credentials have already been read or not */
    private Boolean credentialsHasBeenRead = false;

    
    public DBCredentialsManager() {}

    /**
     * {@link DBCredentialsManager#url}
     */
    public String getUrl() throws NoSuchElementException {
        readCredentials();

        return url;
    }

    /**
     * {@link DBCredentialsManager#username}
     */
    public String getUsername() throws NoSuchElementException {
        readCredentials();

        return username;
    }

    /**
     * {@link DBCredentialsManager#password}
     */
    public String getPassword() throws NoSuchElementException {
        readCredentials();

        return password;
    }

    /**
     * Reads database credentials from config.properties
     * @author Farah
     */
    private void readCredentials() {
        if (!credentialsHasBeenRead) {

            /* TODO : 
                There's a config.properties file in 'resources' directory
                Add <code> here to read the url, username and password of the database
                Refer : https://crunchify.com/java-properties-file-how-to-read-config-properties-values-in-java/
            */


            credentialsHasBeenRead = true;
        }
    }
}
