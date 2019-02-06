/**
 * Exercise 3 kmom02.
 * testing async and await
 * @ author Jen Lee
 */
"use strict";

const config = require("./config.json");
const mysql = require("promise-mysql");


/**
* main function to run
*/
(async function() {
    const db = await mysql.createConnection(config);

    let sql;
    let res;

    sql = "SELECT 1+1 AS Sum";
    res = await db.query(sql);

    console.info(res);

    db.end();
})();
