#!/bin/bash

#########
# Restoring i2b2 to pre SHRINE installation state
#
#########
source ./i2b2.rc
#########
echo "[i2b2/clean.sh] Begin."

echo "[i2b2/clean.sh] HIVE: If exists, restore Backup copy of HIVE Ontology Datasource (file:ont-ds.xml)"

cp  backup/ont-ds.xml  ${JBOSS_DEPLOY_DIR}/ont-ds.xml

sqlplus ${I2B2_DB_HIVE_USER}/${I2B2_DB_HIVE_PASSWORD}@${I2B2_ORACLE_SID} < clean_hive.sql

echo "[i2b2/clean.sh] PM: Restoring PM Config, removing SHRINE project"

interpolate_file clean_pm.sql "SHRINE_USER" "${SHRINE_USER}" > clean_pm.sql.interpolated

sqlplus ${I2B2_DB_PM_USER}/${I2B2_DB_PM_PASSWORD}@${I2B2_ORACLE_SID} < clean_pm.sql.interpolated

echo "[i2b2/clean.sh] ONT: Removing Ontology User and Data"

interpolate_file clean_ontology.sql "I2B2_DB_SHRINE_ONT_USER" "${I2B2_DB_SHRINE_ONT_USER}" > clean_ontology.sql.interpolated

sqlplus system/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID} < clean_ontology.sql.interpolated

find -name *.interpolated | xargs rm

echo "[i2b2/clean.sh] Done."





