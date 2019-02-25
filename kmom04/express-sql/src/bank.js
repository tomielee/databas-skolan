/**
* Module export functiont to access dbwebb, and bank database
https://dbwebb.se/kunskap/koppla-appservern-express-till-databasen-mysql#srcbankjs
* komom04
*/
"use strict";

module.exports = {
    showBalance: showBalance,
    transactionAdam: transactionAdam,
    transactionEva: transactionEva
};

const mysql = require("promise-mysql");
const config = require ("../config/db/bank.json");

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

/**
* Show data in accout table
*/
async function showBalance() {
    return findAllInTable("account");
}

/**
* Function select all from table
* @param {table}
*/

async function findAllInTable(table) {
    let sql;
    let res;

    sql = `SELECT * FROM ??; `;

    res = await db.query(sql, [table]);
    // console.info(
    //     `SQL: ${sql} from table ${table} got
    //     ${res.length} rows.`
    // );

    return res;
}

async function transactionAdam(table) {
    let sql;

    sql =
    `
    START TRANSACTION;

    UPDATE account
    SET
    	balance = balance + 1.5
    WHERE id = "1111";

    UPDATE account
    SET
        balance = balance - 1.5
    WHERE
        id = "2222";
    COMMIT;
    `
    ;
    await db.query(sql, [table]);
}

async function transactionEva(table) {
    let sql;

    sql =
    `
    START TRANSACTION;

    UPDATE account
    SET
    	balance = balance + 1.5
    WHERE id = "2222";

    UPDATE account
    SET
        balance = balance - 1.5
    WHERE
        id = "1111";
    COMMIT;
    `
    ;
    await db.query(sql, [table]);
}
