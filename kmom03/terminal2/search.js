/**
* For Assigmnent 1 kmom03
* From Exercise 3 kmom02.
* search function with user input.
* promisift rl
* @author Jen Lee
*/
"use strict";

const utils = require("./table.js");

module.exports = {
    "searchTeacher": searchTeacher
};


/**
@param db the databasconnection
@param search is the string of search.
*/

async function searchTeacher(db, search) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Search result for: ${search}`);

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
        WHERE
            acronym LIKE ?
            OR fname LIKE ?
            OR sirname LIKE ?
            OR section LIKE ?
            OR competence LIKE ?
            OR salary LIKE ?
            OR birth = ?
        ORDER BY acronym;
        `;

    res = await db.query(sql, [like, like, like, like, like, like, search]);
    // str = utils.createTable(res);

    return res;
}
