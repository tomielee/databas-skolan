# !/usr/local/bin/env bash
#
# Recreate and reset the database to be as after part 1
# 08_dml_update_salaryrevision
#


# user root
# recreate database
# /dev/null = no prints
# user och pass är satt https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/aterstall-databasen-del-1#warning
file='setup.sql'
mysql -uroot -p skolan < $file > /dev/null

file='ddl.sql'
echo ">>> Create tables($file)"
mysql -uuser skolan < $file > /dev/null

file='dml_insert.sql'
echo ">>> Insert data in table"
mysql -uuser skolan < $file > /dev/null

file='ddl_migrate.sql'
echo ">>> Edit data in table, using ALTER TABLE"
mysql -uuser skolan < $file > /dev/null

file='dml_update.sql'
echo ">>> Update and set salaries before salaryrevision, $file"
mysql -uuser skolan < $file > /dev/null

file='ddl_copy.sql'
echo ">>> Creating a copy of teacher in teacher_pre, $file"
mysql -uuser skolan < $file> /dev/null

# file='dml_update_lonerevision.sql'
# echo ">>> Making the changes in salary with $file"
# mysql -uuser skolan < $file> /dev/null
#
# echo ">>> Check salary = 330242, competence = 19 in teacher:"
# mysql -uuser skolan -e "SELECT SUM(salary) AS 'Sal', SUM(competence) AS 'Comp' FROM teacher;"
# echo ">>> Check salary = 30500, competence = 8 in teacher_pre:"
# mysql -uuser skolan -e "SELECT SUM(salary) AS 'Sal', SUM(competence) AS 'Comp' FROM teacher_pre;"

# mysql -uuser -ppass skolan < ddl.sql
# mysql -uuser -ppass skolan < dml_insert.sql
# mysql -uuser -ppass skolan < ddl_migrate.sql
# mysql -uuser -ppass skolan < dml_update.sql
