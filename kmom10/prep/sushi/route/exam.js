/**
* Routes for exam
* KMOM10 Förberedande Examinationstenta
* Sushi
* @author Jennifer Lee jelf18
* 2019-03-26
*/

"use strict";

const express = require("express");
const router  = express.Router();
// const bodyParser = require("body-parser");
//hämtar ut body i vårt request objekt (se create account post)
// const urlencodedParser = bodyParser.urlencoded({ extended: false });


const exam    = require("../src/exam.js");

// FÖRSTA SIDAN
router.get("/index", (req, res) => {
    let data = {
        title: "Sushi sushi sushi"
    };

    res.render("exam/index", data);
});

// SUSHI
// show all sushi in table sushi
router.get("/sushi", async (req, res) => {
    let data = {
        title: "About"
    };

    data.sushi = await exam.showAllSushi();

    res.render(`exam/sushi`, data);
});

// COMPETITIONS
// show all the competitions
router.get("/comp", async (req, res) => {
    let data = {
        title: "Competitions"
    };

    data.comp = await exam.showAllComp();

    res.render(`exam/comp`, data);
});

// COMPETITION
// More info about a specific competition
router.get("/comp-info/:id", async (req, res) => {
    let compid = req.params.id;

    let data = {
        title: "Competition info"
    };

    data.sc = await exam.showSushiComp(compid);

    res.render(`exam/comp-info`, data);
});

// ABOUT
router.get("/about", (req, res) => {
    let data = {
        title: "About"
    };

    res.render(`exam/about`, data);
});


module.exports = router;
