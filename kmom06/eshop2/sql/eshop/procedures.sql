--
-- PROCEDURES 
-- for ehop2 KMOM06
-- eshop
-- 2018 - 03- 21



-- --------------------------------------------------------- PROCEDURES
-- ------------------------------------------- KMOM05

--
-- SHOW ALL PRODUCTS
--
DROP PROCEDURE IF EXISTS show_all_products;

DELIMITER ;;
CREATE PROCEDURE show_all_products
(
)
BEGIN
	SELECT 
		prod.id as 'id',
        prod.title as 'title',
        prod.info as 'info',
        prod.price as 'price',
        inv.items as 'items'
	FROM product as prod
		JOIN inventory as inv
			ON prod.id = inv.prod_id;
-- 	GROUP BY prod.id;
    
END
;;

DELIMITER ;



--
-- SHOW PRODUCTS
--
DROP PROCEDURE IF EXISTS show_product;

DELIMITER ;;
CREATE PROCEDURE show_product
(
	a_id VARCHAR(10)
)
BEGIN
	SELECT 
		prod.id as 'id',
        prod.title as 'title',
        prod.info as 'info',
        prod.price as 'price',
        inv.items as 'items'
	FROM product as prod
		JOIN inventory as inv
			ON prod.id = inv.prod_id
 	WHERE prod.id = a_id;
    
END
;;

DELIMITER ;


--
-- SHOW CATEGORIES
--
DROP PROCEDURE IF EXISTS show_categories;

DELIMITER ;;
CREATE PROCEDURE show_categories
(
)
BEGIN
	-- SELECT * FROM v_prodcat; //VISAR BARA KATEGORIER DÄR DET FINNS PRODUKTER
    SELECT cat AS Categories FROM prod_cat;
END
;;
DELIMITER ;


--
-- ADD PRODUCT
--
DROP PROCEDURE IF EXISTS add_product;
DELIMITER ;;
CREATE PROCEDURE add_product
(
	a_id VARCHAR(10),
    a_title CHAR(100),
    a_info VARCHAR(300), 
    a_price FLOAT
)
BEGIN
   
	INSERT INTO product
		VALUES(a_id, a_title, a_info, a_price);
        
    INSERT INTO prod_2_cat (prod_id, cat_id)
		VALUES(a_id, 'cat_new');
    
    COMMIT;
-- 	INSERT INTO inventory (prod_id, shelf, items)
-- 		VALUES(a_id, a_shelf, a_items);
END
;;

DELIMITER ;


--
-- EDIT PRODUCT
--
DROP PROCEDURE IF EXISTS edit_product;
DELIMITER ;;
CREATE PROCEDURE edit_product(
	a_id VARCHAR(10),
    a_title CHAR(100),
    a_info VARCHAR(300), 
    a_price FLOAT,
    a_items INT
)
BEGIN
	UPDATE product
		SET
			title  = a_title,
            info = a_info, 
            price = a_price
	WHERE
		id = a_id;
	
    UPDATE inventory
		SET
			items = a_items
	WHERE
		prod_id = a_id;
        
	COMMIT;
END
;;

DELIMITER ;


--
-- DELETE PRODUCT
--
DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
	a_id VARCHAR(10)
)
BEGIN
      
	DELETE FROM inventory
	WHERE prod_id = a_id;
    
    DELETE FROM prod_2_cat
	WHERE prod_id = a_id;
    
	DELETE FROM product
	WHERE id = a_id;
	
    COMMIT;
END
;;

DELIMITER ;



-- ------------------------------------------- KMOM06

--
-- SHOW CUSTOMERS ORDERS
--
DROP PROCEDURE IF EXISTS show_customers_orders;
DELIMITER ;;

