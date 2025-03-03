#!/bin/sh

echo "start-domain

add-library --type common ./custom/postgresql-42.7.5.jar

create-jdbc-connection-pool \
--restype javax.sql.ConnectionPoolDataSource \
--datasourceclassname org.postgresql.ds.PGConnectionPoolDataSource \
--property \
serverName=$POSTGRES_CONTAINER_NAME:\
portNumber=5432:\
databaseName=$POSTGRES_DB:\
user=$POSTGRES_USER:\
password=$POSTGRES_PASSWORD \
MainPool

create-jdbc-resource --connectionpoolid MainPool $JTA_DATA_SOURCE

stop-domain" | asadmin --interactive=false multimode
