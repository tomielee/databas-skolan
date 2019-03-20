/**
* Functions for terminalklient
* Kmom05 eshop
*/
"use strict";

module.exports = {
    showMenu: showMenu,
    handleInput: handleInput,
    exitProgram: exitProgram
};

const mysql = require("promise-mysql");

const config = require ("../config/db/eshop.json");
const te    = require("./terminal-eshop.js");

/**
* Show menu
*/
function showMenu() {
    console.log(
        "  THE MENU\n \n"
        + "     exit, quit: to exit. \n"
        + "     help, menu: to show this menu. \n"
        + "     log <number>: show latest <number> rows in the log . \n"
        + "     shelf: show avaible shelfs in stock. \n"
        + "     inventory: show products in stock. \n"
        + "     inventory <str>: filter inventory by prod id, product name or shelf. \n"
        + "     invadd <productid> <shelf> <number>: add products on specific shelf. \n"
        + "     invdel <productid> <shelf> <number>: del products on specific shelf. \n"





    );
}

/**
* Handle user input
* @param input string, user input
*/
async function handleInput(line) {
    const db = await mysql.createConnection(config);

    line = line.trim();

    let lineArr = line.split(' ');
    let choice = lineArr[0];

    switch (choice) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        case "menu":
        case "help":
            showMenu();
            break;

        case "log":
            console.info("LOG °°° \n");
            console.info(`Showing the latest ${lineArr[1]} input in log`);
            console.table(await te.showLog(lineArr[1]));
            console.info("\n");
            break;

        case "shelf":
            console.info("SHELFS °°° \n");
            console.info(`Avaible shelfs in stock`);
            console.table(await te.showShelfs());
            console.info("\n");
            break;

        case "inventory":
            console.info("INVENTORY °°° \n");
            console.info(`Products in stock stock`);
            if (lineArr[1]) {
                console.table(await te.filterInventory(lineArr[1]));
            } else {
                console.table(await te.showInventory());
            }
            break;

        case "invadd":
            console.info("ADD °°° \n");
            console.info(await handleInvAdd(lineArr));
            console.table(await te.showInventory());
            console.info("\n");
            break;

        case "invdel":
            console.info("ADD °°° \n");
            console.info(await handleInvDel(lineArr));
            console.table(await te.showInventory());
            console.info("\n");
            break;

        default:
            showMenu();
            break;
    }
    db.end();
}

async function handleInvAdd(lineArr) {
    let prodid = lineArr[1];
    let shelf = lineArr[2];
    let items = lineArr[3];

    // let res = await te.addInv(lineArr[1], lineArr[2], lineArr[3])
    let res = await te.addInv(prodid, shelf, items);

    if (res.length > 0) {
        return res[0][0].message;
    } else {
        return `Added ${items} of ${prodid} on ${shelf}.`;
    }
}

async function handleInvDel(lineArr) {
    let prodid = lineArr[1];
    let shelf = lineArr[2];
    let items = lineArr[3];

    // let res = await te.addInv(lineArr[1], lineArr[2], lineArr[3])
    let res = await te.delInv(prodid, shelf, items);

    if (res.length > 0) {
        return res[0][0].message;
    } else {
        return `Deleted ${items} of ${prodid} from ${shelf}.`;
    }
}

/**
* Close down program and exit with a status code.
*
* @param {number} code Exit with this value, defaults to 0.
*
* @returns {void}
*/
function exitProgram(code) {
    code = code || 0;

    process.exit(code);
}
