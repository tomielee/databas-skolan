--
-- FUNCTIONS for ehop2 KMOM06
-- eshop
-- 2018 - 03- 21


-- --------------------------------------------------------- FUNCTIONS
-- ------------------------------------------- KMOM06

-- ORDER_STATUS()
DROP FUNCTION IF EXISTS order_status;
DELIMITER ;;

CREATE FUNCTION order_status(
	a_created DATETIME,
    a_updated DATETIME,
    a_ordered DATETIME,
    a_deleted DATETIME,
    a_shipped DATETIME
    
)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN

	IF a_updated > a_created AND a_updated > a_ordered AND a_updated > a_deleted THEN
		RETURN 'UPDATED ';
	ELSEIF a_ordered = a_updated THEN
		RETURN 'ORDERED';
	ELSEIF a_deleted = a_updated THEN
		RETURN 'DELETED';
	ELSEIF a_shipped = a_updated THEN
		RETURN 'SHIPPED';
	END IF;
    RETURN 'CREATED';

END
;;

DELIMITER ;


