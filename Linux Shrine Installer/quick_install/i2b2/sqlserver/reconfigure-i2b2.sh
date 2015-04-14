#!/bin/bash

#NOTE: this script is used to update the standard i2b2 vm to use
# the MSSQL database(s) that are configured in the i2b2.rc file

#########
source ./i2b2.rc
#########

echo "[i2b2/configure_hive.sh] Backing up ont-ds.xml"

mkdir -p backup

(! [ -d backup ]) && (echo "Couldn't create backup/" ; exit -1)



require "$I2B2_DB_HIVE_JDBC_URL" "I2B2_DB_HIVE_JDBC_URL must be set"
require "$I2B2_DB_HIVE_USER" "I2B2_DB_HIVE_USER must be set"
require "$I2B2_DB_HIVE_PASSWORD" "I2B2_DB_HIVE_PASSWORD must be set"

require "$I2B2_DB_CRC_JDBC_URL" "I2B2_DB_CRC_JDBC_URL must be set"
require "$I2B2_DB_CRC_USER" "I2B2_DB_CRC_USER must be set"
require "$I2B2_DB_CRC_PASSWORD" "I2B2_DB_CRC_PASSWORD must be set"

require "$I2B2_DB_IM_JDBC_URL" "I2B2_DB_IM_JDBC_URL must be set"
require "$I2B2_DB_IM_USER" "I2B2_DB_IM_USER must be set"
require "$I2B2_DB_IM_PASSWORD" "I2B2_DB_IM_PASSWORD must be set"


require "$I2B2_DB_PM_JDBC_URL" "I2B2_DB_PM_JDBC_URL must be set"
require "$I2B2_DB_PM_USER" "I2B2_DB_HIVE_JDBC_URL must be set"
require "$I2B2_DB_PM_PASSWORD" "I2B2_DB_HIVE_USER must be set"


require "$I2B2_DB_WORK_JDBC_URL" "I2B2_DB_WORK_JDBC_URL must be set"
require "$I2B2_DB_WORK_USER" "I2B2_DB_WORK_USER must be set"
require "$I2B2_DB_WORK_PASSWORD" "I2B2_DB_WORK_PASSWORD must be set"



#NOTE: crc-ds.xml
echo "[i2b2/reconfigure_i2b2.sh] Configuring I2B2 crc-ds.xml"

cp  ${JBOSS_DEPLOY_DIR}/crc-ds.xml backup/crc-ds.xml

(! [ -f backup/crc-ds.xml ]) && (echo "Couldn't back up crc-ds.xml" ; exit -1)

interpolate_file ./skel/crc-ds.xml "I2B2_DB_CRC_JDBC_URL" "$I2B2_DB_CRC_JDBC_URL" | \
interpolate "I2B2_DB_CRC_USER" "$I2B2_DB_CRC_USER" | \
interpolate "I2B2_DB_CRC_PASSWORD" "$I2B2_DB_CRC_PASSWORD" | \
interpolate "I2B2_DB_HIVE_JDBC_URL" "$I2B2_DB_HIVE_JDBC_URL" | \
interpolate "I2B2_DB_HIVE_USER" "$I2B2_DB_HIVE_USER" | \
interpolate "I2B2_DB_HIVE_PASSWORD" "$I2B2_DB_HIVE_PASSWORD" > crc-ds.xml.interpolated

echo "[i2b2/reconfigure_i2b2.sh] Copying I2B2 crc-ds.xml"

cp  crc-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/crc-ds.xml

(! [ -f ${JBOSS_DEPLOY_DIR}/crc-ds.xml ]) && (echo "Couldn't copy crc-ds.xml to JBoss dir" ; exit -1)

[ "`diff crc-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/crc-ds.xml`" != "" ] && ( echo "Couldn't copy crc-ds.xml to JBoss dir" ; exit -1 )


#NOTE: im-ds.xml
echo "[i2b2/reconfigure_i2b2.sh] Configuring I2B2 im-ds.xml"

cp  ${JBOSS_DEPLOY_DIR}/im-ds.xml backup/im-ds.xml

(! [ -f backup/im-ds.xml ]) && (echo "Couldn't back up im-ds.xml" ; exit -1)

interpolate_file ./skel/im-ds.xml "I2B2_DB_IM_JDBC_URL" "$I2B2_DB_IM_JDBC_URL" | \
interpolate "I2B2_DB_IM_USER" "$I2B2_DB_IM_USER" | \
interpolate "I2B2_DB_IM_PASSWORD" "$I2B2_DB_IM_PASSWORD" | \
interpolate "I2B2_DB_HIVE_JDBC_URL" "$I2B2_DB_HIVE_JDBC_URL" | \
interpolate "I2B2_DB_HIVE_USER" "$I2B2_DB_HIVE_USER" | \
interpolate "I2B2_DB_HIVE_PASSWORD" "$I2B2_DB_HIVE_PASSWORD" > im-ds.xml.interpolated

