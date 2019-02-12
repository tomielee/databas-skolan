/**
 * Exercise 1. Kmom03
 * Course databas
 * Using Node.js, Javascript, await async, ER-modeling
 * @ author Jen Lee
 */
"use strict";

// const config = require('./config.json');
const mysql = require('promise-mysql');
const readline = require('readline');

/**
* MAIN function
*/
(function() {
    const rl = readline.createInterface({
        input: process.stdin, //process inbyggd i node tillgång till standard in
        output: process.stdout //kan även vara en fil
    });

    rl.setPrompt("Choose from the menu: ");
    rl.prompt(); //visa prompten

    rl.on('close', process.exit); //kunna avsluta
    //varje gång vi klickar enter i terminalen får vi ut detta.
    //line är vår variabel, vad ska ske =>
    rl.on('line', (line) => {
        console.log(line);

        rl.prompt();

    });//använd en funktion? vad ska hända vid ny line
})();
