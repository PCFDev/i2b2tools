#!/bin/bash

echo "[shrine/mysql.sh] Begin."

#########
# SHRINE MySQL setup for Query History Database.
#
# SHRINE uses hibernate, so technically any DB vendor will suffice.
# We default to mysql since it is so easy to setup.
#
#########
source ./shrine.rc

mkdir -p $SHRINE_HOME
mkdir -p work; cd work
#########

echo "[shrine/mysql.sh] creating shrine_query_history";

interpolate_file ../mysql.sql "SHRINE_MYSQL_USER" "$SHRINE_MYSQL_USER" | \
interpolate "SHRINE_MYSQL_PASSWORD" "$SHRINE_MYSQL_PASSWORD" | \
interpolate "SHRINE_MYSQL_HOST" "$SHRINE_MYSQL_HOST" > mysql.sql.interpolated

mysql -u root < mysql.sql.interpolated

wget ${SHRINE_SVN_URL_BASE}/code/adapter/src/main/resources/adapter.sql

mysql -u $SHRINE_MYSQL_USER -p$SHRINE_MYSQL_PASSWORD -D shrine_query_history < adapter.sql

wget ${SHRINE_SVN_URL_BASE}/code/broadcaster-aggregator/src/main/resources/hub.sql

mysql -u $SHRINE_MYSQL_USER -p$SHRINE_MYSQL_PASSWORD -D shrine_query_history < hub.sql

wget ${SHRINE_SVN_URL_BASE}/code/service/src/main/resources/create_broadcaster_audit_table.sql

mysql -u $SHRINE_MYSQL_USER -p$SHRINE_MYSQL_PASSWORD -D shrine_query_history < create_broadcaster_audit_table.sql

echo "[shrine/mysql.sh] Done."

cd ..
