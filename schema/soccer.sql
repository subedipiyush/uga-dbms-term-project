START TRANSACTION;

DROP TABLE IF EXISTS `Match`;
DROP TABLE IF EXISTS `Team_Attributes`;
DROP TABLE IF EXISTS `Team`;
DROP TABLE IF EXISTS `Player_Attributes`;
DROP TABLE IF EXISTS `Player`;
DROP TABLE IF EXISTS `League`;
DROP TABLE IF EXISTS `Country`;

SELECT "Creating Country" AS "INFO";
CREATE TABLE IF NOT EXISTS `Country` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`name`	VARCHAR(255) UNIQUE
);
SELECT "Creating League" AS "INFO";
CREATE TABLE IF NOT EXISTS `League` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`country_id`	INTEGER,
	`name`	VARCHAR(255) UNIQUE,
	FOREIGN KEY(`country_id`) REFERENCES `Country`(`id`)
);
SELECT "Creating Players" AS "INFO";
CREATE TABLE IF NOT EXISTS `Player` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`player_api_id`	INTEGER UNIQUE,
	`player_name`	VARCHAR(255),
	`player_fifa_api_id`	INTEGER UNIQUE,
	`birthday`	VARCHAR(255),
	`height`	INTEGER,
	`weight`	INTEGER
);
SELECT "Creating Player_Attributes" AS "INFO";
CREATE TABLE IF NOT EXISTS `Player_Attributes` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`player_fifa_api_id`	INTEGER,
	`player_api_id`	INTEGER,
	`date`	VARCHAR(255),
	`overall_rating`	INTEGER,
	`potential`	INTEGER,
	`preferred_foot`	VARCHAR(255),
	`attacking_work_rate`	VARCHAR(255),
	`defensive_work_rate`	VARCHAR(255),
	`crossing`	INTEGER,
	`finishing`	INTEGER,
	`heading_accuracy`	INTEGER,
	`short_passing`	INTEGER,
	`volleys`	INTEGER,
	`dribbling`	INTEGER,
	`curve`	INTEGER,
	`free_kick_accuracy`	INTEGER,
	`long_passing`	INTEGER,
	`ball_control`	INTEGER,
	`acceleration`	INTEGER,
	`sprint_speed`	INTEGER,
	`agility`	INTEGER,
	`reactions`	INTEGER,
	`balance`	INTEGER,
	`shot_power`	INTEGER,
	`jumping`	INTEGER,
	`stamina`	INTEGER,
	`strength`	INTEGER,
	`long_shots`	INTEGER,
	`aggression`	INTEGER,
	`interceptions`	INTEGER,
	`positioning`	INTEGER,
	`vision`	INTEGER,
	`penalties`	INTEGER,
	`marking`	INTEGER,
	`standing_tackle`	INTEGER,
	`sliding_tackle`	INTEGER,
	`gk_diving`	INTEGER,
	`gk_handling`	INTEGER,
	`gk_kicking`	INTEGER,
	`gk_positioning`	INTEGER,
	`gk_reflexes`	INTEGER,
	FOREIGN KEY(`player_fifa_api_id`) REFERENCES `Player`(`player_fifa_api_id`),
	FOREIGN KEY(`player_api_id`) REFERENCES `Player`(`player_api_id`)
);

