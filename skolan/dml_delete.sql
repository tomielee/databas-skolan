--
-- Delete from database skolan
-- By Jen Lee, course databas v1
-- 2018-01-24
--

-- Delte rows from table - according to kmom01
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/ta-bort-rader
--

-- Delete Hagrid
DELETE FROM teacher WHERE fname = 'Hagrid';

-- Delete all from section DIPT
DELETE FROM teacher WHERE section = 'DIPT';

-- Delete all with salary, limit to 2 rows
DELETE FROM teacher WHERE salary LIMIT 2;

-- Delete the rest
DELETE FROM teacher;