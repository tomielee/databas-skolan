/**
* FUNCTION FOR THE WEB
* moudels for export for eshop1
*/
"use strict";

module.exports = {
    showAllProducts: showAllProducts,
    showAbout: showAbout,
    showCategory: showCategory,
    showCatProd: showCatProd,
    addProduct: addProduct,
    showProduct: showProduct,
    editProduct: editProduct,
    deleteProduct: deleteProduct
};

const mysql = require("promise-mysql");
const config = require ("../config/db/eshop.json");


let db;

/**
* Main function
*/
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end(); //om exit, anonymfunktion som avslutar.
    });
})();

//SHOW ABOUT
async function showAbout() {
    let sql = 'SELECT * FROM about;';
    let about = await db.query(sql);

    return about;
}

// SHOW ALL PRODUCTS

async function showAllProducts() {
    let sql = `CALL show_all_products();`;

    let res = await db.query(sql);

    console.info(`showAllProducts >> SQL: ${sql} got ${res.length} rows`);
    console.info(res[0]);

    return res[0];
}

// SHOW CATEGORY
async function showCategory() {
    let sql = `CALL show_categories();`;

    let res = await db.query(sql);

    console.info(`showCategory >> SQL: ${sql} got ${res.length} rows`);
    console.info(res[0]);

    return res[0];
}

// SHOW CAT PRODUCT
// products sorted in specific category
async function showCatProd(catid) {
    let sql = `CALL show_cat_prod(?);`;

    let prod = await db.query(sql, [catid]);

    console.log(prod[0]);
    return prod[0];
}

// ADD PRODUCT
async function addProduct(id, title, info, price) {
    let sql = `CALL add_product(?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, title, info, price]);

    console.info(`addProduct >> SQL: ${sql} got ${res.length} rows`);
}

// SHOW PRODUCT
async function showProduct(id) {
    let sql = `CALL show_product(?);`;
    let res;

    res = await db.query(sql, [id]);

    console.info(`showProduct >> SQL: ${sql} got ${res.length} rows`);

    return res[0][0];
}

// EDIT PRODUCT
async function editProduct(id, title, info, price, cat) {
    let sql = `CALL edit_product(?, ?, ?, ?, ?);`;

    for (var i = 0; i < cat.length; i++) {
        await db.query(sql, [id, title, info, price, cat[i]]);
    }
    // res = await db.query(sql, [id, title, info, price, cat]);

    console.info(`editProduct >> SQL: ${sql} rows`);
}

// DELETE PRODUCT
// @ param
async function deleteProduct(id) {
    let sql = `CALL delete_product(?);`;
    let res;

    res = await db.query(sql, [id]);

    console.info(`deleteProduct >> SQL: ${sql} got ${res.length} rows`);
}
