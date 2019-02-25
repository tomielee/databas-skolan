/**
* Functions for kmom04, terminalbased bank assignment
*/
"use strict";

module.exports = {
    showMenu: showMenu,
    handleInput: handleInput,
    exitProgram: exitProgram
};

const mysql = require("promise-mysql");

const config = require ("../config/db/bank.json");
const bank    = require("./bank.js");

/**
* Show menu
*/
function showMenu() {
    console.log(
        "  THE MENU\n \n"
        + "     exit, quit: to exit. \n"
        + "     help, menu: to show this menu. \n"
        + "     move: to move 1.5 peng from Adam to Eva. \n"
        + "     balance: show balance.\n"
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
        case "balance":
            console.info("THE BALANCE");
            console.table(await bank.showBalance());
            console.info("\n");
            break;
        case "move":
            console.log("You've just moved 1.5 peng from Eva to Adam. \n");
            await bank.transactionEva();
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
