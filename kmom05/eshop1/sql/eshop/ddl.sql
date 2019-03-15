--
-- SETUP for komom05 
-- use dbwebb, GRANT user pass 
-- eshop
-- copy from kmom04 crud 
-- 2018 - 03- 14


-- set all names to be able to read swedish charecters
SET NAMES utf8;

-- -------------------
-- drop all tables if exists
-- tables with most foreign keys last!
--
DROP TABLE IF EXISTS prod_2_cat;
DROP TABLE IF EXISTS prod_cat;

DROP TABLE IF EXISTS inventory;

DROP TABLE IF EXISTS order_row;
DROP TABLE IF EXISTS plock_list;

DROP TABLE IF EXISTS invoice_row;
DROP TABLE IF EXISTS invoice;

DROP TABLE IF EXISTS prod_order;

DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;



-- product(id)
--
CREATE TABLE product
(
	id VARCHAR(6),
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
	id INT NOT NULL AUTO_INCREMENT,
    prod_id VARCHAR(10),
    cat_id VARCHAR(10),
    
    PRIMARY KEY (id),
    FOREIGN KEY (prod_id) REFERENCES product(id),
    FOREIGN KEY (cat_id) REFERENCES prod_cat(id)
);

-- INVENTORY (id, #prod_type)
--
CREATE TABLE inventory
(
	id INT NOT NULL AUTO_INCREMENT,
    prod_id VARCHAR(6),
    shelf VARCHAR(6),
    items INT,
    
    PRIMARY KEY (id),
    FOREIGN KEY (prod_id) REFERENCES product(id)
);

-- customer (id)
--
CREATE TABLE customer
(
	id INT AUTO_INCREMENT,
    mail VARCHAR(50),
    fname CHAR(100),
    sirname CHAR(100),
    adress VARCHAR(300),
    zip INT(6),
    city CHAR(30),
    
    PRIMARY KEY (id)
);

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
	id INT AUTO_INCREMENT,
    prod_order_id INT,
    prod_id VARCHAR(6),
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
    prod_id VARCHAR(6),
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
    prod_id VARCHAR(6),
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

DROP VIEW IF EXISTS v_prodcat;

CREATE VIEW v_prodcat
AS
	SELECT 
		prod.title as product
    FROM product as prod
		JOIN prod_2_cat as p2
			ON prod.id = p2.prod_id
            JOIN prod_cat as pc
				ON p2.prod_id = pc.id
	GROUP BY
		product
;


-- --------------------------------------
-- LOG TRIGGERS
DROP TABLE IF EXISTS product_log;

-- TABLE FOR LOG
CREATE TABLE product_log
(
	`id` INTEGER PRIMARY KEY AUTO_INCREMENT, 
    `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `what` VARCHAR(20),
    `title` VARCHAR(100),
    `info` VARCHAR(300),
    `price` FLOAT
	
);

CREATE TRIGGER log_insert_prod
AFTER UPDATE
ON product FOR EACH ROW
	INSERT INTO product_log(`what`, `id`, `title`, `info`, `price`)
		VALUES("trigger - insert", NEW.id, NEW.title, NEW.info, NEW.price);

SHOW CREATE TRIGGER log_insert_prod;




