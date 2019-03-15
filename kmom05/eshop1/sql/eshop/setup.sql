--
-- SETUP for komom05 
-- eshop
-- copy from kmom04 crud 
-- 2018 - 03- 14


-- CREATE DATABASE
-- DROP DATABASE eshop;
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
