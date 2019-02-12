/**
 * Exercise 1. Kmom03
 * Course databas
 * Using Node.js, Javascript, await async, ER-modeling
 * @ author Jen Lee
 */
"use strict";

class Game {
    /**
    * @constructor
    * @this
    */
   constructor() {
       this.thinking = -1;
   }
    /**
     * Init the game and guess the number.
     *
     * @returns void
     */
    init() {
        this.thinking = Math.round(Math.random() * 100 + 1);
    }

    /**
     * Check if the guess is correct or not.
     *
     * @param {integer} guess The number being guessed.
     *
     * @returns {boolean} True if guess matches thinking, else false.
     */
    check(guess) {
        return guess === this.thinking;
    }
    /**
     * Cheat.
     *
     * @param {integer} guess The number being guessed.
     *
     * @returns {integer} thinking
     */
    cheat() {
        return this.thinking;
    }

    /**
     * Compare guess value with thinking value.
     *
     * @param {integer} guess The number being guessed.
     *
     * @returns {string} 'greater' if guess > thinkging and vv.
     */
    compare(guess) {
        if (guess > this.thinking) {
            return "You're thinking of a greater number than me.";
        }
        else if (guess < this.thinking) {
            return "You're thinkning of a smaller number than me.";
        }
    }
}

module.exports = Game;
