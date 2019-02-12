/**
 * For Kmom03
 * From Assignment 1. Kmom02
 * Course databas
 * Using Node.js, Javascript, await async
 * @author Jen Lee
 */
"use strict";

const utils = require("./table.js");

module.exports = {
    "viewTeachers": viewTeachers
};

/**
* function to create table
* @param db a database
* @param res a result from sql query
*
* @return str a string as a table
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
            competence,
            salary,
            DATE_FORMAT(birth, '%Y %m %d') AS birth
        FROM teacher
        ORDER BY acronym;
        `;


    res = await db.query(sql); //will return a dict with all.
    // str = utils.createTable(res); //send the res to get a table
    //
    // return str;
    return res;
}
