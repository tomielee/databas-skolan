--
-- Create reports from table teacher from database skolan
-- 
-- By Jen Lee, course databas v1
-- 2018-02-12
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/skapa-fler-tabeller#kurs

-- Tänk på att droppa i början då kurs inte kan raderas när den är beroende i tabellen kurstillfälle
SET NAMES 'utf8'; -- kopplingen mellan klient och databas sker med UTF-ut som teckenkodning.
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;

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

-- STORAGE ENGINES https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/skapa-fler-tabeller#storage
-- utf teckenkodningen https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/skapa-fler-tabeller#ddlcharset

-- måste uppdatera tabellen "lärare" aka teacher så att de skapas med samma villkor.
ALTER TABLE teacher CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;
ALTER TABLE teacher_pre CONVERT TO CHARSET utf8 collate utf8_swedish_ci;


-- \G  istället för ; i terminalen låter MYSQL skrvita ut rad för rad.
SHOW CREATE TABLE kurs;
SHOW CREATE TABLE kurstillfalle;
