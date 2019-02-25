-- CREATE DDL.SQL
-- kmom04
--

-- set all names to be able to read swedish charecters
SET NAMES utf8;

-- ------------------------
-- drop all tables if exists
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS ProdOrder;
DROP TABLE IF EXISTS ProductCategory;
DROP TABLE IF EXISTS Product;

-- table for Product
--
CREATE TABLE Product
(
	id INT NOT NULL AUTO_INCREMENT,
    title CHAR(100),
    info VARCHAR(300), 
    price FLOAT,
    
    PRIMARY KEY (id)
);

-- table for ProductCategory
--
CREATE TABLE ProductCategory
(
	prod_type CHAR(50),
    
    PRIMARY KEY (prod_type)
);

-- table for Customer
--
CREATE TABLE Customer
(
	customer_ID INT AUTO_INCREMENT,
    fname CHAR(100),
    sirname CHAR(100),
    adress VARCHAR(300),
    zip INT(6),
    city CHAR(30),
    
    PRIMARY KEY (customer_id)
)
;

-- PRODORDER (order_ID, #customer_ID)
-- could not use ORder... stupid

CREATE TABLE ProdOrder
(
	order_ID INT NOT NULL,
    customer_ID INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted DATETIME DEFAULT NULL,
    delivery DATETIME DEFAULT NULL,
    
    PRIMARY KEY (order_ID),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
)
;

-- ORDERROW(id, #order_ID, #prod_ID)
-- 
CREATE TABLE OrderRow
(
	id INT AUTO_INCREMENT,
    order_ID INT,
    prod_ID INT,
    amount INT,
    
    PRIMARY KEY(id),    
    FOREIGN KEY (order_ID) REFERENCES ProdOrder(order_ID),
    FOREIGN KEY (prod_ID) REFERENCES Product(prod_ID)
)
;

-- INVOICE (inv_ID, #customer_ID)
--
CREATE TABLE Invoice
(
	inv_ID INT NOT NULL AUTO_INCREMENT,
    customer_ID INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (inv_ID),    
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

-- INVOICE ROW
