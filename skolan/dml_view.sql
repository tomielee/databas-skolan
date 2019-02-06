--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-05
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/vyer
-- ref: https://dev.mysql.com/doc/refman/8.0/en/create-view.html

-- Skapa vyn
DROP VIEW IF EXISTS v_name_age;

CREATE VIEW v_name_age 
AS
SELECT 
	CONCAT_WS(" ", fname, sirname, CONCAT('(', LOWER(section), ')')) AS 'Name Section',
	TIMESTAMPDIFF(YEAR, birth, CURDATE())AS 'Age'
FROM teacher
;

-- Använd vyn
-- Radera vyn med DROP VIEW, vill du ändra en befintlig vy kan du använda ALTER VIEW.
SELECT * FROM v_name_age;

-- Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare inklusive en ny kolumn med lärarens ålder.
DROP VIEW  IF EXISTS v_larare;
CREATE VIEW v_larare
AS
SELECT 
	*,
	TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS 'Age'
FROM teacher
;

SELECT * FROM v_larare;
-- Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning. Visa avdelningens namn och medelålder sorterad på medelåldern.
SELECT 
	section,
    ROUND(AVG(Age)) AS 'AVG AGE'
FROM v_larare
GROUP BY section
ORDER BY AVG(Age)
;

