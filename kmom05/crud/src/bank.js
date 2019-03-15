/**
*
* copied from kmom04 to KMOM05
* Det går att lägga in alla funktioner i en och samma modul och exportea hela modulen istället för varje funktion för sig. Se genomgången med Emil.
*/
"use strict";

module.exports = {
    showBalance: showBalance,
    transactionAdam: transactionAdam,
    transactionEva: transactionEva,
    createAccount: createAccount,
    showAccount: showAccount,
    editAccount: editAccount,
    deleteAccount: deleteAccount
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
* Update from kmom04 with proceure
*/
async function showBalance() {
    return findAllInTable("account");
}

/**
* Function select all from table
* @param {table}
*/

async function findAllInTable(table) {
    let sql = `CALL show_balance();`
    let res;

    res = await db.query(sql, [table]);
    console.info(
        `SQL: ${sql} from table ${table} got
        ${res.length} rows.`
    );

    return res[0];
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

async function createAccount(id, name, balance) {
    let sql = `CALL create_account(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, name, balance]);
    console.log(res)
    console.info(`createAccount >> SQL: ${sql} got ${res.length} rows`);
}

async function showAccount(id) {
    let sql = `CALL show_account(?);`;
    let res;

    res = await db.query(sql, [id]);
    console.info(`showAccount >> SQL: ${sql} got ${res.length} rows`);

    return res[0];

}

async function editAccount(id, name, balance) {
    let sql = `CALL edit_account(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, name, balance]);
    console.info(`editAccount >> SQL: ${sql} got ${res.length} rows`);

}

async function deleteAccount(id) {
    let sql = `CALL delete_account(?);`;
    let res;

    res = await db.query(sql, [id]);
    console.info(`deleteAccount >> SQL: ${sql} was run`);

}
