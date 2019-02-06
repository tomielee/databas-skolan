/**
 * Exercise 3 kmom02.
 * search function with user input.
 * @ author Jen Lee
 */
"use strict";

const config = require('./config.json');
const mysql = require('promise-mysql');
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

/**
* MAIN function
* run "auto"
*/
(async function() {
    //configurera och hämta vilken databas och login info.
    const db = await mysql.createConnection(config);

    let str;

    rl.question("Search for something in table teacher: ", async (search) => {
        str = await searchTeachers(db, search);
        console.info(str);

        rl.close();
        db.end();
    });

    /**
    rl.question("Search for: ", async function(search){ ... })
    rl är satt som en readline funktion till crrate Interface
    */
})();


/**
@param db the databasconnection
@param search is the string of search.
*/
async function searchTeachers(db, search) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Searching for: ${search}`);

    sql = `
        SELECT
            acronym,
            fname,
            sirname,
            section,
            salary
        FROM teacher
        WHERE
            acronym LIKE ?
            OR fname LIKE ?
            OR sirname LIKE ?
            OR section LIKE ?
            OR salary = ?
        ORDER BY acronym;
        `;

    res = await db.query(sql, [like, like, like, like, search]);
    str = teacherAsTable(res);

    return str;
}

// /**
// *call for innehåll from table chec select line in sql.
// @param db is the databasconnection
// @param sql the select query to database
// @returns str which is a table from teacherAsTable()
// */
// async function viewTeachers(db) {
//     let sql;
//     let res;
//     let str;
//
//     sql = `
//         SELECT
//             acronym,
//             fname,
//             sirname,
//             section,
//             salary
//         FROM teacher
//         ORDER BY acronym;
//         `;
//
//
//     res = await db.query(sql); //will return a dict with all.
//
//     str = teacherAsTable(res); //send the res to get a table
//     return str;
// }

/** given a dict. return a table */
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
