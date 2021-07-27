--2
--Find the name and height of the shortest player in the database. --Edward Carl Gaedel / 43 / 1 game
--How many games did he play in? What is the name of the team for which he played?
SELECT DISTINCT t.name as teamname,
                p.namegiven,p.namelast,p.height,
				a.teamid,a.g_all
FROM people as p
LEFT JOIN appearances as a
ON p.playerid = a.playerid
LEFT JOIN teams as t
ON a.teamid = t.teamid
ORDER BY p.height