#!/usr/local/bin/env bash
#
#Recreate and reset the database to be as after part 2
#shellcheck disable=SC2181

#
# Load a SQL file into skolan
#
function loadSqlIntoSkolan
{
    echo ">>> $4 ($3)"

    mysql "-u$1" skolan < "$3" > /dev/null
    if [ $? -ne 0 ]; then
        echo "The command failed, you may have issues with your SQL code."
        echo "Verify that all SQL commands can be exeucted in sequence in the file:"
        echo " '$3'"
        exit 1
    fi
}

#
# Recreate and reset the database to be as after part II.
#
echo ">>> Reset skolan to after part 2"
# Kör som root
file='setup.sql'
mysql -uroot -p skolan < $file > /dev/null

# loadSqlIntoSkolan "root" "" "setup.sql" "Initiera database och användare"
loadSqlIntoSkolan "user" "pass" "ddl.sql" "Create tables"
loadSqlIntoSkolan "user" "pass" "dml_insert.sql" "Insert into larare"
loadSqlIntoSkolan "user" "pass" "ddl_migrate.sql" "Alter table larare"
loadSqlIntoSkolan "user" "pass" "dml_update.sql" "Grundlön larare"
loadSqlIntoSkolan "user" "pass" "ddl_copy.sql" "Kopiera till larare_pre"
loadSqlIntoSkolan "user" "pass" "dml_update_lonerevision.sql" "Utför lönerevision"
loadSqlIntoSkolan "user" "pass" "dml_view.sql" "Skapa vyer för larare"
loadSqlIntoSkolan "user" "pass" "dml_join.sql" "Skapa vy för lönerevisionen"

#
# # Kör som root
# file='setup.sql'
# mysql -uroot -p skolan < $file > /dev/null
#
# file='ddl.sql'
# echo ">>> Create tables($file)"
# mysql -uuser skolan < $file > /dev/null
#
# file='dml_insert.sql'
# echo ">>> Insert data in table"
# mysql -uuser skolan < $file > /dev/null
#
# file='ddl_migrate.sql'
# echo ">>> Edit data in table, using ALTER TABLE"
# mysql -uuser skolan < $file > /dev/null
#
# file='dml_update.sql'
# echo ">>> Update and set salaries before salaryrevision, $file"
# mysql -uuser skolan < $file > /dev/null
#
# file='ddl_copy.sql'
# echo ">>> Copy table teacher to teacher_pre before sal rev."
# mysql -uuser skolan < $file > /dev/null
#
# file='dml_update_lonerevision.sql'
# echo ">>> Run salary revision $file"
# mysql -uuser skolan < $file > /dev/null
#
# file='dml_view.sql'
# echo ">>> Create and view v_name_age and v_teacher $file"
# mysql -uuser skolan < $file > /dev/null
#
# file='dml_join.sql'
# echo ">>> Create and view v_lonerevision $file"
# mysql -uuser skolan < $file > /dev/null

echo ">>> Check data, sum salary = 305000 and competence = 8"
mysql -uuser skolan -e "SELECT SUM(salary) as 'Sumsalary', SUM(competence) as 'Sum comp' FROM teacher_pre ;"

echo ">>> Check NEW data, sum salary = 332042 and competence = 19"
mysql -uuser skolan -e "SELECT SUM(salary) as 'Sumsalary', SUM(competence) as 'Sum comp' FROM teacher ;"
