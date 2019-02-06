--
-- Update salary in table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-01-24
--

--
-- Update a column value
--
UPDATE teacher 
	SET salary = 30000 
		WHERE 
        acronym IN('gyl', 'ala')
        OR
        salary is NULL;
        

-- Show status salaries
--
-- SELECT acronym, section, fname, sex, salary, competence
-- FROM teacher
-- ORDER BY salary DESC;

-- SELECT
--     SUM(salary) AS Salary,
--     SUM(competence) AS Competence 
-- FROM teacher
-- ;