#!/bin/bash

echo "[i2b2/hive.sh] Begin."

#########
# I2B2 DB (datasource) lookup
#
#########
source ./i2b2.rc
#########

echo "[i2b2/configure_hive.sh] Configuring ONT_DB_LOOKUP, CRC_DB_LOOKUP"

require "${I2B2_DOMAIN_ID}" "I2B2_DOMAIN_ID must be set"
require "${I2B2_DB_SHRINE_ONT_USER}" "I2B2_DB_SHRINE_ONT_USER must be set"
require "${I2B2_DB_SHRINE_ONT_DATASOURCE_NAME}" "I2B2_DB_SHRINE_ONT_DATASOURCE_NAME must be set"
require "${I2B2_DB_CRC_DATASOURCE_NAME}" "I2B2_DB_CRC_DATASOURCE_NAME must be set"

interpolate_file ./skel/configure_hive_db_lookups.sql "I2B2_DOMAIN_ID" "$I2B2_DOMAIN_ID" | \
interpolate "I2B2_DB_SHRINE_ONT_USER" "$I2B2_DB_SHRINE_ONT_USER" | \
interpolate "I2B2_DB_SHRINE_ONT_DATASOURCE_NAME" "$I2B2_DB_SHRINE_ONT_DATASOURCE_NAME" | \
interpolate "I2B2_DB_CRC_DATASOURCE_NAME" "$I2B2_DB_CRC_DATASOURCE_NAME" > configure_hive_db_lookups.sql.interpolated

sudo -u postgres psql ${I2B2_DB_HIVE_USER} < configure_hive_db_lookups.sql.interpolated

echo "[i2b2/configure_hive.sh] Backing up ont-ds.xml"

mkdir -p backup

(! [ -d backup ]) && (echo "Couldn't create backup/" ; exit -1)

cp  ${JBOSS_DEPLOY_DIR}/ont-ds.xml backup/ont-ds.xml

(! [ -f backup/ont-ds.xml ]) && (echo "Couldn't back up ont-ds.xml" ; exit -1)

echo "[i2b2/configure_hive.sh] Configuring SHRINE ont-ds.xml"

require "$I2B2_DB_HIVE_DATASOURCE_NAME" "I2B2_DB_HIVE_DATASOURCE_NAME must be set"
require "$I2B2_DB_HIVE_JDBC_URL" "I2B2_DB_HIVE_JDBC_URL must be set"
require "$I2B2_DB_HIVE_USER" "I2B2_DB_HIVE_USER must be set"
require "$I2B2_DB_HIVE_PASSWORD" "I2B2_DB_HIVE_PASSWORD must be set"
require "$I2B2_DB_ONT_DATASOURCE_NAME" "I2B2_DB_ONT_DATASOURCE_NAME must be set"
require "$I2B2_DB_ONT_JDBC_URL" "I2B2_DB_ONT_JDBC_URL must be set"
require "$I2B2_DB_ONT_USER" "I2B2_DB_ONT_USER must be set"
require "$I2B2_DB_HIVE_PASSWORD" "I2B2_DB_HIVE_PASSWORD must be set"
require "$I2B2_DB_SHRINE_ONT_DATASOURCE_NAME" "I2B2_DB_SHRINE_ONT_DATASOURCE_NAME must be set"
require "$I2B2_DB_SHRINE_ONT_JDBC_URL" "I2B2_DB_SHRINE_ONT_JDBC_URL must be set"
require "$I2B2_DB_SHRINE_ONT_USER" "I2B2_DB_SHRINE_ONT_USER must be set"
require "$I2B2_DB_SHRINE_ONT_PASSWORD" "I2B2_DB_SHRINE_ONT_PASSWORD must be set"

interpolate_file ./skel/ont-ds.xml "I2B2_DB_HIVE_DATASOURCE_NAME" "$I2B2_DB_HIVE_DATASOURCE_NAME" | \
interpolate "I2B2_DB_HIVE_JDBC_URL" "$I2B2_DB_HIVE_JDBC_URL" | \
interpolate "I2B2_DB_HIVE_USER" "$I2B2_DB_HIVE_USER" | \
interpolate "I2B2_DB_HIVE_PASSWORD" "$I2B2_DB_HIVE_PASSWORD" | \
interpolate "I2B2_DB_ONT_DATASOURCE_NAME" "$I2B2_DB_ONT_DATASOURCE_NAME" | \
interpolate "I2B2_DB_ONT_JDBC_URL" "$I2B2_DB_ONT_JDBC_URL" | \
interpolate "I2B2_DB_ONT_USER" "$I2B2_DB_ONT_USER" | \
interpolate "I2B2_DB_HIVE_PASSWORD" "$I2B2_DB_HIVE_PASSWORD" | \
interpolate "I2B2_DB_SHRINE_ONT_DATASOURCE_NAME" "$I2B2_DB_SHRINE_ONT_DATASOURCE_NAME" | \
interpolate "I2B2_DB_SHRINE_ONT_JDBC_URL" "$I2B2_DB_SHRINE_ONT_JDBC_URL" | \
interpolate "I2B2_DB_SHRINE_ONT_USER" "$I2B2_DB_SHRINE_ONT_USER" | \
interpolate "I2B2_DB_SHRINE_ONT_PASSWORD" "$I2B2_DB_SHRINE_ONT_PASSWORD" > ont-ds.xml.interpolated

echo "[i2b2/configure_hive.sh] Copying SHRINE ont-ds.xml"

cp  ont-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/ont-ds.xml

(! [ -f ${JBOSS_DEPLOY_DIR}/ont-ds.xml ]) && (echo "Couldn't copy ont-ds.xml to JBoss dir" ; exit -1)

[ "`diff ont-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/ont-ds.xml`" != "" ] && ( echo "Couldn't copy ont-ds.xml to JBoss dir" ; exit -1 )

echo "[i2b2/configure_hive.sh] Done."
