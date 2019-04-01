--
-- Functions
-- For kmom06
-- By Jen Lee, course databas v
-- 2018-03-20

USE dbwebb;

CREATE USER IF NOT EXISTS 'user'
IDENTIFIED
BY 'pass'
;

GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'
;

SET GLOBAL log_bin_trust_function_creators = 0;


-- EXEMPEL
-- https://dbwebb.se/kunskap/egen-definierade-funktioner-i-databas#ex
DROP TABLE IF EXISTS exam;
CREATE TABLE exam
(
	`acronym`CHAR (4),
    `score`INTEGER,
    
    PRIMARY KEY (`acronym`)
);

INSERT INTO exam
	VALUES
		('adam', 77),
		('ubbe', 52),
		('june', 49),
		('john', 63),
		('meta', 97),
		('siva', 88);

SELECT * FROM exam;

-- CREATE FUNCTION
-- https://dbwebb.se/kunskap/egen-definierade-funktioner-i-databas#create

-- FUNCTION FOR GRADES
--

-- DROP FUNCTION IF EXISTS grade;
-- DELIMITER ;;

-- CREATE FUNCTION grade(
-- 	score INTEGER
-- )
-- RETURNS INTEGER
-- BEGIN
-- 	RETURN score;
-- END
-- ;;

-- DELIMITER ;


-- FUNCTION WITH FLOW CONTROL STATMENTS
--
DROP FUNCTION IF EXISTS grade;
DELIMITER ;;

CREATE FUNCTION grade(
	score INTEGER
)
RETURNS CHAR(2)
DETERMINISTIC
BEGIN
	IF score >= 90 THEN
        RETURN 'A';
    ELSEIF score >= 80 THEN
        RETURN 'B';
    ELSEIF score >= 70 THEN
        RETURN 'C';
    ELSEIF score >= 60 THEN
        RETURN 'D';
    ELSEIF score >= 55 THEN
        RETURN 'E';
    ELSEIF score >= 50 THEN
        RETURN 'FX';
    END IF;
    RETURN 'F';
END
;;

DELIMITER ;

--
-- FUNCTION grade2, U, 3-5
--
DROP FUNCTION IF EXISTS grade2;
DELIMITER ;;

CREATE FUNCTION grade2(
    score INTEGER
)
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    IF score >= 90 THEN
        RETURN '5';
    ELSEIF score >= 70 THEN
        RETURN '4';
    ELSEIF score >= 55 THEN
        RETURN '3';
    END IF;
    RETURN 'U';
END
;;

DELIMITER ;



SELECT *,
	grade(score) AS 'A-F, FX',
    grade2(score) AS 'U,3-5'
FROM exam
ORDER BY score DESC;


-- DETERMENISTIC and NOT DETERMINISTICK function
-- https://dbwebb.se/kunskap/egen-definierade-funktioner-i-databas#karaktar
-- Deterministic - alltid samma svar när en mängd parameterar skickas in
-- Not Deterministic - olika även om samma mängd parameterar skickas in. t.ex. retur av ålder som blir olika även om födelesdatumet (inparamenter)
-- är densamma.

DROP FUNCTION IF EXISTS time_of_the_day;
DELIMITER ;;

CREATE FUNCTION time_of_the_day()
RETURNS DATETIME
NOT DETERMINISTIC NO SQL
BEGIN
    RETURN NOW();
END
;;

DELIMITER ;

SELECT time_of_the_day();

-- SHOW FUNCTIONS
--
SHOW FUNCTION STATUS;

-- i terminalen >>
-- SHOW FUNCTION STATUS LIKE 'grade' \G
-- SHOW FUNCTION STATUS WHERE Db = 'dbwebb';
-- koden bakom funktionen
-- SHOW CREATE FUNCTION grade \G


