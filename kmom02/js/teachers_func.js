/**
 * Exercise 3 kmom02.
 * testing async and await
 * @ author Jen Lee
 */
"use strict";

// set config do a dict - check the file.
//require på modulnivå https://dbwebb.se/kunskap/mysql-och-nodejs-v2#struktur
const config = require("./config.json");
const mysql = require("promise-mysql");

/**
* MAIN function
* run "auto"
*/
(async function() {
    //configurera och hämta vilken databas och login info.
    const db = await mysql.createConnection(config);

    let str;

    str = await viewTeachers(db);

    console.info(str);

    db.end();
})();

/**
*call for innehåll from table chec select line in sql.
*/
async function viewTeachers(db) {
    let sql;
    let res;
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


    res = await db.query(sql); //will return a dict with all.

    str = teacherAsTable(res); //send the res to get a table
    return str;
}

/**
* given a dict.
* return a table
*/
function teacherAsTable(res) {
    let str;

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

    return str;
}
