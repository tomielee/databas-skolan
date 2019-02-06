/**
 * Exercise 3 kmom02.
 * search function with user input.
 * promisift rl
 * @ author Jen Lee
 */
"use strict";

module.exports = {
    "userChoice": userChoice
};


const config = require('./config.json');
const mysql = require('promise-mysql');
const readline = require('readline');
const util = require('util'); //built-in
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};

const question = util.promisify(rl.question);


const view = require('./teacher.js');
const find = require('./search.js');
const between = require('./between.js');



/**
* handle user input
* @param question user input choice of output.
*/
async function userChoice() {
    //configurera och hämta vilken databas och login info.
    const db = await mysql.createConnection(config);

    let str;
    let choice;
    let search;
    let searchMin;
    let searchMax;

    choice = await question(
        "    Please make a selection: \n" +
        "    T) All teachers in table teacher. \n" +
        "    S) Search for specific teacher. \n" +
        "    B) Search for teachers with salary or comp betw a min and max value \n"
    );

    console.info("Displaying your coice: " + choice.toUpperCase() + "\n");

    if (choice.toLowerCase().trim() == "t") {
        str = await view.viewTeachers(db);
        console.info(str);
    } else if (choice.toLowerCase().trim() == "s") {
        search = await question("Search in table teachers: ");
        str = await find.searchTeacher(db, search);
        console.info(str);
    } else if (choice.toLowerCase().trim() == "b") {
        searchMin = await question("Min value: ");
        searchMax = await question("Max value: ");
        str = await between.valBetween(db, searchMin, searchMax);
        console.info(str);
    } else {
        console.info("Not available. Please try again.");
    }

    rl.close();
    db.end();
}
