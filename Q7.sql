--7a. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
--7b. What is the smallest number of wins for a team that did win the world series? 
--7c. Doing this will probably result in an unusually small number of wins for a world series champion – 
--	determine why this is the case. Then redo your query, excluding the problem year. 
--7d. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
--7e. What percentage of the time?

SELECT *
FROM teams
WHERE yearid >= '1970';

--7a.
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid >= '1970'
AND WSWin = 'N'
GROUP BY name, yearid, w, wswin
ORDER BY w DESC
LIMIT 5;
		
--7b. 
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid >= '1970'
AND WSWin = 'Y'
GROUP BY name, yearid, w, wswin
ORDER BY w
LIMIT 5;

--7c.
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid <> '1981' AND yearid >= '1970'
AND WSWin = 'Y'
GROUP BY name, yearid, w, wswin
ORDER BY w
LIMIT 5;

--7d.
WITH max_wins AS 
			(SELECT yearid,
			MAX(w) AS w
			FROM teams
			WHERE yearid >= '1970'
			GROUP BY yearid),
max_wins_team AS 
			(SELECT name, yearid
			FROM max_wins LEFT JOIN teams USING(yearid)
			WHERE teams.w = max_wins.w),
wswinners AS (SELECT yearid, name, wswin
				FROM teams
				WHERE yearid >= '1970'
				AND wswin = 'Y')
SELECT * 
FROM wswinners 
FULL JOIN max_wins_team USING(yearid) 
WHERE wswinners.name = max_wins_team.name

--7e.
WITH max_wins AS 
			(SELECT yearid,
			MAX(w) AS w
			FROM teams
			WHERE yearid >= '1970'
			GROUP BY yearid),
max_wins_team AS 
			(SELECT name, yearid
			FROM max_wins LEFT JOIN teams USING(yearid)
			WHERE teams.w = max_wins.w),
wswinners AS (SELECT yearid, name, wswin
				FROM teams
				WHERE yearid >= '1970'
				AND wswin = 'Y')			 
SELECT ROUND((COUNT(*)/(MAX(yearid)-MIN(yearid))::decimal*100),2) AS perc_time
	FROM wswinners FULL JOIN max_wins_team USING(yearid) 
	WHERE wswinners.name = max_wins_team.name;

