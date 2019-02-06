--
-- Update/migrate from database skolan
-- By Jen Lee, course databas v1
-- 2018-01-24
--

-- Add column competence to table teacher
ALTER TABLE teacher ADD COLUMN competence INT;

-- Delete column competence in table teacher
ALTER TABLE teacher DROP COLUMN competence;

-- Add column competence again, with default as value
ALTER TABLE teacher ADD COLUMN competence INT DEFAULT 1 NOT NULL;