#!/usr/local/bin/env bash
#
#recreate for eshop
#


# user root
# recreate database
# /dev/null = no prints
# user och pass är satt https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/aterstall-databasen-del-1#warning

file='setup.sql'
mysql -uroot -pHejhej2019 eshop < $file > /dev/null

file='ddl.sql'
echo ">>> Create tables($file)"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null

file='insert.sql'
echo ">>> Insert data in table"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null

file='func.sql'
echo ">>> Create functions"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null

file='procedures.sql'
echo ">>> Create procedures"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null

file='procedures-terminal.sql'
echo ">>> Create procedures"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null

file='views.sql'
echo ">>> Create views"
mysql -uroot -pHejhej2019  eshop < $file > /dev/null
