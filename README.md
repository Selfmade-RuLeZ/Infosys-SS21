# Infosys-SS21

## milestone 1 meeting

- kein Login und Benutzerverwaltung
- ein Benutzer sieht Tabellen
- export to pdf file
- kein email versenden
- möglichst viel in Datenbanklogik

## docker


```sh
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password1!' --name mssql -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1!

```

https://github.com/microsoft/sql-server-samples/tree/master/samples/containers/replication/db2
https://stackoverflow.com/questions/58309452/docker-initialize-database-tables-and-records-in-sql-server

