package edu.uga.eu_soccer_explorer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.NoSuchElementException;
import java.util.Properties;

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

            InputStream inputStream = null;
    		try {
    			Properties prop = new Properties();
    			String propFileName = "config.properties";
    			inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
     
    			if (inputStream != null) {
    				prop.load(inputStream);
    			} else {
    				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
    			}
          
    			// get the property value and print it out
//    			String user = prop.getProperty("user");
    			url = prop.getProperty("db_url");
    			username = prop.getProperty("db_username");
    			password = prop.getProperty("db_password");
//    			String company3 = prop.getProperty("company3");
     
    		} catch (Exception e) {
    			System.out.println("Exception: " + e);
    		} finally {
    			try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    
            credentialsHasBeenRead = true;
        }
    }
}
