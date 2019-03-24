
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

SELECT * from order_row;
EXPLAIN order_row;
EXPLAIN SELECT * FROM order_row;
EXPLAIN SELECT * FROM order_row WHERE prod_id = "boo1";
EXPLAIN SELECT * FROM order_row WHERE order_id = "2";


