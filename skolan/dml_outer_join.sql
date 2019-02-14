--
-- OUTER JOIN tables larare (aka teacher) kurs and kurstillfalle
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-13

SELECT DISTINCT 
	acronym AS Acronym,
    CONCAT(fname, " ", sirname) AS Name
FROM v_planering
ORDER BY Acronym;

-- OUTER JOIN
-- Vid OUTER JOIN så utgår uttrycket i någon av tabellerna, den vänstra eller den högra, 
-- och kör enligt “för alla rader i tabell A, visa dem oavsett om de matchar någon rad i tabell B”.
SELECT DISTINCT
	t.acronym AS Acronym,
    CONCAT(fname, " ", sirname) AS Name,
    t.section AS Section,
    kt.kurskod AS Kurskod
FROM teacher as t
	LEFT OUTER JOIN kurstillfalle AS kt
		ON t.acronym = kt.kursansvarig
;

SELECT DISTINCT
	t.acronym AS Acronym,
    CONCAT(fname, " ", sirname) AS Name,
    t.section AS Section,
    kt.kurskod AS Kurskod
FROM teacher as t
	RIGHT OUTER JOIN kurstillfalle AS kt
		ON t.acronym = kt.kursansvarig
;

-- Kurser utan kurstillfällen
SELECT DISTINCT
	k.kod,
    k.namn AS Kursnamn,
    kt.lasperiod AS 'Lasperiod'
FROM kurstillfalle as kt
	RIGHT OUTER JOIN kurs AS k
		ON k.kod = kt.kurskod
WHERE Lasperiod IS NULL
;
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/outer-join#summering
-- Om INNER JOIN.
-- En JOIN, eller INNER JOIN, visar de rader som kan matchas mellan tabellerna. 
-- Finns det ingen matchning så visas inte raden.
-- -- Om OUTER JOIN.
-- OUTER JOIN visar resultat för alla rader i en tabell, även om det inte finns
-- en matchande rad i den andra tabellen.
-- LEFT/RIGHT bestämmer vilken tabell som OUTER JOIN utgår från.
-- För alla rader i den vänstra/högra tabellen, visa samtliga rader i den 
-- tabellen inklusive värden från den joinade tabellen. Visa NULL om koppling saknas.
