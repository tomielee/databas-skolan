/**
* For Assigmnent 1 kmom03
* From Exercise 3 kmom02.
* search function with user input.
* promisift rl
* @author Jen Lee
*/
"use strict";

module.exports = {
    "newSalary": newSalary
};


/**
@param db the databasconnection
@param search is the string of search.
*/

async function newSalary(db, acro, salary) {
    let sql;
    let res;

    acro = acro.trim();

    let acronym = `${acro}`;
    let newsalary = Number.parseInt(salary);

    console.info(
        `\nUpdated the teacher with acro: ${acro} `
        + `with the new salary: ${salary}`
    );

    sql = `
        UPDATE teacher
            SET salary = ?
                WHERE acronym = ?;
        `;

    res = await db.query(sql, [newsalary, acronym, acronym]);

    sql = `
        SELECT
            acronym,
            fname,
            sirname,
            section,
            competence,
            salary AS "new sal",
            DATE_FORMAT(birth, '%Y %m %d') AS birth
        FROM teacher
        WHERE
            acronym = ?;
        `;

    res = await db.query(sql, [acronym]);

    return res;
}
