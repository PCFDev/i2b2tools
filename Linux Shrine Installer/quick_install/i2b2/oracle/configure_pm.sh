#!/bin/bash

echo "[i2b2/configure_pm.sh] Begin."

#########
# I2B2 PM (project management) setup
#
#########
source ./i2b2.rc
#########

echo "[i2b2/configure_pm.sh] Configuring i2b2 tables PM_* "

interpolate_file skel/configure_pm.sql "SHRINE_IP" "${SHRINE_IP}" | \
interpolate "SHRINE_SSL_PORT" "${SHRINE_SSL_PORT}" | \
interpolate "SHRINE_USER" "${SHRINE_USER}" | \
interpolate "SHRINE_PASSWORD_CRYPTED" "${SHRINE_PASSWORD_CRYPTED}" > configure_pm.sql.interpolated

sqlplus ${I2B2_DB_PM_USER}/${I2B2_DB_PM_PASSWORD}@${I2B2_ORACLE_SID} < configure_pm.sql.interpolated

echo "[i2b2/configure_pm.sh] Done."


