# !/usr/local/bin/env bash
#
# Recreate and reset the database to be as after part 3
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
# Recreate and reset the database to be as after part III
#
echo ">>> Reset skolan to beginning of part 3."
# Kör som root
file='setup.sql'
mysql -uroot -p skolan < $file > /dev/null

# loadSqlIntoSkolan "root" "" "setup.sql" "Initiera database och användare"
loadSqlIntoSkolan "user" "pass" "ddl_all.sql" "Create ALL tables"
loadSqlIntoSkolan "user" "pass" "insert.sql" "Insert all values teacher and teacher_pre"
loadSqlIntoSkolan "user" "pass" "dml_update_lonerevision.sql" "Do lönerevision"


echo ">>> Check data, sum salary = 305000 and competence = 8"
mysql -uuser skolan -e "SELECT SUM(salary) as 'Sumsalary', SUM(competence) as 'Sum comp' FROM teacher_pre ;"

echo ">>> Check NEW data, sum salary = 332042 and competence = 19"
mysql -uuser skolan -e "SELECT SUM(salary) as 'Sumsalary', SUM(competence) as 'Sum comp' FROM teacher ;"
