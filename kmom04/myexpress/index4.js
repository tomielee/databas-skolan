/**
* KMOM 04 - övningar
* kopy och redigering från index3.js som redan innehåller lite vyer
* från genomgången.
*/
"use strict";

const port = 1337;
const express = require('express'); //installerad via npm
const routeIndex = require('./route/index.js');
const routeToday = require('./route/today.js');

const middleware = require('./middleware/index.js');
const path = require('path'); // gå bland filerna.
const app = express();

// VYER OCH TEMPLATEMOTOR
//https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#vyer
app.set("view engine", "ejs");


// MIDDLEWARE
//en log. kolla middleware mappen.
// https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#structmiddle
app.use(middleware.logIncomingToConsole);


// STATISKA FILER
//express.static //statiska filer vi vill skicka
//den mapp vi är i , join med public
//https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#publicexppress
app.use(express.static(path.join(__dirname, "public")))

//ROUTES
app.use("/", routeIndex);
app.use("/today", routeToday);

// VISAR tillgängliga routes.
app.listen(port, logStartUpDetailsToConsole);

//ORDNINGEN
// https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#ordning


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
};
