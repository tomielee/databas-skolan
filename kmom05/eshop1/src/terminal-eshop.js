/**
* TERMINAL FUNCTION
* moudels for export for eshop1
*/
"use strict";

module.exports = {
    showLog: showLog,
    showShelfs: showShelfs,
    showInventory: showInventory,
    filterInventory: filterInventory,
    addInv: addInv,
    delInv: delInv
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

    return res[0];
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
    let sql = `SELECT * FROM v_inventory`;
    let res;

    res = await db.query(sql);

    return res;
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
    let res;

    res = await db.query(sql, [prodid, shelf, items]);
    return res;
}

// DELETE number of PRODUCTS
async function delInv(prodid, shelf, items) {
    let sql = `CALL del_inventory(?, ?, ?);`;
    let res;

    res = await db.query(sql, [prodid, shelf, items]);
    return res;
}
