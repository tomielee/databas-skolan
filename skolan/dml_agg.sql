--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-04

-- Lowest and max salary
-- SELECT
-- 	MIN(salary) AS "Lowest salary", 
--     MAX(salary) AS "Highest salary" 
-- FROM teacher;

-- -- Avrage competence
-- SELECT section,
-- 	AVG(competence)
-- FROM teacher
-- GROUP BY section;

-- -- Average competence desc list
-- SELECT section, competence, SUM(salary) AS "Summa"
-- FROM teacher
-- GROUP BY section, competence
-- ORDER BY Summa DESC;

-- -- How many teachers on each section
-- SELECT section, COUNT(*)
-- FROM teacher
-- GROUP by section;

-- -- Hur mycket betalar respektive avdelning ut i lön varje månad?
-- SELECT section, SUM(salary) * 12 AS "sum of salary"
-- FROM teacher
-- GROUP BY section;

-- -- Hur mycket är medellönen för de olika avdelningarna?
-- SELECT section, AVG(salary)
-- FROM teacher
-- GROUP by section;

-- -- Hur mycket är medellönen för kvinnor kontra män?
-- SELECT sex, AVG(salary)
-- FROM teacher
-- GROUP BY sex;

-- -- Visa snittet på kompetensen för alla avdelningar, sortera på kompetens i sjunkande ordning och visa enbart den avdelning som har högst kompetens.
-- SELECT section, AVG(competence) as "avg"
-- FROM teacher
-- GROUP BY section
-- ORDER BY avg DESC LIMIT 1;

-- -- Visa den avrundade snittlönen (ROUND()) grupperad per avdelning och per kompetens, sortera enligt avdelning och snittlön. 
-- -- Visa även hur många som matchar i respektive gruppering. Ditt svar skall se ut så här.-- 
-- SELECT section, competence, ROUND(AVG(salary)) AS "avg_salary", COUNT(*) AS "no_of"
-- FROM teacher
-- GROUP BY section, competence
-- ORDER BY section, competence;

-- -- Aggregerade funktioner Having https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/aggregerande-funktioner-having
-- SELECT
-- 	section,
--     ROUND(AVG(salary)) AS Avr_salary,
--     COUNT(salary) AS Quantity
-- FROM teacher
-- GROUP BY 
-- 	section
-- HAVING
-- 	Avr_salary > 35000
-- ORDER BY 
-- 	Avr_salary DESC
-- ;

-- -- Vi vill se snittlönen per avdelning (och antal), men bara om det är 3 eller fler personer på den avdelningen.
-- SELECT 
-- 	section,
--     ROUND(AVG(salary)) AS Avr_salary,
--     COUNT(salary) AS Quantity
-- FROM teacher
-- GROUP BY section
-- HAVING 
-- 	Quantity >= 3
-- ORDER BY
-- 	Avr_salary DESC;

-- -- OM WHERE
-- SELECT 
-- 	section,
--     ROUND(AVG(salary)) as Avr_salary,
--     COUNT(salary) as Quantity
-- FROM teacher
-- WHERE
-- 	competence = 1
-- GROUP BY section
-- HAVING
-- 	Avr_salary < 30000
-- ORDER by section
-- ;

-- -- Visa per avdelning hur många anställda det finns gruppens snittlön, sortera per avdelning och snittlön.
-- SELECT
-- 	section,
-- 	ROUND(AVG(salary)) AS Avg_salary,
--     Count(salary) AS 'Num. of empl.'
-- FROM teacher
-- GROUP BY section
-- ORDER BY
-- 	section,
--     Avg_salary
-- ;

-- -- Visa samma sak som i 1), men visa nu även de kompetenser som finns. Du behöver gruppera på avdelning och per kompetens, sortera per avdelning och per kompetens.
-- SELECT
-- 	section,
--     competence,
-- 	ROUND(AVG(salary)) AS Avg_salary,
--     Count(salary) AS 'Num. of empl.'
-- FROM teacher
-- GROUP BY section, competence
-- ORDER BY
-- 	section,
--     competence DESC
-- ;

-- -- Visa samma sak som i 2), men ignorera de kompetenser som är större än 3.
-- SELECT
-- 	section,
--     competence,
-- 	ROUND(AVG(salary)) AS Avg_salary,
--     Count(salary) AS 'Num. of empl.'
-- FROM teacher
-- WHERE 
-- 	competence <= 3
-- GROUP BY section, competence
-- ORDER BY
-- 	section,
--     competence DESC
-- ;

-- -- Visa samma sak som i 3), men exkludera de grupper som har fler än 1 i Antal och snittlön mellan 30 000 - 45 000. Sortera per snittlön.
-- SELECT
-- 	section,
--     competence,
-- 	ROUND(AVG(salary)) AS Avg_salary,
--     Count(salary) AS Num
-- FROM teacher
-- WHERE 
-- 	competence <= 3
-- GROUP BY section, competence
-- HAVING 
-- 	Num <= 1
--     AND Avg_salary >= 30000 AND Avg_salary <= 45000
--     
-- ORDER BY
--     Avg_salary DESC
-- ;



