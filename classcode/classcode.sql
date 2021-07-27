--Q8
--Josh
SELECT team,
			name,
			park_name,
			ROUND(hg.attendance::numeric/ hg.games) AS avg_att
	FROM homegames AS hg
	LEFT JOIN parks
	USING (park)
	LEFT JOIN teams AS t
	ON hg.team = t.teamid AND hg.year = t.yearid
	WHERE year = 2016 AND games >= 10
	ORDER BY hg.attendance/hg.games DESC
	LIMIT 5;


--Q9
--Preston

SELECT CONCAT(namefirst,' ', namelast) AS fullname, teams.name, awardid, awardsmanagers.lgid, awardsmanagers.yearid
FROM awardsmanagers
LEFT JOIN people
	ON awardsmanagers.playerid = people.playerid
LEFT JOIN managers
	ON managers.playerid = awardsmanagers.playerid
	AND managers.yearid = awardsmanagers.yearid
LEFT JOIN teams
	ON managers.teamid = teams.teamid
	AND managers.yearid = teams.yearid
WHERE awardsmanagers.playerid IN (
			SELECT playerid
			FROM awardsmanagers
			WHERE awardid ILIKE 'TSN%'
			AND lgid = 'AL'
			INTERSECT
			SELECT playerid
			FROM awardsmanagers
			WHERE awardid ILIKE 'TSN%'
			AND lgid = 'NL'
			)
AND awardid ILIKE 'TSN%'