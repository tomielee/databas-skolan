--
-- INSERT för databasen sapo
-- Data från läses från filer.
-- Examinationstenta kmom10, databas v1
-- Jennifer Lee - jelf18
-- 2019 - 03 - 28


-- Ta bort all data innan den laddas in så att det inte blir dubbelt...
-- tar bort från logg först p g a har kopplingar till person, organisation och kategori.
-- 
DELETE FROM logg;
ALTER TABLE logg AUTO_INCREMENT = 1;

DELETE FROM person;
DELETE FROM org;
DELETE FROM kategori;


-- INSERT data into person 
LOAD DATA LOCAL INFILE 'person.csv'
INTO TABLE person
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;


-- INSERT data into organisation 
LOAD DATA LOCAL INFILE 'org.csv'
INTO TABLE org
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;




-- INSERT data into kategori 
LOAD DATA LOCAL INFILE 'kategori.csv'
INTO TABLE kategori
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;
-- SHOW WARNINGS;

-- INSERT data into logg 
-- GOT id as auto_increment
LOAD DATA LOCAL INFILE 'logg.csv'
INTO TABLE logg
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;

-- SHOW WARNINGS