CREATE PROCEDURE show_customers_orders(
	a_id INT
)
BEGIN

	SELECT
		od.id AS orderid,
        od.customer_id as customerid,
        CONCAT(c.fname, " ", c.sirname) as `name`,
        od.created as created,
        od.updated as updated,
        od.ordered as ordered,
        od.deleted as deleted,
        od.shipped as shipped,
        order_status(od.created, od.updated, od.ordered, od.deleted, od.shipped) as status
	FROM `order`as od
		JOIN customer as c
			ON c.id = od.customer_id
	WHERE c.id = a_id
    ORDER BY updated DESC;
    
END
;;

DELIMITER ;



-- SHOW STATUS FOR order
--
DROP PROCEDURE IF EXISTS show_status;
DELIMITER ;;
CREATE PROCEDURE show_status(
	a_id INT
)
BEGIN
	SELECT
		order_status(created, updated, ordered, deleted, shipped) as `status`
	FROM `order`
    WHERE id = a_id;
	    
END
;;

DELIMITER ;




-- 
-- SHOW CUSTOMER
--
DROP PROCEDURE IF EXISTS show_customer;
DELIMITER ;;

CREATE PROCEDURE show_customer(
	a_id INT
)
BEGIN
	SELECT 
		*
	FROM v_customer
    WHERE id = a_id;
END
;;

DELIMITER ;


--
-- CREATE ORDER
--
DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;

CREATE PROCEDURE create_order(
	a_customerid INT
)
BEGIN
	INSERT INTO `order` (customer_id)
		VALUES(a_customerid);
	
    SELECT 
		id AS orderid
	FROM `order` 
    WHERE `order`.customer_id = a_customerid
    ORDER BY id DESC LIMIT 1; 
    
			
END
;;

DELIMITER ;


--
-- SHOW ORDERDETAILS
--

DROP PROCEDURE IF EXISTS show_order;
DELIMITER ;;
CREATE PROCEDURE show_order(
	a_orderid INT
)
BEGIN

	IF EXISTS (
		SELECT * FROM order_row
        WHERE order_id = a_orderid) THEN
			SELECT * 
				FROM v_order_info 
				WHERE orderid = a_orderid;
	ELSE 
		SELECT
			o.id as orderid,
			o.created as ordercreated,
			o.customer_id as customerid,
			vc.name as customername
		FROM `order` AS o
			LEFT OUTER JOIN v_customer as vc
				ON vc.id = o.customer_id
		WHERE o.id = a_orderid
		ORDER BY o.id;
        
	END IF;

      
  END
;;

DELIMITER ;





--
-- ADD PRODCUTS TO ORDER
-- order row...
--
DROP PROCEDURE IF EXISTS add_to_order;
DELIMITER ;;

CREATE PROCEDURE add_to_order(
	a_orderid INT,
    a_prodid VARCHAR(10),
    a_amount INT
)
MAIN:BEGIN

	DECLARE current_status VARCHAR(10);
    
    SELECT `status` INTO current_status FROM v_show_status WHERE orderid = a_orderid;
    
      -- IF-SATS 
    IF current_status = "ordered" THEN
		ROLLBACK;
        SELECT 'This order has already been ordered and cannot be modified.' AS message;
        LEAVE MAIN;
	ELSEIF current_status = "deleted" THEN
		ROLLBACK;
        SELECT 'This order is deleted' AS message;
        LEAVE MAIN;
	ELSEIF current_status = "shipped" THEN
		ROLLBACK;
		SELECT 'This order has already been shipped' AS message;
		LEAVE MAIN;
	END IF;

	IF EXISTS (
		SELECT * FROM order_row
        WHERE order_id = a_orderid AND prod_id = a_prodid) THEN
			UPDATE order_row
				SET amount = amount + a_amount 
                WHERE prod_id = a_prodid;
	ELSE
		INSERT INTO order_row (order_id, prod_id, amount)
			VALUES (a_orderid, a_prodid, a_amount);

	END IF;
    
    IF EXISTS (
		SELECT * FROM pick_list
        WHERE order_id = a_orderid AND prod_id = a_prodid) THEN
        UPDATE pick_list
			SET amount = amount + a_amount
            WHERE prod_id = a_prodid;
	ELSE
       INSERT INTO pick_list(order_id, prod_id, amount)
		VALUES(a_orderid, a_prodid, a_amount);
	END IF;
        
    UPDATE `order`
		SET 
        updated = CURRENT_TIMESTAMP
	WHERE id = a_orderid;
        
