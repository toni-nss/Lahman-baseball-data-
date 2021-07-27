--Q11.Is there any correlation between number of wins and team salary? 
--Use data from 2000 and later to answer this question. As you do this analysis, 
--keep in mind that salaries across the whole league tend to increase together, 
--so you may want to look on a year-by-year basis.

SELECT * FROM teams

SELECT * FROM salaries

--team/number of win each year >=2000

WITH number_of_win AS (SELECT yearid,teamid,name,w
					   FROM teams
					   WHERE yearid >=2000),
					   
					   
-- WITH sum_salary AS	  (SELECT yearid,teamid,SUM(salary) as total_salary
-- 					   FROM salaries
-- 					   WHERE yearid >=2000
-- 					   GROUP BY yearid,teamid
-- 					   ORDER BY yearid,teamid)
					   
										
				           

SELECT DISTINCT s.yearid,s.teamid,nw.w,SUM(salary)OVER(PARTITION BY s.yearid,s.teamid) as total_salary
					   FROM salaries as s
					   FULL JOIN number_of_win as nw USING(teamid)
					   WHERE s.yearid = nw.yearid
					   
					   --GROUP BY s.yearid,s.teamid
					   ORDER BY s.teamid,s.yearid















 						   