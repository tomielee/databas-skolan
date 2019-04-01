/**
 * Modules for exam.
 * Routes import these modules. The modules get result from database
 * @author Jennifer Lee jelf18
 * 2019-03-26
 */

"use strict";

module.exports = {
    showAllSushi: showAllSushi,
    showAllComp: showAllComp,
    showSushiComp: showSushiComp,
    showSushiCompTerminal: showSushiCompTerminal
};
const mysql = require("promise-mysql");
const config = require ("../config/db/exam.json");


let db;

/**
* Main function
*/
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end(); //om exit, anonymfunktion som avslutar.
    });
})();

// SHOW ALL SUSHIS
async function showAllSushi() {
    let sql = `CALL show_all_sushi();`;

    let sushi = await db.query(sql);
    // console.info(`showAllSushi >> SQL: ${sql} got ${sushi.length} rows`);

    return sushi[0];
}

// SHOW ALL COMPETITIONS
async function showAllComp() {
    let sql = `CALL show_all_comp();`;
    let comp = await db.query(sql);

    return comp[0];
}

async function showSushiComp(compid) {
    let sql = `CALL show_sushi_comp(?);`;
    let sc = await db.query(sql, [compid]);

    return sc[0];
}
async function showSushiCompTerminal(compid) {
    let sql = `CALL show_sushi_comp_t(?);`;
    let sc = await db.query(sql, [compid]);

    return sc[0];
}
