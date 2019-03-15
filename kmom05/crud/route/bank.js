/**
* Route for views/bank/... fil.
* https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#rendera
*
* @author Jen Lee
*/
"use strict";
const express = require("express");
const router  = express.Router();
const bodyParser = require("body-parser");
//hämtar ut body i vårt request objekt (se create account post)
const urlencodedParser = bodyParser.urlencoded({ extended: false });


const bank    = require("../src/bank.js");

// FÖRSTA SIDAN
router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | The Bank"
    };

    res.render("bank/index", data);
});

// BALANCE
router.get("/balance", async (req, res) => {
    let data = {
        title: "Account balance | The Bank"
    };

    data.res = await bank.showBalance();

    res.render("bank/balance", data);
});

// MOVE MONEY FROM EVA TO ADAM
router.get("/move-to-adam", async (req, res) => {
    let data = {
        title: "Moved money to Adam | The Bank"
    };

    data.res = await bank.transactionAdam();

    res.render("bank/move-to-adam", data);
});


// CREATE ACCOUNT
router.get("/create", async (req, res) => {
    let data = {
        title: "Create an account | The Bank"
    };

    data.res = await bank.transactionAdam();

    res.render("bank/create", data);
});

// CREATE POST ACCOUNT
// Receive data from posted form
// Send data to stored procedure (show_balance kolla ddl.procedure kmom05)
router.post("/create", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await bank.createAccount(req.body.id, req.body.name, req.body.balance);
    res.redirect("/bank/balance");
});

// VIEW ACCOUNT
router.get("/account/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Account ${id}`,
        account: id
    };

    data.res = await bank.showAccount(id);

    res.render("bank/account-view", data);
});

// EDIT ACCOUNT
router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Account ${id}`,
        account: id
    };

    data.res = await bank.showAccount(id);

    res.render("bank/account-edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await bank.editAccount(req.body.id, req.body.name, req.body.balance);
    //OBS! i övningen ska redirectas till edit igen.
    // res.redirect(`/bank/edit/${req.body.id}`);

    res.redirect(`/bank/account/${req.body.id}`);
});

//DELETE Account
router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Account ${id}`,
        account: id
    };

    //Show the account that you want to delete
    data.res = await bank.showAccount(id);

    res.render("bank/account-delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    console.log("borde deletea")
    await bank.deleteAccount(req.body.id);

    res.redirect(`/bank/balance`);
});

module.exports = router;
