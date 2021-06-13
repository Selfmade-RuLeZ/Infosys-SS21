docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1! -Q "$(cat table_script.sql)"
