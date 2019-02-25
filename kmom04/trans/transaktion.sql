--
-- Transaktioner i databas
-- For kmom04
-- By Jen Lee, course databas v
-- 2018-02-14

USE dbwebb;

CREATE USER IF NOT EXISTS 'user'
IDENTIFIED
BY 'pass'
;

GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'
;

--
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
	id CHAR(4),
    name VARCHAR(8),
    balance DECIMAL(4, 2),
    
    PRIMARY KEY (id)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- INSERT to account;
INSERT INTO account
VALUES
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;
SELECT * FROM account;

-- MOVE money
-- Dock leder detta till en stund av överskott i databasen = farligt.
-- UPDATE account
-- SET
-- 	balance = balance + 1.5
-- WHERE
-- 	id = "2222";
-- UPDATE account 
-- SET
--     balance = balance - 1.5
-- WHERE
--     id = "1111";

-- SELECT * FROM account;

-- TRANSAKTION alter
-- https://dbwebb.se/kunskap/transaktioner-i-databas#flyttrans

-- MOVE money with TRANSACTION
--
START TRANSACTION;

UPDATE account
SET
	balance = balance + 1.5
WHERE id = "1111";

UPDATE account 
SET
    balance = balance - 1.5
WHERE
    id = "2222";

-- ROLLBACK gör en undo på hela sekvensen som utfördes inom tranaktionen. 
-- COMMIT utför alla ändrningar och ROLLBACK tar bort effekten av allt som utförst i transaktionen.
-- TRANSAKTION avslutas med COMMIt och avbryts med ROLLBACK.
-- https://dbwebb.se/kunskap/transaktioner-i-databas#sqlite SQLITE
COMMIT;

SELECT * FROM account;





