



--6 :
     --Rajai Davis with post season

--Find the player who had the most success stealing bases in 2016, 
--where success is measured as the percentage of stolen base attempts which are successful. 
--(A stolen base attempt results either in a stolen base or being caught stealing.) 
--Consider only players who attempted at least 20 stolen bases.

--sb: stolen bases
--CS :caught stealing

SELECT p.namefirst,
       p.namelast,
       yearid,
       sb::decimal,
	   cs::decimal,
	   (sb+cs) as stolen_attemt,
	   ROUND(sb/(sb+cs)::decimal,2) as success_rate
	 
	   
FROM batting as b
LEFT JOIN people as p
ON b.playerid = p.playerid
WHERE (sb+cs) >20
AND yearid = 2016
ORDER BY sb DESC

-- postgame data
SELECT * 
FROM battingpost
WHERE yearid = 2016
AND playerid = 'davisra01'

--
SELECT DISTINCT p.namefirst,p.namelast,
       b.yearid,
	   b.playerid,
       b.sb,b.cs,
	   bp.sb as post_sb,
	   bp.cs as post_cs,
	   
	   CASE WHEN bp.sb IS NULL THEN (b.sb+b.cs)
	        WHEN bp.sb IS NOT NULL THEN (b.sb+b.cs+bp.sb+bp.cs) 
			END AS total_attempt,
	
	   CASE WHEN bp.sb IS NULL THEN b.sb/(b.sb+b.cs)
	        WHEN bp.sb IS NOT NULL THEN ROUND(((b.sb+bp.sb)::decimal/(b.sb+b.cs+bp.sb+bp.cs))::decimal,4)
	        END AS success_rate
			
	 
	   
FROM batting as b

	LEFT JOIN people as p
	ON b.playerid = p.playerid
	LEFT JOIN battingpost as bp
	ON p.playerid = bp.playerid

WHERE b.yearid = 2016
AND b.sb+b.cs+bp.sb+bp.cs >20
ORDER BY total_attempt DESC
--ORDER BY success_rate DESC

--- post season data + with CET

WITH ps as (SELECT yearid,playerid,
			       SUM(sb) as post_sb,
			       SUM(cs) as post_cs
		           FROM battingpost
		     WHERE yearid = 2016
		     GROUP BY yearid,playerid
		     ORDER BY SUM(sb) DESC)

SELECT p.namefirst,
       p.namelast,
       b.yearid,
       sb::decimal,
	   cs::decimal,
	   post_sb,
	   post_cs,
	   CASE WHEN post_sb IS NULL THEN sb+cs 
	        WHEN post_sb IS NOT NULL THEN sb+cs+post_sb+post_cs
			END AS total_attempt,
		CASE WHEN post_sb IS NULL THEN (sb::decimal/(sb+cs)::decimal)
		     WHEN post_sb IS NOT NULL THEN ROUND(((sb+post_sb)::decimal/(sb+cs+post_sb+post_cs)::decimal),4)
	         END AS success_rate
	   
	 
	   
FROM batting as b
LEFT JOIN people as p
ON b.playerid = p.playerid
LEFT JOIN ps
ON b.playerid = ps.playerid
WHERE b.yearid = 2016
AND sb+cs+post_sb+post_cs >20

ORDER BY success_rate DESC


	   