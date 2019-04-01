--
-- SETUP
-- KMOM10/PREP
-- Förberedelsetenta från 2018
-- https://dbwebb.se/kurser/databas-v1/kmom10/tentamen/en-japansk-smakresa 
-- By Jen Lee, course databas v
-- 2018-03-26


--
-- CREATE DATABASE
-- 
DROP DATABASE IF EXISTS exam;
CREATE DATABASE exam;
SHOW WARNINGS;


USE exam;


-- CREATE USER "user" with password "pass"
-- With all access. 
DROP USER IF EXISTS 'user';
CREATE USER IF NOT EXISTS 'user'
IDENTIFIED
BY 'pass'
;
SHOW WARNINGS;

GRANT ALL PRIVILEGES
    ON exam.*
    TO 'user'@'%'
;

-- 
-- local_inile = 1 to be able to load local file
-- Maybe unecessery for exam
SET GLOBAL local_infile = 1;


GRANT TRIGGER ON *.* TO 'user'@'%';

