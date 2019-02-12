/**
 * Assignment 1. Kmom02
 * Course databas
 * Using Node.js, Javascript, await async
 * @ author Jen Lee
 */
"use strict";

const utils = require("./table.js");
const mysql = require('promise-mysql');
const config = require('./config.json');


// module.exports = {
//     "viewTeachers": viewTeachers
// };

/**
* function to create table
* @param db a database
* @param res a result from sql query
*
* @return str a string as a table
*/
(async function viewTeachers() {
    const db = await mysql.createConnection(config);

    let sql;
    let res;
    let str;

    sql = `
        SELECT
            acronym,
            fname,
            sirname,
            section,
            competence,
            salary,
            birth
        FROM teacher
        ORDER BY acronym;
        `;


    res = await db.query(sql); //will return a dict with all.
    str = utils.createTable(res); //send the res to get a table
    console.info("test")
    console.info(str)
})();
