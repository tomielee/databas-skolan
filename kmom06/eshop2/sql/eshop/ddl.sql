--
-- SETUP copy from kmom05
-- for ehop2 KMOM06
-- eshop
-- copy from kmom04 crud 
-- 2018 - 03- 20


-- set all names to be able to read swedish charecters
SET NAMES utf8mb4;


-- -------------------
-- drop all tables if exists
-- tables with most foreign keys last!
--


DROP TABLE IF EXISTS prod_2_cat;
DROP TABLE IF EXISTS prod_cat;

DROP TABLE IF EXISTS inventory;

DROP TABLE IF EXISTS order_row;
DROP TABLE IF EXISTS pick_list;

DROP TABLE IF EXISTS invoice_row;
DROP TABLE IF EXISTS invoice;

DROP TABLE IF EXISTS `order`;
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
    
    PRIMARY KEY (id),
	KEY `index_prod_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- prod_cat(prod_type)
--
CREATE TABLE prod_cat
(
	id VARCHAR(10),
    cat CHAR(50),
    
    PRIMARY KEY (id),
    KEY `index_prod_cat` (`cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
    FOREIGN KEY (prod_id) REFERENCES product(id),
	KEY `index_shelf` (`shelf`)
)
ENGINE=InnoDB 
AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- CUSTOMER (id)
--
CREATE TABLE customer
(
	id INT NOT NULL AUTO_INCREMENT,
    fname CHAR(100),
    sirname CHAR(100),
    adress VARCHAR(300),
    zip INT(10),
    city CHAR(30),
    telefon VARCHAR(10),
    
    PRIMARY KEY (id)
);

-- `order` (id, #customer_ID)
-- 

CREATE TABLE `order`
(
	id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT NULL 
			ON UPDATE CURRENT_TIMESTAMP,
	ordered DATETIME DEFAULT NULL,
    deleted DATETIME DEFAULT NULL,
    shipped DATETIME DEFAULT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- order_row(id, #prod_order_ID, #prod_ID)
-- 
CREATE TABLE order_row
(
	id INT NOT NULL AUTO_INCREMENT,
    order_id INT,
    prod_id VARCHAR(10),
    amount INT,
    
    PRIMARY KEY(id),    
    FOREIGN KEY (order_id) REFERENCES `order`(id),
    FOREIGN KEY (prod_id) REFERENCES product(id)
);

-- picklist (id, #prod_order_id, #prod_id)
-- varje picklista innehåller flera order_rows - som är kopplade till själva prod_order.

CREATE TABLE pick_list
(
	id INT AUTO_INCREMENT,
    order_id INT,
    prod_id VARCHAR(10),
    amount INT,
    
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES `order`(id),
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
    order_id INT,
    inv_id INT,
    total FLOAT,
    
    PRIMARY KEY (id),
    FOREIGN KEY (prod_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES `order`(id),
    FOREIGN KEY (inv_id) REFERENCES invoice(id)    
);






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



-- ------------------------------------------- INDEX 
--
--






