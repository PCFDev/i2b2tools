#!/bin/bash

echo "[i2b2/ontology.sh] Begin."

#########
# I2B2 Ontology Setup for SHRINE
#
#########
source ./i2b2.rc
#########

#####
echo "[i2b2/ontology.sh] Creating shrine_ont user: " ${I2B2_DB_SHRINE_ONT_USER}

interpolate_file ./skel/ontology_create_user.sql "I2B2_DB_SHRINE_ONT_USER" "${I2B2_DB_SHRINE_ONT_USER}" | \
interpolate "I2B2_DB_SHRINE_ONT_PASSWORD" "${I2B2_DB_SHRINE_ONT_PASSWORD}" | \
interpolate "I2B2_DB_SHRINE_ONT_DATABASE" "${I2B2_DB_SHRINE_ONT_DATABASE}" | \
interpolate "I2B2_DB_SCHEMA" "${I2B2_DB_SCHEMA}" > ontology_create_user.sql.interpolated

#sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_create_user.sql.interpolated
java -cp ../../:../../sqljdbc.jar tsql ontology_create_user.sql.interpolated \
  ${I2B2_DB_ONT_SERVER} ${I2B2_DB_ONT_USER} ${I2B2_DB_ONT_PASSWORD} ${I2B2_DB_ONT_DATABASE}

# we interpolate ontology_create_tables for Postgres in order to correctly set owner/grants
interpolate_file ./skel/ontology_create_tables.sql "I2B2_DB_SCHEMA" "${I2B2_DB_SCHEMA}" \
 > ontology_create_tables.sql.interpolated

#sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_create_tables.sql.interpolated
java -cp ../../:../../sqljdbc.jar tsql ontology_create_tables.sql.interpolated \
  ${I2B2_DB_ONT_SERVER} ${I2B2_DB_ONT_USER} ${I2B2_DB_ONT_PASSWORD} ${I2B2_DB_ONT_DATABASE}

interpolate_file ./skel/ontology_table_access.sql "I2B2_DB_SCHEMA" "${I2B2_DB_SCHEMA}" > ontology_table_access.sql.interpolated

#sudo -u postgres psql ${I2B2_DB_ONT_USER} < ontology_table_access.sql.interpolated
java -cp ../../:../../sqljdbc.jar tsql ontology_table_access.sql.interpolated \
  ${I2B2_DB_ONT_SERVER} ${I2B2_DB_ONT_USER} ${I2B2_DB_ONT_PASSWORD} ${I2B2_DB_ONT_DATABASE}


#echo "NEED TO DO SCHEMES"
#echo "select distinct  c_key, c_name  from i2b2demodata.schemes"

#########
echo "[i2b2/ontology.sh] Downloading shrine ontology."

SHRINE_ONTOLOGY_SQL_FILE="Shrine.sql"
SHRINE_ONTOLOGY_SQL_FILE_URL=`perl ../determine-shrine-sql-url.pl`
wget --no-clobber -O ${SHRINE_ONTOLOGY_SQL_FILE} ${SHRINE_ONTOLOGY_SQL_FILE_URL}

#NOTE: this is not needed for MSSQL
# temporary workaround to make sure all insert statements use the proper schema
#sed -i '1s/^/SET search_path TO '"${I2B2_DB_SHRINE_ONT_USER}"';\n/' ${SHRINE_ONTOLOGY_SQL_FILE}

#####
echo "[i2b2/ontology.sh] Inserting shrine ontology."

#sudo -u postgres psql ${I2B2_DB_ONT_USER} < ${SHRINE_ONTOLOGY_SQL_FILE}
java -cp ../../:../../sqljdbc.jar tsql ${SHRINE_ONTOLOGY_SQL_FILE} \
  ${I2B2_DB_ONT_SERVER} ${I2B2_DB_ONT_USER} ${I2B2_DB_ONT_PASSWORD} ${I2B2_DB_ONT_DATABASE}


#####

echo "[i2b2/ontology.sh] Done."
