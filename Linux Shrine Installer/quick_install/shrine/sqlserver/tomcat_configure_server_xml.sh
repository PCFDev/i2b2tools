#!/bin/bash

source ./shrine.rc

echo "[shrine/tomcat.sh] Configuring tomcat $SHRINE_TOMCAT_SERVER_CONF"

require "${SHRINE_SSL_PORT}" "SHRINE_SSL_PORT must be set"
require "${SHRINE_PORT}" "SHRINE_PORT must be set"
require "${KEYSTORE_FILE}" "KEYSTORE_FILE must be set"
require "${KEYSTORE_PASSWORD}" "KEYSTORE_PASSWORD must be set"

interpolate_file ./skel/tomcat_server.xml "KEYSTORE_FILE" "$KEYSTORE_FILE" | \
interpolate "KEYSTORE_PASSWORD" "$KEYSTORE_PASSWORD" | \
interpolate "SHRINE_PORT" "$SHRINE_PORT" | \
interpolate "SHRINE_SSL_PORT" "$SHRINE_SSL_PORT" > $SHRINE_TOMCAT_SERVER_CONF
