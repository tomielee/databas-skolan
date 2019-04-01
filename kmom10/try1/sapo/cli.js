/**
* Mainfunktionen för terminalklienten
* CLI.JS ör Examinationstenta
* Examinationstenta kmom10
* database sapo
*
* @author Jennifer Lee - jelf18
* 2019-03-28
*/


"use strict";

/** To handle input for terminal*/
const readline      = require('readline');
const rl            = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const util          = require('util');

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};

const terminal    = require("./src/terminal.js");

/** FOR TERMIINAL */
/**
* MAIN function
*/
(function() {
    rl.on("close", terminal.exitProgram); //när användaren väljer exit.
    rl.on("line", terminal.handleInput); //när användaren klickar enter
    //configurera och hämta vilken databas och login info.

    rl.setPrompt("Väkommen till Säpos terminalklient. Skriv 'menu' för att se menyn.. \n");
    rl.prompt("Ditt val:");
    rl.prompt();
})();
