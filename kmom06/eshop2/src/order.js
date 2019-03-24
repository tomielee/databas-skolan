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
    showAllOrders: showAllOrders
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

    let status = await db.query(sql, [id])

    console.info(`showOrderStatus >> SQL: ${sql} got ${status.length} rows`);

    console.info(status[0]);

    return status[0];
}

// CREATE ORDER
async function createOrder(customerid) {
    let sql = `CALL create_order(?);`;

    let orderid = await db.query(sql, [customerid])

    console.info(`createOrder >> SQL: ${sql} got ${orderid.length} rows`);
    console.info(orderid[0])
    return orderid[0];

}

// SHOW ORDER
async function showOrder(orderid) {
    let sql = `CALL show_order(?);`;

    let order = await db.query(sql, [orderid]);

    // console.info(`showOrder >> SQL: ${sql} got ${order.length} rows`);
    // console.info(order[0]);
    console.info(`Showing order ${orderid}`);
    return order[0];

}

// ADD TO Order
// SHOPE SOME more

async function addToOrder(orderid, prodid, amount) {
    let sql = `CALL add_to_order(?, ?, ?);`;
    let orderinfo;

    for (var i = 0; i < prodid.length; i++) {

        if (amount[i] === "null") {
            continue;
        } else {
            orderinfo = await db.query(sql, [orderid, prodid[i], amount[i]]);
        }
    }
}

//ORDER ORDER - FINISH
async function finishOrder(orderid) {
    let sql = `CALL finish_order(?);`;

    let res = await db.query(sql, [orderid]);
}

async function deleteOrder(orderid) {
    let sql = `CALL delete_order(?);`;

    let res = await db.query(sql, [orderid]);
}

//EDIT ORDER
async function editOrder(orderid, prodid, amount) {
    let sql = `CALL edit_order(?, ?, ?);`;
    let orderinfo;

    for (var i = 0; i <= prodid.length; i++) {
        if (amount[i] === "null") {
            continue;
        } else {
            orderinfo = await db.query(sql, [orderid, prodid[i], amount[i]]);
        }
    }
}

// SHOW ALL ORDERS
async function showAllOrders() {
    let sql = `CALL show_all_orders();`;

    let orders = await db.query(sql);
    return orders[0];
}
