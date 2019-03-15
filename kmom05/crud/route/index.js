/**
 * General routes.
 */
"use strict";

const express = require("express");
const router  = express.Router();

// Add a route for the path /
router.get("/", (req, res) => {
    res.send("FÖRSTA SIDAN");
});

// Add a route for the path /about
router.get("/about", (req, res) => {
    res.send("ABOUTSIDAN");
});

module.exports = router;
