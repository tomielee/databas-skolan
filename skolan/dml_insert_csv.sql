--
-- ALL ddl-commands in one file. 
-- Insert adata to kurs and kurstillfalle from csv-file (export från excel)
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-12

-- delete if any
DELETE FROM kurstillfalle;
DELETE FROM kurs;

-- insert

LOAD DATA LOCAL INFILE 'kurs.csv'
INTO TABLE kurs
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;

    
LOAD DATA LOCAL INFILE 'kurstillfalle.csv'
INTO TABLE kurstillfalle
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(kurskod, kursansvarig, lasperiod)
;

-- SELECT * FROM kurs;
-- SELECT * FROM kurstillfalle;
-- SHOW WARNINGS ;
