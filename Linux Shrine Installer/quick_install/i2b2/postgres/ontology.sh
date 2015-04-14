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

sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_create_user.sql.interpolated

# we interpolate ontology_create_tables for Postgres in order to correctly set owner/grants
interpolate_file ./skel/ontology_create_tables.sql "I2B2_DB_ONT_USER" "${I2B2_DB_ONT_USER}" | \
interpolate "I2B2_DB_SHRINE_ONT_USER" "${I2B2_DB_SHRINE_ONT_USER}" > ontology_create_tables.sql.interpolated

sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_create_tables.sql.interpolated

interpolate_file ./skel/ontology_table_access.sql "I2B2_DB_SHRINE_ONT_USER" "${I2B2_DB_SHRINE_ONT_USER}" > ontology_table_access.sql.interpolated

sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_table_access.sql.interpolated

#echo "NEED TO DO SCHEMES"
#echo "select distinct  c_key, c_name  from i2b2demodata.schemes"

#########
echo "[i2b2/ontology.sh] Downloading shrine ontology."

SHRINE_ONTOLOGY_SQL_FILE="Shrine.sql"
SHRINE_ONTOLOGY_SQL_FILE_URL=`perl ../determine-shrine-sql-url.pl`
wget --no-clobber -O ${SHRINE_ONTOLOGY_SQL_FILE} ${SHRINE_ONTOLOGY_SQL_FILE_URL}

# temporary workaround to make sure all insert statements use the proper schema
sed -i '1s/^/SET search_path TO '"${I2B2_DB_SHRINE_ONT_USER}"';\n/' ${SHRINE_ONTOLOGY_SQL_FILE}

#####
echo "[i2b2/ontology.sh] Inserting shrine ontology."

sudo -u postgres psql ${I2B2_DB_ONT_USER} < ${SHRINE_ONTOLOGY_SQL_FILE}

#####

echo "[i2b2/ontology.sh] Done."
