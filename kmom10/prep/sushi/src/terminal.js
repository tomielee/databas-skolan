/**
* CLIENT FOR TERMINAL
* KMOM10 Förberedande Examinationstenta
* Sushi
* @author Jennifer Lee jelf18
* 2019-03-26
*/

"use strict";

module.exports = {
    showMenu: showMenu,
    handleInput: handleInput,
    exitProgram: exitProgram
};

const mysql = require("promise-mysql");

const config = require ("../config/db/exam.json");
const exam    = require("./exam.js");

/**
* Show menu
*/
function showMenu() {
    console.log(
        "  Välkommen till en japans smakresa!\n \n"
        + "     sushi: Visar alla sushirätter som vunnit tävligen. \n"
        + "     tavling: Visar alla tävlingar. \n"
        + "     tavling <id>: Visar rätterna som tävlade i tävlingen. \n"
        + "---------------------------------------------\n"
        + "     exit: För att avsluta. \n"
    );
}

/**
* Handle user input
* @param input string, user input
*/
async function handleInput(inp) {
    const db = await mysql.createConnection(config);

    inp = inp.trim();

    let inpArr = inp.split(' ');
    let choice = inpArr[0];

    switch (choice) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        case "menu":
        case "help":
            showMenu();
            break;

        case "sushi":
            console.info("Sushi °°° \n");
            console.table(await exam.showAllSushi());
            console.info("\n");
            break;

        case "tavling":
            console.info("Våra tävlingar °°° \n");
            console.table(await handleTavling(inpArr));
            console.info("\n");
            break;

        default:
            showMenu();
            break;
    }
    db.end();
}

function handleTavling(inpArr) {
    if (inpArr.length === 1) {
        return exam.showAllComp();
    } else {
        return exam.showSushiCompTerminal(inpArr[1]);
    }
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
