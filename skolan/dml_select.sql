--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-01-24

-- Visa alla rader i tabellen där avdelningen är DIDD.
SELECT * FROM teacher
	WHERE section = 'DIDD';
-- Visa de rader som har en akronym som börjar med bokstaven ‘h’ (ledtråd LIKE).
SELECT * FROM teacher
	WHERE acronym LIKE 'h%';

-- Visa de rader vars lärares förnamn innehåller bokstaven ‘o’.
SELECT * FROM teacher
	WHERE fname LIKE '%o%';
-- Visa de rader där lärarna tjänar mellan 30 000 - 50 000.
SELECT * FROM teacher
		WHERE salary BETWEEN 30000 AND 50000;

-- Visa de rader där lärarens kompetens är mindre än 7 och lönen är större än 40 000.
SELECT * FROM teacher
	WHERE competence < 7 AND salary > 40000;

-- Visa rader som innehåller lärarna sna, dum, min (ledtråd IN).
SELECT * FROM teacher
        WHERE acronym IN('sna', 'dum', 'min');

-- Visa de lärare som har lön över 80 000, tillsammans med de lärare som har en kompetens om 2 och jobbar på avdelningen ADM.
SELECT * FROM teacher
        WHERE salary > 80000
			OR competence = 2
            AND section = 'ADM';

-- Skriv endast ut namnen på alla lärare och vad de tjänar.
SELECT fname, sirname, salary FROM teacher;

-- Sortera listan på efternamnet, både i stigande och sjunkande ordning.
SELECT fname, sirname, salary FROM teacher ORDER BY sirname DESC;
SELECT fname, sirname, salary FROM teacher ORDER BY sirname;

-- Sortera listan på lönen, både i stigande och sjunkande ordning. Vem tjänar mest och vem tjänar minst?
SELECT fname, sirname, salary FROM teacher ORDER BY salary;
SELECT fname, sirname, salary FROM teacher ORDER BY salary DESC;

-- Välj ut de tre som tjänar mest och visa dem (ledtråd LIMIT).
SELECT fname, sirname, salary FROM teacher ORDER BY salary DESC LIMIT 3;

--
-- Change name of a column
SELECT
	fname AS 'Teacher',
    salary AS 'Sal'
FROM teacher;
