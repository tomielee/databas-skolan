
USE eshop;
-- CALL add_to_order(7, 'merch1', 3);
-- CALL add_to_order(7, 'boo3', 3);


-- SELECT * FROM order_row WHERE order_id = 7;
-- CALL show_order(7);

-- SELECT * FROM v_order_info WHERE orderid = 7;
-- CALL add_to_order(7, 'boo3', 3);


-- CALL add_to_order(1, 'boo3', 3);
-- INSERT INTO order_row (order_id, prod_id, amount)
-- VALUES(1, 'boo3', 3);

-- SELECT * FROM order_row WHERE order_id = 1;
-- SELECT * FROM v_order_info WHERE orderid = 1;

-- SELECT * FROM v_order_info WHERE orderid = 1;

-- CALL show_all_orders();

-- SELECT COUNT(*) FROM order_row WHERE order_id = 1;
-- CALL create_order(1);
-- CALL add_to_order(1, "merch1", 2);
-- CALL add_to_order(1, "merch1", 3);
-- CALL add_to_order(1, "cd1", 2);

-- CALL create_order(2);
-- CALL add_to_order(2, "boo1", 2);
-- CALL add_to_order(2, "boo2", 3);
-- CALL add_to_order(2, "boo3", 2);

-- CALL create_order(3);
-- CALL add_to_order(3, "boo1", 2);
-- CALL add_to_order(3, "boo2", 3);
-- CALL add_to_order(3, "boo1", 2);

-- CALL create_order(3);
-- CALL add_to_order(4, "boo1", 2);
-- CALL add_to_order(4, "boo2", 3);
-- CALL add_to_order(4, "boo1", 2);

-- SELECT * FROM pick_list WHERE order_id = 1;
-- CALL pick_list(1);

-- SELECT * from inventory;
-- EXPLAIN SELECT * from inventory;
-- EXPLAIN SELECT * from inventory WHERE shelf = "B:02";
-- CREATE INDEX index_shelf ON inventory(shelf);
-- EXPLAIN SELECT * from inventory WHERE shelf = "B:02";

-- SELECT * from product;
-- EXPLAIN SELECT * from product;
-- EXPLAIN SELECT * from product WHERE title = "%k";
-- CREATE INDEX index_prod_title ON product(title);
-- EXPLAIN SELECT * from product WHERE title = "%k";

-- SELECT * FROM prod_cat;
-- EXPLAIN SELECT * FROM prod_cat;
-- EXPLAIN SELECT * FROM prod_cat WHERE cat LIKE  "sale%";
-- CREATE INDEX index_prod_cat ON prod_cat(cat); 
-- EXPLAIN SELECT * FROM prod_cat WHERE cat LIKE  "sale%";

-- CALL show_items_in_stock(1);

-- CALL show_search_order(1);
-- CALL show_search_order(5);

-- CALL show_categories();

-- CALL filter_inventory('b');
-- SELECT * FROM v_inventory;
-- CALL add_inventory('New', 'C:02', 200);
-- SELECT * FROM v_inventory;

-- CALL pick_list(2);
-- CALL show_log(0);

-- CALL show_log_search(35);




-- CALL show_inventory_t;
-- SELECT * FROM inventory;
-- SELECT * FROM product;
-- CALL add_inventory("boo1", "B:02", 20);
-- CALL add_inventory("nytt", "hyllan", 20);
-- SELECT * FROM inventory;




-- CALL show_cat_prod("cat_new");

DROP PROCEDURE IF EXISTS ship_order;
DELIMITER ;;

CREATE PROCEDURE ship_order( 
	a_orderid INT
)
MAIN:BEGIN
-- 	DECLARE current_stock INT;
--             
-- 	SELECT diff INTO current_stock FROM v_pick_list WHERE orderid = a_orderid;
-- 		
-- 	IF current_stock < 0 THEN
-- 		ROLLBACK;
--         SELECT 'There are not enough items in stock' AS message;
--         LEAVE MAIN;
-- 	END IF;
    
	UPDATE `order`
		SET 
			shipped = current_timestamp()
	WHERE id = a_orderid;
    
   
    
END
;;

DELIMITER ;

CALL ship_order(2);
