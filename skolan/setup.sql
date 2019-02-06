-- Skapa databas om den ej redan finns
CREATE DATABASE IF NOT EXISTS skolan;

-- Välj vilken databas du vill använda
USE skolan;

-- Radera en databas med allt innehåll
-- DROP DATABASE skolan;

-- Visa vilka databaser som finns
-- SHOW DATABASES;

-- Visa vilka databaser som finns
-- som heter något i stil med *skolan*
SHOW DATABASES LIKE "%skolan%";

-- Skapa en användare user med lösenorder pass och ge tillgång oavsett
-- hostnamn. 
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
BY 'pass'
;

-- Ta bort en användare -- använder IF NOT EXISTS i create user.
-- DROP USER 'user'@'%';
-- DROP USER IF EXISTS 'user'@'%';

-- Skapa användaren med en bakåtkompatibel lösenordsalgoritm.
-- CREATE USER IF NOT EXISTS 'user'@'%'
-- IDENTIFIED
-- WITH mysql_native_password -- MySQL with version > 8.0.4
-- BY 'pass'
-- ;


-- -- Skapa användaren "user" med
-- -- lösenordet "pass" och ge
-- -- fulla rättigheter till databasen "skolan"
-- -- när användaren loggar in från maskinen "localhost"
-- GRANT ALL ON skolan.* TO user@localhost IDENTIFIED BY 'pass';

-- Ge användaren alla rättigheter på en specifk databas.
GRANT ALL PRIVILEGES
    ON skolan.*
    TO 'user'@'%'
;

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';

-- Visa för nuvarande användare
-- SHOW GRANTS FOR CURRENT_USER;