--
-- INSERT for komom05 
-- eshop
-- copy from kmom04 crud 
-- 2018 - 03- 14

-- SHOW VARIABLES LIKE 'local_infile';
-- SHOW VARIABLES LIKE "secure_file_priv";
DELETE FROM product;
DELETE FROM customer;
DELETE FROM prod_cat;
DELETE FROM inventory;
DELETE FROM prod_2_cat;


-- INSERT 5 PRODUCTS
LOAD DATA LOCAL INFILE 'product.csv'
INTO TABLE product
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;


-- INSERT 5 CUSTOMERS
LOAD DATA LOCAL INFILE 'customer.csv'
INTO TABLE customer
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;

-- INSERT 5 CATEGORIES
LOAD DATA LOCAL INFILE 'category.csv'
INTO TABLE prod_cat
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;

-- INSERT products to category
LOAD DATA LOCAL INFILE 'prod_2_cat.csv'
INTO TABLE prod_2_cat
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;

-- INSERT PRODUCTS TO INVENTORY
LOAD DATA LOCAL INFILE 'inventory.csv'
INTO TABLE inventory
CHARSET utf8
FIELDS
	TERMINATED BY ','
    ENCLOSED BY '"'
LINES
	TERMINATED BY '\n'
IGNORE 1 LINES
;


SELECT * from product;
SELECT * from customer;
SELECT * from prod_cat;
SELECT * from inventory;
SELECT * from prod_2_cat;

-- VISA LITE VIEWS (skapat i ddl.sql)
SELECT * FROM v_prodcat;

-- VISA TRIGGERS (skapat i ddl.sql)
INSERT INTO product VALUES ("cd2", "music", "ny musik för ditt test", 20);

SELECT * FROM product_log;

SHOW WARNINGS;
