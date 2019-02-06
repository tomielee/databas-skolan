/**
 * Exercise 3 kmom02.
 * search function with user input.
 * two values
 * @ author Jen Lee
 */
"use strict";

const utils = require("./table.js");

module.exports = {
    "valBetween": valBetween
};


/**
@param db the databasconnection
@param search is the string of search.
*/

async function valBetween(db, searchMin, searchMax) {
    let sql;
    let res;
    let str;
    let minQuery = `${searchMin}`;
    let maxQuery = `${searchMax}`;

    console.info(`Searching for: ${minQuery} and ${maxQuery}`);

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
        WHERE
            salary BETWEEN ? AND ?
            OR competence BETWEEN ? AND ?
        ORDER BY acronym;
        `;

    res = await db.query(sql, [minQuery, maxQuery, minQuery, maxQuery]);

    str = utils.createTable(res);

    return str;
}
