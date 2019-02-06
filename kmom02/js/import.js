/**
* Exercise 1 kmom02.
* import module
* @ author Jen Lee
*/

"use strict";


const utils = require("./stringRange1.js");
let res = "";

res = utils.stringRange(1, 10);
console.info(res);

res = utils.stringRange(1, 10, "-");
console.info(res);

res = utils.stringRange(1, 10, "^_^");
console.info(res);
