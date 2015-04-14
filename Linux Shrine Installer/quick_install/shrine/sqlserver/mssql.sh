#!/bin/bash

echo "[shrine/mssql.sh] Begin."

#########
# SHRINE MSSQL setup for Query History Database.
#
# SHRINE uses hibernate, so technically any DB vendor will suffice.
# We default to mysql since it is so easy to setup.
#
#########
source ./shrine.rc

mkdir -p $SHRINE_HOME
mkdir -p work; cd work
#########

echo "[shrine/mssql.sh] creating shrine database" $SHRINE_DB_NAME;

interpolate_file ../create_database.sql "SHRINE_DB_NAME" "$SHRINE_DB_NAME" | \
interpolate "SHRINE_DB_USER" "$SHRINE_DB_USER" | \
interpolate "SHRINE_DB_PASSWORD" "$SHRINE_DB_PASSWORD" | \
interpolate "SHRINE_DB_SCHEMA" "$SHRINE_DB_SCHEMA" > create_database.sql.interpolated

#NOTE: due to issue with jdbc and GO this file had to be split from mssql.sql
interpolate_file ../create_user.sql "SHRINE_DB_NAME" "$SHRINE_DB_NAME" | \
interpolate "SHRINE_DB_USER" "$SHRINE_DB_USER" | \
interpolate "SHRINE_DB_PASSWORD" "$SHRINE_DB_PASSWORD" | \
interpolate "SHRINE_DB_SCHEMA" "$SHRINE_DB_SCHEMA" > create_user.sql.interpolated

#mysql -u root < mysql.sql.interpolated
java -cp ../../../:../../../sqljdbc.jar tsql create_database.sql.interpolated \
 $SHRINE_DB_HOST $SHRINE_DB_ADMIN_USER $SHRINE_DB_ADMIN_PASSWORD 'master' 'yes'

java -cp ../../../:../../../sqljdbc.jar tsql create_user.sql.interpolated \
 $SHRINE_DB_HOST $SHRINE_DB_ADMIN_USER $SHRINE_DB_ADMIN_PASSWORD 'master' 'yes'

#wget ${SHRINE_SVN_URL_BASE}/code/adapter/src/main/resources/adapter.sql
java -cp ../../../:../../../sqljdbc.jar tsql ../adapter.sql \
 $SHRINE_DB_HOST $SHRINE_DB_USER $SHRINE_DB_PASSWORD $SHRINE_DB_NAME

#wget ${SHRINE_SVN_URL_BASE}/code/broadcaster-aggregator/src/main/resources/hub.sql
#mysql -u $SHRINE_MYSQL_USER -p$SHRINE_MYSQL_PASSWORD -D shrine_query_history < hub.sql
java -cp ../../../:../../../sqljdbc.jar tsql ../hub.sql \
 $SHRINE_DB_HOST $SHRINE_DB_USER $SHRINE_DB_PASSWORD $SHRINE_DB_NAME

#wget ${SHRINE_SVN_URL_BASE}/code/service/src/main/resources/create_broadcaster_audit_table.sql
#mysql -u $SHRINE_MYSQL_USER -p$SHRINE_MYSQL_PASSWORD -D shrine_query_history < create_broadcaster_audit_table.sql
java -cp ../../../:../../../sqljdbc.jar tsql ../create_broadcaster_audit_table.sql \
 $SHRINE_DB_HOST $SHRINE_DB_USER $SHRINE_DB_PASSWORD $SHRINE_DB_NAME


echo "[shrine/mssql.sh] Done."

cd ..