echo "[i2b2/reconfigure_i2b2.sh] Copying I2B2 im-ds.xml"

cp  im-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/im-ds.xml

(! [ -f ${JBOSS_DEPLOY_DIR}/im-ds.xml ]) && (echo "Couldn't copy im-ds.xml to JBoss dir" ; exit -1)

[ "`diff im-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/im-ds.xml`" != "" ] && ( echo "Couldn't copy im-ds.xml to JBoss dir" ; exit -1 )



#NOTE: pm-ds.xml
echo "[i2b2/reconfigure_i2b2.sh] Configuring I2B2 pm-ds.xml"

cp  ${JBOSS_DEPLOY_DIR}/pm-ds.xml backup/pm-ds.xml

(! [ -f backup/pm-ds.xml ]) && (echo "Couldn't back up pm-ds.xml" ; exit -1)

interpolate_file ./skel/pm-ds.xml "I2B2_DB_PM_JDBC_URL" "$I2B2_DB_PM_JDBC_URL" | \
interpolate "I2B2_DB_PM_USER" "$I2B2_DB_PM_USER" | \
interpolate "I2B2_DB_PM_PASSWORD" "$I2B2_DB_PM_PASSWORD" > pm-ds.xml.interpolated

echo "[i2b2/reconfigure_i2b2.sh] Copying I2B2 pm-ds.xml"

cp  pm-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/pm-ds.xml

(! [ -f ${JBOSS_DEPLOY_DIR}/pm-ds.xml ]) && (echo "Couldn't copy pm-ds.xml to JBoss dir" ; exit -1)

[ "`diff pm-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/pm-ds.xml`" != "" ] && ( echo "Couldn't copy pm-ds.xml to JBoss dir" ; exit -1 )


#NOTE: work-ds.xml
echo "[i2b2/reconfigure_i2b2.sh] Configuring I2B2 work-ds.xml"

cp  ${JBOSS_DEPLOY_DIR}/work-ds.xml backup/work-ds.xml

(! [ -f backup/work-ds.xml ]) && (echo "Couldn't back up work-ds.xml" ; exit -1)

interpolate_file ./skel/work-ds.xml "I2B2_DB_WORK_JDBC_URL" "$I2B2_DB_WORK_JDBC_URL" | \
interpolate "I2B2_DB_WORK_USER" "$I2B2_DB_WORK_USER" | \
interpolate "I2B2_DB_WORK_PASSWORD" "$I2B2_DB_WORK_PASSWORD" | \
interpolate "I2B2_DB_HIVE_JDBC_URL" "$I2B2_DB_HIVE_JDBC_URL" | \
interpolate "I2B2_DB_HIVE_USER" "$I2B2_DB_HIVE_USER" | \
interpolate "I2B2_DB_HIVE_PASSWORD" "$I2B2_DB_HIVE_PASSWORD" > work-ds.xml.interpolated

echo "[i2b2/reconfigure_i2b2.sh] Copying I2B2 work-ds.xml"

cp  work-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/work-ds.xml

(! [ -f ${JBOSS_DEPLOY_DIR}/work-ds.xml ]) && (echo "Couldn't copy work-ds.xml to JBoss dir" ; exit -1)

[ "`diff work-ds.xml.interpolated ${JBOSS_DEPLOY_DIR}/work-ds.xml`" != "" ] && ( echo "Couldn't copy work-ds.xml to JBoss dir" ; exit -1 )



echo "[i2b2/reconfigure_i2b2.sh] Updating workplaceapp/workplace.properties"
sed -ie 's/metadataschema=public/metadataschema=dbo/g' ${JBOSS_HOME}/standalone/configuration/workplaceapp/workplace.properties

echo "[i2b2/reconfigure_i2b2.sh] Updating ontologyapp/ontology.properties"
sed -ie 's/metadataschema=public/metadataschema=dbo/g' ${JBOSS_HOME}/standalone/configuration/ontologyapp/ontology.properties

echo "[i2b2/reconfigure_i2b2.sh] Updating crcapp/crc.properties"
sed -ie 's/schemaname=public/schemaname=dbo/g' ${JBOSS_HOME}/standalone/configuration/crcapp/crc.properties
sed -ie 's/POSTGRESQL/SQLSERVER/g' ${JBOSS_HOME}/standalone/configuration/crcapp/crc.properties
