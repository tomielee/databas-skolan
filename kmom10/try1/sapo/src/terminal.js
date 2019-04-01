/**
* FUNKTIONER
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
    showMenu: showMenu,
    handleInput: handleInput,
    exitProgram: exitProgram
};

const mysql = require("promise-mysql");
const config = require ("../config/db/sapo.json");

const st    = require("./sapo-terminal.js");
const sapo = require("./sapo.js");

/**
* Show menu
*/
function showMenu() {
    console.log(
        "  Meny\n \n"
        + "° logg: visar loggen \n"
        + "° search <str>: sök i loggen \n"
        + "° rapport: visar chefens rapport \n"
        + "----------------------------------------\n"
        + "     exit, quit: to exit. \n"
        + "     help, menu: to show this menu. \n"
        + "     about: about me. \n"

    );
}

/**
* Handle user input
* @param input string, user input
*/
async function handleInput(line) {
    const db = await mysql.createConnection(config);

    line = line.trim();

    let lineArr = line.split(' ');
    let choice = lineArr[0];

    switch (choice) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        case "menu":
        case "help":
            showMenu();
            break;

        case "logg":
            console.info("---- ** LOGGEN\n");
            console.table(await st.showLoggTerminal());
            console.info("\n");
            break;

        case "search":
            console.info(`---- ** SÖKRESULTAT FÖR "` + lineArr[1] + `"\n`);
            console.table(await st.showLoggSearchTerminal(lineArr[1]));
            console.info("\n");
            break;

        case "rapport":
            console.info("---- ** Rapporten\n");
            console.table(await sapo.showRapport());
            console.info("\n");
            break;

        default:
            showMenu();
            break;
    }
    db.end();
}


/**
* Close down program and exit with a status code.
*
* @param {number} code Exit with this value, defaults to 0.
*
* @returns {void}
*/
function exitProgram(code) {
    code = code || 0;

    process.exit(code);
}
