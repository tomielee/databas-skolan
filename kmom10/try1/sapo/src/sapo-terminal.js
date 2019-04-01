/**
* FUNKTIONER som hämtar lagrade procedurer
* för terminalklienten
* databasen sapo
* Examinationstenta kmom10
* databas v1
*
* @author Jennifer Lee - jelf18
* 2019-03-28
*/

"use strict";

module.exports = {
    showLoggTerminal: showLoggTerminal,
    showLoggSearchTerminal: showLoggSearchTerminal
};

const mysql = require("promise-mysql");
const config = require ("../config/db/sapo.json");


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

// SHOW LOGG
async function showLoggTerminal() {
    let sql = `CALL show_logg_terminal();`;
    let logg;

    logg = await db.query(sql);

    return logg[0];
}

// SHOW LOGG SEARCH
async function showLoggSearchTerminal(search) {
    let sql = 'CALL show_logg_search_t(?);';

    let logg = await db.query(sql, [search]);

    return logg[0];
}
