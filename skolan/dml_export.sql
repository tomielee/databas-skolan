--
-- Export rapport to Excel
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-13

-- Det finns en option --batch till terminalklienten som skriver ut samma sak men tab-separerad, varje fält 
-- är separerat av en tabb \t.
-- mysql -uuser -ppass skolan -e "SELECT * FROM teacher LIMIT 3;" --batch
-- mysql -uuser -ppass skolan -e "SELECT * FROM teacher LIMIT 3;" --batch > report.xls

SELECT * FROM teacher LIMIT 3;