-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS eshop;

-- USE eshop
USE eshop;


-- CREATE USER "user" with password "pass"
-- With all access. 
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
BY 'pass'
;

GRANT ALL PRIVILEGES
    ON eshop.*
    TO 'user'@'%'
;
