--
-- ALL ddl-commands in one file. 
-- Insert all data in one file. EXCEPT for dml_update_lonerevision.sql
-- For kmom03 databas 
-- By Jen Lee, course databas v1
-- 2018-02-12


-- from dml_insert.sql
DELETE FROM teacher;
DELETE FROM teacher_pre;


INSERT INTO teacher
	(acronym, section, fname, sirname, sex, salary, birth)
VALUES
	('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01'),
	('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01'),
	('min', 'DIDD', 'Minerva', 'McGonagall', 'F', 40000, '1955-05-05'),
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06'),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06'),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'F', 35000, '1948-04-08'),
	('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', 30000, '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', 30000, '1943-04-03')
;

-- INSERT INTO teacher
--  	(acronym, section, fname, sirname, sex, birth)
-- VALUES 
--     ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', '1952-05-02'),
--     ('ala', 'DIPT', 'Alastor', 'Moody', 'M', '1943-04-03')
-- ;

-- from dml_update (set sal. before sal.revision)
-- UPDATE teacher 
-- 	SET salary = 30000 
-- 		WHERE 
--         acronym IN('gyl', 'ala')
--         OR
--         salary is NULL;
        
-- from ddl_copy.sql 
INSERT INTO teacher_pre SELECT * FROM teacher;

SELECT acronym, section, fname, sex, salary, competence
FROM teacher
ORDER BY salary DESC;