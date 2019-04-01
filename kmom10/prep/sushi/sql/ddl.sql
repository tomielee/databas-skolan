--
-- DML
-- EXTRA SQL code
-- KMOM10/PREP
-- Förberedelsetenta från 2018
-- https://dbwebb.se/kurser/databas-v1/kmom10/tentamen/en-japansk-smakresa 
-- By Jen Lee, course databas v
-- 2018-03-26


-- DROP VIEW IF EXISTS v_all_sushi;
-- CREATE VIEW v_all_sushi
-- AS
-- 	SELECT
-- 		id,
-- 		sushiname,
--         DATE_FORMAT(created, '%d %M %Y') AS created,
--         picture
--     FROM sushi;


-- SELECT * FROM  v_all_sushi;

-- CALL show_all_sushi();

-- SELECT * FROM comp;
-- CALL show_all_comp();


SELECT
	s.id AS sushiid,
	s.sushiname,
	s.info as sushiinfo,
	s.created,
    c.id AS compid,
    c.compname,
    c.info AS compinfo,
    c.compdate
FROM sushi_2_comp AS sc
	JOIN sushi AS s
        ON sc.s_id = s.id
	JOIN comp as c
		ON sc.c_id = c.id
WHERE sc.c_id = 1;