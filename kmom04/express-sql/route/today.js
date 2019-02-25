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
