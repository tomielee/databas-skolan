/**
* For kmom03.
* From Assignment 1. Kmom02
* Course databas
* Using Node.js, Javascript, await async
* @author Jen Lee
*/
"use strict";

module.exports = {
    "createTable": createTable
};

/**
* function to create table
* @param res a dict
*
* @return str a string as a table
*/

function createTable(res) {
    let str;

    str  = "+ ----------| --------------------| ----------| ----------|------| -----------+\n";
    str += "+ -ACRONYM--| -NAME---------------| -SECTION--| -SALARY---|-COMP-| -BIRTH-----+\n";
    str += "+ ----------| --------------------| ----------| ----------|------| -----------+\n";
    for (const row of res) {
        //start of a row and col
        str += "| ";
        //rad akronym + ett space på 10 för att fylla upp kolumn 12teck
        str += row.acronym.padEnd(10);
        str += "| ";
        str += (row.fname + " " + row.sirname).padEnd(20);
        str += "| ";
        str += row.section.padEnd(10);
        str += "| ";
        str += row.salary.toString().padEnd(10);
        str += "| ";
        str += row.competence.toString().padEnd(5);
        str += "| ";
        str += dateFormat(row.birth).padEnd(10);
        str += " |\n";
    }
    str += "+ ----------| --------------------| ----------| ----------|------|------------+\n";
    str += "..END OF TABLE ..";

    return str;
}

/**
@param date date
@returns newdate in format YYYY-MM-DD
*/
function dateFormat(date) {
    var fDate = new Date(date),
        year = fDate.getFullYear(),
        month = (fDate.getMonth() + 1), // jan = 0, dec = 11
        day = fDate.getDate();


    if (month.toString().length < 2) {month = "0" + month;}
    if (day.toString().length < 2) {day = "0" + day;}


    return [year, month, day].join('-');
}
