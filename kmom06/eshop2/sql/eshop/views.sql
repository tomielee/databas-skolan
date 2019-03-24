--
-- VIEWS for ehop2 KMOM06
-- eshop
-- 2018 - 03- 21

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

--
-- -- ------- VIEW all categories 
-- cat join with product and prod_cat
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


--
-- ------- VIEW customers / customers
-- 
DROP VIEW IF EXISTS v_customer;
CREATE VIEW v_customer
AS
	SELECT
		id as id,
		CONCAT(fname, " ", sirname) AS `name`,
        CONCAT(adress, ", ", zip, ", ", city) AS `adress`,
        telefon
    FROM customer;
    
    
    
-- 
-- -------- VIEW ORDER INFO
--
DROP VIEW IF EXISTS v_order_info;
CREATE VIEW v_order_info
AS
	SELECT
		o.id as orderid,
		o.created as ordercreated,
		o.customer_id as customerid,
		vc.name as customername,
		orow.prod_id as prodid,
		CONCAT(SUBSTRING(p.info, 1, 20), "...") as prodinfo,
		p.price as price,
		orow.amount as amount,
		(p.price * orow.amount) as 'sum' 
	FROM `order` AS o
		LEFT OUTER JOIN order_row AS orow
			ON orow.order_id = o.id
				LEFT JOIN product as p
					ON p.id = orow.prod_id
		LEFT OUTER JOIN v_customer as vc
			ON vc.id = o.customer_id;


--
-- ------- VIEW ALL ORDERS
--

DROP VIEW IF EXISTS v_all_orders;
CREATE VIEW v_all_orders
AS
SELECT 
		o.id AS orderid,
        o.created AS created,
        order_status(o.created, o.updated, o.ordered, o.deleted, o.shipped) AS `status`,
        CONCAT(c.fname, " ", c.sirname, " (ID: ", c.id, ")") AS customer
	FROM `order` AS o
		JOIN customer AS c
			ON c.id = o.customer_id
	ORDER BY orderid;


--
-- ------- PICKLIST
--
DROP VIEW IF EXISTS v_pick_list;
CREATE VIEW v_pick_list
AS 
	SELECT
		pl.order_id AS orderid,
        pl.prod_id AS prodid, 
        pl.amount AS amount,
        i.items AS "in stock",
        i.shelf AS shelf,
        (i.items - pl.amount) AS "diff"
    FROM pick_list AS pl
		JOIN inventory as i
			ON i.prod_id = pl.prod_id
    ORDER BY shelf;

DROP VIEW IF EXISTS v_show_status;
CREATE VIEW v_show_status
AS 
	SELECT
		id AS orderid,
		order_status(created, updated, ordered, deleted, shipped) as `status`
	FROM `order`;