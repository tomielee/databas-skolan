/**
* Exercise 1 kmom02. testing javascript in node - copy of instructor.js
* for command line utility
* REPL
* @ author Jen Lee
*/


/**
* A couple of test functions
*/
function main() {
    // let a = 5;
    // let b;
    let range = "";

    // b = a + 1;

    for (let i = 0; i < 8; i ++) {
        range += i + ", ";
    }

    console.info(range.substr(0, range.length -2));

    let small = 0;

    while (small < 10) {
        console.info(small);
        if (small == 3 | small == 5) {
            console.info("liten" + small);
        }
        small +=1;
    }
}

main();
