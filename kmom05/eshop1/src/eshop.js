/**
* FUNCTION FOR THE WEB
* moudels for export for eshop1
*/
"use strict";

module.exports = {
    showAllProducts: showAllProducts,
    showCategory: showCategory,
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

// SHOW ALL PRODUCTS

async function showAllProducts() {
    let sql = `CALL show_all_products();`;

    let res = await db.query(sql);

    console.info(`showAllProducts >> SQL: ${sql} got ${res.length} rows`);


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
async function editProduct(id, title, info, price, items) {
    let sql = `CALL edit_product(?, ?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, title, info, price, items]);

    console.info(`editProduct >> SQL: ${sql} got ${res.length} rows`);
}

// DELETE PRODUCT
// @ param
async function deleteProduct(id) {
    let sql = `CALL delete_product(?);`;
    let res;

    res = await db.query(sql, [id]);

    console.info(`deleteProduct >> SQL: ${sql} got ${res.length} rows`);
}
