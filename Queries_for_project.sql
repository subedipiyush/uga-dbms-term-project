

/* i have left in the origianl variables so that you know what should go where in the sql statements when you replace them with "?",
you can ignore all of the SET statements, i left them in incase you wanted some valid values to test */

/*match search parameters for workbench testing */
SET @TEAM1NAME = "Royal Excel Mouscron";
SET @TEAM2NAME = "KSV Roeselare";
SET @COUNTRYNAME = "Belgium";
SET @DATE1 = "2000-01-01";
SET @DATE2 = "2020-01-01";
SET @LEAGUENAME = "Belgium Jupiler League";

/*return a list of matches that match the given parameteres, parameters must include:
 TEAM1NAME, TEAM2NAME, COUNTRYNAME, DATE1, DATE2, LEAGUENAME the query will attempt to find a match that involves both teams
 (does not matter if the teams are home or away team), occured between the given dates, occured in the given country, and the given league*/
 
SELECT eu_soccer.match.id AS Match_id, locationCountry.name AS country_name, matchLeague.name AS League, eu_soccer.match.home_team_goal, eu_soccer.match.away_team_goal,
eu_soccer.match.shoton AS shots_on_target, eu_soccer.match.shotoff AS shots_off_target, eu_soccer.match.possession, eu_soccer.match.foulcommit as fouls,
(SELECT team.team_long_name
FROM team
WHERE eu_soccer.match.home_team_api_id = team.team_api_id) AS Home_team, 
(SELECT team.team_long_name
FROM team
WHERE eu_soccer.match.away_team_api_id = team.team_api_id) AS Away_team
FROM eu_soccer.match ,
(SELECT  team_api_id, team_long_name
FROM team
WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM1NAME OR team_short_name COLLATE utf8mb4_general_ci = @TEAM1NAME) AS team1, 
(SELECT team_api_id, team_long_name
FROM team
WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM2NAME OR team_short_name COLLATE utf8mb4_general_ci = @TEAM2NAME) AS team2, 
(SELECT country.name, country.id
FROM country
WHERE country.name = @COUNTRYNAME) AS locationCountry,
(SELECT *
FROM league 
WHERE league.name = @LEAGUENAME) AS matchLeague
WHERE (eu_soccer.match.home_team_api_id = team1.team_api_id AND eu_soccer.match.away_team_api_id = team2.team_api_id) OR
(eu_soccer.match.home_team_api_id = team2.team_api_id AND eu_soccer.match.away_team_api_id = team1.team_api_id) AND 
eu_soccer.match.country_id = locationCountry.id AND eu_soccer.match.date BETWEEN @DATE1 AND @DATE2 AND eu_soccer.match.league_id = matchLeague.id;

/*workbench variables for team searching */
SET @SEARCHTEAM = "liverpool";

/* returns stats for a team given the name*/
SELECT * 
FROM team, team_attributes
WHERE team.team_long_name COLLATE utf8mb4_general_ci = @SEARCHTEAM OR  team.team_short_name COLLATE utf8mb4_general_ci = @SEARCHTEAM AND
team.team_api_id = team_attributes.team_api_id;

/variables for player searching*/
SET @SEARCHPLAYER = "Aaron doran";

/* search for a given player and returns an average of all stats */
SELECT  player.player_api_id, player_name, player.player_fifa_api_id, birthday, height, AVG(weight), attacking_work_rate, defensive_work_rate, AVG(overall_rating), AVG(potential), AVG(crossing), AVG(finishing), AVG(heading_accuracy), AVG(short_passing), AVG(volleys),
AVG(dribbling), AVG(curve), AVG(free_kick_accuracy), AVG(long_passing), AVG(ball_control), AVG(acceleration), AVG(sprint_speed),
AVG(agility), AVG(reactions), AVG(balance), AVG(shot_power), AVG(jumping), avg(stamina), AVG(aggression), AVG(strength), AVG(long_shots),
AVG(aggression), AVG(interceptions), AVG(positioning), AVG(vision), AVG(penalties), AVG(marking), AVG(standing_tackle), AVG(sliding_tackle),
AVG(gk_diving), AVG(gk_handling), AVG(gk_kicking), AVG(gk_positioning), AVG(gk_reflexes)
FROM player, player_attributes
WHERE player.player_name COLLATE utf8mb4_general_ci = @SEARCHPLAYER AND player.player_api_id = player_attributes.player_api_id
GROUP BY player.player_name;

/*variables for prediction query */
SET @TEAM1 = "Beerschot AC";
SET @TEAM2 = "Sporting Lokeren";

