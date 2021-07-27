/*
QUESTION 9
Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.
*/

WITH qualifying_managers AS (SELECT playerid, 
									yearid,
									awardid,
									lgid
							FROM awardsmanagers 
							WHERE awardid = 'TSN Manager of the Year'
							AND lgid IN ('NL','AL')
							AND playerid IN (	SELECT 	playerid 
												FROM awardsmanagers 
												WHERE awardid = 'TSN Manager of the Year' 
												AND lgid IN ('NL','AL')
												GROUP BY playerid
												HAVING COUNT(DISTINCT(lgid))=2) 
							 ),
							 
qm_with_names AS (	SELECT 	namefirst, 
				  			namelast, 
				  			qm.* 
				  	FROM qualifying_managers AS qm 
				  	LEFT JOIN people AS p 
				  	USING(playerid)
				 ),
					
qm_with_teamid AS (	SELECT 	DISTINCT q.*, 
							m.teamid 
					FROM qm_with_names AS q 
					LEFT JOIN managers AS m 
					USING(playerid)
					LEFT JOIN teams AS t
					USING(teamid)
					WHERE m.yearid=q.yearid
					AND m.lgid IN (SELECT lgid 
								   FROM qm_with_names))
								   
SELECT 	qmt.namefirst || ' ' || qmt.namelast AS full_name,
		t.name,
		qmt.yearid,
		awardid,
		qmt.lgid
FROM qm_with_teamid AS qmt 
LEFT JOIN teams AS t 
USING(teamid) 
WHERE qmt.yearid = t.yearid 
ORDER BY namefirst, yearid;