/**
* Route for views/today.ejs.
* https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#rendera
* @author Jen Lee
*/
"use strict";

const express = require("express");
const router = express.Router(); //anropa Router funktionen i expressobjektet.


router.get("/", (req, res) => {
    let data= {}; // ett dataobjekt som vi sedan kan tilldela attribut.

    data.date = new Date(); //variabeln date i today.ejs

    res.render("today", data)  //en vy + datan
});

module.exports = router;


/** EGNA NOTES
route som renderar vyn för today.
48 min på genomgången!

skapa en route, en grund URL
get - hämta
post request - kommer längre fram som t.ex. sicka data i ett formulär
 "/" grund url >> en anonym funktion som tar emot två argument req och res
req kommer innehålla som klienten, webbläsaren, har skickat
res det vi skickar tillbaka -
*/