--     UPDATE inventory
-- 		SET
-- 			items = items - a_amount
-- 		WHERE prod_id = a_prodid;
	
 
    COMMIT;

END
;;

DELIMITER ;

--
-- EDIT PRODCUTS TO ORDER
-- order row...
--
DROP PROCEDURE IF EXISTS edit_order;
DELIMITER ;;

CREATE PROCEDURE edit_order(
	a_orderid INT,
    a_prodid VARCHAR(10),
    a_amount INT
)
BEGIN
	DECLARE current_amount INT;
    SELECT amount INTO current_amount from order_row WHERE order_id = a_orderid AND prod_id = a_prodid;
    
	UPDATE order_row
		SET amount = a_amount 
		WHERE order_id = a_orderid AND prod_id = a_prodid;
     
    UPDATE `order`
		SET 
        updated = CURRENT_TIMESTAMP
	WHERE id = a_orderid;
        
    
    IF current_amount >= a_amount THEN
		UPDATE inventory
			SET
				items = items + a_amount
			WHERE prod_id = a_prodid;
	ELSEIF amount < a_amount THEN
		UPDATE inventory
			SET
				items = items - a_amount
			WHERE prod_id = a_prodid;	
	END IF;
    
    COMMIT;

END
;;

DELIMITER ;


--
-- FINISH ORDER "ORDER ORDER"
--

DROP PROCEDURE IF EXISTS finish_order;
DELIMITER ;;
CREATE PROCEDURE finish_order(
	a_orderid INT
)
BEGIN

  UPDATE `order` 
	SET
		ordered = current_timestamp
	WHERE
		id = a_orderid;
  
END
;;

DELIMITER ;


--
-- DELETE ORDER "SOFT DELETE
--

DROP PROCEDURE IF EXISTS delete_order;
DELIMITER ;;
CREATE PROCEDURE delete_order(
	a_orderid INT
)
BEGIN

  UPDATE `order` 
	SET
		deleted = current_timestamp
	WHERE
		id = a_orderid;
  
END
;;

DELIMITER ;



--
-- SHOW ALL ORDERS
--
DROP PROCEDURE IF EXISTS show_all_orders;
DELIMITER ;;
CREATE PROCEDURE show_all_orders(
)
BEGIN
	SELECT
		orderid,
		created,
		`status`,
		customer,
		COUNT(orow.order_id) AS orderrows
	FROM v_all_orders as o
		JOIN order_row as orow
			ON orow.order_id = o.orderid
	GROUP BY orderid
    ORDER BY created;
            
END 
;;

DELIMITER ;


--
-- SHOW ITEMS IN STOCK
--
DROP PROCEDURE IF EXISTS show_items_in_stock;
DELIMITER ;;
CREATE PROCEDURE show_items_in_stock(
	a_orderid INT
)
BEGIN
	SELECT
		i.items AS items
	FROM inventory AS i
		JOIN order_row AS orow
			ON orow.prod_id = i.prod_id
			JOIN `order` AS o
				ON o.id = orow.order_id
	WHERE o.id = a_orderid;
            
END 
;;

DELIMITER ;



--
-- SHOW TOTAL
--
DROP PROCEDURE IF EXISTS show_total;
DELIMITER ;;
CREATE PROCEDURE show_total(
	a_orderid INT
)
BEGIN
	SELECT
		SUM(`sum`) AS total
	FROM v_order_info
	WHERE orderid = a_orderid;
            
END 
;;

DELIMITER ;




