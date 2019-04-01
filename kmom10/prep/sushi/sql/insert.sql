--
-- INSERT
-- content for database sushi
-- KMOM10/PREP
-- Förberedelsetenta från 2018
-- https://dbwebb.se/kurser/databas-v1/kmom10/tentamen/en-japansk-smakresa 
-- By Jen Lee, course databas v
-- 2018-03-26

-- Insert all data for database exam
--

--
-- delete all content
--
DELETE FROM sushi_2_comp;
ALTER TABLE sushi_2_comp AUTO_INCREMENT = 1;

DELETE FROM sushi;
ALTER TABLE sushi AUTO_INCREMENT = 1;

DELETE FROM comp;
ALTER TABLE comp AUTO_INCREMENT = 1;



-- 
-- Load in data for SUSHI
LOAD DATA LOCAL INFILE 'sushi.csv'
INTO TABLE sushi
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(sushiname, info, created)
SET id = NULL
;


UPDATE sushi 
SET 
	picture = CONCAT(ID, ".jpg");

SHOW WARNINGS;
SELECT * FROM sushi;



--
-- Load in data for competition
LOAD DATA LOCAL INFILE 'comp.csv'
INTO TABLE comp
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(compname, info, compdate)
SET id = NULL
;


--
-- Load in data for sushi_2_comp
LOAD DATA LOCAL INFILE 'sushi_2_comp.csv'
INTO TABLE sushi_2_comp
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(s_id, c_id)
SET id = NULL
;