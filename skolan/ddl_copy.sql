--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-05
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/kopiera-tabell

--
-- Make copy of table
--
DROP TABLE IF EXISTS teacher_pre;
CREATE TABLE teacher_pre LIKE teacher;
INSERT INTO teacher_pre SELECT * FROM teacher;

-- Check the content of the tables, for sanity checking
SELECT SUM(salary) AS 'Salary', SUM(competence) AS 'Comp' FROM teacher;
SELECT SUM(salary) AS 'Salary', SUM(competence) AS 'Comp' FROM teacher_pre;