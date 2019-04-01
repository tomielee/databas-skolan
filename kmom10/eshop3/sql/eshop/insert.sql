--
-- INSERT
-- for ehop3 KMOM10
-- eshop
-- 2018 - 03- 28

--  OM DET INTE FuNKAR ATT LADDA FIL
-- SET GLOBAL local_infile = 1;
-- ßSHOW VARIABLES LIKE 'local_infile';

-- SHOW VARIABLES LIKE 'local_infile';
-- SHOW VARIABLES LIKE "secure_file_priv";
DELETE FROM about;
ALTER TABLE about AUTO_INCREMENT = 1;

DELETE FROM order_row;
ALTER TABLE order_row AUTO_INCREMENT = 1;

DELETE FROM `order`;
ALTER TABLE `order` AUTO_INCREMENT = 1;
-- DELETE FROM prod_order; -- a rest from kmom05 //in case UX for kmom05


DELETE FROM customer;
ALTER TABLE customer AUTO_INCREMENT = 1 ;

DELETE FROM inventory;
ALTER TABLE inventory AUTO_INCREMENT = 1;

DELETE FROM prod_2_cat;
ALTER TABLE prod_2_cat AUTO_INCREMENT = 1;

DELETE FROM prod_cat;
ALTER TABLE prod_cat AUTO_INCREMENT = 1;

DELETE FROM product;

DELETE FROM product_log;
ALTER TABLE product_log AUTO_INCREMENT = 1;



-- INSERT info about 
LOAD DATA LOCAL INFILE 'about.csv'
INTO TABLE about
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(author, part, info)
;

-- -- INSERT 5 PRODUCTS
LOAD DATA LOCAL INFILE 'product.csv'
INTO TABLE product
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;
-- SHOW WARNINGS;
-- SELECT * FROM product;



-- -- INSERT 5 CATEGORIES
LOAD DATA LOCAL INFILE 'category.csv'
INTO TABLE prod_cat
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;
SHOW WARNINGS;
SELECT * FROM prod_cat;



-- -- INSERT products to category
LOAD DATA LOCAL INFILE 'prod_2_cat.csv'
INTO TABLE prod_2_cat
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(prod_id, cat_id)
SET id = NULL
;

SHOW WARNINGS;
SELECT * FROM prod_2_cat;


-- -- INSERT PRODUCTS TO INVENTORY
LOAD DATA LOCAL INFILE 'inventory.csv'
INTO TABLE inventory
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(prod_id, shelf, items)
;
-- SHOW WARNINGS;
-- SELECT * FROM inventory;


-- -- INSERT CUSTUMERS
LOAD DATA LOCAL INFILE 'customer.csv'
INTO TABLE customer
CHARSET UTF8MB4
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
(fname, sirname, adress, zip, city, telefon)
SET id = NULL
;
-- SHOW WARNINGS;
-- SELECT * FROM customer;


-- -- INSERT a ORDER
-- LOAD DATA LOCAL INFILE 'order.csv'
-- INTO TABLE `order`
-- CHARSET UTF8MB4
-- FIELDS
-- 	TERMINATED BY ','
-- 	ENCLOSED BY '"'
-- LINES
-- 	TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (customer_id)
-- SET id = NULL
-- ;

-- INSERT ORDER ROW
-- LOAD DATA LOCAL INFILE 'order_row.csv'
-- INTO TABLE order_row
-- CHARSET UTF8MB4
-- FIELDS
-- 	TERMINATED BY ','
-- 	ENCLOSED BY '"'
-- LINES
-- 	TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (order_id, prod_id, amount)
-- SET id = NULL
-- ;

-- SELECT * FROM order_row;

-- VISA LITE VIEWS (skapat i ddl.sql)
-- SELECT * FROM v_products;
-- SELECT * FROM v_prodcat;

-- -- VISA TRIGGERS (skapat i ddl.sql)
-- UPDATE product 
-- 	SET price = 200 WHERE id = "boo1";
--     
-- INSERT INTO product
-- 	(id, title, info, price)
-- 	VALUES 
--     ("cd2", "musica", "more music",30),
-- 	("merch2", "mugg", "kopp med logo", 1)
--     ;

-- DELETE FROM product WHERE id = "cd2";
-- DELETE FROM product WHERE id = "merch2";


-- SELECT * FROM product_log;

-- CALL show_categories();
-- CALL show_all_products();
