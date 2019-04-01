/**
* TERMINAL FUNCTION
* moudels for export for eshop1
*/
"use strict";

module.exports = {
    showLog: showLog,
    showLogSearch: showLogSearch,
    showShelfs: showShelfs,
    showInventory: showInventory,
    filterInventory: filterInventory,
    addInv: addInv,
    delInv: delInv,
    pickList: pickList,
    shipOrder: shipOrder,
    showSearchOrder: showSearchOrder
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

// SHOW LOG
// @param number user input number of rows
async function showLog(number) {
    let sql = `CALL show_log(?);`;
    let res;

    res = await db.query(sql, [number]);
    // console.log(res[0]);
    return res[0];
}

//SHOW LOG
// @params search user input search STRING
async function showLogSearch(search) {
    let sql = `CALL show_log_search(?);`;
    let log = await db.query(sql, [search]);

    return log[0];
}

// SHOW SHELFS
async function showShelfs() {
    let sql = `CALL show_shelfs();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

// SHOW INVENTORY
async function showInventory() {
    let sql = `CALL show_inventory_t();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

// FILTER INVENTORY
async function filterInventory(value) {
    let sql = `CALL filter_inventory(?);`;
    let res;

    res = await db.query(sql, [value]);

    return res[0];
}

// ADD number of PRODUCTS
async function addInv(prodid, shelf, items) {
    let sql = `CALL add_inventory(?, ?, ?);`;
    let res = await db.query(sql, [prodid, shelf, items]);

    return res;
}

// DELETE number of PRODUCTS
async function delInv(prodid, shelf, items) {
    let sql = `CALL del_inventory(?, ?, ?);`;
    let res = await db.query(sql, [prodid, shelf, items]);

    return res;
}

// CREATE PICKLIST
async function pickList(orderid) {
    let sql = `CALL pick_list(?);`;

    let picklist = await db.query(sql, [orderid]);

    return picklist[0];
}

// SHIP ORDER
async function shipOrder(orderid) {
    let sql = `CALL ship_order(?);`;

    let shipstatus = await db.query(sql, [orderid]);

    return shipstatus[0];
}

// SHOW ORDER FILTERED BY
//@params order id OR customer id

async function showSearchOrder(id) {
    let sql = `CALL show_search_order(?);`;
    let res = await db.query(sql, [id]);

    // console.info(res[0]);
    return res[0];
}
