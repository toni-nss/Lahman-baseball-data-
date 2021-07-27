--#5
/*5a. Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. 
5b.Do the same for home runs per game. 
5c.Do you see any trends?*/

WITH games_per_decade AS (	SELECT 	yearid/10*10 AS decade, 
									SUM(g)::NUMERIC/2 AS total_games
					   		FROM teams
							WHERE yearid >= 1920
					   		GROUP BY yearid/10*10
					   		ORDER BY decade DESC),
						
so_and_hr_per_decade AS (	SELECT 	yearid/10*10 AS decade, 
									SUM(so)::NUMERIC AS total_so,
						  			SUM(hr)::NUMERIC AS total_hr
					   		FROM batting
							WHERE yearid >= 1920
					   		GROUP BY yearid/10*10
					   		ORDER BY decade DESC)

SELECT 	decade,
		ROUND(total_so/total_games,1) AS avg_so_per_game,
		ROUND(total_hr/total_games,1) AS avg_hr_per_game
FROM games_per_decade LEFT JOIN
so_and_hr_per_decade USING(decade)
ORDER BY decade

