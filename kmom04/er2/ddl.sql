-- CREATE DDL.SQL
-- kmom04
-- --

-- set all names to be able to read swedish charecters
-- SET NAMES utf8;

-- ------------------------
-- drop all tables if exists
-- DROP TABLE IF EXISTS Prod2Cat;
-- DROP TABLE IF EXISTS ProductCategory;
-- DROP TABLE IF EXISTS Inventory;
-- DROP TABLE IF EXISTS OrderRow;
-- DROP TABLE IF EXISTS Plocklist;


-- DROP TABLE IF EXISTS InvoiceRow;
-- DROP TABLE IF EXISTS Invoice;


-- DROP TABLE IF EXISTS ProdOrder;


-- DROP TABLE IF EXISTS Customer;
-- DROP TABLE IF EXISTS Product;


-- PRODUCT(id)
-- --
-- CREATE TABLE Product
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     title CHAR(100),
--     info VARCHAR(300), 
--     price FLOAT,
--     
--     PRIMARY KEY (id)
-- );


-- PRODUCTCATEGORY(prod_type)
-- --
-- CREATE TABLE ProductCategory
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     cat CHAR(50),
--     
--     PRIMARY KEY (id)
-- );

-- PROD2CAT(id, #prod_id, #cat_id)
-- --
-- CREATE TABLE Prod2Cat
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     prod_id INT,
--     cat_id INT,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (prod_id) REFERENCES Product(id),
--     FOREIGN KEY (cat_id) REFERENCES ProductCategory(id)
-- );

-- INVENTORY (id, #prod_type)
-- --
-- CREATE TABLE Inventory
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     prod_id INT,
--     shelf INT,
--     items INT,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (prod_id) REFERENCES Product(id)
-- );

-- CUSTOMER (id)
-- --
-- CREATE TABLE Customer
-- (
-- 	id INT AUTO_INCREMENT,
--     mail VARCHAR(50),
--     fname CHAR(100),
--     sirname CHAR(100),
--     adress VARCHAR(300),
--     zip INT(6),
--     city CHAR(30),
--     
--     PRIMARY KEY (id)
-- );

-- PRODORDER (id, #customer_ID)
-- could not use ORder... stupid

-- CREATE TABLE ProdOrder
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     customer_id INT,
--     created DATETIME DEFAULT CURRENT_TIMESTAMP,
--     updated DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
--     deleted DATETIME DEFAULT NULL,
--     delivery DATETIME DEFAULT NULL,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (customer_id) REFERENCES Customer(id)
-- );

-- ORDERROW(id, #order_ID, #prod_ID)

-- CREATE TABLE OrderRow
-- (
-- 	id INT AUTO_INCREMENT,
--     order_id INT,
--     prod_id INT,
--     amount INT,
--     
--     PRIMARY KEY(id),    
--     FOREIGN KEY (order_id) REFERENCES ProdOrder(id),
--     FOREIGN KEY (prod_id) REFERENCES Product(id)
-- );

-- PLOCKLIST(id, #order_id, #prod_id)
-- varje plocklista innehåller flera orderrows - som är kopplade till själva ProdOrder.

-- CREATE TABLE PlockList
-- (
-- 	id INT AUTO_INCREMENT,
--     order_id INT,
--     prod_id INT,
--     items INT,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (order_id) REFERENCES ProdOrder(id),
--     FOREIGN KEY (prod_id) REFERENCES Product(id)
-- );

-- INVOICE (inv_ID, #customer_id)
-- --
-- CREATE TABLE Invoice
-- (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     customer_id INT,
--     created DATETIME DEFAULT CURRENT_TIMESTAMP,
--     
--     PRIMARY KEY (id),    
--     FOREIGN KEY (customer_id) REFERENCES Customer(id)
-- );

-- INVOICEROW (id, #prod_id, #order_id, #inv_id)
-- CREATE TABLE InvoiceRow
-- (
-- 	id INT AUTO_INCREMENT,
--     prod_id INT,
--     order_id INT,
--     inv_id INT,
--     total FLOAT,
--     
--     PRIMARY KEY (id),
--     FOREIGN KEY (prod_id) REFERENCES Product(id),
--     FOREIGN KEY (order_id) REFERENCES ProdOrder(id),
--     FOREIGN KEY (inv_id) REFERENCES Invoice(id)    
-- );


-- DATABASENS API
-- 1. Lägga till en ny Product
-- INSERT INTO ProductCategory
-- 	(cat)
-- VALUES
-- 	("book"),
--     ("cd")
-- ;

-- INSERT INTO Product
-- 	(title, info, price)
-- VALUES
-- 	("book1", "This is the first book from 1974", 120),
--     ("book2", "This is the second book from 2019", 100),
--     ("cd1", "This is our first record from 2000", 150)
-- ;

-- INSERT INTO Prod2Cat
-- 	(prod_id, cat_id)
-- VALUES
-- 	(1, 1), 
--     (2, 1),
--     (3, 2)
-- ;

-- 2. Uppdatera en befintlig Produkt.
-- Spring sale on all CD's...
-- UPDATE Product SET price = price * 0.9 WHERE cat = "cd";


-- 3. Visa information samtliga Produkter
-- SELECT * FROM Product;

-- 4. Skapa en Kund
-- 5. Skapa en Order
-- 6. Skapa en Plocklista
-- 7. Skapa en Faktura


