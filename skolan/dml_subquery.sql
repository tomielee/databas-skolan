--
-- Subquery tables larare (aka teacher) kurs and kurstillfalle
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-13

-- Välj alla kurstillfällen som hålls av lärare på avdelningen DIDD


SELECT 
	* 
FROM kurstillfalle
WHERE
	kursansvarig IN(
		SELECT
			acronym
		FROM teacher
		WHERE
			section = 'DIDD'
	)
;

-- SELECT
--    kt.id,
--    kt.kurskod,
--    kt.kursansvarig,
--    kt.lasperiod
-- FROM kurstillfalle as kt
-- 	JOIN teacher as t
-- 		ON kt.kursansvarig = t.acronym
-- WHERE 
-- 	t.section = 'DIDD'
-- ;

(
    SELECT acronym, section FROM teacher WHERE section = 'DIDD'
)
UNION
(
    SELECT acronym, section FROM teacher WHERE section = 'DIPT'
)
;

SELECT
	acronym,
    fname,
    sirname,
	Age
FROM v_larare
WHERE
	Age IN (
    SELECT
		MAX(Age)
	FROM v_larare
    )
;
