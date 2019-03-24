--
-- PROCEDURES FOR TERMINAL
-- for ehop2 KMOM06
-- eshop
-- 2018 - 03- 21



-- --------------------------------------------------------- TERMINAL PROCEDURES
-- SHOW LOG
--
DROP PROCEDURE IF EXISTS show_log;
DELIMITER ;;
CREATE PROCEDURE show_log(
	a_number INT
)
BEGIN
	SELECT * FROM product_log
	ORDER BY log DESC LIMIT a_number;
	
    
END
;;

DELIMITER ;


-- SHOW SHELFS
--
DROP PROCEDURE IF EXISTS show_shelfs;
DELIMITER ;;
CREATE PROCEDURE show_shelfs(
	
)
BEGIN
	SELECT 
		shelf
	FROM inventory;
    
END
;;

DELIMITER ;


-- FILTER INVENTORY
--
DROP PROCEDURE IF EXISTS filter_inventory;
DELIMITER ;;
CREATE PROCEDURE filter_inventory(
	a_value VARCHAR(20)
)
BEGIN
	SELECT
		inv.id,
        inv.prod_id,
        p.title,
        inv.shelf,
        inv.items
    FROM inventory as inv
		JOIN product as p
			ON inv.prod_id = p.id
	WHERE p.title = a_value
	OR p.id = a_value
	OR inv.shelf = a_value
	ORDER BY inv.id;
    
END
;;

DELIMITER ;


-- ADD INVENTORY
--
DROP PROCEDURE IF EXISTS add_inventory;
DELIMITER ;;
CREATE PROCEDURE add_inventory(
	a_prodid VARCHAR(10),
    a_shelf VARCHAR (10),
    a_items INT
)
MAIN:BEGIN
	DECLARE current_shelf VARCHAR(10);
    
	SELECT shelf INTO current_shelf FROM inventory WHERE prod_id = a_prodid;
    
    IF current_shelf != a_shelf THEN
		ROLLBACK;
        SELECT "Could not add products to different shelf. Check 'inventory' to see correct shelf." AS message;
        LEAVE MAIN;
	END IF;

   	UPDATE inventory
		SET items = items + a_items
		WHERE prod_id = a_prodid;
	    
END
;;

DELIMITER ;


-- DELETE INVENTORY
--
DROP PROCEDURE IF EXISTS del_inventory;
DELIMITER ;;
CREATE PROCEDURE del_inventory(
	a_prodid VARCHAR(10),
    a_shelf VARCHAR (10),
    a_items INT
)
MAIN:BEGIN
	DECLARE current_shelf VARCHAR(10);
    
	SELECT shelf INTO current_shelf FROM inventory WHERE prod_id = a_prodid;
    
    IF current_shelf != a_shelf THEN
		ROLLBACK;
        SELECT "The product is not on this shelf. Could not remove items." AS message;
        LEAVE MAIN;
	END IF;

   	UPDATE inventory
		SET items = items - a_items
		WHERE prod_id = a_prodid;
	    
END
;;

DELIMITER ;



--
-- CREATE PICKLIST
--
DROP PROCEDURE IF EXISTS pick_list;
DELIMITER ;;
CREATE PROCEDURE pick_list(
	a_orderid INT
)
MAIN: BEGIN
	    DECLARE current_status VARCHAR(10);
    
    SELECT `status` INTO current_status FROM v_show_status WHERE orderid = a_orderid;
    
      -- IF-SATS 
    IF current_status != "ordered" THEN
		ROLLBACK;
        SELECT 'This ordered is not done' AS message;
        LEAVE MAIN;
	END IF;

	SELECT
		*
	FROM v_pick_list
	WHERE orderid = a_orderid
	ORDER BY shelf;

		
		
END 
;;

DELIMITER ;


-- 
-- SHIP THE ORDER
--
DROP PROCEDURE IF EXISTS ship_order;
DELIMITER ;;

CREATE PROCEDURE ship_order( 
	a_orderid INT
)
BEGIN
    
	UPDATE `order`
		SET 
			shipped = current_timestamp()
	WHERE id = a_orderid;
    
-- 	UPDATE inventory
-- 	SET
-- 		items = items - a_amount
-- 	WHERE prod_id = a_prodid;
    
    
END
;;

DELIMITER ;

-- CREATE TABLE pick_list
-- (
-- 	id INT AUTO_INCREMENT,
--     order_id INT,
--     prod_id VARCHAR(10),
--     items INT,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (order_id) REFERENCES `order`(id),
--     FOREIGN KEY (prod_id) REFERENCES product(id)
--     
--     CREATE TABLE order_row
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     order_id INT,
--     prod_id VARCHAR(10),
--     amount INT,
--     
--     PRIMARY KEY(id),    
--     FOREIGN KEY (order_id) REFERENCES `order`(id),
--     FOREIGN KEY (prod_id) REFERENCES product(id)
-- );

-- CREATE TABLE inventory
-- (
-- 	`id` INT NOT NULL AUTO_INCREMENT,
--     prod_id VARCHAR(10),
--     shelf VARCHAR(8),
--     items INT,
--     
--     PRIMARY KEY (`id`),
--     FOREIGN KEY (prod_id) REFERENCES product(id)
-- );
