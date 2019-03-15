--
-- Transaktioner i databas
-- For kmom05
-- By Jen Lee, course databas v
-- 2018-03-13
-- OBS! ordningen är annolrunda än den från själva övningen - p g a annars funkar det ej.

DROP TABLE IF EXISTS account_log;
DROP TRIGGER IF EXISTS log_balance_update;
DROP TRIGGER IF EXISTS trigger_test2;



-- LOG TABLE
-- https://dbwebb.se/kunskap/triggers-i-databas#logg 
--
CREATE TABLE account_log
(
	`id` INTEGER PRIMARY KEY AUTO_INCREMENT, 
    `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `what` VARCHAR(20),
    `account` CHAR(4),
    `balance` DECIMAL(4, 2),
    `amount` DECIMAL(4, 2)
	
);

-- 
-- TRIGGER for logging updating balance
-- https://dbwebb.se/kunskap/triggers-i-databas#loggatri

CREATE TRIGGER log_balance_update
AFTER UPDATE
ON account FOR EACH ROW
	INSERT INTO account_log(`what`, `account`, `balance`, `amount`)
		VALUES("trigger", NEW.id, NEW.balance, NEW.balance - OLD.balance);




-- PROCEDURE move_money
-- uppdaterad med MAIN begin enligt
-- https://dbwebb.se/kunskap/triggers-i-databas#ex
-- 
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;
CREATE PROCEDURE move_money(
    --  The definition of the parameters
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
MAIN:BEGIN
    DECLARE current_balance NUMERIC(4, 2);
    
	START TRANSACTION;
    
    -- declarering av variabel med INTO 
    -- 	SET current_balance = (SELECT balance FROM account WHERE id = from_account);

    SELECT balance INTO current_balance FROM account WHERE id = from_account;    
	-- 	SELECT current_balance;
    
    -- IF-SATS 
    IF current_balance - amount < 0 THEN
		ROLLBACK;
        SELECT 'Amount on the account is not enough' AS message;
        -- leave main om för lite pengar
        LEAVE MAIN;
	END IF;
	
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
	
	-- LOGGA VAD SOM SKER - bortkommenterad för att använda TRIGGER istället.
    -- https://dbwebb.se/kunskap/triggers-i-databas#loggasp
   --  INSERT INTO
-- 		account_log (what, account, amount)
-- 		VALUES
-- 			('move_money from', from_account, -amount),
-- 			('move_money to', to_account, amount);
	
	COMMIT;

    -- behövs ej select här utan det är bara för att visa vad som händer som console.log
	SELECT * FROM account;

END
;;


DELIMITER ;



-- TRIGGER LOG I EN COMPOUND STATEMENT
-- COMPOUND STATMENTS >> UPDATE... INSERT... OSV 
-- använd då av DELIMITER ;;
-- https://dbwebb.se/kunskap/triggers-i-databas#trigger-compound

-- 
-- TRIGGER med COMPOUND to log ERROR
-- https://dbwebb.se/kunskap/triggers-i-databas#miss


DELIMITER ;;
CREATE TRIGGER trigger_test2
-- kan också vara efter men eftersom vi satt en trigger på after update vill vi ju veta om det inte funkade innan
BEFORE UPDATE
ON account FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET message_text = 'ERROR something went wrong';
END
;;

DELIMITER ;

-- vill ej ha kvar triggersn...
DROP TRIGGER IF EXISTS trigger_test2;


-- KALLA PÅ move_money
CALL move_money('1111', '2222', 1.5);
CALL move_money('2222', '1111', 1.5);

-- OCH FÅ en log
SELECT * FROM account_log;

-- VISA TRIGGERS -- omöjligt att läsa...
SHOW TRIGGERS FROM dbwebb;

-- VISA TRIGGERS - och dess kod
SHOW CREATE TRIGGER log_balance_update;

-- VISA TRIGGERS I terminlalen
-- SHOW TRIGGERS LIKE 'account' \G;
-- SHOW TRIGGERS FROM dbwebb \G;

-- B RA ATT VETA
-- https://dbwebb.se/kunskap/triggers-i-databas#bra




