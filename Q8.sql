--Question 8.Using the attendance figures from the homegames table, 
--find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). 
--Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.
(SELECT park_name,
       t.name AS team_name,
       ROUND((AVG(h.attendance)/h.games),0) AS avg_attendance,
       'TOP 5' AS ranking
FROM homegames AS h 
INNER JOIN parks AS p
USING (park)
	LEFT JOIN teams AS t
	ON t.park =p.park_name
WHERE year= '2016'
AND games >'10'
AND t.yearid = '2016'
GROUP BY park_name,t.name,games
ORDER BY avg_attendance DESC
LIMIT 5)
UNION
(SELECT park_name,
       t.name AS team_name,
       ROUND((AVG(h.attendance)/h.games),0) AS avg_attendance,
       'BOTTOM 5' AS ranking
FROM homegames AS h 
INNER JOIN parks AS p
USING (park)
	LEFT JOIN teams AS t
	ON t.park =p.park_name
WHERE year= '2016'
AND games >'10'
AND t.yearid = '2016'
GROUP BY park_name,t.name,games
ORDER BY avg_attendance ASC
LIMIT 5)
ORDER BY Avg_attendance DESC;
