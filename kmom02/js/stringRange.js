/**
 * Exercise 1 kmom02. testing javascript in node - copy of instructor.js
 * for command line utility
 * REPL
 * @ author Jen Lee
 */


"use strict";

/**
* Stringrange function to test.
*/
function stringRange(a, b, sep = ", ") {
    let res = "";
    let i = a;

    while (i < 10) {
        res += i + sep;
        i ++;
    }

    res = res.substring(0, res.length - sep.length);
    return res;
}

console.log(stringRange(0, 2));
