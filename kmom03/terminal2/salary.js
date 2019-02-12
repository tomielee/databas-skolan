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
    "salDiff": salDiff
};


/**
@param db the databasconnection
@param search is the string of search.
*/

async function salDiff(db) {
    let sql;
    let res;
    let str;

    sql = `
        SELECT
        	t.acronym AS Acro,
            t.fname AS Fname,
            t.sirname AS SName,
            p.salary AS Presalary,
            t.salary AS Nowsalary,
            (t.salary - p.salary) AS "Diff"
        FROM teacher AS t
        	JOIN teacher_pre AS p
        		ON t.acronym = p.acronym
        ORDER BY Diff DESC;
        `;

    res = await db.query(sql);

    return res;
}
