--
-- Insert values into table teacher in database skolan
-- By Jen Lee
-- 2018-01-24
--

DELETE FROM teacher;

--
-- Add personel
--
INSERT INTO teacher VALUES ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01');
INSERT INTO teacher VALUES ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01');
INSERT INTO teacher VALUES ('min', 'DIDD', 'Minerva', 'McGonagall', 'F', 40000, '1955-05-05');

-- Other ways to add personal to table
INSERT INTO teacher VALUES
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06'),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06'),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'F', 35000, '1948-04-08')
;

INSERT INTO teacher
	(acronym, section, fname, sirname, sex, birth)
VALUES
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', '1943-04-03')
;