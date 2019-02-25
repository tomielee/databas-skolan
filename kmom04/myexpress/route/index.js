"use strict";

const express = require("express");
const router = express.Router(); //anropa Router funktionen i expressobjektet.

//skapa en route, en grund URL
//get - hämta
//post request - kommer längre fram som t.ex. sicka data i ett formulär
// "/" grund url >> en anonym funktion som tar emot två argument req och res
//req kommer innehålla som klienten, webbläsaren, har skickat
//res det vi skickar tillbaka -
router.get("/", (req, res) => {
    res.send("Hello World!");
});

router.get("/about", (req, res) => {
    res.send("About something!");
});

module.exports = router;
