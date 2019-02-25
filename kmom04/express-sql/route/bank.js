/**
* Route for views/bank/... fil.
* https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#rendera
* @author Jen Lee
*/
"use strict";
const express = require("express");
const router  = express.Router();

const bank    = require("../src/bank.js");


router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | The Bank"
    };

    res.render("bank/index", data);
});

router.get("/balance", async (req, res) => {
    let data = {
        title: "Account balance | The Bank"
    };

    data.res = await bank.showBalance();

    res.render("bank/balance", data);
});

module.exports = router;
