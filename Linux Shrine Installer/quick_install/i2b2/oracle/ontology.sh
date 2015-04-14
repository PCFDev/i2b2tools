#!/bin/bash

echo "[i2b2/ontology.sh] Begin."

#########
# I2B2 Ontology Setup for SHRINE
#
#########
source ./i2b2.rc
#########

#####
echo "[i2b2/ontology.sh] Creating shrine_ont user."

interpolate_file ./skel/ontology_create_user.sql "I2B2_DB_SHRINE_ONT_USER" "${I2B2_DB_SHRINE_ONT_USER}" | \
interpolate "I2B2_DB_SHRINE_ONT_PASSWORD" "${I2B2_DB_SHRINE_ONT_PASSWORD}" > ontology_create_user.sql.interpolated

sqlplus system/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID} < ontology_create_user.sql.interpolated

sqlplus ${I2B2_DB_SHRINE_ONT_USER}/${I2B2_DB_SHRINE_ONT_PASSWORD}@${I2B2_ORACLE_SID} < ontology_create_tables.sql
sqlplus ${I2B2_DB_SHRINE_ONT_USER}/${I2B2_DB_SHRINE_ONT_PASSWORD}@${I2B2_ORACLE_SID} < ontology_table_access.sql

#echo "NEED TO DO SCHEMES"
#echo "select distinct  c_key, c_name  from i2b2demodata.schemes"

#########
echo "[i2b2/ontology.sh] Downloading shrine ontology."

SHRINE_ONTOLOGY_SQL_FILE="Shrine.sql"
SHRINE_ONTOLOGY_SQL_FILE_URL=`perl ../determine-shrine-sql-url.pl`
wget --no-clobber -O ${SHRINE_ONTOLOGY_SQL_FILE} ${SHRINE_ONTOLOGY_SQL_FILE_URL}

#####
echo "[i2b2/ontology.sh] Inserting shrine ontology."

sqlplus ${I2B2_DB_SHRINE_ONT_USER}/${I2B2_DB_SHRINE_ONT_PASSWORD}@${I2B2_ORACLE_SID} < ${SHRINE_ONTOLOGY_SQL_FILE}

#####

echo "[i2b2/ontology.sh] Done."
