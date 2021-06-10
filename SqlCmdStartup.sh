#!/bin/bash
set -e

wait_time=90s 
password=Password1!

# wait for SQL Server to come up
echo "importing data will start in $wait_time..."
sleep $wait_time

echo "initialize sql server"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $password -i init.sql

exec "$@"
