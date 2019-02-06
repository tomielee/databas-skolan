--
-- Create reports from table teacher from database skolan
-- By Jen Lee, course databas v1
-- 2018-02-05
-- https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/union

--
-- UNION https://dev.mysql.com/doc/refman/8.0/en/union.html
--

SELECT 
	sal.origin,
    acronym,
    fname,
    sirname,
    sex,
    competence,
    salary
FROM
(
	SELECT
    *,
		'after' AS origin FROM teacher
	UNION
	SELECT
		*,
		'before' AS origin FROM teacher_pre
) AS sal
WHERE
	acronym IN('ala', 'dum')
ORDER BY acronym, origin
;