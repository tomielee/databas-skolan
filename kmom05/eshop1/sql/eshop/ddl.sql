--
-- SETUP for komom05 
-- use dbwebb, GRANT user pass 
-- eshop
-- copy from kmom04 crud 
-- 2018 - 03- 14


-- set all names to be able to read swedish charecters
SET NAMES utf8mb4;


-- -------------------
-- drop all tables if exists
-- tables with most foreign keys last!
--

-- need to drop tables from kmom06
DROP TABLE IF EXISTS pick_list;
DROP TABLE IF EXISTS `order`;


-- drop table for kmom05;
DROP TABLE IF EXISTS prod_2_cat;
DROP TABLE IF EXISTS prod_cat;

DROP TABLE IF EXISTS inventory;

DROP TABLE IF EXISTS order_row;
DROP TABLE IF EXISTS plock_list;

DROP TABLE IF EXISTS invoice_row;
DROP TABLE IF EXISTS invoice;

DROP TABLE IF EXISTS prod_order;
DROP TABLE IF EXISTS customer;

DROP TABLE IF EXISTS product;



-- product(id)
--
CREATE TABLE product
(
	id VARCHAR(10),
    title CHAR(100),
    info VARCHAR(300), 
    price FLOAT,
    
    PRIMARY KEY (id)
);


-- prod_cat(prod_type)
--
CREATE TABLE prod_cat
(
	id VARCHAR(10),
    cat CHAR(50),
    
    PRIMARY KEY (id)
);

-- prod_2_cat (id, #prod_id, #cat_id)
--
CREATE TABLE prod_2_cat
(
	`id` INT NOT NULL AUTO_INCREMENT,
	prod_id VARCHAR(10),
    cat_id VARCHAR(10),
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (prod_id) REFERENCES product(id),
    FOREIGN KEY (cat_id) REFERENCES prod_cat(id)
);

-- INVENTORY (id, #prod_id)
--
CREATE TABLE inventory
(
	`id` INT NOT NULL AUTO_INCREMENT,
    prod_id VARCHAR(10),
    shelf VARCHAR(8),
    items INT,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (prod_id) REFERENCES product(id)
);

-- CUSTOMER (id)
--
CREATE TABLE customer
(
	`id` INT NOT NULL AUTO_INCREMENT,
    mail VARCHAR(50),
    fname CHAR(100),
    sirname CHAR(100),
    adress VARCHAR(300),
    zip INT(10),
    city CHAR(30),
    
    PRIMARY KEY (`id`)
);
SHOW WARNINGS;

-- prod_order (id, #customer_ID)
-- 

CREATE TABLE prod_order
(
	id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted DATETIME DEFAULT NULL,
    delivery DATETIME DEFAULT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- order_row(id, #prod_order_ID, #prod_ID)
-- 
CREATE TABLE order_row
(
	id INT NOT NULL AUTO_INCREMENT,
    prod_order_id INT,
    prod_id VARCHAR(10),
    amount INT,
    
    PRIMARY KEY(id),    
    FOREIGN KEY (prod_order_id) REFERENCES prod_order(id),
    FOREIGN KEY (prod_id) REFERENCES product(id)
);

-- PLOCKLIST(id, #prod_order_id, #prod_id)
-- varje plocklista innehåller flera order_rows - som är kopplade till själva prod_order.

CREATE TABLE plock_list
(
	id INT AUTO_INCREMENT,
    prod_order_id INT,
    prod_id VARCHAR(10),
    items INT,
    
    PRIMARY KEY (id),
    FOREIGN KEY (prod_order_id) REFERENCES prod_order(id),
    FOREIGN KEY (prod_id) REFERENCES product(id)
);

-- invoice (inv_ID, #customer_id)
--
CREATE TABLE invoice
(
	id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),    
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- invoice_row (id, #prod_id, #prod_order_id, #inv_id)
CREATE TABLE invoice_row
(
	id INT AUTO_INCREMENT,
    prod_id VARCHAR(10),
    prod_order_id INT,
    inv_id INT,
    total FLOAT,
    
    PRIMARY KEY (id),
    FOREIGN KEY (prod_id) REFERENCES product(id),
    FOREIGN KEY (prod_order_id) REFERENCES prod_order(id),
    FOREIGN KEY (inv_id) REFERENCES invoice(id)    
);


-- --------------------------------------
-- VIEWS

-- I webbklienten, skapa en sida /eshop/product som visar en översikt av de produkter som finns. 
-- Visa (minst) produktens id, namn, pris och antal som finns i lagret. 
-- Visa även information om vilken kategori som produkten tillhör (TIPS GROUP_CONCAT).


DROP VIEW IF EXISTS v_products;

CREATE VIEW v_products
AS
	SELECT 
		prod.id as 'ProdId',
        prod.title as 'Title',
        prod.price as 'Price',
        inv.items as 'Items in stock'
        
    FROM product as prod
		JOIN inventory as inv
			ON inv.prod_id = prod.id
;

DROP VIEW IF EXISTS v_prodcat;
CREATE VIEW v_prodcat
AS
	SELECT
		pc.cat as "Categories"
        
    FROM product as prod
		JOIN prod_2_cat as p2
			ON prod.id = p2.prod_id
            JOIN prod_cat as pc
				ON p2.cat_id = pc.id
	GROUP BY p2.cat_id
;


-- --------------------------------------
-- PROCEDURES

-- SHOW ALL PRODUCTS
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

-- SHOW PRODUCTS
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

-- SHOW CATEGORIES
--
DROP PROCEDURE IF EXISTS show_categories;

DELIMITER ;;
CREATE PROCEDURE show_categories
(
)
BEGIN
	SELECT * FROM v_prodcat;
END
;;
DELIMITER ;

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

END
;;

DELIMITER ;

-- EDIT PRODUCT
--
DROP PROCEDURE IF EXISTS edit_product;

DELIMITER ;;

CREATE PROCEDURE edit_product
(
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


-- DELETE PRODUCT
--
DROP PROCEDURE IF EXISTS delete_product;

DELIMITER ;;

CREATE PROCEDURE delete_product
(
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

-- SHOW LOG
--
DROP PROCEDURE IF EXISTS show_log;
DELIMITER ;;
CREATE PROCEDURE show_log
(
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
CREATE PROCEDURE show_shelfs
(
	
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
CREATE PROCEDURE filter_inventory
(
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
CREATE PROCEDURE add_inventory
(
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
CREATE PROCEDURE del_inventory
(
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



-- --------------------------------------
-- LOG TRIGGERS
DROP TABLE IF EXISTS product_log;

-- TABLE FOR LOG
CREATE TABLE product_log
(
	`log` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id` VARCHAR(10), 
    `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `what` VARCHAR(20),
    `title` VARCHAR(100),
    `info` VARCHAR(300),
    `price` FLOAT
	
);

CREATE TRIGGER log_insert_prod
AFTER INSERT
ON product FOR EACH ROW
	INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - insert", NEW.id, NEW.title, NEW.info, NEW.price);

-- BÖR GÖRAS SNYGGARE...
CREATE TRIGGER log_update_prod
BEFORE UPDATE
ON product FOR EACH ROW
	INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - update", NEW.id, NEW.title, NEW.info, NEW.price);
        
CREATE TRIGGER log_delete_prod
BEFORE DELETE
ON product FOR EACH ROW
	INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - delete", OLD.id, OLD.title, OLD.info, OLD.price);

-- SHOW CREATE TRIGGER log_insert_prod;

-- SHOW CREATE TRIGGER log_update_prod;

