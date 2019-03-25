/**
* FUNCTION FOR THE WEB
* moudels for export for eshop2
*/
"use strict";

module.exports = {
    showCustomersOrders: showCustomersOrders,
    showOrderStatus: showOrderStatus,
    createOrder: createOrder,
    showOrder: showOrder,
    addToOrder: addToOrder,
    finishOrder: finishOrder,
    deleteOrder: deleteOrder,
    editOrder: editOrder,
    showAllOrders: showAllOrders,
    showItemsInStock: showItemsInStock,
    showTotal: showTotal
};

const mysql = require("promise-mysql");
const config = require ("../config/db/eshop.json");


let db;

/**
* Main function
*/
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end(); //om exit, anonymfunktion som avslutar.
    });
})();

// SHOW ALL ORDERS

async function showCustomersOrders(id) {
    let sql = `CALL show_customers_orders(?);`;

    let res = await db.query(sql, [id]);

    console.info(`showCustomersOrders >> SQL: ${sql} got ${res.length} rows`);

    console.info(res);

    return res[0];
}

// GET ORDER STATUS
async function showOrderStatus(id) {
    let sql = `CALL show_status(?);`;

    let status = await db.query(sql, [id]);

    console.info(`showOrderStatus >> SQL: ${sql} got ${status.length} rows`);

    return status[0];
}

// CREATE ORDER
async function createOrder(customerid) {
    let sql = `CALL create_order(?);`;
    let orderid = await db.query(sql, [customerid]);

    console.info(`createOrder >> SQL: ${sql} got ${orderid.length} rows`);

    return orderid[0];
}

// SHOW ORDER
async function showOrder(orderid) {
    let sql = `CALL show_order(?);`;
    let order = await db.query(sql, [orderid]);

    // console.info(`showOrder >> SQL: ${sql} got ${order.length} rows`);

    console.info(`Showing order ${orderid}`);
    return order[0];
}

// ADD TO Order
// SHOPE SOME more

async function addToOrder(orderid, prodid, amount) {
    let sql = `CALL add_to_order(?, ?, ?);`;

    for (var i = 0; i < prodid.length; i++) {
        if (amount[i] === "null") {
            continue;
        } else {
            await db.query(sql, [orderid, prodid[i], amount[i]]);
        }
    }
}

//ORDER ORDER - FINISH
async function finishOrder(orderid) {
    let sql = `CALL finish_order(?);`;

    await db.query(sql, [orderid]);
}

async function deleteOrder(orderid) {
    let sql = `CALL delete_order(?);`;

    await db.query(sql, [orderid]);
}

//EDIT ORDER
async function editOrder(orderid, prodid, amount) {
    let sql = `CALL edit_order(?, ?, ?);`;

    for (var i = 0; i <= prodid.length; i++) {
        if (amount[i] === "null") {
            continue;
        } else {
            await db.query(sql, [orderid, prodid[i], amount[i]]);
        }
    }
}

// SHOW ALL ORDERS
async function showAllOrders() {
    let sql = `CALL show_all_orders();`;
    let orders = await db.query(sql);

    return orders[0];
}

//SHOW ITEMS IN stock
//@params orderid
async function showItemsInStock(orderid) {
    let sql = `CALL show_items_in_stock(?);`;
    let items = await db.query(sql, [orderid]);

    console.info(`ITEMS IN STOCK ${items}`);
    // console.info(items[0]);

    return items[0];
}

//SHOW total
async function showTotal(orderid) {
    let sql = `CALL show_total(?);`;

    let total = await db.query(sql, [orderid]);

    return total[0];
}
