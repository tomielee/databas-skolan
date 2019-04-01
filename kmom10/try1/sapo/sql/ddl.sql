--
-- DDL för databasen sapo
-- Databasens schema, tabeller, views, procedurer, triggers och loggar
-- Examinationstenta kmom10, databas v1
-- Jennifer Lee - jelf18
-- 2019 - 03 - 28
--


-- ----------------------------------------------- TABLES
-- alla drop i början.

DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS organisation;
DROP TABLE IF EXISTS org;
DROP TABLE IF EXISTS person;


--
-- Create table person (id)
--
CREATE TABLE person (
	id VARCHAR(5),
    fornamn VARCHAR(20),
    efternamn VARCHAR(30),
    
    PRIMARY KEY(id)
);

--
-- Create table organisation (id)
--
CREATE TABLE org (
	id VARCHAR(5),
    namn VARCHAR(30),
    
    PRIMARY KEY(id)	
);

--
-- Create table kategori (id)
--
CREATE TABLE kategori (
    typ VARCHAR(20),
    niva INT,
    
    PRIMARY KEY(typ)    
);

--
-- Create table logg (id, #kategori_typ, #person_id, #organisation_id)
--
CREATE TABLE logg (
	id INT,
    kategori_typ VARCHAR(20),
    person_id VARCHAR(5),
    org_id VARCHAR(5),
    vad VARCHAR(200),
    
    PRIMARY KEY(id),
    FOREIGN KEY (kategori_typ) REFERENCES kategori(typ),
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (org_id) REFERENCES org(id)
);

SHOW WARNINGS;

-- ----------------------------------------------- VIEWS

-- v_person
-- ALL from person 
-- + fullname
--
DROP VIEW IF EXISTS v_person;
CREATE VIEW v_person
AS
	SELECT *,
		CONCAT(fornamn, " ", efternamn) AS namn
    FROM person;
    
    
-- v_logg
-- ALL from logg
--
DROP VIEW IF EXISTS v_logg;
CREATE VIEW v_logg
AS
	SELECT 
		id AS loggid,
        kategori_typ as kategorityp,
        person_id AS personid,
        org_id AS orgid,
        vad AS vad
    FROM logg;


-- v_show_logg_extra
-- all from logg 
-- + all from person 
-- + all from organisation 
-- + all from kategori
--
DROP VIEW IF EXISTS v_show_logg_extra;
CREATE VIEW v_show_logg_extra
AS
	SELECT
		l.loggid,
        l.kategorityp,
        l.personid,
        l.orgid,
        l.vad,
		o.namn AS orgnamn, 
        p.namn AS namn,
        k.niva AS niva
	FROM v_logg AS l
		JOIN org AS o
			ON l.orgid = o.id
		JOIN v_person AS p
			ON l.personid = p.id
		JOIN kategori AS k
			ON l.kategorityp = k.typ;

-- v_show_logg_extra_t
-- view for terminal with all from logg + person + organisation + kategori
-- nicer headlines but not workable with js.
DROP VIEW IF EXISTS v_show_logg_extra_t;
CREATE VIEW v_show_logg_extra_t
AS
	SELECT
		loggid AS "LoggID",
        kategorityp AS "Kategorityp",
        niva AS "Nivå",
        orgid AS "Org.ID",
        orgnamn AS "Organisationsnamn",
        personid AS "Pers.ID",
        namn AS "Personnamn", 
        vad AS "Notering vad som hände"
	FROM v_show_logg_extra;
    
    
-- UPPGIFT 3
-- skapa två vyer, en för person och en för organisation.
-- joina enligt spec.

-- 1. View för person
-- Skapar en view för person.
DROP VIEW IF EXISTS v_pers;
CREATE VIEW v_pers
AS
	SELECT
		p.id AS Personid,
		CONCAT(p.fornamn, " ", p.efternamn, " (", p.id, ")") AS Namn,
		COUNT(l.id) AS Antal
	FROM person AS p
		LEFT OUTER JOIN logg AS l
			ON p.id = l.person_id
	GROUP BY Namn, personid
	ORDER BY Namn DESC;

-- 2. View för organsation
DROP VIEW IF EXISTS v_org;
CREATE VIEW v_org
	AS
	SELECT 
		l.person_id,
		GROUP_CONCAT(
		DISTINCT o.namn
		ORDER BY o.namn DESC SEPARATOR ' + ') AS Organsation
	FROM logg AS l
		JOIN org as o
			ON l.org_id = o.id
	GROUP BY l.person_id;

-- 3. Joina för att få EXAKT tabell
-- joins v_person och v_org
DROP VIEW IF EXISTS v_rapport;
CREATE VIEW v_rapport
AS
	SELECT 
		p.Namn,
		p.Antal,
		o.Organsation
	FROM v_pers AS p
		LEFT OUTER JOIN v_org AS o
			ON p.Personid = o.person_id
	ORDER BY Namn DESC;
        

-- ----------------------------------------------- PROCEDURES
-- ----------------------------------------------- 


-- PROCEDURE show_log
-- som visar en rapport från tabellen logg tillsammans med organisationens namn, personens fulla namn och nivå på brottskategorin.
DROP PROCEDURE IF EXISTS show_logg;
DELIMITER ;;
CREATE PROCEDURE show_logg(
)
BEGIN
	SELECT
		*
	FROM v_show_logg_extra;
		          
END
;;

DELIMITER ;

CALL show_logg();


-- PROCEDURE show_logg_terminal
-- Samma som show_logg snyggare rubriker till tabellen i terminalklienten.

DROP PROCEDURE IF EXISTS show_logg_terminal;
DELIMITER ;;
CREATE PROCEDURE show_logg_terminal(
)
BEGIN
	SELECT
	*
	FROM v_show_logg_extra_t;
END
;;

DELIMITER ;



--  PROCEDURE show_logg_search 
-- I webbklienten, skapa routen sapo/search där man i ett formulär kan ange en söksträng. 
-- visar logg filtrerad på input sökstring
-- Man skall kunna söka på delsträngar av 
-- kategorier, säkerhetsnivån == kategorityp, niva
-- personer (id, fornamn, efternamn) == namn personid
-- organisationer (id, namn) == orgid, orgnamn
-- loggtexten (vad) == vad
-- samt exakt sökning på säkerhetsnivån (kategorin) == se ovan under kategori

DROP PROCEDURE IF EXISTS show_logg_search;
DELIMITER ;;
CREATE PROCEDURE show_logg_search(
	a_search VARCHAR(300)
)
MAIN: BEGIN
	DECLARE current_search VARCHAR(30);
    
    SELECT CONCAT('%', a_search, '%') INTO current_search;

	SELECT * FROM v_show_logg_extra
    WHERE kategorityp LIKE current_search
    OR niva LIKE current_search
    OR namn LIKE current_search
    OR personid LIKE current_search
    OR orgid LIKE current_search
    OR orgnamn LIKE current_search
    OR vad LIKE current_search
	ORDER BY loggid;

END
;;

DELIMITER ;


--  PROCEDURE show_logg_search_terminal
--  samma som show_logg_search men med snyggar rubriker.

DROP PROCEDURE IF EXISTS show_logg_search_t;
DELIMITER ;;
CREATE PROCEDURE show_logg_search_t(
	a_search VARCHAR(300)
)
MAIN: BEGIN
	DECLARE current_search VARCHAR(30);
    
    SELECT CONCAT('%', a_search, '%') INTO current_search;

	SELECT 
	*
	FROM v_show_logg_extra
    WHERE kategorityp LIKE current_search
    OR niva LIKE current_search
    OR namn LIKE current_search
    OR personid LIKE current_search
    OR orgid LIKE current_search
    OR orgnamn LIKE current_search
    OR vad LIKE current_search
	ORDER BY loggid;

END
;;

DELIMITER ;


-- 
-- PROCEDURE show_rapport
-- uppgift 3 show rapport to boss
--
DROP PROCEDURE IF EXISTS show_rapport;
DELIMITER ;;
CREATE PROCEDURE show_rapport(
)
BEGIN
	SELECT * FROM v_rapport;
END
;;
DELIMITER ;











