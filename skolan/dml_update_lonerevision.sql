--
-- Update salaries in table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-01-24

-- Calculate total salary
SELECT SUM(salary) AS 'Sum salary before', SUM(competence) AS 'Competence before' FROM teacher;

SELECT acronym, section, fname, sex, salary, competence
FROM teacher
ORDER BY salary DESC;

-- Salary revision per personal according to kmom01
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/uppdatera-varden-lonerevision

UPDATE teacher SET salary = 85000, competence = 7 WHERE fname = 'Albus';
UPDATE teacher SET salary = salary + 4000 WHERE fname = 'Minerva';
UPDATE teacher SET salary = salary + 2000, competence = 3 WHERE fname = 'Argus';
UPDATE teacher SET salary = salary - 3000 WHERE fname IN('Gyllenroy', 'Alastor');
UPDATE teacher SET salary = salary * 1.02 WHERE section = 'DIDD';
UPDATE teacher SET salary = salary * 1.03 WHERE sex = 'F' AND salary < 40000;
UPDATE teacher SET salary = salary + 5000, competence = competence + 1 WHERE fname IN('Severus', 'Minerva', 'Hagrid');
UPDATE teacher SET salary = salary * 1.022 WHERE fname NOT IN('Albus', 'Severus', 'Minerva', 'Hagrid');

-- Calculate how much salary has increased after the revision
SELECT SUM(salary) AS 'Sum salary after', SUM(competence) AS 'Competence after' FROM teacher;

-- Calculate revision in % after the revision
SELECT SUM(salary)/30500 AS 'Increase in salary in %' FROM teacher;

SELECT acronym, section, fname, sex, salary, competence
FROM teacher
ORDER BY salary DESC;