SELECT "Creating Teams" AS "INFO";
CREATE TABLE IF NOT EXISTS `Team` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`team_api_id`	INTEGER UNIQUE,
	`team_fifa_api_id`	INTEGER,
	`team_long_name`	VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	`team_short_name`	VARCHAR(255)
);
SELECT "Creating Teams_Attributes" AS "INFO";
CREATE TABLE IF NOT EXISTS `Team_Attributes` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`team_fifa_api_id`	INTEGER,
	`team_api_id`	INTEGER,
	`date`	VARCHAR(255),
	`buildUpPlaySpeed`	INTEGER,
	`buildUpPlaySpeedClass`	VARCHAR(255),
	`buildUpPlayDribbling`	INTEGER,
	`buildUpPlayDribblingClass`	VARCHAR(255),
	`buildUpPlayPassing`	INTEGER,
	`buildUpPlayPassingClass`	VARCHAR(255),
	`buildUpPlayPositioningClass`	VARCHAR(255),
	`chanceCreationPassing`	INTEGER,
	`chanceCreationPassingClass`	VARCHAR(255),
	`chanceCreationCrossing`	INTEGER,
	`chanceCreationCrossingClass`	VARCHAR(255),
	`chanceCreationShooting`	INTEGER,
	`chanceCreationShootingClass`	VARCHAR(255),
	`chanceCreationPositioningClass`	VARCHAR(255),
	`defencePressure`	INTEGER,
	`defencePressureClass`	VARCHAR(255),
	`defenceAggression`	INTEGER,
	`defenceAggressionClass`	VARCHAR(255),
	`defenceTeamWidth`	INTEGER,
	`defenceTeamWidthClass`	VARCHAR(255),
	`defenceDefenderLineClass`	VARCHAR(255),
	FOREIGN KEY(`team_api_id`) REFERENCES `Team`(`team_api_id`)
	-- FOREIGN KEY(`team_fifa_api_id`) REFERENCES `Team`(`team_fifa_api_id`)
);
SELECT "Creating Matches" AS "INFO";
CREATE TABLE IF NOT EXISTS `Match` (
	`id`	INTEGER PRIMARY KEY AUTO_INCREMENT,
	`country_id`	INTEGER,
	`league_id`	INTEGER,
	`season`	VARCHAR(255),
	`stage`	INTEGER,
	`date`	VARCHAR(255),
	`match_api_id`	INTEGER UNIQUE,
	`home_team_api_id`	INTEGER,
	`away_team_api_id`	INTEGER,
	`home_team_goal`	INTEGER,
	`away_team_goal`	INTEGER,
	`home_player_X1`	INTEGER,
	`home_player_X2`	INTEGER,
	`home_player_X3`	INTEGER,
	`home_player_X4`	INTEGER,
	`home_player_X5`	INTEGER,
	`home_player_X6`	INTEGER,
	`home_player_X7`	INTEGER,
	`home_player_X8`	INTEGER,
	`home_player_X9`	INTEGER,
	`home_player_X10`	INTEGER,
	`home_player_X11`	INTEGER,
	`away_player_X1`	INTEGER,
	`away_player_X2`	INTEGER,
	`away_player_X3`	INTEGER,
	`away_player_X4`	INTEGER,
	`away_player_X5`	INTEGER,
	`away_player_X6`	INTEGER,
	`away_player_X7`	INTEGER,
	`away_player_X8`	INTEGER,
	`away_player_X9`	INTEGER,
	`away_player_X10`	INTEGER,
	`away_player_X11`	INTEGER,
	`home_player_Y1`	INTEGER,
	`home_player_Y2`	INTEGER,
	`home_player_Y3`	INTEGER,
	`home_player_Y4`	INTEGER,
	`home_player_Y5`	INTEGER,
	`home_player_Y6`	INTEGER,
	`home_player_Y7`	INTEGER,
	`home_player_Y8`	INTEGER,
	`home_player_Y9`	INTEGER,
	`home_player_Y10`	INTEGER,
	`home_player_Y11`	INTEGER,
	`away_player_Y1`	INTEGER,
	`away_player_Y2`	INTEGER,
	`away_player_Y3`	INTEGER,
	`away_player_Y4`	INTEGER,
	`away_player_Y5`	INTEGER,
	`away_player_Y6`	INTEGER,
	`away_player_Y7`	INTEGER,
	`away_player_Y8`	INTEGER,
	`away_player_Y9`	INTEGER,
	`away_player_Y10`	INTEGER,
	`away_player_Y11`	INTEGER,
	`home_player_1`	INTEGER,
	`home_player_2`	INTEGER,
	`home_player_3`	INTEGER,
	`home_player_4`	INTEGER,
	`home_player_5`	INTEGER,
	`home_player_6`	INTEGER,
	`home_player_7`	INTEGER,
	`home_player_8`	INTEGER,
	`home_player_9`	INTEGER,
	`home_player_10`	INTEGER,
	`home_player_11`	INTEGER,
	`away_player_1`	INTEGER,
	`away_player_2`	INTEGER,
	`away_player_3`	INTEGER,
	`away_player_4`	INTEGER,
	`away_player_5`	INTEGER,
	`away_player_6`	INTEGER,
	`away_player_7`	INTEGER,
	`away_player_8`	INTEGER,
	`away_player_9`	INTEGER,
	`away_player_10`	INTEGER,
	`away_player_11`	INTEGER,
	`goal`	VARCHAR(255),
	`shoton`	VARCHAR(255),
	`shotoff`	VARCHAR(255),
	`foulcommit`	VARCHAR(255),
	`card`	VARCHAR(255),
	`cross`	VARCHAR(255),
	`corner`	VARCHAR(255),
	`possession`	VARCHAR(255),
	`B365H`	NUMERIC,
	`B365D`	NUMERIC,
	`B365A`	NUMERIC,
	`BWH`	NUMERIC,
	`BWD`	NUMERIC,
	`BWA`	NUMERIC,
	`IWH`	NUMERIC,
	`IWD`	NUMERIC,
	`IWA`	NUMERIC,
	`LBH`	NUMERIC,
	`LBD`	NUMERIC,
	`LBA`	NUMERIC,
	`PSH`	NUMERIC,
	`PSD`	NUMERIC,
	`PSA`	NUMERIC,
	`WHH`	NUMERIC,
	`WHD`	NUMERIC,
	`WHA`	NUMERIC,
	`SJH`	NUMERIC,
	`SJD`	NUMERIC,
	`SJA`	NUMERIC,
	`VCH`	NUMERIC,
	`VCD`	NUMERIC,
	`VCA`	NUMERIC,
	`GBH`	NUMERIC,
	`GBD`	NUMERIC,
	`GBA`	NUMERIC,
	`BSH`	NUMERIC,
	`BSD`	NUMERIC,
	`BSA`	NUMERIC,
	FOREIGN KEY(`home_player_5`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_6`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_4`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_2`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_2`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_10`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_11`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_7`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_3`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_7`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_3`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_9`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_10`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_5`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_1`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_9`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_11`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`league_id`) REFERENCES `League`(`id`),
	FOREIGN KEY(`home_player_8`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_team_api_id`) REFERENCES `Team`(`team_api_id`),
	FOREIGN KEY(`away_player_8`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`home_player_1`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_player_6`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`away_team_api_id`) REFERENCES `Team`(`team_api_id`),
	FOREIGN KEY(`home_player_4`) REFERENCES `Player`(`player_api_id`),
	FOREIGN KEY(`country_id`) REFERENCES `Country`(`id`)
);

SELECT "Importing country data" AS "INFO";
source load_countries.dump ;
SELECT "Importing leagues data" AS "INFO";
source load_leagues.dump ;
SELECT "Importing players data" AS "INFO";
source load_players.dump ;
SELECT "Importing players attributes data" AS "INFO";
source load_player_attributes.dump ;
SELECT "Importing teams data" AS "INFO";
source load_teams.dump ;
SELECT "Importing teams attributes data" AS "INFO";
source load_team_attributes.dump ;
SELECT 'Importing matches data' as 'INFO';
source load_matches.dump ;

COMMIT