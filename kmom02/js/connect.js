/**
 * Exercise 3 kmom02.
 * testing async and await
 * @ author Jen Lee
 */
"use strict";

const mysql = require("promise-mysql");

/**
* main function to run
*/
(async function() {
    let sql;
    let res;
    const db = await mysql.createConnection({
        "host": "localhost",
        "user": "dbwebb",
        "password": "password",
        "database": "skolan"
    });

    sql = "SELECT 1+1 AS Sum";
    res = await db.query(sql);

    console.info(res);

    db.end();
})();
