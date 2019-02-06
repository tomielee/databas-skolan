--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-05

-- Skriv en SELECT-sats som skriver ut förnamn + efternamn + avdelning i samma kolumn enligt följande struktur: förnamn efternamn (avdelning). (Tips: Att slå ihop strängar kallas att konkatenera/concatenate).
SELECT 
	CONCAT_WS(" ", fname, sirname, CONCAT('(', section, ')')) AS 'Name Section'
FROM teacher
;

-- Gör om samma sak men skriv ut avdelningens namn med små bokstäver och begränsa utskriften till 3 rader.
SELECT 
	CONCAT_WS(" ", fname, sirname, CONCAT('(', LOWER(section), ')')) AS 'Name Section'
FROM teacher LIMIT 3
;

-- Skriv en SELECT-sats som endast visar dagens datum. https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/inbyggda-funktioner#datum
SELECT NOW() AS 'Todays date and time';

-- Gör en SELECT-sats som visar samtliga lärare, deras födelseår samt dagens datum och klockslag.
SELECT
	fname AS 'Name',
    birth AS Birth,
    CURRENT_DATE() AS 'Date',
    CURRENT_TIME() AS 'Time'
FROM teacher
;

-- Skriv en SELECT-sats som beräknar lärarens ålder, sortera rapporten för att visa vem som är äldst och yngst.
SELECT
	fname AS 'Name',
    TIMESTAMPDIFF(YEAR, birth, CURDATE())AS 'Age',
    birth AS Birth,
    CURDATE() AS 'Date',
    CURTIME() AS 'Time'
FROM teacher
ORDER BY Age DESC
;

-- Visa de lärare som är födda på 40-talet.
SELECT
	fname AS 'Name',
    YEAR(birth) AS 'Year'
FROM teacher
WHERE YEAR(birth) BETWEEN 1940 and 1949
;



