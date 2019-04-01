/**
* FUNKTIONER som hämtar lagrade procedurer
* för WEBBKLIENTEN
* databasen sapo
* Examinationstenta kmom10
* databas v1
*
* @author Jennifer Lee - jelf18
* 2019-03-28
*/

"use strict";

module.exports = {
    showLogg: showLogg,
    showLoggSearch: showLoggSearch,
    showRapport: showRapport
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
async function showLogg() {
    let sql = 'CALL show_logg();';
    let logg = await db.query(sql);

    console.info(logg[0]);
    return logg[0];
}

// SHOW LOGG SEARCH
async function showLoggSearch(search) {
    let sql = 'CALL show_logg_search(?);';
    let logg = await db.query(sql, [search]);

    console.info(logg[0]);
    return logg[0];
}


// SHOW RAPPORT
async function showRapport() {
    let sql = 'CALL show_rapport();';
    let res = await db.query(sql);

    return res[0];
}
