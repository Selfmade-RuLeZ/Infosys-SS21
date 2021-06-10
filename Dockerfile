FROM mcr.microsoft.com/mssql/server:2017-latest
# docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password1!' --name mssql -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest
# docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1!


ENV SA_PASSWORD Password1!
ENV ACCEPT_EULA Y

COPY init.sql .

COPY ./EntryPoint.sh .
COPY ./SqlCmdStartup.sh .

# RUN /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1! -i init.sql


