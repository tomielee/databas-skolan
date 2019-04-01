--
-- DDL
-- Create all tables for exam
-- KMOM10/PREP
-- Förberedelsetenta från 2018
-- https://dbwebb.se/kurser/databas-v1/kmom10/tentamen/en-japansk-smakresa 
-- By Jen Lee, course databas v
-- 2018-03-26

--
-- ------------------------- TABLES
-- all drops in the beginning.
--

DROP TABLE IF EXISTS sushi_2_comp;

DROP TABLE IF EXISTS sushi;
DROP TABLE IF EXISTS comp;


--
-- sushi (id)
CREATE TABLE sushi
(	
	id INT NOT NULL AUTO_INCREMENT,
    sushiname VARCHAR(30),
    info VARCHAR(300),
    created DATE,
    picture VARCHAR(100),
    
    PRIMARY KEY(id)
);

--
-- competition (id)
CREATE TABLE comp
(	
	id INT NOT NULL AUTO_INCREMENT,
	compname VARCHAR(50),
    info VARCHAR(300),
    compdate DATE,
    
    PRIMARY KEY(id)
);

--
-- sushi_2_comp
CREATE TABLE sushi_2_comp
(	
	id INT NOT NULL AUTO_INCREMENT,
	s_id INT,
    c_id INT,
    
    PRIMARY KEY(id),
    FOREIGN KEY(s_id) REFERENCES sushi(id),
    FOREIGN KEY(c_id) REFERENCES comp(id)
);


--
-- ------------------------- VIEWS
--

--
-- VIEW
-- all sushi
DROP VIEW IF EXISTS v_all_sushi;
CREATE VIEW v_all_sushi
AS
	SELECT
		id,
		sushiname,
        info,
        DATE_FORMAT(created, '%d %M %Y') AS created,
        picture
    FROM sushi;

--
-- VIEW
-- all competitions
DROP VIEW IF EXISTS v_all_comp;
CREATE VIEW v_all_comp
AS
	SELECT
		id, compname, info,
        DATE_FORMAT(compdate, '%d %M %Y') AS compdate
    FROM comp;






--
-- -------------------------PROCEDURES
-- for exam

--
-- PROCEDURE show_all_sushi
-- return all all innehåll i tabellen sushi
--
DROP PROCEDURE IF EXISTS show_all_sushi;
DELIMITER ;;
CREATE PROCEDURE show_all_sushi (
)
BEGIN

	SELECT * FROM v_all_sushi;
    
END
;;

DELIMITER ;


--
-- PROCEDURE 
-- returnerar alla tävlingar och sätter även en tävling till dagens datum enligt krav.
--
DROP PROCEDURE IF EXISTS show_all_comp;
DELIMITER ;;
CREATE PROCEDURE show_all_comp (
)
BEGIN
	-- En tävling ska ha dagens datum så detta är ingen standar bara för tenta kravet.
	UPDATE comp
		SET compdate = NOW()
	WHERE id = 2;
    
	SELECT 
    * 
    FROM v_all_comp
    ORDER BY compdate DESC;
    
END
;;

DELIMITER ;


--
-- PROCEDURE show_sushi_comp
-- returnerar kopplingesinformationen mellan sushi och comp 
--
DROP PROCEDURE IF EXISTS show_sushi_comp;
DELIMITER ;;
CREATE PROCEDURE show_sushi_comp (
	a_compid INT
)
BEGIN
	
	SELECT
		s.id AS sushiid,
		s.sushiname,
		s.info as sushiinfo_long,
		CONCAT(SUBSTRING(s.info, 1, 20), "...") as sushiinfo_short,
		s.created,
        s.picture,
		c.id AS compid,
		c.compname,
		c.info AS compinfo_long,
		CONCAT(SUBSTRING(c.info, 1, 20), "...") as compinfo_short,
		c.compdate
	FROM sushi_2_comp AS sc
		JOIN v_all_sushi AS s
			ON sc.s_id = s.id
		JOIN v_all_comp as c
			ON sc.c_id = c.id
	WHERE sc.c_id = a_compid;
END
;;

DELIMITER ;


-- PROCEDURE show_sushi_comp_t
-- TERMINALEN för att inte få med all information...
-- returnerar kopplingesinformationen mellan sushi och comp 
-- 
DROP PROCEDURE IF EXISTS show_sushi_comp_t;
DELIMITER ;;
CREATE PROCEDURE show_sushi_comp_t(
	a_compid INT
)
BEGIN
	
	SELECT
		s.sushiname AS "Name of dish",
		CONCAT(SUBSTRING(s.info, 1, 40), "...") AS "A short description",
		s.created,
		c.compname AS "Competitions name",
		CONCAT(SUBSTRING(c.info, 1, 40), "...") as "Short info of competition",
		c.compdate AS "Sate of compeition"
	FROM sushi_2_comp AS sc
		JOIN v_all_sushi AS s
			ON sc.s_id = s.id
		JOIN v_all_comp as c
			ON sc.c_id = c.id
	WHERE sc.c_id = a_compid;
END
;;

DELIMITER ;





