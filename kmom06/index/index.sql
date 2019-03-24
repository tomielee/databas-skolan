--
-- Index and prestanda
-- For kmom06
-- By Jen Lee, course databas v
-- 2018-03-20

USE dbwebb;

CREATE USER IF NOT EXISTS 'user'
IDENTIFIED
BY 'pass'
;

GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'
;

-- CREATE TABLE course_idx 
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#testabell
DROP TABLE IF EXISTS `course_idx`;

CREATE TABLE `course_idx`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
    `name` VARCHAR(60)
);

DELETE FROM course_idx;
INSERT INTO course_idx
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

-- SELECT * FROM course_idx;

-- EXPLAIN 
-- EXPLAIN OCH DESCRIBE UNGEFÄR SAMMA
-- EXPLAIN anväds mer till select, delete, insert, replace och update statments
-- DESCRIBE används för att visa hur en viss query kommer exekveras
-- -- -- -- SYNTAX https://dev.mysql.com/doc/refman/8.0/en/explain.html
-- Ger info om hur tabellen är struktueraad
-- En fråga till frågeoptimereraen.

EXPLAIN course_idx;

-- select_type = simple när det inte finns några join subquery osv.
EXPLAIN SELECT * FROM course_idx;

-- SÄTTER PRIMARY KEY
-- code är unikt och får bli primärnyckel.
-- en primärnyckel skapar per auto index.
-- EXPLAIN SELECT * FROM course_idx WHERE code = "PA1444";

ALTER TABLE course_idx ADD PRIMARY KEY(code);

-- EXPLAIN SELECT * FROM course_idx WHERE code = "PA1444";
-- EXPLAIN course_idx;

-- Genom att säta code som en primänyckel så undiviks "full table scan" när vi söker med code.
-- Om vi däremot söker på nick så är vi tillbaka i full tabel scan.
-- använd därför
-- 
-- INDEX med UNIQUE
--
-- EXPLAIN SELECT * FROM course_idx WHERE nick = 'dbjs';

ALTER TABLE course_idx ADD CONSTRAINT nick_unique UNIQUE (nick);
-- EXPLAIN SELECT * FROM course_idx WHERE nick = 'dbjs';


-- VISA INDEX
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#dropindex
SHOW INDEX FROM course_idx;

DROP INDEX nick_unique ON course_idx;

SHOW INDEX FROM course_idx;

-- ett alternativ till ALTER TABLE för at skapa unikt index
CREATE UNIQUE INDEX nick_unique ON course_idx(nick);

-- ISTÄLLET för alla alter och create kan vi skpa index redan när vi skapar tabellen...
DROP TABLE IF EXISTS `course_idx`;
CREATE TABLE `course_idx`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
    `name` VARCHAR(60),
    
    PRIMARY KEY (`code`),
    UNIQUE KEY `nick_unique` (`nick`)
);

DELETE FROM course_idx;
INSERT INTO course_idx
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;
-- Det är nu opimterat för sökning på nick och sökning av code. 
--
-- Index för DELSÖKNING
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#strinindex
SELECT * FROM course_idx WHERE name LIKE 'Webb%';
-- Hur många rader behövdes besökas för at få fram svaret på 3 rader? HELA TABELLEN 9 rader.
EXPLAIN SELECT * FROM course_idx WHERE name LIKE 'Webb%';
-- Skapa INDEX
CREATE INDEX index_name ON course_idx(name);
-- Samma test! 3 rader!
EXPLAIN SELECT * FROM course_idx WHERE name LIKE 'Webb%';
-- Fungerar dock inte med 'Python' eller annat... 
EXPLAIN SELECT * FROM course_idx WHERE name LIKE '%Python%';


-- FULL TEXT INDEX
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#fulltext
CREATE FULLTEXT INDEX full_name ON course_idx(name);
SELECT name, 
MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score 
FROM course_idx
ORDER BY score DESC;

-- INDEX FOR NUMBERS
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#larger
-- före
EXPLAIN SELECT * FROM course_idx WHERE points > 7.5;
-- Skapa index för po9ints
CREATE INDEX index_points ON course_idx(points);
-- efter
EXPLAIN SELECT * FROM course_idx WHERE points > 7.5;



-- VISA OCH TA BORT INDEX
SHOW INDEX FROM course_idx;

-- Att ta bort
-- DROP INDEX full_name ON course_idx;


-- EFTER att ha tagit bort och lagt till en massa kan vi få fram hela koden för att skapa tabellen
--
-- CREATE TABLE
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#createtable
--
SHOW CREATE TABLE course_idx;

DROP TABLE IF EXISTS course_idx;

CREATE TABLE `course_idx` (
  `code` char(6) NOT NULL,
  `nick` char(12) DEFAULT NULL,
  `points` decimal(3,1) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `nick_unique` (`nick`),
  KEY `index_name` (`name`),
  KEY `index_points` (`points`),
  FULLTEXT KEY `full_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM course_idx;
INSERT INTO course_idx
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;
-- LOGGA FRÅGOR
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql#logga

-- SET profiling = 1;

-- SELECT * FROM course_idx WHERE nick = 'dbjs';
-- SELECT * FROM course_idx WHERE name LIKE 'Webb%';
-- SELECT name, MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score FROM course_idx ORDER BY score DESC;

-- SHOW PROFILES;

