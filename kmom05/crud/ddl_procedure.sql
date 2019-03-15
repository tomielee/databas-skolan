--
-- SQL code for kmom05 CRUD
-- 2019 - 03 - 19
-- 

-- PROCEDURE show_balance
DROP PROCEDURE IF EXISTS show_balance;

DELIMITER ;;
CREATE PROCEDURE show_balance 
(
)
BEGIN
	SELECT * FROM account;
END 
;;


DELIMITER ;
--
-- PROCEDURE create_account;
--

DROP PROCEDURE IF EXISTS create_account;

DELIMITER ;;
CREATE PROCEDURE create_account
(
	a_id CHAR(4),
    a_name VARCHAR(8),
    a_balance DECIMAL(4, 2)
)
BEGIN
	INSERT into account
		VALUES (a_id, a_name, a_balance);
END
;;
DELIMITER ;

-- Test if it works.
-- CALL create_account("1234", "test", 20.0);

--
-- PRODCEDURE show_account;
--

DROP PROCEDURE IF EXISTS show_account;

DELIMITER ;;
CREATE PROCEDURE show_account
(
	a_id CHAR(4)
)
BEGIN
	SELECT * from account WHERE id = a_id;
END
;;
DELIMITER ;

-- TEST if it works
-- CALL show_account("3333");

-- PROCEDURE edit_account
--
DROP PROCEDURE IF EXISTS edit_account;

DELIMITER ;;
CREATE PROCEDURE edit_account
(
	a_id CHAR(4),
    a_name VARCHAR(8),
    a_balance DECIMAL(4, 2)
)
BEGIN
	UPDATE account
    SET
		name = a_name,
        balance = a_balance
	WHERE id = a_id;
	
END
;;

DELIMITER ;

-- TEST
-- CALL edit_account("1234", "nytt", 20.4);

DROP PROCEDURE IF EXISTS delete_account;

DELIMITER ;;
CREATE PROCEDURE delete_account
(
	a_id CHAR(4)
)
BEGIN
	DELETE FROM account 
    WHERE id = a_id;
END
;;

DELIMITER ;

-- TEST
-- CALL delete_account("1234");
