/**
* For Assigmnent 1 kmom03
* From Exercise 3 kmom02.
* search function with user input.
* promisift rl
* @author Jen Lee
*/
"use strict";

module.exports = {
    "compDiff": compDiff
};


/**
@param db the databasconnection
@param search is the string of search.
*/

async function compDiff(db) {
    let sql;
    let res;

    sql = `
        SELECT
        	t.acronym AS Acro,
            t.fname AS Fname,
            t.sirname AS SName,
            p.competence AS Precomp,
            t.competence AS Nowcomp,
            (t.competence - p.competence) AS "Diff"
        FROM teacher AS t
        	JOIN teacher_pre AS p
        		ON t.acronym = p.acronym
        ORDER BY Acro;
        `;

    res = await db.query(sql);

    return res;
}
