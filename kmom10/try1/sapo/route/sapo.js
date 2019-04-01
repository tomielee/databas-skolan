/**
* Route for webbklienten
* databasen sapo
* Examinationstenta kmom10
* databas v1
*
* @author Jennifer Lee - jelf18
* 2019-03-28
*/

"use strict";
const express = require("express");
const router  = express.Router();
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });


const sapo    = require("../src/sapo.js");


// FÖRSTA SIDAN
router.get("/index", (req, res) => {
    let data = {
        title: "SÄPO (på låtsas)"
    };

    res.render("sapo/index", data);
});


// ABOUT
router.get("/about", (req, res) => {
    let data = {
        title: "ABOUT"
    };

    res.render("sapo/about", data);
});

// LOGG
router.get("/logg", async (req, res) => {
    let data = {
        title: "SÄPOS logg",
        headline: "Säpos logg",
        info: "Visar all logginlägg"
    };

    data.logg = await sapo.showLogg();

    res.render(`sapo/logg`, data);
});

// SEARCH
// result logg filtrerad with search from user

router.get("/search", async (req, res) => {
    let data = {
        title: "SÄPOS logg sök",
        headline: "Sök i Säpos logg.",
        info: "Skriv sökord nedan."
    };

    res.render(`sapo/search`, data);
});

router.get("/search/:s", async (req, res) => {
    let search = req.params.s;
    let data = {
        title: "SÄPOS logg",
        headline: "Säpos logg, sökresultat",
        info: "Visar sökresultat av '" + search + "'"
    };

    data.logg = await sapo.showLoggSearch(search);

    res.render(`sapo/logg`, data);
});

router.post("/search", urlencodedParser, async (req, res) => {
    let search = req.body.search;

    res.redirect(`/sapo/search/${search}`);
});

// RAPPORT
// result logg filtrerad with search from user

router.get("/rapport", async (req, res) => {
    let data = {
        title: "SÄPOS extra rapport",
        headline: "RAPPORTEN",
        info: "Visar rapporten enligt spec"
    };

    data.res = await sapo.showRapport();

    res.render(`sapo/rapport`, data);
});



module.exports = router;
