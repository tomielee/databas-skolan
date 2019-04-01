#!/usr/local/bin/env bash
#
#recreate for eshop
#


# user root
# recreate database
# /dev/null = no prints
# user och pass är satt https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/aterstall-databasen-del-1#warning

file='setup.sql'
mysql -uroot -pHejhej2019exam < $file > /dev/null

file='dml.sql'
echo ">>> Create tables($file)"
mysql -uroot -pHejhej2019  exam < $file > /dev/null

file='insert.sql'
echo ">>> Insert data in table"
mysql -uroot -pHejhej2019  exam < $file > /dev/null
