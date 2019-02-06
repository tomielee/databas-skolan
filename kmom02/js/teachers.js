/**
 * Exercise 3 kmom02.
 * testing async and await
 * @ author Jen Lee
 */
"use strict";

// set config do a dict - check the file.
const config = require("./config.json");
const mysql = require("promise-mysql");

/**
* show teachers in databas skolan -
* databas is chosen and set in config
* config is run i connect_config
*/
(async function() {
    const db = await mysql.createConnection(config);

    let sql;
    let res;
    // let data;
    let str;

    sql = `
        SELECT
            acronym,
            fname,
            sirname,
            section,
            salary
        FROM teacher
        ORDER BY acronym;
        `;

    res = await db.query(sql);

    // data = JSON.stringify(res, null, 4);
    // console.info(data);
    // console.info(res);

    str  = "+ ----------| --------------------| ----------| -------------+\n";
    str += "+ -ACRONYM--| -NAME---------------| -SECTION--| -SALARY------+\n";
    str += "+ ----------| --------------------| ----------| -------------+\n";
    for (const row of res) {
        //start of a row and col
        str += "| ";
        //rad akronym + ett space på 10 för att fylla upp kolumn 12teck
        str += row.acronym.padEnd(10);
        str += "| ";
        str += (row.fname + " " + row.sirname).padEnd(20);
        str += "| ";
        str += row.section.padEnd(10);
        str += "| ";
        str += row.salary.toString().padEnd(10);
        str += "\n";
    }
    str += "+ ----------| --------------------| ----------| -------------+";

    console.info(str);

    db.end();
})();

/**
From
*/
