#!/bin/bash

echo "[i2b2/configure_pm.sh] Begin."

#########
# I2B2 PM (project management) setup
#
#########
source ./i2b2.rc
#########

echo "[i2b2/configure_pm.sh] Configuring i2b2 tables PM_* "

require "${SHRINE_IP}" "SHRINE_IP must be set"
require "${SHRINE_SSL_PORT}" "SHRINE_SSL_PORT must be set"
require "${SHRINE_USER}" "SHRINE_USER must be set"
require "${SHRINE_PASSWORD_CRYPTED}" "SHRINE_PASSWORD_CRYPTED must be set"



interpolate_file skel/configure_pm.sql "SHRINE_IP" "${SHRINE_IP}" | \
interpolate "SHRINE_SSL_PORT" "${SHRINE_SSL_PORT}" | \
interpolate "SHRINE_USER" "${SHRINE_USER}" | \
interpolate "SHRINE_PASSWORD_CRYPTED" "${SHRINE_PASSWORD_CRYPTED}" > configure_pm.sql.interpolated

#sudo -u postgres psql ${I2B2_DB_PM_USER} < configure_pm.sql.interpolated
#ITL modified to use jdbc to execute file against MSSQL server
java -cp ../../:../../sqljdbc.jar tsql configure_pm.sql.interpolated  \
   ${I2B2_DB_PM_SERVER}  ${I2B2_DB_PM_USER}  ${I2B2_DB_PM_PASSWORD} ${I2B2_DB_PM_DATABASE}


echo "[i2b2/configure_pm.sh] Done."
