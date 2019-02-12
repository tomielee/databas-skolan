/**
 * Exercise 1. Kmom03
 * Course databas
 * Using Node.js, Javascript, await async, ER-modeling
 * @ author Jen Lee
 */
"use strict";

const Game = require('./game.js');
const game = new Game(); //init a new object of Game.

const mysql = require('promise-mysql');

const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
// Promisify rl.question to question
const util = require("util");

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = util.promisify(rl.question);

/**
* MAIN function
*/
(function() {
    rl.on("close", exitProgram); //när användaren väljer exit.
    rl.on("line", handleInput); //när användaren klickar enter

    game.init(); //initerar ett nytt spelobjekt

    console.log(
        "Lets run a game of 'Guess my number'!\n"
        + "I am guessing of a number between 1 and 100.\n"
        + "Can you find out what number I'm guessing?\n"
    );

    rl.setPrompt("Guess my number: "); //vad ska det stå i terminalen
    rl.prompt(); //visa $ på en gång


})();

/**
* Handle input as command
* @param (string) input from user
*/
function handleInput(line) {
    let guess;

    line = line.trim(); //ta bort alla whitespaces
    switch (line) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        default:
            guess = Number.parseInt(line); //gör om input line string till integ
            makeGuess(guess);
    }

    rl.prompt();
}

/**
* Function to handle guess
* @param guess input value from player
* @return bool true if guess == thinking
*/
function makeGuess(guess) {
    let match;
    let message;
    let thinking = game.cheat();

    match = game.check(guess);
    message = `Ok, cheating, the number I'm thinking of is... ${thinking} \n`
        + `You're guess is ${guess}\n`
        + `You guessed right?`
        + match;

    console.info(message);

    return match;
}

/**
Du kan se ytterligare ett exempel på det i funktionen exitProgram().
Det är en funktion som avslutar alla processer och stänger programmet
med en exit kod som normalt är 0, vilket innebär att programmets
exekvering gick bra.
*/

/**
* Close down program and exit with a status code.
*
* @param {number} code Exit with this value, defaults to 0.
*
* @returns {void}
*/
function exitProgram(code) {
    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);

// (async function() {
//     let guess;
//     let match;
//
//     game.init(); //här ligger thinkning - random number - kolla game obj.
//
//     console.log(
//     "Lets run a game of 'Guess my number'!\n"
//     + "I am guessing of a number between 1 and 100.\n"
//     + "Can you find out what number I'm guessing?\n"
//     );
//
//     while (!match) {
//         guess = await question("Guess my number: "); //wait for user input
//         guess = Number.parseInt(guess); //parseInt return a int of the string
//         match = makeGuess(guess);
//     }
//
//     console.log("You've solved it. Congrats!");
//
//     exitProgram();
// })();


}
