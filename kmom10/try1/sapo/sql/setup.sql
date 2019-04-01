--
-- SETUP för databasen sapo
-- Examinationstenta kmom10, databas v1
-- Jennifer Lee - jelf18
-- 2019 - 03 - 28


-- CREATE the database
CREATE DATABASE IF NOT EXISTS sapo;

-- SET to use the database
USE sapo;


-- CREATE USER "user" with password "pass"
-- With all access. 
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
BY 'pass'
;

GRANT ALL PRIVILEGES
    ON sapo.*
    TO 'user'@'%'
;

-- GLOBAL setup to be able to insert data from file.
SET GLOBAL local_infile = 1;

-- GRANT trigger to user
GRANT TRIGGER ON *.* TO 'user'@'%';

