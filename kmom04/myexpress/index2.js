"use strict";

const port = 1337;
//ejs en vy template motor
//express framework för node

const express = require('express'); //installerad via npm
const routeIndex = require('./route/index.js');
const routeToday = require('./route/today.js');

const middleware = require('./middleware/index.js');
const path = require('path'); // gå bland filerna.
const app = express();

//app.set("attribut", "värde")
//express fattar och fixar - mappen måste hitta views
app.set("view engine", "ejs");


// LÄGG DENNA LOGG INNAN något annat görs.
// https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#structmiddle
app.use(middleware.logIncomingToConsole);


//express.static //statiska filer vi vill skicka
//den mapp vi är i , join med public
app.use(express.static(path.join(__dirname, "public")));

app.use("/", routeIndex);
app.use("/today", routeToday);

app.listen(port, logStartUpDetailsToConsole);



/**
* Function för at visa vilka routers som finns tillgängliga samt att lägga till.
* https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#structfunc
* app.listen(port, () => {
    * console.info(`Server lyssnar på ${port}.`);
* });
*/

function logStartUpDetailsToConsole() {
    let routes = [];

    //Find supported routes
    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            //Registered routes
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            //Routes addes as router Middleware
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                route && routes.push(route);
            });
        }
    });

    console.info(`Server is listening on port ${port}.`);
    console.info("Available routes are:");
    console.info(routes);
}
