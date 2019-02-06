--
-- Ceate table teacher
-- By Jen Lee
-- 2018 - 02 - 05
-- recreated because the last ddl.sql was ereased...
--

--
-- Create table: teacher
--

DROP TABLE IF EXISTS teacher;

CREATE TABLE teacher
(
    acronym CHAR(3),
    section CHAR(4),
    fname VARCHAR(20),
    sirname VARCHAR(20),
    sex CHAR(1),
    salary INT,
    birth DATE,

    PRIMARY KEY (acronym)
);