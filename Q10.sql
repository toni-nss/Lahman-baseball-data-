--BONUS QUESTION 10
/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues. 
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.
hall of fame?
currently playing?

*/

WITH tn_schools AS (SELECT DISTINCT schoolname, schoolid 
					FROM schools 
					WHERE schoolstate = 'TN'
					),
					
tn_players AS (	SELECT DISTINCT playerid, schoolid 
				FROM collegeplaying 
				WHERE schoolid IN (SELECT schoolid 
				   					FROM tn_schools)
			   ORDER BY schoolid
				),

avg_player_salary_by_school AS (SELECT	schoolid,
										COUNT(DISTINCT(playerid)) AS num_players,
										AVG(salary)::numeric::money AS avg_salary
								FROM tn_players
								LEFT JOIN salaries USING(playerid)
								GROUP BY schoolid),
						
awards_by_school AS (	SELECT schoolid, COUNT(awardid) AS num_player_awards
				  		FROM tn_players LEFT JOIN awardsplayers USING(playerid)
					  	GROUP BY schoolid
					  )
					  
SELECT DISTINCT schoolname AS school, 
		num_players, 
		COALESCE(avg_salary::text,'no data') AS avg_salary,
		num_player_awards
FROM tn_schools
LEFT JOIN tn_players
USING(schoolid)
LEFT JOIN avg_player_salary_by_school
USING(schoolid)
LEFT JOIN awards_by_school
USING(schoolid)
WHERE num_players > 0
ORDER BY num_players DESC