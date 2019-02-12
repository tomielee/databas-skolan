/**
 * Assignment 1. Kmom03
 * Course databas
 * Using Node.js, Javascript, await async, rl.prompt, ER-modelering
 * @author Jen Lee
 */
"use strict";

const config = require('./config.json');
const mysql = require('promise-mysql');

const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const util = require('util');

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
// const question = util.promisify(rl.question);

/**
* import own modules
*/
const larare = require('./teachers.js');
const kompetens = require('./competence.js');
const lon = require('./salary.js');
const sok = require('./search.js');
const nylon = require('./newsalary.js');

/**
* MAIN function
*/
(function() {
    showMenu();

    rl.on("close", exitProgram); //när användaren väljer exit.
    rl.on("line", handleInput); //när användaren klickar enter
    //configurera och hämta vilken databas och login info.

    rl.setPrompt("Your choice: ");
    rl.prompt();
})();

/**Show menu*/
function showMenu() {
    console.log(
        "°°°Choose from the menu. °°°\n \n"
        + "* larare: tabell över lärarna \n"
        + "* kompetens: en rapport på förändringen i komptenes \n"
        + "* lon: rapport hur lönen förändras i senaste lönerevision \n"
        + "* sok <string>: sök på lärare\n"
        + "* nylon <acro> <newsalary>: sätt en ny lön hos lärare efter akronym\n"
        + "°°°exit°°°  to exit. | °°°help°°° for menu\n"
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
        case "larare":
            console.log("Visar tabellen för samtliga lärare.\n");
            console.table(await larare.viewTeachers(db));
            rl.prompt();
            break;
        case "kompetens":
            console.log("Visar förändringen i kompetens. \n");
            console.table(await kompetens.compDiff(db));
            rl.prompt();
            break;
        case "lon":
            console.log("Visar förändringen i lön. \n");
            console.table(await lon.salDiff(db));
            rl.prompt();
            break;
        case "sok":
            console.log("Söker på lärare. \n");
            console.table(await sok.searchTeacher(db, lineArr[1]));
            rl.prompt();
            break;
        case "nylon":
            console.log("Uppdaterar en lärares lön. \n");
            console.table(await nylon.newSalary(db, lineArr[1], lineArr[2]));
            rl.prompt();
            break;
        case "help":
            showMenu();
            rl.prompt();
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