/*prediction query */
SELECT CASE WHEN (Team_1_Win_Percent = Team_2_Win_Percent OR Team_1_AVG_Goals = Team_2_AVG_Goals) THEN "Predicted Outcome: Draw"
	WHEN (Team_1_Win_Percent > Team_2_Win_Percent AND Team_1_AVG_Goals > Team_2_AVG_Goals) THEN "Team 1 victory"	
	WHEN (Team_2_Win_Percent > Team_1_Win_Percent AND Team_2_AVG_Goals > Team_1_AVG_Goals) THEN "Team 2 victory"
    WHEN (Team_1_Win_Percent > Team_2_Win_Percent) THEN "Team 1 victory"
	WHEN (Team_1_Win_Percent < Team_2_Win_Percent) THEN "Team 2 victory"
    WHEN (Team_1_AVG_Goals > Team_2_AVG_Goals) THEN "Team 1 victory"
    WHEN (Team_1_AVG_Goals < Team_2_AVG_Goals) THEN "Team 2 victory"	
    ELSE "Predicted Outcome: Draw"
    END AS Predicted_Outcome
FROM
(SELECT ((T1_away.T1_away_wins + T1_home.T1_home_wins)/(T1_away.T1_away_total + T1_home.T1_home_total)*100) AS Team_1_Win_Percent,
((T1_away.T1_away_goals + T1_home.T1_home_goals)/(T1_away.T1_away_total + T1_home.T1_home_total)) AS Team_1_AVG_Goals,
((T2_away.T2_away_wins + T2_home.T2_home_wins)/(T2_away.T2_away_total + T2_home.T2_home_total)*100) AS Team_2_Win_Percent,
((T2_away.T2_away_goals + T2_home.T2_home_goals)/(T2_away.T2_away_total + T2_home.T2_home_total)) AS Team_2_AVG_Goals
FROM 
(SELECT COUNT(*) AS T1_away_wins, numGames.count AS T1_away_total, SUM(away_team_goal) AS T1_away_goals 
FROM (SELECT * FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM1) AS team1id
	 WHERE matches.away_team_api_id = team1id.team_api_id) AS T1_away_games, (SELECT COUNT(*) AS count FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM1) AS team1id
	 WHERE matches.away_team_api_id = team1id.team_api_id) AS numGames
     WHERE away_team_goal > home_team_goal
     GROUP BY away_team_api_id) AS T1_away,     
(SELECT COUNT(*) AS T1_home_wins, numGames.count AS T1_home_total, SUM(home_team_goal) AS T1_home_goals
FROM (SELECT * FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM1) AS team1id
	 WHERE matches.home_team_api_id = team1id.team_api_id) AS T1_home_games, (SELECT COUNT(*) AS count FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM1) AS team1id
	 WHERE matches.home_team_api_id = team1id.team_api_id) AS numGames
     WHERE home_team_goal > away_team_goal
     GROUP BY home_team_api_id) AS T1_home,     
(SELECT COUNT(*) AS T2_away_wins, numGames.count AS T2_away_total, SUM(away_team_goal) AS T2_away_goals
FROM (SELECT * FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM2) AS team2id
	 WHERE matches.away_team_api_id = team2id.team_api_id) AS T2_away_games, (SELECT COUNT(*) AS count FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM2) AS team2id
	 WHERE matches.away_team_api_id = team2id.team_api_id) AS numGames
     WHERE away_team_goal > home_team_goal
     GROUP BY away_team_api_id) AS T2_away,
(SELECT COUNT(*) AS T2_home_wins, numGames.count AS T2_home_total, SUM(home_team_goal) AS T2_home_goals
FROM (SELECT * FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM2) AS team2id
	 WHERE matches.home_team_api_id = team2id.team_api_id) AS T2_home_games, (SELECT COUNT(*) AS count FROM eu_soccer.match AS matches, (SELECT team_api_id FROM team WHERE team_long_name COLLATE utf8mb4_general_ci = @TEAM2) AS team2id
	 WHERE matches.home_team_api_id = team2id.team_api_id) AS numGames
     WHERE away_team_goal < home_team_goal
     GROUP BY home_team_api_id) AS T2_home
) AS summaryStats;
     
/* return a list of all the teams in a given league 
 The only parameter required is the league name*/
SET @LEAGUESEARCH = "Belgium Jupiler League";

SELECT team.team_long_name
FROM team, (SELECT id FROM league WHERE league.name COLLATE utf8mb4_general_ci = @LEAGUESEARCH) AS leagueid
WHERE team.team_api_id IN (SELECT home_team_api_id FROM eu_soccer.match WHERE league_id = leagueid.id);
