--
-- Transaktioner i databas
-- For kmom04
-- By Jen Lee, course databas v
-- 2018-02-14

USE dbwebb;

--
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
	'id' CHAR(4) PRIMARY KEY,
    'name' VARCHAR(8),
    'balance' DECIMAL(4, 2)
);

-- DELETE FROM account;
INSERT INTO account
VALUES
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;

SELECT * FROM account;