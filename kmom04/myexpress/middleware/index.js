/**
* Middleware
* Skapar en log.
* Kmom04 https://dbwebb.se/kunskap/grunderna-i-express-med-nodejs#structmiddle
* @author Jen Lee
*/

"use strict";

/**
* Log incoming requests to see what acces to the server on what route
*
* @param {Request} req Incoming request.
* @param {Response} res Outcoing response.
* @param {Function} next Next to call in chain of middleware.
*/

function logIncomingToConsole(req, res, next) {
    console.info(
        `Got request on ${req.path} (${req.method}).`
    );

    next();
}
module.exports = {
    logIncomingToConsole: logIncomingToConsole
};
