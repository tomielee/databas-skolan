/**
 * Assignment 1. Kmom02
 * Course databas
 * Using Node.js, Javascript, await async
 * @ author Jen Lee
 */
"use strict";

const config = require('./config.json');
const mysql = require('promise-mysql');
const user = require('./choice.js');


/**
* MAIN function
*/
(async function() {
    //configurera och hämta vilken databas och login info.
    const db = await mysql.createConnection(config);

    user.userChoice();


    db.end();
})();
