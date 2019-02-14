--
--  ALL ddl-commands in one file. 
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-12

-- from ddl.sql and ddl_more_tables.sql

-- 1 >> DROP i början
SET NAMES 'utf8'; 
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS teacher_pre;

DROP VIEW IF EXISTS v_name_age;
DROP VIEW IF EXISTS v_larare;
DROP VIEW IF EXISTS v_lonerevision;


-- 2 >> CREATE
-- tabellen teacher uppdateras med rätt enginge, charset och collate så skippas updpateringen.
-- även från ddl_migrate.sql med alter table för competence integreras från början
CREATE TABLE teacher
(
    acronym CHAR(3),
    section CHAR(4),
    fname VARCHAR(20),
    sirname VARCHAR(20),
    sex CHAR(1),
    salary INT,
    birth DATE,
    competence INT DEFAULT 1 NOT NULL,

    PRIMARY KEY (acronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

CREATE TABLE kurs
(
	kod CHAR(6) NOT NULL,
    namn VARCHAR(40),
    poang FLOAT,
    niva CHAR(3),
    
    PRIMARY KEY (kod)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

CREATE TABLE kurstillfalle
(
	id INT NOT NULL AUTO_INCREMENT,
    kurskod CHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES teacher(acronym)
) 
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- From ddl_copy.sql (drop i början av filen)
CREATE TABLE teacher_pre LIKE teacher;

-- 3 >>> VYER från dml.view.sql och dml_join.sql
-- DROP i början av filen

-- 
-- VIEW v_name_age
CREATE VIEW v_name_age 
AS
SELECT 
	CONCAT_WS(" ", fname, sirname, CONCAT('(', LOWER(section), ')')) AS 'Name Section',
	TIMESTAMPDIFF(YEAR, birth, CURDATE())AS 'Age'
FROM teacher
;

SELECT * FROM v_name_age;

--
-- VIEW v_larare
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

--
-- VIEW v_lonerevision
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
 	ROUND(
		(t.salary - p.salary) / p.salary * 100
        , 2)
        AS "proc"
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
    Nowsal - Presal AS "Diff salary",   
    proc,
    IF (proc < 3, 'nok', 'ok') AS "mini"
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