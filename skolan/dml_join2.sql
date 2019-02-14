--
-- JOIN tables larare (aka teacher) kurs and kurstillfalle
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-13

--
-- CROSSJOIN
-- SELECT * FROM kurs, kurstillfalle;
--
-- CROSS JOIN med WHERE

SELECT * 
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;

--
-- Join using JOIN..ON
--
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod;
        
--
-- Join three tables
-- Får dubbla info p g a * 
--
-- SELECT *
-- FROM kurs AS k
--    JOIN kurstillfalle AS kt
--        ON k.kod = kt.kurskod
--    JOIN teacher AS t
--        ON t.acronym = kt.kursansvarig;
	
-- Skapa en vy
DROP VIEW IF EXISTS v_planering;
CREATE VIEW v_planering 
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN teacher AS t
        ON t.acronym = kt.kursansvarig;
        
-- Vy för lärares arbetsbelastning
SELECT
	t.acronym,
    CONCAT_WS(' ', t.fname, t.sirname) AS Name,
    COUNT(*) AS 'Tillfallen'
FROM teacher AS t
	JOIN kurstillfalle AS kt
		ON t.acronym = kt.kursansvarig
GROUP BY t.acronym
ORDER by Tillfallen DESC
;

-- Vy för lärares ålder
-- de kurser där som har de tre äldsta lärarna som ansvariga.
--     DATE_FORMAT(birth, '%Y %m %d') AS birth,

DROP VIEW IF EXISTS v_oldest;
CREATE VIEW v_oldest
AS
SELECT
	acronym,
    TIMESTAMPDIFF(YEAR, birth, CURDATE())AS 'Age'
FROM v_planering
GROUP BY acronym
ORDER BY AGE DESC LIMIT 3;

-- SELECT * FROM v_oldest; bara för att kolla

-- RÄTT SÄTT ATT GÖRA DET PÅ °°°
SELECT
	CONCAT_WS(' ', vp.namn, CONCAT('(',vp.kod,')')) AS kurs,
    CONCAT_WS(' ', vp.fname, vp.sirname) AS Larare,
    vo.Age
FROM v_planering AS vp
	JOIN v_oldest AS vo
		ON vp.acronym = vo.acronym;

-- FULT SÄTT ATT GÖRA DET PÅ °°°
SELECT
	CONCAT_WS(' ', k.namn, CONCAT('(',k.kod,')')) AS kurs,
    CONCAT_WS(' ', t.fname, t.sirname) AS Larare,
    TIMESTAMPDIFF(YEAR, birth, CURDATE())AS 'Age'
FROM teacher AS t
	JOIN kurstillfalle as kt
		ON t.acronym = kt.kursansvarig
        JOIN kurs as k
			ON k.kod = kt.kurskod
ORDER BY Age DESC LIMIT 6;













