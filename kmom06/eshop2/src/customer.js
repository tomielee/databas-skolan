/**
* FUNCTION FOR THE WEB
* moudels for export for eshop2
*/
"use strict";

module.exports = {
    showAllCustomers: showAllCustomers,
    showCustomer: showCustomer
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

// SHOW ALL CUSTOMERS

async function showAllCustomers() {
    let sql = `SELECT * FROM v_customer`;
    let res = await db.query(sql);

    console.info(`showAllCustomers >> SQL: ${sql} got ${res.length} rows`);
    console.log(res);
    return res;
}

async function showCustomer(id) {
    let sql = `CALL show_customer(?);`;
    let customer = await db.query(sql, [id]);

    return customer[0][0];
}
