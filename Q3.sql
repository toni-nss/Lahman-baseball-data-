-- Question 1.What range of years for baseball games played does the provided database cover?
SELECT MIN(yearid),MAX(yearid)
FROM teams;

--Question 3.Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
WITH played_at_vandy AS (SELECT DISTINCT playerid
					                 
                    FROM people AS p 
					 INNER JOIN collegeplaying AS cp
                     USING(playerid)
                     WHERE schoolid ILIKE 'vandy')

SELECT namefirst,namelast,
SUM(s.salary)AS total_salary
                 
      FROM people AS p 
      INNER JOIN salaries AS s
      USING(playerid)
            
                  WHERE playerid IN (SELECT * FROM played_at_vandy)
				  GROUP BY namefirst,namelast
				  ORDER BY total_salary DESC;
--ANSWER - David Price, $81,851,296 total salary		
				  


					 










 




