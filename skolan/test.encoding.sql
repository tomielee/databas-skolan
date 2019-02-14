--
-- CHARCTER SET ADN COLLATION
-- By Jen Lee, course databas v1
-- 2018-0212
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/teckenkodning

-- manualen: https://dev.mysql.com/doc/refman/8.0/en/charset-mysql.html
SET NAMES 'utf8';

-- skapa tabell med å ä ö
DROP TABLE IF EXISTS person;
CREATE TABLE person
(
	fornamn VARCHAR(10)
);

-- insert value i tabellen
INSERT INTO person VALUES
("Örjan"), ("Börje"), ("Bo"), ("Øjvind"),
("Åke"), ("Åkesson"), ("Arne"), ("Ängla"),
("Ægir")
;

-- SELECT * FROM person;
SELECT * FROM person
	ORDER BY fornamn;
    
-- SHOW CREATE TABLE person;
-- SHOW CHARSET LIKE 'latin1';
-- SHOW COLLATION WHERE Charset = 'latin1';
-- SHOW CHARSET LIKE 'utf8';
-- SELECT HEX("©");

-- KOLLA VILKA COLLATIONS SOM ÄR TILLgängliga
-- SHOW COLLATION WHERE Charset = 'utf8';


ALTER TABLE person CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

SELECT * FROM person
	ORDER BY fornamn;