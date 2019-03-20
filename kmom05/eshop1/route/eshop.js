/**
* Route for views/eshop/... fil.
* Mycket copy från crud
* https://dbwebb.se/uppgift/bygg-databasen-till-en-eshop-del-1
*
* @author Jen Lee
*/
"use strict";
const express = require("express");
const router  = express.Router();
const bodyParser = require("body-parser");
//hämtar ut body i vårt request objekt (se create account post)
const urlencodedParser = bodyParser.urlencoded({ extended: false });


// const bank    = require("../src/bank.js");
const eshop    = require("../src/eshop.js"); //src eshop.js - alla moduler


// FÖRSTA SIDAN
router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | The Shop"
    };

    res.render("eshop/index", data);
});

// CATEGORIES
router.get("/category", async (req, res) => {
    let data = {
        title: "Categories | The Shop"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

// PRODUCTS
router.get("/products", async (req, res) => {
    let data = {
        title: "Products | The Shop"
    };

    data.res = await eshop.showAllProducts();

    res.render("eshop/products", data);
});

// ADMIN
router.get("/admin", async (req, res) => {
    let data = {
        title: "Admin | The Shop"
    };

    data.res = await eshop.showAllProducts();

    res.render("eshop/admin", data);
});

// // ADD PRODUCT
// SHOW A FORM ADD INFO ON NEW PRODUCT
router.get("/add", async (req, res) => {
    let data = {
        title: "Add a product | The shop"
    };

    res.render("eshop/add", data);
});

router.post("/add", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.addProduct(
        req.body.id,
        req.body.title,
        req.body.info,
        req.body.price,
        req.body.shelf,
        req.body.items
    );

    res.redirect("/eshop/products");
});

// // EDIT PRODUCT
router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Product ${id}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    await eshop.editProduct(
        req.body.id,
        req.body.title,
        req.body.info,
        req.body.price,
        req.body.items
    );
    res.redirect(`/eshop/admin`);
});

// // DELETE PRODUCT
router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Product ${id}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    await eshop.deleteProduct(
        req.body.id
    );
    res.redirect(`/eshop/admin`);
});


module.exports = router;
