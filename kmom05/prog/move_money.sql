--
-- Transaktioner i databas
-- For kmom05
-- By Jen Lee, course databas v
-- 2018-03-13


--
-- Procedure move_money()
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#create
--
-- DROP PROCEDURE IF EXISTS move_money;

-- DELIMITER ;;

-- CREATE PROCEDURE move_money(
--     --  The definition of the parameters
--     from_account CHAR(4),
--     to_account CHAR(4),
--     amount NUMERIC(4, 2)
-- )
-- BEGIN
-- -- The SQL and compund statements
-- 	SELECT from_account, to_account, amount;
-- END
-- ;;

-- DELIMITER ;


--
-- TRANSACTION  i move_money
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#move

DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;
CREATE PROCEDURE move_money(
    --  The definition of the parameters
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
-- The SQL and compund statements
	START TRANSACTION;
	
    UPDATE account
    SET
		balance = balance + amount
	WHERE
		id = to_account;
	
    UPDATE account
    SET
		balance = balance - amount
	WHERE
		id = from_account;
        
	COMMIT;
    
	SELECT * FROM account;
END
;;

DELIMITER ;


-- KOLLA OM PENGAR FINNS
-- lägga till en lokal variabel
-- och dra nytta av den med IF-sats https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#if 
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#kolla

DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;
CREATE PROCEDURE move_money(
    --  The definition of the parameters
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
-- TRANSACTION + LOCAL VARIABLE TO CHECK BALANCE
	-- en lokal variabel, max 4 digits before decimal, and 2 digits after decimal
    DECLARE current_balance NUMERIC(4, 2);
    
	START TRANSACTION;
	SET current_balance = (SELECT balance FROM account WHERE id = from_account);
    -- aktivera om du vill se SELECT current_balance;
    
    -- IF-SATS 
    IF current_balance - amount < 0 THEN
		ROLLBACK;
        SELECT 'Amount on the account is not enough';
	ELSE
		UPDATE account
		SET
			balance = balance + amount
		WHERE
			id = to_account;
		
		UPDATE account
		SET
			balance = balance - amount
		WHERE
			id = from_account;
		COMMIT;
	END IF;
    
	SELECT * FROM account;
END
;;


DELIMITER ;
--
-- Anropa move_money()
--

CALL move_money('1111', '2222', 1.5);


--
-- LOKALA VARIABLER
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#lokvar
-- olika sätt

-- ENKEL
SET @lokal = 42;
SELECT @lokal;
-- LITE KRÅNGLIGARE
SET @lokal = (SELECT 52);
SELECT @lokal;

-- LAGRA INFORMATION i fler kolumner med INTO
SELECT 42, 52 INTO @ett, @tva;
SELECT @ett AS ett, @tva AS tva;


-- IN AND OUT
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#inout
--


DROP PROCEDURE IF EXISTS get_money;

DELIMITER ;;

CREATE PROCEDURE get_money(
	IN a_account CHAR(4),
    OUT a_total NUMERIC(4, 2)
)
BEGIN
	-- lagra med INTO i variablen TOAL som används ovan i OUT
	SELECT balance INTO a_total FROM account WHERE id = account;
END 
;;

DELIMITER ;

CALL get_money('1111', @sum);
SELECT @sum;

-- SHOW WARNINGS
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#warnings

CALL edit_account('1337', 'Mega', 420000);
SHOW WARNINGS;

-- SHOW PROCEDURE
-- https://dbwebb.se/kunskap/lagrade-procedurer-i-databas#show
SHOW PROCEDURE STATUS LIKE '%money';

-- för att se koden
SHOW CREATE PROCEDURE move_money \G;







 