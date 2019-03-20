--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-05
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/joina-tabell

-- Visa de lärare som inte har fått en löneökning om minst 3%.
-- Gör en rapport som visar hur många % respektive lärare fick i löneökning.

--
-- JOIN
--
SELECT
    t.acronym,
    t.salary,
    t.competence,
    p.salary AS "pre-sal",
    p.competence AS "pre-comp"
FROM teacher AS t
    JOIN teacher_pre AS p
        ON t.acronym = p.acronym
ORDER BY acronym
;

-- Skapa rapporten som visar resultatet enligt nedan.
-- DROP VIEW IF EXISTS v_lonerevision;
-- CREATE VIEW v_lonerevision
-- AS
-- SELECT
-- 	t.acronym AS Acro,
--     t.fname AS Fname,
--     t.sirname AS SName,
--     p.salary AS Presal,
--     t.salary AS Nowsal,
--     p.competence AS Precomp,
--     t.competence AS Nowcomp,
--  	ROUND(
-- 		(t.salary - p.salary) / p.salary * 100
--         , 2)
--         AS "proc"
-- FROM teacher AS t
-- 	JOIN teacher_pre AS p
-- 		ON t.acronym = p.acronym
-- ORDER BY proc DESC;

 DROP VIEW IF EXISTS v_lonerevision;
CREATE VIEW v_lonerevision
AS
SELECT
	t.acronym AS Acro,
    t.fname AS Fname,
    t.sirname AS SName,
    p.salary AS Presal,
    t.salary AS Nowsal,
    p.competence AS Precomp,
    t.competence AS Nowcomp,
    t.salary - p.salary as Diff,
 	ROUND(
		(t.salary - p.salary) / p.salary * 100
        , 2)
        AS "proc",
	IF (ROUND(
		(t.salary - p.salary) / p.salary * 100
        , 2) < 3, 'nok', 'ok') AS "mini"
FROM teacher AS t
	JOIN teacher_pre AS p
		ON t.acronym = p.acronym
ORDER BY proc DESC;

-- Show diff in salary 
SELECT 
	Acro,
    Fname,
    Sname,
    Presal,
    Nowsal,
    Diff , 
    proc,
    mini
 FROM v_lonerevision;

-- Show diff in competence
SELECT
	Acro,
    Fname,
    Sname,
    Precomp,
    Nowcomp,
    Nowcomp - Precomp AS Diffcomp
FROM v_lonerevision
ORDER BY Nowcomp DESC, Diffcomp DESC;
	

-- Spara rapporten som en vy v_lonerevision.